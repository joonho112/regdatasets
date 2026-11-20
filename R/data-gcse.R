# gcse ----------------------------------------------------------------------

#' @eval rd_title_tag("gcse")
#'
#' @description
#' Examination results of 4,059 students in 65 inner-London schools, one row
#' per student: the GCSE (General Certificate of Secondary Education) exam
#' score at age 16 and the London Reading Test (LRT) score at age 11. The
#' data are the Exam data of Goldstein et al. (1993), distributed by the
#' Centre for Multilevel Modelling at the University of Bristol, with both
#' scores multiplied by 10.
#'
#' @eval rd_format_tag("gcse")
#'
#' @details
#' **Scores.** `gcse` and `lrt` are the Exam data's `normexam` and `standLRT`
#' (as named in `mlmRev::Exam`) multiplied by 10, so each has a mean of about
#' 0 and a standard deviation of about 10: one point is about a tenth of a
#' standard deviation. The data frame and its outcome share the name `gcse`,
#' so the outcome is `gcse$gcse`.
#'
#' **Coding.** `gender` is 1 for girls and 0 for boys. Thirty of the 65
#' schools are single-sex (20 girls' and 10 boys' schools), so in a model
#' with a school factor the gender effect rests on the 35 mixed schools.
#' `school` is an ID number from 1 to 65; the data do not name the schools.
#' `student` is the original Exam ID: it is not unique across schools, and
#' four IDs occur twice within the same school (8 rows, different students),
#' so `school` and `student` together do not identify a row. No value is
#' missing.
#'
#' **Changes in version 1.0.0.** The column `pred`, a stored prediction from
#' a multilevel model on the original score scale (not multiplied by 10), was
#' removed, so the data now have 5 columns. The other values are unchanged.
#'
#' **Suggested analyses.**
#'
#' - Simple regression of `gcse` on `lrt`, for all students or within one
#'   school.
#' - ANCOVA: comparing schools, or girls and boys, at the same `lrt` score.
#' - Interactions: does the `lrt` slope differ by `gender`, or across schools
#'   (`lrt * factor(school)`)?
#' - Nonlinearity, model building and diagnostics: a quadratic term in `lrt`,
#'   residual plots and influence measures. Because students are nested in
#'   schools, the data also suit random-intercept and random-slope models.
#'
#' @eval rd_source_tag("gcse")
#'
#' @seealso `mlmRev::Exam` on CRAN has the same students on the original
#'   score scale, with more variables; [codebook()] and [list_datasets()].
#'
#' @examples
#' head(gcse)
#'
#' # Simple regression of the GCSE score on the reading score at age 11
#' summary(lm(gcse ~ lrt, data = gcse))
#'
#' # ANCOVA: schools 1 and 2 compared at the same LRT score
#' two <- subset(gcse, school %in% c(1, 2))
#' lm(gcse ~ lrt + factor(school), data = two)
"gcse"
