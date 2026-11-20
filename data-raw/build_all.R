# build_all.R ---------------------------------------------------------------
# Rebuild every dataset in data/ from the vendored sources. The one rule:
#   source("data-raw/build_all.R")  ->  devtools::document()  ->  devtools::check()
# Run from the package root. Never edit data/*.rda by hand.
#
# For each dataset listed in data-raw/source/MANIFEST.csv:
#   1. source data-raw/recipes/<name>.R and call recipe();
#   2. check the result against the data contract (data-raw/CONTRACT.md);
#   3. save data/<name>.rda (xz, serialization version 3).
# Then:
#   - delete data/*.rda files that are no longer built (removed datasets);
#   - write data-raw/audit/recode_log.csv (cells recoded to NA, per variable);
#   - when inst/extdata/registry.csv exists, rewrite its n_rows / n_cols;
#   - when data-raw/codebook/*.csv exist, compile inst/extdata/codebook.csv
#     (adding the na_count column from the data).
# ---------------------------------------------------------------------------

source("data-raw/helpers.R")

datasets <- sort(unique(MANIFEST$dataset))
built <- list()
recode_logs <- list()

for (name in datasets) {
  env <- new.env(parent = globalenv())
  sys.source(file.path("data-raw", "recipes", paste0(name, ".R")), envir = env)
  df <- env$recipe()
  log <- attr(df, "recode_log")
  attr(df, "recode_log") <- NULL
  if (!is.null(log)) recode_logs[[name]] <- log
  assert_contract(df, name)
  assign(name, df, envir = env)
  save(list = name, file = file.path("data", paste0(name, ".rda")), envir = env,
       compress = "xz", version = 3)
  built[[name]] <- df
  cat(sprintf("built %-13s %6d rows x %3d cols\n", name, nrow(df), ncol(df)))
}

stale <- setdiff(sub("[.]rda$", "", list.files("data", pattern = "[.]rda$")), datasets)
if (length(stale)) {
  file.remove(file.path("data", paste0(stale, ".rda")))
  cat("removed datasets no longer built:", paste(stale, collapse = ", "), "\n")
}

if (length(recode_logs)) {
  rl <- do.call(rbind, recode_logs)
  utils::write.csv(rl, "data-raw/audit/recode_log.csv", row.names = FALSE)
  cat(sprintf("recoded to NA: %s cells (see data-raw/audit/recode_log.csv)\n",
              format(sum(rl$n_cells), big.mark = ",")))
}

# --- metadata kept in sync with the data --------------------------------------
reg_path <- "inst/extdata/registry.csv"
if (file.exists(reg_path)) {
  reg <- utils::read.csv(reg_path, stringsAsFactors = FALSE, na.strings = "", encoding = "UTF-8")
  stopifnot(setequal(reg$dataset, datasets))
  reg$n_rows <- vapply(reg$dataset, function(d) nrow(built[[d]]), integer(1))
  reg$n_cols <- vapply(reg$dataset, function(d) ncol(built[[d]]), integer(1))
  raw <- MANIFEST[MANIFEST$role %in% c("raw", "simulated"), ]
  reg$raw_file   <- raw$file[match(reg$dataset, raw$dataset)]
  reg$raw_sha256 <- raw$sha256[match(reg$dataset, raw$dataset)]
  utils::write.csv(reg, reg_path, row.names = FALSE, na = "", fileEncoding = "UTF-8")
  cat("registry dimensions updated\n")
}

cb_files <- list.files("data-raw/codebook", pattern = "[.]csv$", full.names = TRUE)
cb_cols <- c("dataset", "variable", "position", "type", "label", "values", "units",
             "group", "recoded_to_na", "notes", "status")
if (length(cb_files)) {
  dir.create("inst/extdata", recursive = TRUE, showWarnings = FALSE)
  cb <- do.call(rbind, lapply(cb_files, function(f) {
    x <- utils::read.csv(f, stringsAsFactors = FALSE, na.strings = "", encoding = "UTF-8")
    x[, cb_cols]   # draft-only helper columns (observed, old_doc) are not shipped
  }))
  cb$na_count <- mapply(function(d, v) {
    if (!d %in% names(built) || !v %in% names(built[[d]])) return(NA_integer_)
    sum(is.na(built[[d]][[v]]))
  }, cb$dataset, cb$variable, USE.NAMES = FALSE)
  cb <- cb[order(cb$dataset, cb$position), ]
  utils::write.csv(cb, "inst/extdata/codebook.csv", row.names = FALSE, na = "", fileEncoding = "UTF-8")
  cat(sprintf("codebook compiled: %d variables in %d datasets\n", nrow(cb), length(unique(cb$dataset))))
}

invisible(built)
