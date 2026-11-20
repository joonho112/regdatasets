# titanic -------------------------------------------------------------------

#' @eval rd_title_tag("titanic")
#'
#' @description
#' Survival, passenger class, sex, age, fare and port of embarkation for
#' 1,309 passengers of the Titanic, which sank in April 1912; the crew are
#' not included. One row per passenger. The data are 6 of the 14 variables
#' of titanic3, compiled by Thomas Cason from Encyclopedia Titanica and
#' other sources and distributed by the Department of Biostatistics at
#' Vanderbilt University.
#'
#' @eval rd_format_tag("titanic")
#'
#' @details
#' `survived` is 1 for the 500 passengers (38%) who survived. `sex` is coded
#' 1 = female and 0 = male, so its coefficient compares women with men.
#' `pclass` is an integer; use `factor(pclass)` for a separate effect of
#' each class rather than a linear trend. `fare` is in pre-1970 British
#' pounds; 17 passengers have a fare of 0 and 1 has none.
#'
#' Age is missing for 263 passengers (20%), 208 of them in third class, and
#' passengers with no recorded age survived less often (28% against 41%).
#' Models with `age` drop these passengers by default, and the complete
#' cases are not a random subset. Ages under 1 year are fractional.
#'
#' Version 1.0.0 corrected `embarked`. In the file used by earlier versions
#' the port was wrong for 355 passengers (27%); it is now taken from
#' titanic3, so results that use `embarked` change. Two passengers have no
#' recorded port. The other variables are unchanged.
#'
#' **Suggested analyses.**
#'
#' - simple logistic regression of survival on sex, with odds ratios;
#' - multiple logistic regression with class (as a factor) and age, and a
#'   sex-by-class interaction: 97% of first-class women survived, but only
#'   49% of third-class women;
#' - missing data: what complete-case analysis of `age` does to the sample;
#' - logit versus probit links, and the latent-variable view of a binary
#'   outcome.
#'
#' @section Note:
#' Each row is a real person, and 809 of these passengers died in the
#' sinking. The data are offered for statistical teaching, with respect for
#' the people they describe and for their families.
#'
#' @eval rd_source_tag("titanic")
#'
#' @seealso `carData::TitanicSurvival` on CRAN has the same 1,309
#'   passengers in the same order, with four of these variables (survival,
#'   sex and class as factors, and age). The base R table `datasets::Titanic`
#'   is a different source: counts for 2,201 people, crew included, with age
#'   only as child or adult. [codebook()] and [list_datasets()].
#'
#' @examples
#' head(titanic)
#'
#' # Proportion surviving by sex (1 = female) and class
#' with(titanic, tapply(survived, list(sex = sex, class = pclass), mean))
#'
#' # Logistic regression with class as a factor
#' fit <- glm(survived ~ sex + factor(pclass) + age, family = binomial,
#'            data = titanic)
#' summary(fit)
#' exp(coef(fit))   # odds ratios
"titanic"
