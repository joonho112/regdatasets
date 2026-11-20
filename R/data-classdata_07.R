# classdata_07 --------------------------------------------------------------

#' @eval rd_title_tag("classdata_07")
#'
#' @description
#' Simulated data for 44 imaginary students: study and work hours (actual
#' and desired), gender, height, desired weight, exercise, sleep, alcohol use
#' and age group. The values are a seeded, simulated look-alike of a
#' 44-student class survey from 2007, not anyone's real answers. The original
#' survey has no consent or release record, so version 1.0.0 replaced it with
#' simulated values that keep its variable names, types, codes and plausible
#' ranges.
#'
#' @eval rd_format_tag("classdata_07")
#'
#' @details
#' **Simulated values.** Every value comes from a seeded simulation (the
#' script `data-raw/recipes/classdata_07.R` in the package's source
#' repository), so the values are the same in every build. By construction,
#' height and desired weight differ between women and men, desired study
#' hours are actual study hours plus noise, and desired work hours are a
#' fraction of actual work hours; the other variables were drawn
#' independently. Any pattern in the data is a property of the simulation:
#' use the data to practice methods, not to learn about real students.
#'
#' **Coding.** `gender` is 0 for female and 1 for male (32 and 12 rows).
#' `age` is an age group (0 = up to 27, 1 = 28 to 31, 2 = 32 and up), not
#' years. `overage` is `"no"` in every row; what the original survey item
#' recorded is not documented. Because `overage` is a single-level character
#' column, exclude it when using dot formulas (for example,
#' `lm(height ~ . - overage, data = classdata_07)`). No value is missing.
#'
#' **Suggested analyses.**
#'
#' - A two-sample t-test and a regression on a 0/1 dummy are the same test:
#'   `t.test(height ~ gender, var.equal = TRUE)` and `lm(height ~ gender)`
#'   give the same t statistic (up to its sign) and p-value, and the dummy's
#'   coefficient is the difference between the two group means.
#' - Simple regression, for example of `actual_study` on `desired_study`.
#' - A dummy and a continuous predictor together, for example
#'   `desired_weight ~ height + gender`: height predicts desired weight on
#'   its own but not once gender is controlled, because the simulation links
#'   the two only through gender.
#'
#' @eval rd_source_tag("classdata_07")
#'
#' @seealso [codebook()] and [list_datasets()].
#'
#' @examples
#' str(classdata_07)
#'
#' # A two-sample t-test (equal variances) and a regression on the 0/1 dummy
#' # give the same t statistic (up to sign) and the same p-value
#' t.test(height ~ gender, data = classdata_07, var.equal = TRUE)
#' summary(lm(height ~ gender, data = classdata_07))
"classdata_07"
