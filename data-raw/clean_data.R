# clean_data.R
# Phase 2 of regdatasets v0.2.0 upgrade
# Cleans sentinel missing values, removes Stata artifacts,
# and normalizes blanks to NA.
#
# Run from package root: source("data-raw/clean_data.R")

library(tibble)

# Helper: load .rda, return the object
load_dataset <- function(name) {
  e <- new.env()
  load(file.path("data", paste0(name, ".rda")), envir = e)
  get(name, envir = e)
}

# Helper: save as .rda with xz compression
save_dataset <- function(obj, name) {
  assign(name, obj)
  save(list = name, file = file.path("data", paste0(name, ".rda")),
       compress = "xz")
}

cat("=== Step 2.1: Recode sentinel missing values ===\n\n")

# --- disc: 8 and 98 are missing codes for original NELS variables ---
disc <- load_dataset("disc")
nels_sentinel_vars_disc <- c("bys34a", "bys34b")
for (v in nels_sentinel_vars_disc) {
  if (v %in% names(disc)) {
    n_before <- sum(is.na(disc[[v]]))
    disc[[v]][disc[[v]] == 8] <- NA
    disc[[v]][disc[[v]] == 98] <- NA
    n_after <- sum(is.na(disc[[v]]))
    cat(sprintf("  disc$%s: %d -> %d NAs (recoded 8, 98)\n", v, n_before, n_after))
  }
}
save_dataset(disc, "disc")
cat("  disc saved.\n\n")

# --- disc2: check for same patterns ---
disc2 <- load_dataset("disc2")
# disc2 uses more intuitive variable names; check for sentinel codes
disc2_check <- sapply(disc2, function(x) any(x == 98, na.rm = TRUE))
if (any(disc2_check)) {
  cat("  disc2 sentinel vars:", paste(names(disc2_check)[disc2_check], collapse = ", "), "\n")
  for (v in names(disc2_check)[disc2_check]) {
    disc2[[v]][disc2[[v]] == 98] <- NA
    disc2[[v]][disc2[[v]] == 8 & !is.na(disc2[[v]])] <- NA
  }
  save_dataset(disc2, "disc2")
  cat("  disc2 cleaned and saved.\n\n")
} else {
  cat("  disc2: no sentinel values found. Skipped.\n\n")
}

# --- nels_data: 99.98, 99.99, 99.998, 998, 100 are missing codes ---
nels_data <- load_dataset("nels_data")
sentinel_values <- c(99.98, 99.99, 99.998, 998, 100)
n_cleaned <- 0
for (v in names(nels_data)) {
  if (is.numeric(nels_data[[v]])) {
    for (sv in sentinel_values) {
      matches <- which(nels_data[[v]] == sv)
      if (length(matches) > 0) {
        nels_data[[v]][matches] <- NA
        n_cleaned <- n_cleaned + length(matches)
      }
    }
  }
}
cat(sprintf("  nels_data: %d sentinel values recoded to NA across all columns.\n", n_cleaned))
save_dataset(nels_data, "nels_data")
cat("  nels_data saved.\n\n")

cat("=== Step 2.2: Clean artifacts ===\n\n")

# --- gcse: remove u0, u1, filter__ (Stata MLM artifacts) ---
gcse <- load_dataset("gcse")
cols_before <- ncol(gcse)
gcse <- gcse[, !names(gcse) %in% c("u0", "u1", "filter__")]
cat(sprintf("  gcse: %d -> %d columns (removed u0, u1, filter__)\n", cols_before, ncol(gcse)))
save_dataset(gcse, "gcse")
cat("  gcse saved.\n\n")

# --- titanic: convert blank embarked to NA ---
titanic <- load_dataset("titanic")
n_blanks <- sum(titanic$embarked == "", na.rm = TRUE)
titanic$embarked[titanic$embarked == ""] <- NA
cat(sprintf("  titanic$embarked: %d blank strings converted to NA\n", n_blanks))
save_dataset(titanic, "titanic")
cat("  titanic saved.\n\n")

cat("=== Phase 2 cleaning complete ===\n")
cat("Datasets modified: disc, disc2 (if applicable), nels_data, gcse, titanic\n")
