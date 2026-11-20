#' Codebook of a dataset
#'
#' Returns the variable-level documentation of one dataset: label, type,
#' meaning of every code, units, the number of missing values, and which
#' codes of the source file were recoded to `NA`, with the number of cells. It
#' is the same table that generates the dataset's help page, in a form you can
#' filter and print.
#'
#' When printed in the console, empty (all-`NA`) metadata columns are hidden so
#' that value meanings and notes stay readable; all nine columns remain in the
#' returned tibble. For wide datasets such as `nels_data`, filter by `label` or
#' `group` or inspect with `View(codebook("nels_data"))`.
#'
#' @param dataset The name of a dataset, as a string, e.g. `"nels_data"`.
#'   See [list_datasets()] for the names.
#'
#' @return A tibble (with subclass `regdatasets_codebook`) containing one row
#'   per variable and columns `variable`, `label`, `type`, `values`, `units`,
#'   `group`, `na_count`, `recoded_to_na` and `notes`.
#'
#' @examples
#' codebook("titanic")
#'
#' # Find the self-concept variables in a wide dataset
#' cb <- codebook("nels_data")
#' cb[grepl("self-concept", cb$label, ignore.case = TRUE),
#'    c("variable", "label", "group")]
#'
#' @export
codebook <- function(dataset) {
  if (!is.character(dataset) || length(dataset) != 1L || is.na(dataset)) {
    stop(
      "`dataset` must be a dataset name as a string, e.g. codebook(\"gcse\").",
      call. = FALSE
    )
  }
  cb <- read_meta("codebook.csv")
  known <- unique(cb$dataset)
  if (!dataset %in% known) {
    dists <- utils::adist(tolower(dataset), tolower(known))[1, ]
    best <- known[which.min(dists)]
    hint <- if (min(dists) <= max(2L, floor(nchar(dataset) / 3))) {
      sprintf(" Did you mean \"%s\"?", best)
    } else {
      ""
    }
    stop(
      sprintf(
        "No dataset called \"%s\".%s See list_datasets() for the names.",
        dataset, hint
      ),
      call. = FALSE
    )
  }
  v <- cb[cb$dataset == dataset, , drop = FALSE]
  v <- v[order(v$position), , drop = FALSE]
  out <- tibble::tibble(
    variable      = v$variable,
    label         = v$label,
    type          = v$type,
    values        = v$values,
    units         = v$units,
    group         = v$group,
    na_count      = as.integer(v$na_count),
    recoded_to_na = v$recoded_to_na,
    notes         = v$notes
  )
  class(out) <- c("regdatasets_codebook", class(out))
  out
}

#' @export
print.regdatasets_codebook <- function(x, n = NULL, ...) {
  non_empty <- vapply(x, function(col) !all(is.na(col)), logical(1))
  always <- names(x) %in% c("variable", "label", "type", "na_count")
  keep <- always | non_empty
  hidden <- names(x)[!keep]
  shown <- x[, keep, drop = FALSE]
  class(shown) <- setdiff(class(shown), "regdatasets_codebook")
  if (is.null(n)) {
    n <- if (nrow(x) <= 25L) Inf else 20L
  }
  print(shown, n = n, ...)
  if (length(hidden)) {
    cat(
      "# Empty (all-NA) columns hidden:",
      paste(hidden, collapse = ", "),
      "\n"
    )
  }
  if (nrow(x) > 25L && is.finite(n) && n < nrow(x)) {
    cat(
      "# Tip: use View() or filter by $group or $label to browse all",
      nrow(x), "variables.\n"
    )
  }
  invisible(x)
}
