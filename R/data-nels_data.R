# nels_data -----------------------------------------------------------------

#' @eval rd_title_tag("nels_data")
#'
#' @description
#' Questionnaire items, composites and test scores for 2,000 students in the
#' National Education Longitudinal Study of 1988 (NELS:88): 299 variables
#' from the base year, 1988 (grade 8), and the first follow-up, 1990
#' (grade 10). One row per student. The NELS variables keep their original
#' names and codes, for example `bys12` (sex) and `by2xmstd` (grade-8
#' mathematics score). The file is a teaching extract of the NCES
#' public-use data; how its 2,000 students were chosen is not documented.
#' Because there are 299 variables, use `codebook("nels_data")` to search
#' variables in R, or scroll below the variable list for **Details** and
#' **Examples**.
#'
#' @eval rd_format_tag("nels_data")
#'
#' @details
#' **Layout.** The variables are grouped by wave and kind: the base-year
#' (1988) student questionnaire (148 items, `bys2a` to `bys83j`), tests,
#' composites and school characteristics; then the first follow-up (1990)
#' questionnaire (105 items, `f1s8a` to `f1s110yr`), one test score, and
#' composites and status variables such as `f1stat`. The only 1990 test score
#' is reading (`f12xrstd`), so change in achievement can be followed for
#' reading only. `id` is the NELS student identifier (`STU_ID` in NCES files).
#' `year1` and `year2` are not NELS variables and their meaning is not
#' documented; leave them out of analyses.
#'
#' **Codes.** Items keep their NELS codes and follow the NCES NELS:88 codebook
#' wording, so check them before modeling. The 40 agreement items run from
#' 1 = strongly agree to 4 = strongly disagree. Most yes/no items are 1 = yes
#' and 2 = no, but `bys74` (held back a grade) is 1 = no and 2 = yes. `bys12`
#' (sex) is 1 = male and 2 = female, and `bys31a` (race/ethnicity) runs from
#' 1 = Asian or Pacific Islander to 5 = American Indian. Nominal items, such
#' as occupations and school programs, need `factor()`. `codebook("nels_data")`
#' returns the full variable table, with codes and units, as a data frame.
#'
#' **Missing data and version 1.0.0.** In 0.2.0 most nonresponse codes were
#' stored as numbers, so a 98 or a 99.98 could enter a model as if it were
#' a real value. Version 1.0.0 recodes them to NA, 41,966 values in all
#' (0.2.0 had already recoded 82 others, the 998 codes in `g8minor` and
#' `g8lunch`):
#'
#' - NELS nonresponse codes such as 8 = missing, 9 = legitimate skip,
#'   6 = multiple response and 7 = refusal, or 98, 99, 96 and 97 on items
#'   with more categories (40,145 cells);
#' - non-integer codes from the NELS codebook in test scores and
#'   composites, such as 99.98 = missing and 99.99 = test not completed
#'   (1,356 cells);
#' - "don't know" answers on the ordered items `bypared`, `bys34a`,
#'   `bys34b` and `f1s17` (465 cells).
#'
#' On nominal items, such as the occupation and school-program items,
#' "don't know" is kept as its own category. The `recoded_to_na` column of
#' `codebook("nels_data")` shows what was recoded in each variable.
#'
#' Legitimate skips (questions that did not apply to a student) are NA as
#' well, so NA does not always mean a missing answer: `bys31c` and
#' `bys31d`, which ask Hispanic students about their origin and race, hold
#' 1,717 legitimate skips each. The 109 students who did not take part in
#' the 1990 follow-up (`f1stat` other than 0) have no 1990 questionnaire
#' data. No student is complete on all 299 variables, so
#' `na.omit(nels_data)` returns no rows; choose the variables first.
#'
#' **Sample.** How the 2,000 students were drawn is not documented, and the
#' file has no sampling weights, so results describe these students rather
#' than the national population of eighth graders that NELS:88 sampled.
#' All 296 named NELS variables (plus `id`, the NCES student ID `STU_ID`) are
#' in the NCES public-use data; the remaining two columns (`year1`, `year2`)
#' are undocumented.
#'
#' **Suggested analyses.**
#'
#' - model building and variable selection, for example for the grade-8
#'   mathematics score (`by2xmstd`) with SES (`byses`), bracketed homework
#'   time (`byhomewk`, 1 = none to 8 = 21+ hours/week), attitudes and school
#'   characteristics as candidate predictors;
#' - regression diagnostics (residuals, leverage and influence) for such
#'   models;
#' - change in reading between grade 8 and grade 10: `f12xrstd` on
#'   `by2xrstd` and other predictors;
#' - logistic regression of a binary item, such as being held back a grade
#'   (`bys74`, recoded to 0/1, e.g. `I(bys74 == 2)`).
#'
#' @eval rd_source_tag("nels_data")
#'
#' @seealso [disc] and [disc2] hold some of these variables, with recodes,
#'   for the same 2,000 students in the same order. [codebook()], for
#'   example `codebook("nels_data")`, and [list_datasets()].
#'
#' @examples
#' head(nels_data)
#'
#' # Find variables by their labels
#' cb <- codebook("nels_data")
#' cb[grepl("socioeconomic", cb$label, ignore.case = TRUE),
#'    c("variable", "label", "group")]
#'
#' # Grade-8 mathematics score on SES (nonresponse codes are NA since 1.0.0)
#' fit <- lm(by2xmstd ~ byses, data = nels_data)
#' summary(fit)
#'
#' # Reading in 1990 (grade 10) given reading in 1988 (grade 8)
#' lm(f12xrstd ~ by2xrstd + byses, data = nels_data)
"nels_data"
