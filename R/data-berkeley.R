# berkeley ------------------------------------------------------------------

#' @eval rd_title_tag("berkeley")
#'
#' @description
#' Admission decisions for the 3,593 applicants to five departments of the
#' graduate school of the University of California, Berkeley, in fall 1973,
#' one row per applicant. Departments 1 to 5 are departments B to F of the
#' admissions table in base R's `datasets::UCBAdmissions`, which identifies
#' departments only by letter; department A is not included. The data are a
#' classic example of confounding and Simpson's paradox in logistic
#' regression.
#'
#' @eval rd_format_tag("berkeley")
#'
#' @details
#' **Departments.** `department` is a code: 1 = B, 2 = C, 3 = D, 4 = E and
#' 5 = F. Department A (933 applicants) is absent, so the data hold 3,593 of
#' the 4,526 applicants in `datasets::UCBAdmissions`. Use
#' `factor(department)` in models: entered as a number, the code would force
#' a straight-line trend across arbitrary labels.
#'
#' **One row per applicant.** The rows were expanded from a table of counts,
#' so there are only 20 distinct rows (5 departments x 2 genders x 2
#' decisions). `female` is 1 for women and 0 for men, whereas [berk_sub]
#' codes `male`. No value is missing, and the values are unchanged in version
#' 1.0.0.
#'
#' **Simpson's paradox.** Overall, 27% of women and 37% of men were admitted
#' (odds ratio for women 0.64). But almost all women (1,702 of 1,727) applied
#' to departments C to F, which admitted 6% to 35% of their applicants, while
#' 30% of men applied to department B, which admitted 63%. Controlling for
#' department, the odds ratio for women is about 0.97.
#'
#' **Suggested analyses.**
#'
#' - Logistic regression of `admitted` on `female`, without and with
#'   `factor(department)`: how adjusting for a confounder changes the gender
#'   coefficient.
#' - Adding `female:factor(department)` gives the saturated model for the 10
#'   department-by-gender cells. A likelihood-ratio test against it
#'   (`anova(..., test = "Chisq")`) asks whether the gender effect differs
#'   across departments, and is a goodness-of-fit test of the main-effects
#'   model.
#'
#' @eval rd_source_tag("berkeley")
#'
#' @seealso [berk_sub] for departments B and E only, coded with `male`;
#'   `datasets::UCBAdmissions` in base R for the full six-department table of
#'   counts (4,526 applicants); [codebook()] and [list_datasets()].
#'
#' @examples
#' head(berkeley)
#'
#' # Admission rate by department (rows) and gender (columns, female = 1)
#' with(berkeley, tapply(admitted, list(department, female), mean))
#'
#' # Odds ratio for women, before and after controlling for department
#' fit0 <- glm(admitted ~ female, data = berkeley, family = binomial)
#' fit1 <- glm(admitted ~ female + factor(department), data = berkeley,
#'             family = binomial)
#' exp(coef(fit0)["female"])
#' exp(coef(fit1)["female"])
"berkeley"
