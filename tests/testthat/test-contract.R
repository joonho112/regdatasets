# Data contract (data-raw/CONTRACT.md): C1, C5, C8 for every shipped dataset.
# Note: C9 (two-build determinism) and C10 (approved diff against v0.2.0) are
# build-time checks enforced by data-raw/audit/fingerprint.R and rebuild_diff.R.

test_that("C1: shipped datasets match registry and are non-empty tibbles", {
  expect_setequal(shipped_datasets(), registry()$dataset)
  expect_length(shipped_datasets(), 22L)
  for (d in shipped_datasets()) {
    x <- get_dataset(d)
    expect_s3_class(x, "tbl_df")
    expect_gt(nrow(x), 0)
  }
})

test_that("C5: datasets are plain data, with no extra attributes", {
  for (d in shipped_datasets()) {
    x <- get_dataset(d)
    expect_setequal(names(attributes(x)), c("names", "row.names", "class"))
    for (v in names(x)) {
      allowed <- if (is.factor(x[[v]])) c("levels", "class") else character(0)
      extra <- setdiff(names(attributes(x[[v]])), allowed)
      expect(
        length(extra) == 0,
        sprintf(
          "%s$%s carries attributes: %s",
          d, v, paste(extra, collapse = ", ")
        )
      )
    }
  }
})

test_that("C8: data files are xz, version 3, one named object each", {
  dir <- system.file("data", package = "regdatasets")
  rda_files <- list.files(dir, pattern = "[.]rda$", full.names = TRUE)
  skip_if(
    dir == "" || !length(rda_files),
    "data stored as a lazy-load database"
  )
  info <- tools::checkRdaFiles(dir)
  expect_true(all(info$compress == "xz"))
  expect_true(all(info$version == 3))
  for (f in rda_files) {
    e <- new.env(parent = emptyenv())
    objs <- load(f, envir = e)
    expect_identical(objs, sub("[.]rda$", "", basename(f)), label = basename(f))
  }
})
