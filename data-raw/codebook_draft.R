# codebook_draft.R ------------------------------------------------------------
# Step 5.1: seed data-raw/codebook/<name>.csv for every shipped dataset from
# what is already known, for curation in Steps 5.2-5.3:
#   - type and observed values from the rebuilt data/;
#   - variable and value labels from the raw Stata files (disc borrows the
#     NELS labels of the same-named nels_data variables);
#   - recoded_to_na from data-raw/audit/recode_log.csv;
#   - the v0.2.0 help text (R/data.R) as `old_doc`, for reference only:
#     it contains known errors (see audit/provenance.csv).
# Run once from the package root. It refuses to overwrite a curated file.
# ---------------------------------------------------------------------------
suppressPackageStartupMessages({ library(haven); library(tibble) })

manifest <- utils::read.csv("data-raw/source/MANIFEST.csv", stringsAsFactors = FALSE)
recode   <- utils::read.csv("data-raw/audit/recode_log.csv", stringsAsFactors = FALSE)
nonresp  <- c("{missing}", "{refusal}", "{legitimate skip}", "{multiple respnse}", "{test not comp}")
dir.create("data-raw/codebook", showWarnings = FALSE)

# v0.2.0 help text, per dataset and variable
old_items <- local({
  src <- readLines("R/data.R", warn = FALSE)
  ends <- grep('^"[a-z0-9_]+"$', src)
  starts <- c(1, head(ends, -1) + 1)
  out <- list()
  for (k in seq_along(ends)) {
    ds <- gsub('"', "", src[ends[k]])
    txt <- paste(sub("^#' ?", "", src[starts[k]:ends[k]]), collapse = " ")
    mm <- gregexpr("\\\\item\\{([^}]*)\\}\\{", txt)
    m <- mm[[1]]
    if (m[1] == -1) next
    hits <- regmatches(txt, mm)[[1]]
    for (j in seq_along(m)) {
      st <- m[j] + attr(m, "match.length")[j]
      depth <- 1; pos <- st
      while (depth > 0 && pos <= nchar(txt)) {
        ch <- substr(txt, pos, pos)
        if (ch == "{") depth <- depth + 1 else if (ch == "}") depth <- depth - 1
        pos <- pos + 1
      }
      nm <- sub("\\\\item\\{([^}]*)\\}\\{", "\\1", hits[j])
      out[[paste(ds, nm, sep = "::")]] <- gsub("\\s+", " ", trimws(substr(txt, st, pos - 2)))
    }
  }
  out
})

nels_raw <- haven::read_dta("data-raw/source/nels_data.dta")
fmt_labels <- function(lab) {
  if (is.null(lab) || !length(lab)) return("")
  keep <- !names(lab) %in% nonresp
  if (!any(keep)) return("")
  paste(sprintf("%s = %s", unname(lab[keep]), names(lab[keep])), collapse = "; ")
}
observed <- function(x) {
  if (is.factor(x)) return(paste("levels:", paste(levels(x), collapse = " | ")))
  u <- sort(unique(stats::na.omit(x)))
  if (!length(u)) return("all NA")
  if (length(u) <= 12) return(paste("values:", paste(u, collapse = ", ")))
  if (is.numeric(u)) return(sprintf("range %s to %s (%d distinct)", format(min(u)), format(max(u)), length(u)))
  sprintf("%d distinct, e.g. %s", length(u), paste(utils::head(u, 3), collapse = ", "))
}

for (ds in sort(unique(manifest$dataset))) {
  out_path <- file.path("data-raw/codebook", paste0(ds, ".csv"))
  if (file.exists(out_path)) {
    prev <- utils::read.csv(out_path, stringsAsFactors = FALSE)
    if (any(prev$status == "curated")) { cat("skip (curated):", ds, "\n"); next }
  }
  e <- new.env(); load(file.path("data", paste0(ds, ".rda")), envir = e); x <- get(ds, e)
  raw_file <- manifest$file[manifest$dataset == ds & manifest$role == "raw"]
  raw <- if (length(raw_file)) haven::read_dta(file.path("data-raw/source", raw_file)) else NULL
  rows <- lapply(seq_along(x), function(i) {
    v <- names(x)[i]; col <- x[[v]]
    rv <- if (!is.null(raw) && v %in% names(raw)) raw[[v]] else if (ds == "berkeley" && v == "department") raw[["departme"]] else NULL
    if (ds == "disc" && v %in% names(nels_raw) && is.null(attr(rv, "labels"))) rv <- nels_raw[[v]]
    rc <- recode[recode$dataset == ds & recode$variable == v, ]
    data.frame(
      dataset = ds, variable = v, position = i,
      type = if (is.factor(col)) "factor" else typeof(col),
      label = if (!is.null(rv) && !is.null(attr(rv, "label", exact = TRUE))) gsub("\\^", "'", attr(rv, "label", exact = TRUE)) else "",
      values = if (is.factor(col)) paste(levels(col), collapse = "; ") else gsub("\\^", "'", fmt_labels(attr(rv, "labels"))),
      units = "", group = "",
      recoded_to_na = if (nrow(rc)) paste(sprintf("%s %s: %d", rc$code, rc$code_label, rc$n_cells), collapse = "; ") else "",
      notes = "", status = "draft",
      observed = observed(col),
      old_doc = if (!is.null(old_items[[paste(ds, v, sep = "::")]])) old_items[[paste(ds, v, sep = "::")]] else "",
      stringsAsFactors = FALSE
    )
  })
  cb <- do.call(rbind, rows)
  utils::write.csv(cb, out_path, row.names = FALSE, na = "", fileEncoding = "UTF-8")
  cat(sprintf("draft %-13s %3d variables (raw labels: %d, value labels: %d, old doc: %d)\n", ds, nrow(cb),
              sum(nzchar(cb$label)), sum(nzchar(cb$values)), sum(nzchar(cb$old_doc))))
}
