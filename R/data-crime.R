# crime ---------------------------------------------------------------------

#' @eval rd_title_tag("crime")
#'
#' @description
#' Crime rate, median income, education and urbanization for the 67
#' counties of Florida, one row per county. They are the Florida county data
#' of Agresti and Finlay's textbook *Statistical Methods for the Social
#' Sciences* (2009), courtesy of L. Winner of the University of Florida. The
#' year the figures refer to and the agency that compiled them are not
#' documented.
#'
#' @eval rd_format_tag("crime")
#'
#' @details
#' **Variables.** `c` is the crime rate (crimes per 1,000 residents per
#' year), `i` the median income in thousands of US dollars, `hs` the
#' percentage of adults with at least a high school education and `u` the
#' percentage of residents living in urban areas.
#'
#' **Quirks.** County names are in capitals and at most 8 characters long,
#' so 11 are cut short (for example `HILLSBOR` is Hillsborough and `PALM_B.`
#' is Palm Beach). Miami-Dade appears under its former name `DADE`, and
#' Suwannee is spelled `SUWANEE`. Check the names before merging with other
#' county data. Ten counties have no
#' urban population (`u` = 0) and one has `c` = 0, which matters for log
#' transformations. No value is missing, and the values are unchanged in
#' version 1.0.0.
#'
#' **Confounding.** On its own, `hs` has a positive slope (about 1.5 crimes
#' per 1,000 residents per percentage point), but controlling for `u` turns
#' it negative (about -0.6) and not statistically significant: urbanization
#' is strongly correlated with both education (r = 0.79) and crime
#' (r = 0.68). Likewise, the correlation of `c` and `hs` is 0.47, but their
#' partial correlation controlling for `u` is -0.15. Income `i` shows the
#' same reversal.
#'
#' **Suggested analyses.**
#'
#' - Multiple regression with continuous predictors and omitted-variable
#'   bias: `c ~ hs` versus `c ~ hs + u`.
#' - Partial correlation and added-variable plots.
#' - An interaction between two continuous predictors, `c ~ hs * u`;
#'   centering `hs` and `u` first makes the main effects easier to
#'   interpret.
#' - Nonlinear terms, such as a quadratic in `u` or the log of `i`.
#'
#' @eval rd_source_tag("crime")
#'
#' @seealso The CRAN package smss has the same county data as
#'   `smss::fl.crime`; [codebook()] and [list_datasets()].
#'
#' @examples
#' head(crime)
#' round(cor(crime[, c("c", "i", "hs", "u")]), 2)
#'
#' # Education alone: a positive slope
#' coef(lm(c ~ hs, data = crime))
#'
#' # Controlling for urbanization: the slope of hs turns negative
#' summary(lm(c ~ hs + u, data = crime))
"crime"
