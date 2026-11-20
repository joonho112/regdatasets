# berk_sub ------------------------------------------------------------------

#' @eval rd_title_tag("berk_sub")
#'
#' @description
#' Admission decisions for the 1,169 applicants to two departments of the
#' graduate school of the University of California, Berkeley, in fall 1973,
#' one row per applicant. The two departments are B and E of the admissions
#' table in base R's `datasets::UCBAdmissions`, which identifies departments
#' only by letter. With three binary variables, the data are a compact
#' example of confounding and Simpson's paradox in logistic regression.
#'
#' @eval rd_format_tag("berk_sub")
#'
#' @details
#' **Departments.** `engineering` = 1 is department B (585 applicants) and
#' `engineering` = 0 is department E (584 applicants); they are departments
#' 1 and 4 of [berkeley]. The names "engineering" (for B) and "psychology"
#' (for E) are guesses, not documented facts: the real departments are
#' anonymous. The variable keeps its old name, but describe the departments
#' as B and E.
#'
#' **One row per applicant.** The rows were expanded from a table of counts,
#' so there are only eight distinct rows (2 departments x 2 genders x 2
#' decisions). A logistic regression on the 1,169 rows gives the same
#' estimates and standard errors as a binomial regression on the four
#' department-by-gender counts.
#'
#' **Coding.** `male` is 1 for men and 0 for women, whereas [berkeley] codes
#' `female` (1 = women). No value is missing, and the values are unchanged in
#' version 1.0.0.
#'
#' **Simpson's paradox.** Overall, 54% of men and 27% of women were admitted
#' (odds ratio for men 3.25). But 96% of department B's applicants were men,
#' against 33% of department E's, and B admitted 63% of its applicants
#' against 25% for E. Controlling for department, the odds ratio for men
#' falls to about 1.1 and is not statistically significant; in department B,
#' women were admitted at a slightly higher rate than men.
#'
#' **Suggested analyses.**
#'
#' - Logistic regression of `admitted` on `male`, without and with
#'   `engineering`: confounding and omitted-variable bias.
#' - The interaction `male * engineering`: does the gender difference differ
#'   between the two departments?
#' - The same models fitted to the aggregated counts with a binomial
#'   response, `cbind(admitted, rejected)`, to compare individual and
#'   grouped data.
#'
#' @eval rd_source_tag("berk_sub")
#'
#' @seealso [berkeley] for five departments (B to F) of the same admissions
#'   data; `datasets::UCBAdmissions` in base R for the full six-department
#'   table of counts; [codebook()] and [list_datasets()].
#'
#' @examples
#' head(berk_sub)
#'
#' # Share of men and admission rate by department (engineering = 1 is B)
#' aggregate(cbind(male, admitted) ~ engineering, data = berk_sub, FUN = mean)
#'
#' # Odds ratios for men, before and after controlling for department
#' fit0 <- glm(admitted ~ male, data = berk_sub, family = binomial)
#' fit1 <- glm(admitted ~ male + engineering, data = berk_sub,
#'             family = binomial)
#' exp(coef(fit0))
#' exp(coef(fit1))
"berk_sub"
