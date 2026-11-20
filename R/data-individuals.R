# individuals ---------------------------------------------------------------

#' @eval rd_title_tag("individuals")
#'
#' @description
#' Income, education, sex, age and job sector of 55,899 adults aged 25 to 65
#' from the March 2000 Current Population Survey (CPS), the survey of U.S.
#' households that the Census Bureau conducts for the Bureau of Labor
#' Statistics. Each row is a person. The six-variable extract of the CPS
#' Annual Demographic Supplement was made by an unknown party, and the rule
#' that selected these 55,899 people is not documented.
#'
#' @eval rd_format_tag("individuals")
#'
#' @details
#' **Coding.** `educ`, `sex` and `job` are integer codes: wrap them in
#' `factor()` (e.g. `factor(educ)`, `factor(job)`) or create 0/1 dummies so R
#' does not treat category codes as numeric trends. `job` starts at 5:
#' 5 = private sector, 6 = government, 7 = self-employed. `sex` is 1 = male,
#' 2 = female, and `educ` runs from 1 = no high school to 6 = postgraduate
#' degree (see the Format section). The v0.2.0 help page swapped `job` codes
#' 5 and 6 and gave wrong meanings for the `educ` codes, so code written for
#' it may treat government workers as private-sector workers. Version 1.0.0
#' corrected the documentation; the data are unchanged.
#'
#' **Income.** Despite its name, `earn` is total annual income from all
#' sources, in US dollars. Nobody has an income of exactly 0, and 170 values
#' are negative (down to -24,998), which CPS income allows, for example
#' through business losses; `log(earn)` is undefined for them. There are no
#' missing values.
#'
#' **Suggested analyses.**
#' - interactions between two dummy variables, e.g. sex by private versus
#'   government sector, where the interaction coefficient is a difference in
#'   differences;
#' - two-way ANOVA as regression with unequal cell sizes, and the difference
#'   between sequential (Type I) and adjusted (Type II or III) sums of
#'   squares;
#' - dummy coding of the six education levels.
#'
#' @eval rd_source_tag("individuals")
#'
#' @seealso [codebook()] for the variable table as a data frame, and
#'   [list_datasets()], e.g. `list_datasets(topic = "interactions")`, for
#'   other datasets suited to interactions.
#'
#' @examples
#' head(individuals)
#'
#' # Ages 30 to 39, postgraduate degree, private sector or government
#' sub <- subset(individuals,
#'               educ == 6 & age >= 30 & age <= 39 & job %in% c(5, 6))
#' sub$female  <- as.integer(sub$sex == 2)  # sex: 1 = male, 2 = female
#' sub$private <- as.integer(sub$job == 5)  # job: 5 = private, 6 = government
#'
#' # Mean income in the four cells
#' with(sub, tapply(earn, list(female = female, private = private), mean))
#'
#' # The interaction coefficient is a difference in differences
#' lm(earn ~ female * private, data = sub)
"individuals"
