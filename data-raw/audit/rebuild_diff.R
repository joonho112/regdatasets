# rebuild_diff.R -------------------------------------------------------------
# Contract C10: list every difference between the v0.2.0 data and the rebuilt
# data, and map each one to the Gate B item that approved it.
#
# Usage (from the package root):
#   Rscript data-raw/audit/rebuild_diff.R <folder with the v0.2.0 data/*.rda>
# Writes data-raw/audit/rebuild_diff.csv and stops with an error if any
# difference has no approval.
# ---------------------------------------------------------------------------
suppressPackageStartupMessages(library(tibble))
old_dir <- commandArgs(trailingOnly = TRUE)[1]
load_obj <- function(dir, name) { e <- new.env(); load(file.path(dir, paste0(name, ".rda")), envir = e); get(name, e) }
plainv <- function(x) { if (is.factor(x)) return(as.character(x)); attributes(x) <- NULL; x }

old_names <- sub("[.]rda$", "", list.files(old_dir, pattern = "[.]rda$"))
new_names <- sub("[.]rda$", "", list.files("data", pattern = "[.]rda$"))
rl <- utils::read.csv("data-raw/audit/recode_log.csv", stringsAsFactors = FALSE)

rows <- list()
add <- function(dataset, variable, change, n_cells, detail, gate_b) {
  rows[[length(rows) + 1]] <<- data.frame(dataset = dataset, variable = variable, change = change,
    n_cells = n_cells, detail = detail, gate_b = gate_b, stringsAsFactors = FALSE)
}

for (d in setdiff(old_names, new_names)) {
  add(d, "", "dataset_removed", NA, "no longer shipped",
      c(lambert = "PROV-1", civic_ed = "PROV-2")[d])
}
for (d in setdiff(new_names, old_names)) add(d, "", "dataset_added", NA, "", NA)

for (d in intersect(old_names, new_names)) {
  o <- load_obj(old_dir, d); n <- load_obj("data", d)
  if (d == "classdata_07") {
    add(d, "", "values_simulated", nrow(n) * ncol(n),
        "every value replaced by the seeded simulation; names and types kept", "PROV-3")
    next
  }
  for (v in setdiff(names(o), names(n))) add(d, v, "column_removed", nrow(o), "", if (d == "gcse" && v == "pred") "COL-3" else NA)
  for (v in setdiff(names(n), names(o))) add(d, v, "column_added", nrow(n), "", NA)
  n_attr <- sum(vapply(o, function(x) length(setdiff(names(attributes(x)), c("class", "levels"))) > 0, logical(1))) +
            length(setdiff(names(attributes(o)), c("names", "row.names", "class")))
  if (n_attr > 0) add(d, "", "attributes_removed", NA, sprintf("%d columns or data-frame attributes stripped", n_attr), "D5")
  for (v in intersect(names(o), names(n))) {
    a <- o[[v]]; b <- n[[v]]
    if (!identical(class(a), class(b))) add(d, v, "class_changed", NA, paste(class(a)[1], "->", class(b)[1]), NA)
    if (is.factor(a) && is.factor(b) && !identical(levels(a), levels(b))) {
      add(d, v, "levels_changed", NA, paste(paste(levels(a), collapse = "|"), "->", paste(levels(b), collapse = "|")),
          if (v == "race") "DOC-1" else NA)
    }
    pa <- plainv(a); pb <- plainv(b)
    same <- (is.na(pa) & is.na(pb)) | (!is.na(pa) & !is.na(pb) & pa == pb)
    idx <- which(!same)
    if (!length(idx)) next
    to_na <- idx[!is.na(pa[idx]) & is.na(pb[idx])]
    other <- setdiff(idx, to_na)
    if (length(to_na)) {
      logged <- rl[rl$dataset == d & rl$variable == v, ]
      gate <- if (nrow(logged)) paste(sort(unique(ifelse(logged$gate_b == "NR", if (d == "nels_data") "NR-1" else "NR-2", logged$gate_b))), collapse = "+") else NA
      if (d == "titanic" && v == "embarked") gate <- "VAL-2"   # NA positions moved with the corrected column
      tab <- table(pa[to_na])
      add(d, v, "values_to_na", length(to_na), paste(sprintf("%s (%d)", names(tab), as.integer(tab)), collapse = "; "), gate)
    }
    if (length(other)) {
      gate <- if (d == "titanic" && v == "embarked") "VAL-2" else if (v == "race") "DOC-1" else NA
      tab <- table(paste(ifelse(is.na(pa[other]), "NA", pa[other]), "->", ifelse(is.na(pb[other]), "NA", pb[other])))
      add(d, v, "values_changed", length(other), paste(sprintf("%s (%d)", names(tab), as.integer(tab)), collapse = "; "), gate)
    }
  }
}

out <- do.call(rbind, rows)
out <- out[order(out$dataset, out$change, out$variable), ]
utils::write.csv(out, "data-raw/audit/rebuild_diff.csv", row.names = FALSE, na = "")
unapproved <- out[is.na(out$gate_b), ]
cat(sprintf("rebuild_diff.csv: %d rows; unapproved: %d\n", nrow(out), nrow(unapproved)))
print(aggregate(n_cells ~ gate_b + change, data = transform(out, n_cells = ifelse(is.na(n_cells), 0, n_cells)), sum))
if (nrow(unapproved)) { print(unapproved); stop("unapproved differences (contract C10)") }
