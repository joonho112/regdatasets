# Registry (contract C7) and the help topics.

test_that("C7: registry dimensions equal the data", {
  reg <- registry()
  for (i in seq_len(nrow(reg))) {
    x <- get_dataset(reg$dataset[i])
    expect_equal(nrow(x), reg$n_rows[i], label = paste(reg$dataset[i], "rows"))
    expect_equal(ncol(x), reg$n_cols[i], label = paste(reg$dataset[i], "cols"))
  }
})

test_that("registry fields are complete and topics come from the vocabulary", {
  reg <- registry()
  vocab <- c(
    "simple-regression", "ancova", "anova", "continuous-predictors",
    "interactions", "nonlinear", "model-building", "diagnostics",
    "logistic", "glm-latent", "ordinal", "multilevel-longitudinal"
  )
  required_fields <- c(
    "title", "description", "topics", "unit", "source_citation",
    "source_route", "redistribution_basis", "provenance_status"
  )
  for (k in required_fields) {
    expect_false(anyNA(reg[[k]]), label = paste("registry", k))
  }
  expect_true(all(unlist(strsplit(reg$topics, ";", fixed = TRUE)) %in% vocab))
  expect_true(all(reg$provenance_status %in% c("verified", "probable")))
})

test_that("every dataset and exported function has a help page", {
  aliases <- system.file("help", "aliases.rds", package = "regdatasets")
  skip_if(aliases == "", "help pages are not installed (tests run from source)")
  expected <- c(
    registry()$dataset, "list_datasets", "codebook", "regdatasets-package"
  )
  expect_true(all(expected %in% names(readRDS(aliases))))
})
