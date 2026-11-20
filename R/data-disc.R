# disc ----------------------------------------------------------------------

#' @eval rd_title_tag("disc")
#'
#' @description
#' Whether 2,000 eighth graders in the National Education Longitudinal Study
#' of 1988 (NELS:88) had been sent to the office for misbehaving, with their
#' sex, race/ethnicity, parents' education, whether they had their own
#' bedroom and how often they had discussed class work with their parents.
#' One row per student, from the 1988 base-year student questionnaire. The
#' seven NELS items (`bys*`) keep their original NELS codes, next to 0/1
#' recodes ready for regression. The students are the same, and in the same
#' order, as in [disc2].
#'
#' @eval rd_format_tag("disc")
#'
#' @details
#' **Coding.** The `bys*` items keep NELS codes: `bys12` (sex) is 1 = male
#' and 2 = female, and `bys35p` is 1 = has own bedroom and 2 = does not.
#' The recodes are ready for regression: `sentoff` (0/1) and
#' `osentoff` (0 = never, 1 = once or twice, 2 = more than twice) for the
#' outcome, and `male`, `fath_ed` and `moth_ed` (parent finished high
#' school), `bedroom` and the factor `race` as predictors. The outcome is
#' the student's own report of how often they were sent to the office in
#' the first semester of eighth grade; 552 of the 1,972 students who
#' answered (28%) were sent at least once.
#'
#' **`discuss` is misnamed.** Despite its name, `discuss` equals
#' `1 - bedroom` in every row (1 = does not have own bedroom); it has
#' nothing to do with discussing school with parents. Use `bys36c` for how
#' often the student discussed class work with parents.
#'
#' **`race`** has five levels: Asian (Asian or Pacific Islander, 122
#' students), Hispanic (259), Black (194), White (1,333) and American Indian
#' (68); the 24 nonrespondents are NA. The first level, Asian, is the
#' default reference; use `relevel(race, ref = "White")` to compare each
#' group with White students.
#'
#' **Missing data and version 1.0.0.** Version 1.0.0 recoded the
#' nonresponse codes left in the `bys*` items (missing, refusal and
#' multiple response; 144 cells) to NA. On parents' education, "don't know"
#' (8) and missing (98) were already NA in 0.2.0; only the 97 = refusal
#' codes (5 fathers, 3 mothers) are new NAs. The recodes were already NA
#' for all these students. Also new in 1.0.0 is the American Indian
#' level of `race`: these 68 students were NA in 0.2.0, so models with
#' `race` now include them. Parents' education is unknown for many
#' students (282 fathers, 208 mothers), mostly because the student answered
#' "don't know", and models with `fath_ed` or `moth_ed` lose them.
#'
#' The seven `bys*` items match the same items in [nels_data] row by row,
#' so the rows line up with that file as well.
#'
#' **Suggested analyses.**
#'
#' - simple and multiple logistic regression of `sentoff` on sex, race and
#'   parents' education, with odds ratios;
#' - likelihood-ratio tests, for example for the four `race` contrasts
#'   together;
#' - a proportional odds model for the three-category `osentoff`;
#' - how listwise deletion changes the sample when `fath_ed` (282 NAs)
#'   enters a model.
#'
#' @section Ethical context:
#' These data invite models with race as a predictor of school discipline.
#' Racial disparities in school discipline are well documented in
#' educational research and are often discussed in terms of the
#' "school-to-prison pipeline". Here the outcome is the student's own
#' report of being sent to the office, not a school record, and a race
#' coefficient describes a difference in those reports; it does not explain
#' it. The `race` factor follows the 1988 NELS questionnaire item (Asian or
#' Pacific Islander, Hispanic, Black, White, American Indian), whose
#' categories are neither exhaustive nor current descriptions of racial and
#' ethnic identity. Before version 1.0.0 the 68 American Indian students
#' were NA and so were dropped from every model that used `race`; they now
#' have their own level, though estimates for so small a group are
#' imprecise. Analyses are best read alongside the research literature on
#' structural inequities in school discipline.
#'
#' @eval rd_source_tag("disc")
#'
#' @seealso [disc2] for the same students with SES and test scores;
#'   [nels_data] for 299 variables on the same students;
#'   [codebook()] and [list_datasets()].
#'
#' @examples
#' head(disc)
#'
#' # Share sent to the office at least once, by sex (1 = male)
#' tapply(disc$sentoff, disc$male, mean, na.rm = TRUE)
#'
#' # Logistic regression with White students as the reference group
#' d <- disc
#' d$race <- relevel(d$race, ref = "White")
#' fit <- glm(sentoff ~ male + race + fath_ed, family = binomial, data = d)
#' summary(fit)
#'
#' # Proportional odds model for the three categories (requires MASS;
#' # summary() reports t-values without p-values)
#' if (requireNamespace("MASS", quietly = TRUE)) {
#'   fit_ord <- MASS::polr(
#'     factor(osentoff) ~ male + race, data = d, Hess = TRUE
#'   )
#'   summary(fit_ord)
#' }
"disc"
