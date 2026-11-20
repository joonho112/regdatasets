# raw_vs_shipped.R -----------------------------------------------------------
# Step 2.2: reverse-engineer what v0.2.0 did to each raw Stata file.
#
# Compares every vendored raw file (data-raw/source/*.dta) with the dataset
# shipped in data/ and records each difference: renamed / dropped / added
# columns, recoded cells, storage-type changes, factor conversions, blank
# strings turned into NA, and Stata metadata that was dropped or kept.
#
# Usage (from the package root):
#   Rscript data-raw/audit/raw_vs_shipped.R
# Output:
#   data-raw/audit/raw_vs_shipped.csv
# ---------------------------------------------------------------------------

suppressPackageStartupMessages({
  library(haven)
  library(tibble)
})

manifest <- utils::read.csv("data-raw/source/MANIFEST.csv", stringsAsFactors = FALSE)
manifest <- manifest[manifest$role == "raw", ]  # auxiliary sources (titanic3.csv) are not Stata files
rows <- list()
add <- function(dataset, variable, change, n_cells, detail) {
  rows[[length(rows) + 1]] <<- data.frame(
    dataset = dataset, variable = variable, change = change,
    n_cells = n_cells, detail = detail, stringsAsFactors = FALSE
  )
}

plain <- function(x) {
  # values as a plain vector for comparison; "" counts as missing for text
  if (inherits(x, "haven_labelled")) x <- haven::zap_labels(x)
  if (is.factor(x)) return(as.character(x))
  attributes(x) <- NULL
  if (is.character(x)) x[x == ""] <- NA
  x
}

for (i in seq_len(nrow(manifest))) {
  ds  <- manifest$dataset[i]
  raw <- haven::read_dta(file.path("data-raw/source", manifest$file[i]))
  env <- new.env(); load(file.path("data", paste0(ds, ".rda")), envir = env)
  shp <- get(ds, envir = env)
  n_changes <- 0L

  # --- columns: renamed (same position, same values), dropped, added ---------
  rn <- names(raw); sn <- names(shp)
  only_raw <- setdiff(rn, sn); only_shp <- setdiff(sn, rn)
  renamed <- character(0)
  for (o in only_raw) {
    pos <- match(o, rn)
    if (pos <= length(sn) && sn[pos] %in% only_shp &&
        nrow(raw) == nrow(shp) &&
        isTRUE(all.equal(plain(raw[[o]]), plain(shp[[sn[pos]]]), check.attributes = FALSE))) {
      add(ds, sn[pos], "renamed", NA, sprintf("%s -> %s (values identical)", o, sn[pos]))
      renamed <- c(renamed, o); only_shp <- setdiff(only_shp, sn[pos]); n_changes <- n_changes + 1L
    }
  }
  for (o in setdiff(only_raw, renamed)) {
    add(ds, o, "dropped_column", nrow(raw), "present in raw file, absent from shipped data"); n_changes <- n_changes + 1L
  }
  for (o in only_shp) {
    add(ds, o, "added_column", nrow(shp), "absent from raw file"); n_changes <- n_changes + 1L
  }

  # --- per common column ------------------------------------------------------
  name_map <- stats::setNames(sn, sn)
  for (o in renamed) name_map[o] <- sn[match(o, rn)]
  common <- c(intersect(rn, sn), renamed)
  for (v in common) {
    sv <- if (v %in% renamed) name_map[[v]] else v
    r <- raw[[v]]; s <- shp[[sv]]

    if (is.factor(s) && !is.factor(r)) {
      lv <- levels(s)
      codes <- sort(unique(stats::na.omit(as.numeric(plain(r)))))
      add(ds, sv, "converted_to_factor", NA,
          sprintf("raw codes {%s} -> factor levels {%s}", paste(codes, collapse = ","), paste(lv, collapse = ",")))
      n_changes <- n_changes + 1L
      next
    }
    rt <- typeof(plain(r)); st <- typeof(plain(s))
    if (rt != st && !(rt %in% c("double", "integer") && st %in% c("double", "integer"))) {
      add(ds, sv, "type_changed", NA, sprintf("%s -> %s", rt, st)); n_changes <- n_changes + 1L
    }
    if (rt != st && rt %in% c("double", "integer") && st %in% c("double", "integer")) {
      add(ds, sv, "storage_changed", NA, sprintf("%s -> %s (values compared numerically)", rt, st))
    }

    # blank strings in the raw text that became NA
    if (is.character(r)) {
      nb <- sum(r == "", na.rm = TRUE)
      sb <- if (is.character(s)) sum(s == "", na.rm = TRUE) else 0
      if (nb > 0 && sb == 0) { add(ds, sv, "blank_to_na", nb, sprintf("%d blank strings -> NA", nb)); n_changes <- n_changes + 1L }
      if (nb > 0 && sb > 0)  add(ds, sv, "blank_kept", sb, sprintf("%d blank strings still present", sb))
    }

    # recoded cells
    rp <- plain(r); sp <- plain(s)
    if (length(rp) == length(sp)) {
      if (is.numeric(rp) && is.numeric(sp)) { rp <- as.numeric(rp); sp <- as.numeric(sp) }
      same <- (is.na(rp) & is.na(sp)) | (!is.na(rp) & !is.na(sp) & rp == sp)
      diff_idx <- which(!same)
      if (length(diff_idx)) {
        pairs <- table(paste(ifelse(is.na(rp[diff_idx]), "NA", format(rp[diff_idx])), "->",
                             ifelse(is.na(sp[diff_idx]), "NA", format(sp[diff_idx]))))
        add(ds, sv, "values_recoded", length(diff_idx),
            paste(sprintf("%s (%d)", trimws(names(pairs)), as.integer(pairs)), collapse = "; "))
        n_changes <- n_changes + 1L
      }
    }

    # Stata metadata
    vl <- attr(r, "labels", exact = TRUE)
    if (!is.null(vl) && is.null(attr(s, "labels", exact = TRUE)) && !is.factor(s)) {
      add(ds, sv, "value_labels_dropped", NA,
          paste(sprintf("%s=%s", unname(vl), names(vl)), collapse = "; "))
    }
    lab <- attr(r, "label", exact = TRUE)
    if (!is.null(lab) && is.null(attr(s, "label", exact = TRUE))) {
      add(ds, sv, "variable_label_dropped", NA, lab)
    }
    if (!is.null(attr(s, "format.stata", exact = TRUE))) {
      add(ds, sv, "stata_format_kept", NA, attr(s, "format.stata", exact = TRUE))
    }
  }

  if (n_changes == 0L) {
    add(ds, "", "values_identical", NA, "no renamed/dropped/added columns and no recoded cells")
  }
}

out <- do.call(rbind, rows)
out <- out[order(out$dataset, out$change, out$variable), ]
utils::write.csv(out, "data-raw/audit/raw_vs_shipped.csv", row.names = FALSE, na = "")

# console summary
summ <- table(out$dataset, out$change)
print(summ[, colSums(summ) > 0, drop = FALSE])
