# fingerprint.R -------------------------------------------------------------
# Reproducible fingerprint of every dataset shipped in data/.
#
# Usage (from anywhere):
#   Rscript data-raw/audit/fingerprint.R <package_dir> <output_prefix>
#
# Writes two CSV files:
#   <output_prefix>-columns.csv   one row per dataset x column
#   <output_prefix>-datasets.csv  one row per dataset
#
# `values_sha256` hashes the values only (attributes stripped; factors are
# hashed as their character labels), so attribute-only changes do not alter
# it. `object_sha256` hashes the complete R object, attributes included.
# Used for the v0.2.0 baseline (Step 1.2), the rebuild checks (Step 4.5) and
# the release check (Step 9.1).
# ---------------------------------------------------------------------------

args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 2) {
  stop("usage: Rscript fingerprint.R <package_dir> <output_prefix>", call. = FALSE)
}
pkg_dir <- args[[1]]
prefix  <- args[[2]]

if (!requireNamespace("digest", quietly = TRUE)) stop("package 'digest' is required")
suppressPackageStartupMessages(library(tibble))  # so tibbles deserialize cleanly

sha <- function(x) digest::digest(x, algo = "sha256")

values_only <- function(x) {
  if (is.factor(x)) return(as.character(x))
  attributes(x) <- NULL
  x
}

fmt_num <- function(x) if (length(x) == 0 || all(is.na(x))) NA_character_ else format(x, digits = 15)

files <- sort(list.files(file.path(pkg_dir, "data"), pattern = "\\.rda$", full.names = TRUE))
col_rows <- list()
ds_rows  <- list()

for (f in files) {
  env  <- new.env()
  objs <- load(f, envir = env)
  for (nm in objs) {
    x <- get(nm, envir = env)
    std_df_attrs <- c("names", "row.names", "class")
    df_attrs <- setdiff(names(attributes(x)), std_df_attrs)
    ds_rows[[length(ds_rows) + 1]] <- data.frame(
      dataset        = nm,
      file           = basename(f),
      class          = paste(class(x), collapse = "/"),
      n_rows         = nrow(x),
      n_cols         = ncol(x),
      df_attributes  = paste(df_attrs, collapse = ";"),
      values_sha256  = sha(lapply(x, values_only)),
      object_sha256  = sha(x),
      file_bytes     = file.size(f),
      stringsAsFactors = FALSE
    )
    for (i in seq_along(x)) {
      v   <- x[[i]]
      std <- if (is.factor(v)) c("class", "levels") else character(0)
      extra_attrs <- setdiff(names(attributes(v)), std)
      nonmiss <- v[!is.na(v)]
      is_num <- is.numeric(v)
      col_rows[[length(col_rows) + 1]] <- data.frame(
        dataset        = nm,
        position       = i,
        variable       = names(x)[i],
        class          = paste(class(v), collapse = "/"),
        typeof         = typeof(v),
        n              = length(v),
        n_na           = sum(is.na(v)),
        n_unique       = length(unique(nonmiss)),
        min            = if (is_num) fmt_num(suppressWarnings(min(nonmiss))) else NA_character_,
        max            = if (is_num) fmt_num(suppressWarnings(max(nonmiss))) else NA_character_,
        n_blank        = if (is.character(v)) sum(nonmiss == "") else NA_integer_,
        levels         = if (is.factor(v)) paste(levels(v), collapse = "|") else NA_character_,
        attributes     = paste(extra_attrs, collapse = ";"),
        label          = if (!is.null(attr(v, "label", exact = TRUE))) as.character(attr(v, "label", exact = TRUE)) else NA_character_,
        values_sha256  = sha(values_only(v)),
        stringsAsFactors = FALSE
      )
    }
  }
}

cols <- do.call(rbind, col_rows)
dsets <- do.call(rbind, ds_rows)
utils::write.csv(cols,  paste0(prefix, "-columns.csv"),  row.names = FALSE, na = "")
utils::write.csv(dsets, paste0(prefix, "-datasets.csv"), row.names = FALSE, na = "")
cat(sprintf("fingerprint: %d datasets, %d columns -> %s-{columns,datasets}.csv\n",
            nrow(dsets), nrow(cols), prefix))
