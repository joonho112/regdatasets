# test-datasets.R
# Comprehensive tests for all 24 datasets in regdatasets v0.2.0

# --- Dataset registry: expected dimensions ---
dataset_specs <- list(
  alcohol1_pp  = list(rows = 246,   cols = 9),
  berk_sub     = list(rows = 1169,  cols = 3),
  berkeley     = list(rows = 3593,  cols = 3),
  civic_ed     = list(rows = 794,   cols = 237),
  classdata_07 = list(rows = 44,    cols = 12),
  crime        = list(rows = 67,    cols = 5),
  disc         = list(rows = 2000,  cols = 15),
  disc2        = list(rows = 2000,  cols = 15),
  faculty      = list(rows = 514,   cols = 10),
  gcse         = list(rows = 4059,  cols = 6),
  grades       = list(rows = 198,   cols = 8),
  gss_1        = list(rows = 2832,  cols = 16),
  hsb_sub      = list(rows = 188,   cols = 7),
  hsbs1        = list(rows = 350,   cols = 16),
  individuals  = list(rows = 55899, cols = 6),
  instruction  = list(rows = 1190,  cols = 12),
  lambert      = list(rows = 492,   cols = 109),
  nels_data    = list(rows = 2000,  cols = 299),
  penalty      = list(rows = 674,   cols = 3),
  pisa2000     = list(rows = 4528,  cols = 15),
  reading      = list(rows = 66,    cols = 8),
  satisfaction = list(rows = 110,   cols = 3),
  titanic      = list(rows = 1309,  cols = 6),
  womenlf      = list(rows = 263,   cols = 5)
)

test_that("all 24 datasets load and are tibbles", {
  for (nm in names(dataset_specs)) {
    data(list = nm, package = "regdatasets", envir = environment())
    obj <- get(nm, envir = environment())
    expect_s3_class(obj, "tbl_df")
    expect_gt(nrow(obj), 0, label = paste(nm, "rows"))
    expect_gt(ncol(obj), 0, label = paste(nm, "cols"))
  }
})

test_that("all 24 datasets have expected dimensions", {
  for (nm in names(dataset_specs)) {
    data(list = nm, package = "regdatasets", envir = environment())
    obj <- get(nm, envir = environment())
    spec <- dataset_specs[[nm]]
    expect_equal(nrow(obj), spec$rows, label = paste(nm, "nrow"))
    expect_equal(ncol(obj), spec$cols, label = paste(nm, "ncol"))
  }
})

test_that("key datasets have expected column names", {
  data(gcse, package = "regdatasets", envir = environment())
  expect_named(gcse, c("school", "student", "gcse", "lrt", "gender", "pred"))

  data(berkeley, package = "regdatasets", envir = environment())
  expect_named(berkeley, c("department", "female", "admitted"))

  data(crime, package = "regdatasets", envir = environment())
  expect_named(crime, c("county", "c", "i", "hs", "u"))

  data(titanic, package = "regdatasets", envir = environment())
  expect_named(titanic, c("pclass", "survived", "age", "fare", "embarked", "sex"))

  data(penalty, package = "regdatasets", envir = environment())
  expect_named(penalty, c("def_bl", "vic_bl", "death_pe"))

  data(reading, package = "regdatasets", envir = environment())
  expect_named(reading, c("subject", "group", "pre1", "pre2", "post1", "post2", "post3", "method"))

  data(disc, package = "regdatasets", envir = environment())
  expect_true("race" %in% names(disc))
  expect_true("sentoff" %in% names(disc))
  expect_true("male" %in% names(disc))
})

test_that("disc and disc2 race is a factor", {
  data(disc, package = "regdatasets", envir = environment())
  expect_s3_class(disc$race, "factor")
  expect_equal(levels(disc$race), c("Asian", "Hispanic", "Black", "White"))

  data(disc2, package = "regdatasets", envir = environment())
  expect_s3_class(disc2$race, "factor")
  expect_equal(levels(disc2$race), c("Asian", "Hispanic", "Black", "White"))
})

test_that("gcse does not contain Stata artifacts", {
  data(gcse, package = "regdatasets", envir = environment())
  # u0, u1, filter__ should have been removed in v0.2.0
  expect_false("u0" %in% names(gcse))
  expect_false("u1" %in% names(gcse))
  expect_false("filter__" %in% names(gcse))
  # No -1e30 values in any column
  for (v in names(gcse)) {
    if (is.numeric(gcse[[v]])) {
      expect_true(all(gcse[[v]] > -1e20 | is.na(gcse[[v]])),
                  label = paste("gcse", v, "no -1e30"))
    }
  }
})

test_that("berkeley uses 'department' not 'departme'", {
  data(berkeley, package = "regdatasets", envir = environment())
  expect_true("department" %in% names(berkeley))
  expect_false("departme" %in% names(berkeley))
})

test_that("titanic embarked has no blank strings", {
  data(titanic, package = "regdatasets", envir = environment())
  non_na <- titanic$embarked[!is.na(titanic$embarked)]
  expect_true(all(nchar(non_na) > 0), label = "no blank embarked")
  # Should have exactly 2 NAs (converted from blanks)
  expect_equal(sum(is.na(titanic$embarked)), 2)
})

test_that("disc sentinel values have been cleaned", {
  data(disc, package = "regdatasets", envir = environment())
  # bys34a and bys34b should not contain 8 or 98
  expect_false(any(disc$bys34a == 8, na.rm = TRUE),
               label = "disc bys34a no sentinel 8")
  expect_false(any(disc$bys34a == 98, na.rm = TRUE),
               label = "disc bys34a no sentinel 98")
  expect_false(any(disc$bys34b == 8, na.rm = TRUE),
               label = "disc bys34b no sentinel 8")
  expect_false(any(disc$bys34b == 98, na.rm = TRUE),
               label = "disc bys34b no sentinel 98")
})

test_that("paired datasets have consistent row counts", {
  data(disc, package = "regdatasets", envir = environment())
  data(disc2, package = "regdatasets", envir = environment())
  expect_equal(nrow(disc), nrow(disc2), label = "disc/disc2 same nrow")
})

test_that("binary variables contain only 0, 1, or NA", {
  check_binary <- function(dataset_name, var_name) {
    data(list = dataset_name, package = "regdatasets", envir = environment())
    obj <- get(dataset_name, envir = environment())
    vals <- unique(obj[[var_name]])
    vals <- vals[!is.na(vals)]
    expect_true(all(vals %in% c(0, 1)),
                label = paste(dataset_name, var_name, "is binary"))
  }

  check_binary("berk_sub", "admitted")
  check_binary("berk_sub", "male")
  check_binary("berkeley", "female")
  check_binary("berkeley", "admitted")
  check_binary("titanic", "survived")
  check_binary("titanic", "sex")
  check_binary("penalty", "def_bl")
  check_binary("penalty", "vic_bl")
  check_binary("penalty", "death_pe")
  check_binary("disc", "male")
  check_binary("disc", "sentoff")
})
