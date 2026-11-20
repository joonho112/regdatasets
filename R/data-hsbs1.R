# hsbs1 ---------------------------------------------------------------------

#' @eval rd_title_tag("hsbs1")
#'
#' @description
#' Five test scores, locus of control, self-concept, motivation and background
#' of 350 students from High School and Beyond (HS&B), a longitudinal survey
#' of U.S. high school students that the National Center for Education
#' Statistics began in 1980. Each row is a student. The 350 are a subset of
#' the 600-student HS&B teaching sample printed in Tatsuoka (1988); how they
#' were chosen is not documented.
#'
#' @eval rd_format_tag("hsbs1")
#'
#' @details
#' **A subset, not the whole file.** The 350 students are part of Tatsuoka's
#' 600, so their IDs run from 1 to 599 with gaps. `sample` equals 1 in every
#' row: it marks membership in this subset and is not a sampling weight. The
#' match with Tatsuoka's file is probable rather than verified, because the
#' values have not been compared one by one with `candisc::HSB`.
#'
#' **Coding.** `gender`, `race`, `ses`, `sch`, `prog` and `career` are integer
#' codes (see the Format section). Wrap them in `factor()` in a model, or R
#' treats them as numbers; `ses` here is a three-group category, not a
#' continuous score. How `locus`, `concept` and `mot` were built, and which
#' way they run, is not documented. There are no missing values. Version
#' 1.0.0 changed no values; it corrects the v0.2.0 help page, which presented
#' the file as the whole sample and `sample` as a weight.
#'
#' **Suggested analyses.**
#'
#' - regression diagnostics: residual plots, leverage (`hatvalues()`) and
#'   influence (`cooks.distance()`);
#' - model building with five correlated test scores (`read`, `write`,
#'   `math`, `sci` and `ss`, with pairwise correlations from 0.50 to 0.69),
#'   where multicollinearity shows;
#' - categorical predictors with several levels, such as `prog` or `race`.
#'
#' @eval rd_source_tag("hsbs1")
#'
#' @seealso [hsb_sub] for a different High School and Beyond extract, with
#'   students nested in five schools. `candisc::HSB` on CRAN has all 600
#'   students of Tatsuoka's file. [codebook()] gives the variable table as a
#'   data frame, and [list_datasets()] lists the other datasets.
#'
#' @examples
#' head(hsbs1)
#'
#' # Writing score on reading, math and program type (as a factor)
#' fit <- lm(write ~ read + math + factor(prog), data = hsbs1)
#' summary(fit)
#'
#' # Diagnostics: residuals against fitted values; the largest Cook's distances
#' plot(fit, which = 1)
#' head(sort(cooks.distance(fit), decreasing = TRUE))
"hsbs1"
