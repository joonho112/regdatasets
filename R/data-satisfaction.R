# satisfaction --------------------------------------------------------------

#' @eval rd_title_tag("satisfaction")
#'
#' @description
#' Job satisfaction, income and gender of 110 workers, one row per person.
#' The data are not simulated: they come from a table of 1991 General Social
#' Survey data published by Agresti (2002, Table 7.8), expanded to one record
#' per respondent. One case was added to each of the table's six empty
#' cells, so there are 110 rows instead of 104.
#'
#' @eval rd_format_tag("satisfaction")
#'
#' @details
#' `satisfaction` runs from 1 = very dissatisfied to 4 = very satisfied, and
#' `income` has four ordered bands, from 1 = less than $5,000 to 4 = more
#' than $25,000. Both are stored as integers: wrap the outcome in `factor()`
#' for an ordinal model, and enter `income` either as a score (one slope) or
#' as `factor(income)` (three contrasts). `gender` is text, so a model
#' formula turns it into a factor with women (`"F"`) as the reference level.
#' There are no missing values. Note on category 2: this package keeps the
#' label `"a little dissatisfied"` from the source Stata file and the 1991
#' GSS `SATJOB` item, whereas Agresti (2002, Table 7.8) and
#' `coin::jobsatisfaction` print category 2 as `"A Little Satisfied"`.
#'
#' The six added cases fill the empty cells of the published table: one
#' each for women in income bands 3 and 4 and for men in bands 2, 3 and 4
#' with `satisfaction` = 1, and one for men in band 3 with
#' `satisfaction` = 2. All six are in the two lowest satisfaction
#' categories and in income bands 2 to 4, so they weaken the association
#' between income and satisfaction: in the proportional odds model of the
#' examples, the income coefficient is about 0.34 with them and about 0.51
#' without them. Results therefore differ from those for Agresti's original
#' 104 cases. Even so the data are sparse: 23 of the 32
#' gender-by-income-by-satisfaction cells hold three cases or fewer.
#'
#' Version 1.0.0 changes no values. Earlier versions described the data as
#' simulated, which was wrong.
#'
#' **Suggested analyses.**
#'
#' - a proportional odds (cumulative logit) model of satisfaction on income
#'   and gender, with cumulative odds ratios and cut-points;
#' - checking the proportional odds assumption, for example by comparing
#'   binary logits for `satisfaction >= 2`, `>= 3` and `>= 4`;
#' - income as a linear score versus a factor, compared with a
#'   likelihood-ratio test;
#' - cumulative logit versus probit links.
#'
#' @eval rd_source_tag("satisfaction")
#'
#' @seealso [womenlf], and `osentoff` in [disc], for other ordinal outcomes;
#'   [codebook()] and [list_datasets()]. The original 104-case table is on
#'   CRAN as `coin::jobsatisfaction`.
#'
#' @examples
#' head(satisfaction)
#' with(satisfaction, table(income, satisfaction))
#'
#' # Proportional odds model (requires the MASS package)
#' if (requireNamespace("MASS", quietly = TRUE)) {
#'   fit <- MASS::polr(factor(satisfaction) ~ income + gender,
#'                     data = satisfaction, Hess = TRUE)
#'   summary(fit)
#' }
"satisfaction"
