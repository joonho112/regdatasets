test_that("list_datasets() describes every dataset and prints all rows", {
  ld <- list_datasets()
  expect_s3_class(ld, "regdatasets_list")
  expect_s3_class(ld, "tbl_df")
  expect_named(
    ld,
    c("dataset", "title", "rows", "cols", "topics", "description")
  )
  expect_setequal(ld$dataset, shipped_datasets())
  expect_type(ld$rows, "integer")
  expect_type(ld$cols, "integer")
  out <- capture.output(res <- print(ld))
  expect_identical(res, ld)
  expect_true(any(grepl("womenlf", out, fixed = TRUE)))
})

test_that("list_datasets(topic) filters and validates every vocabulary topic", {
  vocab <- c(
    "simple-regression", "ancova", "anova", "continuous-predictors",
    "interactions", "nonlinear", "model-building", "diagnostics",
    "logistic", "glm-latent", "ordinal", "multilevel-longitudinal"
  )
  all_ds <- list_datasets()
  for (tp in vocab) {
    sub <- list_datasets(topic = tp)
    expect_true(nrow(sub) > 0 && nrow(sub) < nrow(all_ds), label = tp)
    expect_true(all(grepl(tp, sub$topics, fixed = TRUE)), label = tp)
  }
  expect_error(list_datasets(topic = "not-a-topic"), "Unknown `topic`")
  expect_error(list_datasets(topic = "Logistic"), "Did you mean \"logistic\"")
  expect_error(list_datasets(topic = c("logistic", "ordinal")), "single topic")
  expect_error(list_datasets(topic = NA_character_), "single topic")
  expect_error(list_datasets(topic = 1), "single topic")
})

test_that("codebook() returns one row per variable and prints cleanly", {
  cb <- codebook("titanic")
  expect_s3_class(cb, "regdatasets_codebook")
  expect_s3_class(cb, "tbl_df")
  expect_identical(cb$variable, names(titanic))
  expect_named(
    cb,
    c("variable", "label", "type", "values", "units", "group",
      "na_count", "recoded_to_na", "notes")
  )
  expect_type(cb$na_count, "integer")
  out_t <- capture.output(res_t <- print(cb))
  expect_identical(res_t, cb)
  expect_true(any(grepl(
    "Empty \\(all-NA\\) columns hidden: group, recoded_to_na", out_t
  )))

  cb_nels <- codebook("nels_data")
  expect_equal(nrow(cb_nels), 299)
  out_n <- capture.output(print(cb_nels))
  expect_true(any(grepl("299 variables", out_n, fixed = TRUE)))
})

test_that("codebook() gives helpful errors on bad inputs", {
  expect_error(codebook("no_such_data"), "list_datasets")
  expect_error(codebook("titanc"), "Did you mean \"titanic\"")
  expect_error(codebook("GCSE"), "Did you mean \"gcse\"")
  expect_error(codebook(NA_character_), "string")
  expect_error(codebook(titanic), "string")
  expect_error(codebook(c("gcse", "titanic")), "string")
  expect_error(codebook(character(0)), "string")
  expect_error(codebook(1), "string")
})

test_that("internal Rd generators format titles, tables and sources cleanly", {
  expect_identical(
    regdatasets:::rd_escape("8 {missing} [Data set]"),
    "8 (missing) (Data set)"
  )
  expect_match(regdatasets:::rd_title_tag("gcse"), "^@title ")
  expect_match(regdatasets:::rd_format_tag("gcse"), "\\\\describe\\{")
  expect_match(regdatasets:::rd_format_tag("nels_data"), "\\\\strong\\{")
  src_fac <- regdatasets:::rd_source_tag("faculty")
  expect_match(src_fac, "\\\\doi\\{10\\.1002/0471677566\\}")
  expect_false(grepl("https://doi.org/", src_fac, fixed = TRUE))
  src_berk <- regdatasets:::rd_source_tag("berkeley")
  expect_match(src_berk, "\\\\doi\\{10\\.1126/science\\.187\\.4175\\.398\\}")
  expect_match(regdatasets:::rd_source_tag("classdata_07"), "Provenance:")
  expect_error(regdatasets:::rd_title_tag("no_such_data"))
  expect_error(regdatasets:::rd_format_tag("no_such_data"))
  expect_error(regdatasets:::rd_source_tag("no_such_data"))
})
