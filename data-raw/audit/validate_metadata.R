# validate_metadata.R ---------------------------------------------------------
# Step 5.5: cross-validate inst/extdata/registry.csv and
# inst/extdata/codebook.csv against data/ (contract rules C1, C2, C3, C6, C7).
# These checks become the testthat contract suite in Phase 7.
# Usage (from the package root): Rscript data-raw/audit/validate_metadata.R
# Exits with an error if any check fails.
# ---------------------------------------------------------------------------
suppressPackageStartupMessages(library(tibble))
reg <- utils::read.csv("inst/extdata/registry.csv", stringsAsFactors = FALSE, na.strings = "", encoding = "UTF-8")
cb  <- utils::read.csv("inst/extdata/codebook.csv", stringsAsFactors = FALSE, na.strings = "", encoding = "UTF-8")
rl  <- utils::read.csv("data-raw/audit/recode_log.csv", stringsAsFactors = FALSE)
files <- sub("[.]rda$", "", list.files("data", pattern = "[.]rda$"))
problems <- character(0)
bad <- function(...) problems <<- c(problems, paste0(...))
topics <- c("simple-regression", "ancova", "anova", "continuous-predictors", "interactions",
            "nonlinear", "model-building", "diagnostics", "logistic", "glm-latent", "ordinal",
            "multilevel-longitudinal")

# registry ------------------------------------------------------------------
if (!setequal(reg$dataset, files)) bad("registry datasets differ from data/: ", paste(setdiff(union(reg$dataset, files), intersect(reg$dataset, files)), collapse = ", "))
for (k in c("title", "description", "topics", "unit", "source_citation", "source_route", "redistribution_basis", "provenance_status")) {
  if (any(is.na(reg[[k]]))) bad("registry: empty ", k, " for ", paste(reg$dataset[is.na(reg[[k]])], collapse = ", "))
}
bad_topics <- setdiff(unlist(strsplit(reg$topics, ";")), topics)
if (length(bad_topics)) bad("registry: unknown topics ", paste(bad_topics, collapse = ", "))
if (!all(reg$provenance_status %in% c("verified", "probable"))) bad("registry: bad provenance_status")

# data vs registry and codebook --------------------------------------------
for (d in files) {
  e <- new.env(); load(file.path("data", paste0(d, ".rda")), envir = e); x <- get(d, e)
  r <- reg[reg$dataset == d, ]
  if (nrow(r) == 1 && (r$n_rows != nrow(x) || r$n_cols != ncol(x))) bad(d, ": registry dims ", r$n_rows, "x", r$n_cols, " vs data ", nrow(x), "x", ncol(x))
  v <- cb[cb$dataset == d, ]
  v <- v[order(v$position), ]
  if (!identical(v$variable, names(x))) { bad(d, ": codebook variables/order differ from the data"); next }
  if (!identical(as.integer(v$position), seq_along(x))) bad(d, ": codebook positions are not 1..", ncol(x))
  typ <- vapply(x, function(c) if (is.factor(c)) "factor" else typeof(c), character(1))
  if (any(typ != v$type)) bad(d, ": type mismatch for ", paste(names(x)[typ != v$type], collapse = ", "))
  na_now <- vapply(x, function(c) sum(is.na(c)), numeric(1))
  if (any(na_now != v$na_count)) bad(d, ": na_count mismatch for ", paste(names(x)[na_now != v$na_count], collapse = ", "))
  if (any(is.na(v$label))) bad(d, ": empty label for ", paste(v$variable[is.na(v$label)], collapse = ", "))
  if (any(v$status != "curated")) bad(d, ": not curated: ", paste(v$variable[v$status != "curated"], collapse = ", "))
  logged <- unique(rl$variable[rl$dataset == d])
  has_note <- v$variable[!is.na(v$recoded_to_na)]
  if (!setequal(logged, has_note)) bad(d, ": recoded_to_na disagrees with recode_log for ", paste(setdiff(union(logged, has_note), intersect(logged, has_note)), collapse = ", "))
  for (i in seq_len(nrow(v))) {             # every observed code must be explained
    col <- x[[v$variable[i]]]
    if (is.na(v$values[i]) || is.double(col) || is.factor(col)) next
    obs <- sort(unique(stats::na.omit(col)))
    if (length(obs) > 15) next
    codes <- gsub('^"|"$', "", trimws(sub("=.*$", "", strsplit(v$values[i], ";", fixed = TRUE)[[1]])))
    ranges <- grepl("^[0-9]+-[0-9]+$", codes)
    covered <- vapply(as.character(obs), function(o) {
      o %in% codes || any(vapply(codes[ranges], function(rg) { b <- as.numeric(strsplit(rg, "-")[[1]]); as.numeric(o) >= b[1] && as.numeric(o) <= b[2] }, logical(1)))
    }, logical(1))
    if (!all(covered)) bad(d, "$", v$variable[i], ": values do not explain observed code(s) ", paste(obs[!covered], collapse = ", "))
  }
}
extra <- setdiff(unique(cb$dataset), files)
if (length(extra)) bad("codebook has datasets not in data/: ", paste(extra, collapse = ", "))

cat(sprintf("registry: %d datasets | codebook: %d variables | problems: %d\n", nrow(reg), nrow(cb), length(problems)))
if (length(problems)) { cat(paste0(" - ", problems), sep = "\n"); quit(status = 1) }
cat("all metadata checks passed\n")
