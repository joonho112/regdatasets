# grades --------------------------------------------------------------------

#' @eval rd_title_tag("grades")
#'
#' @description
#' Grades and six text features of 198 student essays, one row per essay.
#' The grade is one expert grader's grade on four ordered levels (1 = poor to
#' 4 = excellent); the features measure word length, essay length, commas,
#' spelling errors, prepositions and sentence length. The file is an extract
#' of the essay data distributed with Rabe-Hesketh and Skrondal's
#' *Multilevel and Longitudinal Modeling Using Stata*, which appear to come
#' from Johnson and Albert's (1999) *Ordinal Data Modeling*.
#'
#' @eval rd_format_tag("grades")
#'
#' @details
#' **The grade.** In Rabe-Hesketh and Skrondal's essay data, each essay has
#' grades from five experts on 8 levels. `grade` is the grade of one of them
#' (grader 2), collapsed in pairs: 1-2 = 1, 3-4 = 2, 5-6 = 3 and 7-8 = 4.
#' The four levels hold 68, 48, 40 and 42 essays. The grade is ordinal: the
#' distances between its levels have no fixed size.
#'
#' **Text features.** `wordlength` is the average word length in characters,
#' `sqrtwords` the square root of the number of words, `commas` the number of
#' commas per 100 words, `errors` the percentage of words with a spelling
#' error (spelling only, not grammar), `prepos` the percentage of words that
#' are prepositions and `sentlength` the average sentence length in words.
#' No value is missing, and the values are unchanged in version 1.0.0.
#'
#' **Suggested analyses.**
#'
#' - A proportional-odds (ordered logit) model of `grade` on the text
#'   features, for example with `MASS::polr()`: cumulative odds ratios and
#'   cut-points.
#' - The latent-response view: an ordered probit (`method = "probit"`)
#'   treats the grade as a continuous quality score cut at thresholds. Its
#'   coefficients differ from the ordered logit's mainly by a scale factor.
#' - For contrast, a linear regression that treats `grade` as a number, and
#'   model building to choose among the six features.
#'
#' @eval rd_source_tag("grades")
#'
#' @seealso [womenlf] and [satisfaction] for other ordinal outcomes;
#'   `mvord::essay_data` on CRAN has the Johnson and Albert essay grades of
#'   all five experts; [codebook()] and [list_datasets()].
#'
#' @examples
#' head(grades)
#' table(grades$grade)
#'
#' if (requireNamespace("MASS", quietly = TRUE)) {
#'   # Proportional-odds (ordered logit) model
#'   fit <- MASS::polr(factor(grade) ~ wordlength + sqrtwords + errors,
#'                     data = grades, Hess = TRUE)
#'   print(summary(fit))
#'
#'   # Ordered probit: the latent-response formulation
#'   fit_p <- MASS::polr(factor(grade) ~ wordlength + sqrtwords + errors,
#'                       data = grades, method = "probit", Hess = TRUE)
#'   print(coef(fit_p))
#' }
"grades"
