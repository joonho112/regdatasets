## Convert all .dta (Stata) files to R data objects for the regdatasets package
## Source: BER 640 Advanced Statistical Methods in Education

library(haven)
library(usethis)
library(labelled)
library(tibble)

# Path to original .dta files
dta_dir <- file.path(
  dirname(getwd()),
  "BER 640 나의 강의 자료", "Datasets"
)

# List all .dta files
dta_files <- list.files(dta_dir, pattern = "\\.dta$", full.names = TRUE)
cat("Found", length(dta_files), ".dta files\n\n")

# --- Helper: read .dta, clean labels, convert to tibble ---
read_and_clean <- function(path) {
  df <- haven::read_dta(path)
  df <- labelled::unlabelled(df)
  tibble::as_tibble(df)
}

# --- Convert each dataset ---
datasets <- c(
  "gcse", "pisa2000", "berkeley", "crime", "instruction",
  "gss-1", "disc", "disc2", "penalty", "titanic",
  "faculty", "reading", "civic_ed", "nels_data",
  "hsb_sub", "womenlf", "hsbs1", "lambert", "satisfaction",
  "classdata_07", "grades", "individuals", "berk_sub", "alcohol1_pp"
)

for (name in datasets) {
  file_path <- file.path(dta_dir, paste0(name, ".dta"))
  if (!file.exists(file_path)) {
    cat("  SKIP:", name, "(file not found)\n")
    next
  }

  # R variable names cannot contain hyphens

  r_name <- gsub("-", "_", name)
  df <- read_and_clean(file_path)
  assign(r_name, df)

  cat("  OK:", r_name, sprintf("(%d x %d)\n", nrow(df), ncol(df)))

  # Save to data/
  do.call(usethis::use_data, list(as.name(r_name), overwrite = TRUE))
}

cat("\nDone. All datasets saved to data/\n")
