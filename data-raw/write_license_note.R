# write_license_note.R --------------------------------------------------------
# Regenerate LICENSE.note from inst/extdata/registry.csv, so the per-dataset
# provenance statement can never drift from the registry.
# Usage (from the package root): Rscript data-raw/write_license_note.R
# ---------------------------------------------------------------------------
reg <- utils::read.csv(
  "inst/extdata/registry.csv",
  stringsAsFactors = FALSE,
  na.strings = "",
  encoding = "UTF-8"
)
wrap <- function(x, indent = "  ") {
  paste(strwrap(x, width = 76, prefix = indent, initial = indent), collapse = "\n")
}

head <- c(
  "LICENSE.note for regdatasets",
  "============================",
  "",
  "The R code, documentation and package infrastructure of regdatasets are",
  "released under the MIT License (see LICENSE and LICENSE.md).",
  "",
  "The datasets come from published studies, textbooks and public data",
  "archives, each with its own terms. This note records, for every dataset,",
  "its original source, how it reached this package, why it may be",
  "redistributed, and how firmly its provenance is established (\"verified\":",
  "a checkable source ties this exact dataset to its origin; \"probable\": a",
  "strong match without an explicit statement). Each dataset's help page",
  "summarizes its source and provenance; the full metadata live in",
  "inst/extdata/registry.csv (see list_datasets() for titles and topics).",
  "",
  "Most datasets reached this package as teaching extracts used in the",
  "course EDUC 275B (Graduate School of Education, University of California,",
  "Berkeley). This package is not associated with or endorsed by the",
  "original data producers.",
  "",
  "Removed in version 1.0.0: `lambert` and `civic_ed`, because no basis for",
  "redistributing them could be established. `naep` was removed in 0.2.0",
  "(restricted-use NCES data).",
  "",
  "If you believe a dataset is included in error, please contact the",
  "maintainer listed in DESCRIPTION.",
  "",
  "Dataset-level provenance",
  "========================"
)
body <- unlist(lapply(seq_len(nrow(reg)), function(i) {
  r <- reg[i, ]
  c("",
    sprintf("%s (%s)", r$dataset, r$title),
    wrap(paste("Source:", r$source_citation)),
    wrap(paste("Route:", r$source_route)),
    wrap(paste("Basis:", r$redistribution_basis)),
    sprintf("  Provenance: %s", r$provenance_status),
    if (!is.na(r$notes)) wrap(paste("Note:", r$notes)))
}))
writeLines(c(head, body), "LICENSE.note")
cat("LICENSE.note written for", nrow(reg), "datasets\n")
