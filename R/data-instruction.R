# instruction ---------------------------------------------------------------

#' @eval rd_title_tag("instruction")
#'
#' @description
#' Mathematics gains of 1,190 first graders in 312 classrooms and 107
#' schools, with characteristics of the students, their first-grade teachers
#' and their schools. The data come from the Study of Instructional
#' Improvement (SII), an observational study analyzed by Hill, Rowan and Ball
#' (2005), and are the classroom data of West, Welch and Galecki's (2006)
#' book *Linear Mixed Models*. Each row is a student.
#'
#' @eval rd_format_tag("instruction")
#'
#' @details
#' **Design.** Students are nested in classrooms (1 to 10 students per
#' classroom) and classrooms in schools (2 to 31 students per school).
#' `yearstea`, `mathknow` and `mathprep` describe the classroom's teacher and
#' are constant within a classroom; `housepov` is constant within a school.
#' Because the study is observational, regression coefficients describe
#' associations rather than causal effects of teachers or schools.
#'
#' **Coding.** `mathgain` is the spring first-grade score minus the spring
#' kindergarten score (`mathkind`), so it can be negative (39 students).
#' `housepov` is stored as a proportion (0.012 to 0.564), not a percentage.
#' `girl` (1 = girl) is called `sex` in the original classroom data.
#' `mathknow` is missing for 27 of the 312 classrooms (109 students); the
#' other variables are complete. Version 1.0.0 changed no values; it corrects
#' the v0.2.0 help page, which misdescribed the study.
#'
#' **Suggested analyses.**
#'
#' - one-way ANOVA of `mathgain` across schools, `factor(schoolid)`;
#' - simple and multiple regression of `mathgain` on `mathkind`, `ses`,
#'   `minority` and teacher variables such as `mathknow`;
#' - multilevel structure: compare ordinary least-squares standard errors for
#'   classroom- and school-level predictors with those from a model that
#'   allows for clustering.
#'
#' @eval rd_source_tag("instruction")
#'
#' @seealso [hsb_sub] and [gcse] also have students nested in schools. The
#'   same classroom data are on CRAN as `WWGbook::classroom`, where `girl` is
#'   called `sex`. [codebook()] gives the variable table as a data frame, and
#'   [list_datasets()] lists the other datasets.
#'
#' @examples
#' head(instruction)
#'
#' # One-way ANOVA: do mean math gains differ across the 107 schools?
#' anova(lm(mathgain ~ factor(schoolid), data = instruction))
#'
#' # Math gain on the kindergarten score, SES and the teacher's math knowledge
#' fit <- lm(mathgain ~ mathkind + ses + mathknow, data = instruction)
#' summary(fit)  # the 109 students without mathknow are dropped
"instruction"
