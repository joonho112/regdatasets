# helpers.R -----------------------------------------------------------------
# Shared helpers for data-raw/recipes/*.R. Sourced by build_all.R.
# Every recipe returns a plain tibble; build_all.R checks it against the data
# contract (data-raw/CONTRACT.md) before saving.
# ---------------------------------------------------------------------------

suppressPackageStartupMessages({
  library(haven)
  library(tibble)
})

MANIFEST <- utils::read.csv("data-raw/source/MANIFEST.csv", stringsAsFactors = FALSE)

# Read a vendored source file after verifying its SHA-256 against the manifest.
source_file <- function(file) {
  path <- file.path("data-raw", "source", file)
  row  <- MANIFEST[MANIFEST$file == file, , drop = FALSE]
  if (nrow(row) != 1) stop("not in MANIFEST.csv: ", file, call. = FALSE)
  got <- digest::digest(file = path, algo = "sha256")
  if (!identical(got, row$sha256)) stop("checksum mismatch for ", file, call. = FALSE)
  path
}
read_raw <- function(file) haven::read_dta(source_file(file))

# Plain data (contract C5): drop value labels, variable labels, Stata formats
# and data-frame attributes. Whole-number doubles become integers, the rule
# that reproduces every v0.2.0 column class (verified on all 482 columns).
plain_vector <- function(x) {
  if (inherits(x, "haven_labelled")) x <- haven::zap_labels(x)
  if (is.factor(x)) return(factor(as.character(x), levels = levels(x)))
  attributes(x) <- NULL
  if (is.double(x) && all(is.na(x) | (x == round(x) & abs(x) < .Machine$integer.max))) {
    x <- as.integer(x)
  }
  x
}
plain <- function(df) {
  out <- lapply(df, plain_vector)
  tibble::as_tibble(out)
}

# Gate B DK-1: "don't know" on ordered scales is recoded to NA in these
# variables; "don't know" elsewhere is kept as a category (DK-2).
DK1_VARIABLES <- list(
  nels_data = c("bypared", "bys34a", "bys34b", "f1s17"),
  disc      = c("bys34a", "bys34b")
)

# Recode NELS nonresponse codes to NA, driven by audit/missing_codes.csv
# (Gate B NR-1, NR-2, DK-1). Returns the data and a per-variable change log.
codes_to_na <- function(df, dataset) {
  mc <- utils::read.csv("data-raw/audit/missing_codes.csv", stringsAsFactors = FALSE)
  rules <- mc[mc$dataset == dataset &
                (mc$action == "to_na" |
                   (mc$action == "review" & mc$variable %in% DK1_VARIABLES[[dataset]])), ]
  log <- list()
  for (i in seq_len(nrow(rules))) {
    v <- rules$variable[i]
    code <- rules$code[i]
    if (!v %in% names(df)) next
    hit <- which(df[[v]] == code)
    if (length(hit)) {
      df[[v]][hit] <- NA
      log[[length(log) + 1]] <- data.frame(
        dataset = dataset, variable = v, code = code, code_label = sub("respnse", "response", gsub("^", "'", rules$code_label[i], fixed = TRUE), fixed = TRUE),
        n_cells = length(hit), gate_b = if (rules$action[i] == "to_na") "NR" else "DK-1",
        stringsAsFactors = FALSE
      )
    }
  }
  # Gate B NR-1b: NELS composites whose missing codes are not integers
  # (99.98, 99.99, 99.998, 9.8). Stata value labels cannot carry non-integer
  # codes, so these are documented in the NELS codebook instead; see
  # audit/missing_codes_codebook.csv. Matched with a tolerance because the
  # raw values are single-precision floats (e.g. 99.98000336).
  fc <- utils::read.csv("data-raw/audit/missing_codes_codebook.csv", stringsAsFactors = FALSE)
  fc <- fc[fc$dataset == dataset, ]
  for (i in seq_len(nrow(fc))) {
    v <- fc$variable[i]
    if (!v %in% names(df)) next
    hit <- which(abs(df[[v]] - fc$code[i]) < 5e-4)
    if (length(hit)) {
      df[[v]][hit] <- NA
      log[[length(log) + 1]] <- data.frame(
        dataset = dataset, variable = v, code = fc$code[i], code_label = fc$code_label[i],
        n_cells = length(hit), gate_b = "NR-1b", stringsAsFactors = FALSE
      )
    }
  }
  attr(df, "recode_log") <- if (length(log)) do.call(rbind, log) else NULL
  df
}

# Contract checks that must hold before a dataset is saved (C1, C4, C5).
assert_contract <- function(df, name) {
  fail <- function(...) stop(sprintf("[%s] contract violation: ", name), ..., call. = FALSE)
  if (!inherits(df, "tbl_df")) fail("not a tibble (C1)")
  if (nrow(df) < 1) fail("no rows (C1)")
  extra_df <- setdiff(names(attributes(df)), c("names", "row.names", "class"))
  if (length(extra_df)) fail("data-frame attributes ", paste(extra_df, collapse = ", "), " (C5)")
  for (v in names(df)) {
    x <- df[[v]]
    allowed <- if (is.factor(x)) c("levels", "class") else character(0)
    extra <- setdiff(names(attributes(x)), allowed)
    if (length(extra)) fail(v, " has attributes ", paste(extra, collapse = ", "), " (C5)")
    if (is.character(x) && any(x %in% c("", "-1"))) fail(v, " contains \"\" or \"-1\" (C4)")
  }
  if (name %in% c("nels_data", "disc")) {
    mc <- utils::read.csv("data-raw/audit/missing_codes.csv", stringsAsFactors = FALSE)
    rules <- mc[
      mc$dataset == name & (
        mc$action == "to_na" |
          (mc$action == "review" & mc$variable %in% DK1_VARIABLES[[name]])
      ),
    ]
    for (i in seq_len(nrow(rules))) {
      v <- rules$variable[i]
      if (v %in% names(df) && any(df[[v]] == rules$code[i], na.rm = TRUE)) {
        fail(v, " still holds nonresponse code ", rules$code[i], " (C4)")
      }
    }
    fc <- utils::read.csv("data-raw/audit/missing_codes_codebook.csv", stringsAsFactors = FALSE)
    fc <- fc[fc$dataset == name, ]
    for (i in seq_len(nrow(fc))) {
      v <- fc$variable[i]
      if (v %in% names(df) && any(abs(df[[v]] - fc$code[i]) < 5e-4, na.rm = TRUE)) {
        fail(v, " still holds codebook missing code ", fc$code[i], " (C4)")
      }
    }
  }
  invisible(TRUE)
}
