# gss_1 ---------------------------------------------------------------------

#' @eval rd_title_tag("gss_1")
#'
#' @description
#' Responses of all 2,832 people interviewed in the 1998 General Social Survey
#' (GSS), the survey of U.S. adults run by NORC at the University of Chicago.
#' Each row is a respondent, with attitudes to abortion and cohabitation,
#' political views, religion, sexual partners, own income, marital status,
#' schooling, parents' schooling, age, sex and race. The file is a teaching
#' extract of unknown authorship in which several GSS items were recoded or
#' combined into scores.
#'
#' @eval rd_format_tag("gss_1")
#'
#' @details
#' **Recoded variables.** `income` is the respondent's own income (GSS
#' RINCOM98) in 23 unequal brackets, not household income. `conserv` is GSS
#' POLVIEWS (higher = more conservative), `religion` regroups GSS RELIG into
#' five categories, and `respage` gives the mean age, 45.56, to the 4
#' respondents who did not report their age. `partnrs5` codes 5 to 8 are
#' ranges (5 to 10, 11 to 20, 21 to 100 and more than 100 partners), so treat
#' it as ordinal, not as a count. `race`, `marital` and `religion` are integer
#' codes: use `factor()` or, for race, the dummies `black` and `othrace`.
#'
#' **Scores of unknown construction.** `abortion` (0 to 7), `cohabit` (2 to
#' 10) and `relosity` (mean 0) are composites built by an unknown party, and
#' no record of their items or scoring has been found. The 172 fractional
#' values of `abortion` suggest an item count prorated over the items
#' answered. In these data, higher `abortion` and `cohabit` scores go with
#' more liberal views, and higher `relosity` scores go with having a
#' religious affiliation and with conservative views. Report them as scores
#' of unknown construction, not as validated scales.
#'
#' **Missing data.** 55% of `cohabit`, 35% of `income`, 34% of `abortion` and
#' 28% of `paed` are `NA`, and only 348 rows are complete on all 16
#' variables. Per the 1998 NORC GSS archive, 798 of the 983 missing incomes
#' were "inapplicable" (mainly people without earnings; the source file
#' collapsed all missing reasons to plain `NA`), so a model that uses `income`
#' describes people with earnings. `lm()` and `glm()` drop incomplete rows by
#' default (listwise deletion): a regression of `relosity` on
#' `factor(religion)`, `maed`, `respage`, `black` and `othrace` uses 2,371 of
#' the 2,832 rows. Rows 285 and 349 are identical on all 16 variables; whether
#' they are two respondents or one duplicated record is not known.
#'
#' Version 1.0.0 changed no values. It corrects the survey year and the
#' meanings of `income` and `partnrs5` given in the v0.2.0 documentation.
#'
#' **Suggested analyses.**
#'
#' - logistic regression of a dichotomized score, e.g. `abortion >= 4`, on
#'   `conserv`, `educat` and `relosity`, with odds ratios;
#' - dummy variables for `religion`, `marital` or `race`;
#' - comparing listwise deletion with other ways of handling missing data,
#'   such as missing-value indicators or multiple imputation.
#'
#' @eval rd_source_tag("gss_1")
#'
#' @seealso [codebook()] for the variable table as a data frame, and
#'   [list_datasets()], e.g. `list_datasets(topic = "logistic")`, for other
#'   datasets suited to logistic regression.
#'
#' @examples
#' head(gss_1)
#'
#' # Number of missing values in each variable
#' colSums(is.na(gss_1))
#'
#' # Logistic regression for a high abortion score (4 or more on the 0-7 scale)
#' fit <- glm(I(abortion >= 4) ~ conserv + educat + relosity,
#'            family = binomial, data = gss_1)
#' summary(fit)
#' exp(coef(fit))  # odds ratios
#' nobs(fit)       # rows used: only those with no NA in these variables
"gss_1"
