# alcohol1_pp ---------------------------------------------------------------

#' @eval rd_title_tag("alcohol1_pp")
#'
#' @description
#' Alcohol use of 82 adolescents, each measured at ages 14, 15 and 16, in
#' person-period (long) format: one row per adolescent per age, 246 rows in
#' all. Besides an alcohol-use score, the data record whether the adolescent
#' is a child of an alcoholic parent, the adolescent's gender and a score for
#' alcohol use among the adolescent's peers. They are example data from
#' Singer and Willett's (2003) book *Applied Longitudinal Data Analysis*.
#'
#' @eval rd_format_tag("alcohol1_pp")
#'
#' @details
#' **Design.** Every adolescent has exactly three rows, one per age, and no
#' value is missing. `age_14` (age minus 14) is the time variable, so 0 is
#' age 14. Only `age`, `age_14` and `alcuse` vary within an adolescent:
#' `coa`, `male` and `peer` (and the centered `ccoa` and `cpeer`) are the
#' same in all three rows. `peer` is therefore a person-level predictor, not
#' a time-varying one.
#'
#' **Scores.** How `alcuse` and `peer` were constructed is not documented in
#' the package sources, so their units are unknown; higher values mean more
#' alcohol use. Every `alcuse` value is the square root of a whole number
#' from 0 to 13. Check Singer and Willett (2003) before giving the scores a
#' substantive meaning.
#'
#' **Centered variables.** `cpeer` is `peer` minus 1.018 and `ccoa` is `coa`
#' minus 0.451, the sample means rounded to three decimals. In
#' `alcuse ~ age_14 * cpeer`, centering changes the intercept and the
#' `age_14` coefficient (now the age slope at the mean peer score), but the
#' `cpeer` and interaction coefficients are the same as with `peer`.
#'
#' The values are unchanged in version 1.0.0.
#'
#' **Suggested analyses.**
#'
#' - Linear change in `alcuse` over `age_14`, with intercept and slope
#'   allowed to differ by `coa` (`alcuse ~ age_14 * coa`): an interaction
#'   between a dummy and a continuous predictor.
#' - Centering: compare `alcuse ~ age_14 * peer` with
#'   `alcuse ~ age_14 * cpeer`.
#' - Multilevel growth models with a random intercept and a random `age_14`
#'   slope for each `id` (for example with the lme4 or nlme package).
#'   Ordinary regression on the 246 rows treats the three rows of an
#'   adolescent as independent, so its standard errors cannot be trusted.
#'
#' @eval rd_source_tag("alcohol1_pp")
#'
#' @seealso [codebook()] for the variable table as a data frame;
#'   [list_datasets()], for example
#'   `list_datasets(topic = "multilevel-longitudinal")` for other datasets
#'   with nested or repeated measurements.
#'
#' @examples
#' head(alcohol1_pp)
#'
#' # Three rows per adolescent (ages 14, 15 and 16)
#' table(table(alcohol1_pp$id))
#'
#' # Does the age trend differ for children of alcoholics (coa = 1)?
#' # (OLS ignores the dependence among each adolescent's three rows.)
#' coef(lm(alcuse ~ age_14 * coa, data = alcohol1_pp))
#'
#' # Centered peer score: age_14 is now the age slope at the mean peer score
#' coef(lm(alcuse ~ age_14 * cpeer, data = alcohol1_pp))
"alcohol1_pp"
