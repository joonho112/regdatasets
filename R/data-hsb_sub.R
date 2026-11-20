# hsb_sub -------------------------------------------------------------------

#' @eval rd_title_tag("hsb_sub")
#'
#' @description
#' Mathematics achievement and background of 188 students in five schools of
#' the High School and Beyond (HSB) file of Raudenbush and Bryk (2002), which
#' holds 7,185 students in 160 schools from the U.S. High School and Beyond
#' survey of the National Center for Education Statistics. Each row is a
#' student; `size` and `sector` describe the student's school. The five
#' schools are the ones with the lowest school IDs in that file.
#'
#' @eval rd_format_tag("hsb_sub")
#'
#' @details
#' **Design.** The five schools (IDs 1224, 1288, 1296, 1308 and 1317) have
#' 47, 25, 48, 20 and 48 students. Schools 1224, 1288 and 1296 are public;
#' schools 1308 and 1317 are Catholic. Because `size` and `sector` are
#' constant within a school, they vary across only five schools: a sector
#' comparison rests on three public and two Catholic schools, and a model
#' with school dummies, `factor(schoolid)`, cannot separate them from the
#' school effects (R reports the aliased terms as `NA`). Students in the same
#' school are not independent, so ordinary least-squares standard errors,
#' especially for school-level predictors, can be too small.
#'
#' **Coding.** `minority`, `female` and `sector` are 0/1 dummies (`sector`
#' 1 = Catholic). There are no missing values, and version 1.0.0 changed no
#' values.
#'
#' **Suggested analyses.**
#'
#' - simple and multiple regression of `mathach` on `ses`, `minority`,
#'   `female` and `sector`;
#' - interactions, e.g. whether the `ses` slope differs by sector
#'   (`ses * sector`);
#' - model building and regression diagnostics in a small sample;
#' - a first look at nested data: school dummies, `factor(schoolid)`, or a
#'   separate `ses` slope in each school.
#'
#' @eval rd_source_tag("hsb_sub")
#'
#' @seealso [hsbs1] for a different High School and Beyond extract (350
#'   students with five test scores). The full 160-school file is on CRAN as
#'   `nlme::MathAchieve` (students) and `nlme::MathAchSchool` (schools).
#'   [codebook()] gives the variable table as a data frame, and
#'   [list_datasets()] lists the other datasets.
#'
#' @examples
#' head(hsb_sub)
#'
#' # Does the SES slope differ between public and Catholic schools?
#' fit <- lm(mathach ~ ses * sector + minority + female, data = hsb_sub)
#' summary(fit)
#'
#' # School dummies absorb all differences between the five schools
#' fit_school <- lm(mathach ~ ses + factor(schoolid), data = hsb_sub)
#' anova(lm(mathach ~ ses, data = hsb_sub), fit_school)
"hsb_sub"
