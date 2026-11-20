# womenlf -------------------------------------------------------------------

#' @eval rd_title_tag("womenlf")
#'
#' @description
#' Work status, husband's income, presence of children and region of
#' residence for 263 married Canadian women, one row per woman. The data
#' come from a 1977 survey by the Social Change in Canada Project of the
#' York Institute for Social Research and are a textbook example in Fox
#' (2016, 3rd ed.). They are the same data as `carData::Womenlf` on CRAN.
#'
#' @eval rd_format_tag("womenlf")
#'
#' @details
#' The outcome `workstat` has three ordered categories: 0 = not working
#' outside the home (155 women), 1 = part time (42) and 2 = full time (66).
#' `husbinc` is the husband's income in thousands of dollars, `chilpres` is
#' 1 when children are present in the household (184 women), and `region`
#' is text with five values, which a model formula turns into a factor with
#' Atlantic Canada as the reference level. `obs` is a row number, not a
#' predictor. There are no missing values.
#'
#' Version 1.0.0 changes no values. Earlier documentation named the wrong
#' source and edition: the data come from the Social Change in Canada
#' Project, not from a Survey of Consumer Finances, and the book is Fox
#' (2016, 3rd ed.).
#'
#' **Suggested analyses.**
#'
#' - binary logistic regression of working at all (`workstat > 0`) on
#'   husband's income and children;
#' - a proportional odds model for the three ordered categories, with a
#'   check of the proportional odds assumption;
#' - alternatives if that assumption fails: a multinomial logit, or two
#'   binary logits (working or not; full time or part time among women who
#'   work);
#' - an interaction between husband's income and the presence of children.
#'
#' @eval rd_source_tag("womenlf")
#'
#' @seealso `carData::Womenlf` on CRAN holds the same 263 women in the same
#'   order, under other variable names and with work status, children and
#'   region as factors. [satisfaction] has another ordinal outcome.
#'   [codebook()] and [list_datasets()].
#'
#' @examples
#' head(womenlf)
#' table(womenlf$workstat)   # 0 = not working, 1 = part time, 2 = full time
#'
#' # Working at all: binary logistic regression
#' glm(I(workstat > 0) ~ husbinc + chilpres, family = binomial, data = womenlf)
#'
#' # Proportional odds model (requires MASS; summary() reports t-values
#' # without p-values)
#' if (requireNamespace("MASS", quietly = TRUE)) {
#'   fit_ord <- MASS::polr(factor(workstat) ~ husbinc + chilpres,
#'                         data = womenlf, Hess = TRUE)
#'   summary(fit_ord)
#' }
"womenlf"
