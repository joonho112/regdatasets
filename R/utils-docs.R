# Internal helpers that turn the package metadata (inst/extdata/registry.csv
# and inst/extdata/codebook.csv) into Rd for the dataset help pages.
# Used at documentation time through roxygen's `@eval`, so every variable
# table is generated from the codebook and cannot drift.

read_meta <- function(file) {
  path <- system.file("extdata", file, package = "regdatasets", mustWork = TRUE)
  utils::read.csv(
    path,
    stringsAsFactors = FALSE,
    na.strings = "",
    encoding = "UTF-8"
  )
}

# Text for roxygen tags produced by @eval. roxygen itself escapes `%` (do not
# pre-escape it, or it is escaped twice); braces, which Rd would read as
# groups, and square brackets, which markdown would read as links, are shown
# as parentheses: "8 {missing}" -> "8 (missing)", "[Data set]" -> "(Data set)".
rd_escape <- function(x) {
  x <- ifelse(is.na(x), "", x)
  x <- chartr("{}[]", "()()", x)
  x
}

rd_item_text <- function(v) {
  add_dot <- function(s) sub("[.]?$", ".", trimws(s))
  has_val <- function(x) !is.na(x) && nzchar(x)
  parts <- c(
    add_dot(v$label),
    if (has_val(v$values)) paste0("Values: ", add_dot(v$values)),
    if (has_val(v$units)) paste0("Units: ", add_dot(v$units)),
    paste0("Type: ", v$type, "."),
    if (has_val(v$recoded_to_na)) {
      paste0("Codes recoded to NA: ", add_dot(v$recoded_to_na))
    },
    if (has_val(v$notes)) add_dot(v$notes)
  )
  rd_escape(paste(parts[nzchar(parts)], collapse = " "))
}

rd_describe <- function(rows) {
  items <- vapply(seq_len(nrow(rows)), function(i) {
    sprintf(
      "  \\item{\\code{%s}}{%s}",
      rows$variable[i],
      rd_item_text(rows[i, ])
    )
  }, character(1))
  paste0("\\describe{\n", paste(items, collapse = "\n"), "\n}")
}

# Body of the Rd \format section for a dataset, generated from the codebook.
rd_format <- function(name) {
  cb  <- read_meta("codebook.csv")
  reg <- read_meta("registry.csv")
  v   <- cb[cb$dataset == name, , drop = FALSE]
  v   <- v[order(v$position), , drop = FALSE]
  r   <- reg[reg$dataset == name, , drop = FALSE]
  if (!nrow(v) || nrow(r) != 1) stop("no codebook/registry entry for ", name)
  head <- sprintf(
    "A tibble with %s rows and %s variables.",
    format(r$n_rows, big.mark = ","), r$n_cols
  )
  no_group <- all(is.na(v$group) | !nzchar(v$group))
  groups <- if (no_group) NULL else unique(v$group)
  body <- if (is.null(groups)) {
    rd_describe(v)
  } else {
    paste(vapply(groups, function(g) {
      sub_rows <- v[v$group %in% g, , drop = FALSE]
      paste0("\\strong{", rd_escape(g), "}\n", rd_describe(sub_rows))
    }, character(1)), collapse = "\n\n")
  }
  paste0(
    head, "\n\n", body, "\n\n",
    "See \\code{codebook(\"", name, "\")} for this table as a data frame."
  )
}

# Complete roxygen `@format` tag (`#' @eval rd_format_tag("<name>")`).
# Using @eval (rather than @evalRd) stops roxygen from adding its own default
# \format section next to ours.
rd_format_tag <- function(name) paste("@format", rd_format(name))

# Roxygen `@title` tag, from the registry so the help-page title, README table
# and list_datasets() always agree (`#' @eval rd_title_tag("<name>")`).
rd_title_tag <- function(name) {
  reg <- read_meta("registry.csv")
  r <- reg[reg$dataset == name, , drop = FALSE]
  if (nrow(r) != 1) stop("no registry entry for ", name)
  paste("@title", rd_escape(r$title))
}

# Roxygen `@source` tag, from the registry: original source, how the data
# reached this package, and a link (`#' @eval rd_source_tag("<name>")`).
rd_source_tag <- function(name) {
  reg <- read_meta("registry.csv")
  r <- reg[reg$dataset == name, , drop = FALSE]
  if (nrow(r) != 1) stop("no registry entry for ", name)
  link <- if (!is.na(r$source_url) && nzchar(r$source_url)) {
    doi <- sub("^https?://(dx[.])?doi[.]org/", "", r$source_url)
    if (doi != r$source_url) {
      sprintf(" \\doi{%s}", doi)
    } else {
      sprintf(" \\url{%s}", r$source_url)
    }
  } else {
    ""
  }
  cit <- r$source_citation
  if (nzchar(link) && endsWith(cit, r$source_url)) {
    # Drop the trailing URL when it is already appended as \doi{} or \url{}.
    trimmed <- substr(cit, 1, nchar(cit) - nchar(r$source_url))
    cit <- sub("[[:space:]]+$", "", trimmed)
  }
  cit_rd <- rd_escape(cit)
  # Render any remaining doi.org URL inside the citation text as \doi{}.
  cit_rd <- gsub(
    "https?://(dx[.])?doi[.]org/([^[:space:]]+)",
    "\\\\doi{\\2}",
    cit_rd
  )
  paste0(
    "@source ", cit_rd, link, "\n\n",
    rd_escape(r$source_route), " Provenance: ", r$provenance_status, "."
  )
}
