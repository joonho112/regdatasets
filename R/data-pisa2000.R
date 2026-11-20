# pisa2000 ------------------------------------------------------------------

#' @eval rd_title_tag("pisa2000")
#'
#' @description
#' Reading scores and family background of 4,528 15-year-old students in the
#' United Kingdom, Germany and the United States who took part in PISA 2000,
#' the OECD's Programme for International Student Assessment. Each row is a
#' student, and the students come from 720 schools. The file is a three-country
#' teaching extract of the PISA 2000 database, with derived variables defined
#' as in Rabe-Hesketh and Skrondal's *Multilevel and Longitudinal Modeling
#' Using Stata*; how its students were selected is not documented.
#'
#' @eval rd_format_tag("pisa2000")
#'
#' @details
#' **Coding.** `country` holds ISO numeric country codes stored as text:
#' `"826"` = United Kingdom, `"276"` = Germany and `"840"` = United States.
#' The dummies `uk`, `germany` and `usa` sum to 1 in every row, so a model with
#' an intercept can include only two of them, and the one left out is the
#' reference; `factor(country)` makes Germany (`"276"`) the reference.
#' `reading` is the PISA proficiency level (0 = below level 1, up to 5),
#' derived from `wleread`, and `pass_rea` is 1 for levels 4 and 5 only.
#' Parental education is coded by two dummies: students with both `high_sch`
#' and `college` equal to 0 (1,529 of them) form the reference group.
#'
#' **Design.** Students are clustered in schools (`id_schoo`, unique across
#' countries), and the file has no sampling weights. Standard errors that
#' ignore the clustering can be too small, and the country means should not
#' be read as national estimates. Rows 2123 and 2386 are identical on all 15
#' variables; whether they are two students or one duplicated record is not
#' known. There are no missing values. Version 1.0.0 changed no values; it
#' corrects the definition of `pass_rea` given in the v0.2.0 help page.
#'
#' **Suggested analyses.**
#'
#' - simple regression of `wleread` on `isei`;
#' - comparing the three countries with dummy variables (one-way ANOVA as a
#'   regression);
#' - interactions, e.g. whether the `isei` slope or the gender gap differs by
#'   country;
#' - logistic regression of `pass_rea`.
#'
#' @eval rd_source_tag("pisa2000")
#'
#' @seealso [codebook()] for the variable table as a data frame, and
#'   [list_datasets()] for the other datasets.
#'
#' @examples
#' head(pisa2000)
#'
#' # Mean reading score by country ("276" = Germany, "826" = UK, "840" = USA)
#' tapply(pisa2000$wleread, pisa2000$country, mean)
#'
#' # Reading on parental occupation, gender and country (UK is the reference)
#' fit <- lm(wleread ~ isei + female + germany + usa, data = pisa2000)
#' summary(fit)
#'
#' # Logistic regression for reading proficiency at level 4 or 5
#' glm(pass_rea ~ isei + female + germany + usa, family = binomial,
#'     data = pisa2000)
"pisa2000"
