# Shared helpers for the contract tests: read the installed metadata and data.

registry <- function() {
  utils::read.csv(
    system.file("extdata", "registry.csv", package = "regdatasets"),
    stringsAsFactors = FALSE,
    na.strings = "",
    encoding = "UTF-8"
  )
}

codebook_table <- function() {
  utils::read.csv(
    system.file("extdata", "codebook.csv", package = "regdatasets"),
    stringsAsFactors = FALSE,
    na.strings = "",
    encoding = "UTF-8"
  )
}

get_dataset <- function(name) {
  e <- new.env()
  utils::data(list = name, package = "regdatasets", envir = e)
  get(name, envir = e)
}

shipped_datasets <- function() {
  sort(utils::data(package = "regdatasets")$results[, "Item"])
}
