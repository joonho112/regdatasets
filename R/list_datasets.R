#' List the datasets in regdatasets
#'
#' Returns one row per dataset with its title, dimensions, regression topics
#' and a one-sentence description. The information comes from the package
#' registry, the same source that generates the help pages and README, so it
#' always matches the data.
#'
#' @param topic Optional. Keep only datasets tagged with this topic, one of
#'   `"simple-regression"`, `"ancova"`, `"anova"`, `"continuous-predictors"`,
#'   `"interactions"`, `"nonlinear"`, `"model-building"`, `"diagnostics"`,
#'   `"logistic"`, `"glm-latent"`, `"ordinal"`, `"multilevel-longitudinal"`.
#'
#' @return A tibble (with subclass `regdatasets_list`) with columns `dataset`,
#'   `title`, `rows`, `cols`, `topics` and `description`.
#'
#' @seealso [codebook()] for the variables of one dataset.
#'
#' @examples
#' list_datasets()
#'
#' # Datasets suited to logistic regression
#' list_datasets(topic = "logistic")
#'
#' @export
list_datasets <- function(topic = NULL) {
  reg <- read_meta("registry.csv")
  out <- tibble::tibble(
    dataset     = reg$dataset,
    title       = reg$title,
    rows        = as.integer(reg$n_rows),
    cols        = as.integer(reg$n_cols),
    topics      = gsub(";", ", ", reg$topics, fixed = TRUE),
    description = reg$description
  )
  if (!is.null(topic)) {
    vocab <- c(
      "simple-regression", "ancova", "anova", "continuous-predictors",
      "interactions", "nonlinear", "model-building", "diagnostics",
      "logistic", "glm-latent", "ordinal", "multilevel-longitudinal"
    )
    if (!is.character(topic) || length(topic) != 1L || is.na(topic)) {
      stop(
        "`topic` must be a single topic string. Valid topics: ",
        paste(vocab, collapse = ", "), ".",
        call. = FALSE
      )
    }
    if (!topic %in% vocab) {
      dists <- utils::adist(tolower(topic), vocab)[1, ]
      best <- vocab[which.min(dists)]
      hint <- if (min(dists) <= max(2L, floor(nchar(topic) / 3))) {
        sprintf(" Did you mean \"%s\"?", best)
      } else {
        ""
      }
      stop(
        sprintf(
          "Unknown `topic` \"%s\".%s Valid topics: %s.",
          topic, hint, paste(vocab, collapse = ", ")
        ),
        call. = FALSE
      )
    }
    keep <- vapply(
      strsplit(reg$topics, ";", fixed = TRUE),
      function(t) topic %in% t,
      logical(1)
    )
    out <- out[keep, ]
  }
  class(out) <- c("regdatasets_list", class(out))
  out
}

#' @export
print.regdatasets_list <- function(x, n = Inf, ...) {
  shown <- x
  class(shown) <- setdiff(class(shown), "regdatasets_list")
  print(shown, n = n, ...)
  invisible(x)
}
