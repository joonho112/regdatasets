test_that("all 25 datasets load correctly", {
  datasets <- c(
    "alcohol1_pp", "berk_sub", "berkeley", "civic_ed", "classdata_07",
    "crime", "disc", "disc2", "faculty", "gcse",
    "grades", "gss_1", "hsb_sub", "hsbs1", "individuals",
    "instruction", "lambert", "naep", "nels_data", "penalty",
    "pisa2000", "reading", "satisfaction", "titanic", "womenlf"
  )

  for (nm in datasets) {
    data(list = nm, package = "regdatasets")
    df <- get(nm)
    expect_true(is.data.frame(df), label = paste(nm, "is data.frame"))
    expect_gt(nrow(df), 0, label = paste(nm, "nrow"))
    expect_gt(ncol(df), 0, label = paste(nm, "ncol"))
  }
})

test_that("key datasets have expected dimensions", {
  data(gcse, package = "regdatasets")
  expect_equal(nrow(gcse), 4059)
  expect_equal(ncol(gcse), 9)

  data(berkeley, package = "regdatasets")
  expect_equal(nrow(berkeley), 3593)
  expect_equal(ncol(berkeley), 3)

  data(crime, package = "regdatasets")
  expect_equal(nrow(crime), 67)
  expect_equal(ncol(crime), 5)

  data(instruction, package = "regdatasets")
  expect_equal(nrow(instruction), 1190)
  expect_equal(ncol(instruction), 12)

  data(pisa2000, package = "regdatasets")
  expect_equal(nrow(pisa2000), 4528)

  data(penalty, package = "regdatasets")
  expect_equal(nrow(penalty), 674)

  data(titanic, package = "regdatasets")
  expect_equal(nrow(titanic), 1309)

  data(womenlf, package = "regdatasets")
  expect_equal(nrow(womenlf), 263)
})

test_that("datasets are tibbles", {
  data(gcse, package = "regdatasets")
  expect_s3_class(gcse, "tbl_df")

  data(crime, package = "regdatasets")
  expect_s3_class(crime, "tbl_df")
})

test_that("key variables exist in datasets", {
  data(gcse, package = "regdatasets")
  expect_true(all(c("gcse", "lrt", "school") %in% names(gcse)))

  data(berkeley, package = "regdatasets")
  expect_true(all(c("admitted", "female", "departme") %in% names(berkeley)))

  data(crime, package = "regdatasets")
  expect_true(all(c("county") %in% names(crime)))

  data(instruction, package = "regdatasets")
  expect_true(all(c("mathgain", "mathkind", "ses") %in% names(instruction)))

  data(penalty, package = "regdatasets")
  expect_equal(ncol(penalty), 3)
})
