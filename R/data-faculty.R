# faculty -------------------------------------------------------------------

#' @eval rd_title_tag("faculty")
#'
#' @description
#' Academic-year salaries, rank, experience and gender of 514 faculty
#' members of Bowling Green State University (Ohio) in 1993-94, one row per
#' faculty member. The data were provided with DeMaris's (2004) book
#' *Regression with Social Data*. The 514 cases are a subset defined by
#' Rabe-Hesketh and Skrondal for *Multilevel and Longitudinal Modeling Using
#' Stata*, and the file is identical to that book's Stata Press companion
#' data.
#'
#' @eval rd_format_tag("faculty")
#'
#' @details
#' **Sample.** The 514 faculty are not the whole university: the subset
#' leaves out, among others, instructors, lecturers and faculty who are not
#' on the graduate faculty. Rows 57 and 464 are identical on all ten
#' variables; whether they are two people or one duplicated record is not
#' documented. No value is missing, and the values are unchanged in version
#' 1.0.0.
#'
#' **Variables.** `salary` is the nine-month academic-year salary in US
#' dollars. `market` is the ratio of the national average salary in the
#' faculty member's discipline to the national average across disciplines,
#' so values above 1 mark better-paid disciplines. `yearsdg` is years since
#' degree; `rank` is 1 = assistant, 2 = associate and 3 = full professor
#' (use `factor(rank)` in models); `male` is 1 for men and 0 for women.
#'
#' **Unverified variables.** The sources do not define `exprior`, `yearsbg`,
#' `yearsrank`, `termdeg` and `admin`; their labels are guesses from the
#' names. `yearsbg` cannot be years since a bachelor's degree (the meaning
#' given in version 0.2.0), because it is smaller than `yearsdg` in 257 rows.
#' `termdeg` is 0 for only 6 faculty and `admin` is 1 for only 16. Do not
#' base substantive conclusions on the labels of these five variables.
#'
#' **The gender gap.** Men earned about 10,600 dollars more than women on
#' average, but men make up 192 of the 211 full professors and 83 of the 143
#' assistant professors. Adjusting for rank, years since degree and market
#' shrinks the gap to about 1,100 dollars, which is not statistically
#' significant. Whether to adjust for rank is a substantive question, because
#' rank may itself reflect the gender differences under study.
#'
#' **Suggested analyses.**
#'
#' - The salary gap between men and women, before and after adjusting for
#'   `factor(rank)`, `yearsdg` and `market`: dummy and continuous predictors
#'   in one model.
#' - Interactions, for example whether the salary gain per year since degree
#'   differs between men and women (`male * yearsdg`).
#' - `log(salary)` as the outcome: salary is mildly right-skewed, and on the
#'   log scale the coefficients are approximate proportional differences.
#' - Collinearity: `yearsdg`, `yearsbg`, `yearsrank` and `rank` are
#'   correlated with one another (r from 0.49 to 0.84).
#'
#' @eval rd_source_tag("faculty")
#'
#' @seealso [codebook()] and [list_datasets()].
#'
#' @examples
#' head(faculty)
#'
#' # Salary gap between men (male = 1) and women, unadjusted
#' coef(lm(salary ~ male, data = faculty))
#'
#' # Adjusted for rank (as a factor), years since degree and market
#' summary(lm(salary ~ male + factor(rank) + yearsdg + market, data = faculty))
"faculty"
