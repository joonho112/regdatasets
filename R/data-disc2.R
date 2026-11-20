# disc2 ---------------------------------------------------------------------

#' @eval rd_title_tag("disc2")
#'
#' @description
#' The same 2,000 NELS:88 eighth graders as [disc], in the same order, with
#' continuous predictors: the base-year socioeconomic status composite
#' (`ses`), reading and mathematics test scores from 1988 (grade 8), and the
#' reading score from the 1990 follow-up (grade 10). One row per student.
#' The other variables are recodes with readable names: being sent to the
#' office for misbehaving, sex, home language, own bedroom, parents'
#' education and race/ethnicity.
#'
#' @eval rd_format_tag("disc2")
#'
#' @details
#' **Coding.** All the recodes are 0/1 except `osentoff` (0 = never, 1 =
#' once or twice, 2 = more than twice) and the factor `race`, which has the
#' same five levels as in [disc], with Asian as the first (reference)
#' level. `fath_ed` and `moth_ed` mean the parent finished high school;
#' `fath_coll` and `moth_coll` mean the parent graduated from college.
#' `notengl` is 1 for the 220 students whose home language is not English;
#' the 1,560 students who legitimately skipped the NELS home-language item
#' are coded 0, together with the English speakers. `minority` is 1 for
#' Asian, Hispanic, Black and American Indian students alike.
#'
#' **Scores.** `reading1` and `math1` (grade 8, 1988) and `reading2`
#' (grade 10, 1990) are standardized test scores with mean about 50 and SD
#' about 10, so a coefficient per 10 points is roughly a coefficient per
#' SD. `ses` is the NELS base-year SES composite, built from parents'
#' education and occupations and family income; it is on a standardized
#' scale (here from -2.9 to 1.9, SD 0.8).
#'
#' **Missing data.** `reading2` is NA for 218 students, 215 of whom did not
#' complete the 1990 test; `reading1` and `math1` are NA for 77 and 75
#' students, and `ses` for 1. As in [disc], parents' education is unknown
#' for 282 fathers and 208 mothers. These values did not change in 1.0.0.
#'
#' **Version 1.0.0.** As in [disc], `race` gained the level American Indian
#' for 68 students who were NA before; the 24 nonrespondents are NA.
#' `minority` already counted these 68 students as 1. No other values
#' changed.
#'
#' **Suggested analyses.**
#'
#' - logistic regression of `sentoff` on continuous predictors such as
#'   `ses`, `math1` and `reading1`, with odds ratios per unit or per 10
#'   points;
#' - comparing `ses` with the parents' education dummies as measures of
#'   family background;
#' - linear regression of `reading2` on `reading1` and other predictors, a
#'   simple model of change between grade 8 and grade 10;
#' - an interaction between a dummy and a continuous predictor, such as
#'   `male` by `ses`.
#'
#' @section Ethical context:
#' The cautions on the [disc] page apply here too: the outcome is the
#' student's own report, not a school record; the `race` categories are
#' those of the 1988 NELS questionnaire; and a race coefficient describes a
#' difference without explaining it. Since version 1.0.0 the 68 American
#' Indian students have their own `race` level instead of being NA, though
#' estimates for so small a group are imprecise. Two points are specific to
#' this file. `minority` merges four groups, so a single coefficient can
#' hide differences between them. And SES and test scores differ by group
#' in these data (mean `ses` is about 0.1 for White and -0.6 for Hispanic
#' students), so adding them to a model changes what a race or minority
#' coefficient compares.
#'
#' @eval rd_source_tag("disc2")
#'
#' @seealso [disc] for the same students with the original NELS items;
#'   [nels_data] for 299 variables on the same students; [codebook()] and
#'   [list_datasets()].
#'
#' @examples
#' head(disc2)
#'
#' # Office referral and grade-8 achievement
#' fit <- glm(sentoff ~ ses + math1 + male, family = binomial, data = disc2)
#' summary(fit)
#'
#' # Reading in grade 10 (1990) given reading in grade 8 (1988)
#' lm(reading2 ~ reading1 + ses, data = disc2)
"disc2"
