% Please edit documentation in R/data.R
\docType{data}
\name{gcse}
\alias{gcse}
\title{GCSE and London Reading Test Data}
\format{
A tibble with 4,059 rows and 6 columns:
\describe{
\item{school}{School identifier. Type: numeric. Values: 1 to 65.
65 unique London secondary schools.}
\item{student}{Student identifier within school. Type: numeric.
Range: (1, 913). Not unique across schools.}
\item{gcse}{GCSE examination score at age 16, standardized. Type:
numeric. Range: (-36.66, 36.66). Mean approximately 0, SD
approximately 10. This is the primary outcome variable.}
\item{lrt}{London Reading Test score at age 11, standardized. Type:
numeric. Range: (-29.35, 30.16). Mean approximately 0, SD
approximately 10. This is the primary predictor for intake
achievement.}
\item{gender}{Gender of student. Type: numeric. Binary indicator
(0/1) where 1 = female, 0 = male. 60\% female.}
\item{pred}{Predicted GCSE score from the regression model. Type:
numeric. Range: (-1.91, 2.54). Pre-computed predicted values.}
}

Note: Columns \code{u0}, \code{u1}, and \code{filter__} (Stata multilevel
model artifacts containing -1e30 placeholder values) were removed in v0.2.0.
}
\source{
Goldstein, H., Rasbash, J., Yang, M., et al. (1993). A
multilevel analysis of school examination results. \emph{Oxford Review
of Education}, 19(4), 425--433. Original data file: \code{gcse.dta}
}
\usage{
gcse
}
\description{
Student achievement data from 65 London secondary schools, containing
GCSE (General Certificate of Secondary Education) exam scores taken at
age 16 and London Reading Test (LRT) scores at age 11 for 4,059 students.
Both scores have been standardized to have mean 0 and standard deviation
approximately 10. This is the primary running example throughout the
course, used from simple linear regression through interactions and
model diagnostics.
}
\details{
This dataset is the primary running example used throughout the course.
It appears in virtually every chapter:

\strong{Chapter 1 (Simple Linear Regression):} Regressing GCSE on LRT
for individual schools (e.g., Battersea, Chelsea) to introduce the
regression model, OLS estimation, R-squared, and inference.

\strong{Chapter 2 (ANCOVA):} Comparing schools while controlling for
LRT intake scores. The unadjusted difference between Chelsea and
Battersea is 9.86 points, but the LRT-adjusted difference is 7.51.

\strong{Chapter 5 (Interactions):} Testing whether the LRT slope
differs across schools (school-by-LRT interaction).

\strong{Chapter 8 (Model Diagnostics):} Residual analysis, outlier
detection, and influence diagnostics.

The variable \code{pred} contains pre-computed predicted values from
a regression model, included for pedagogical reference. For standard
regression analyses, the key variables are gcse, lrt, school, and gender.
}
\examples{
data(gcse)
head(gcse)

# Simple linear regression: GCSE on LRT
lm(gcse ~ lrt, data = gcse)

# ANCOVA: school differences controlling for LRT
gcse_sub <- gcse[gcse$school \%in\% c(1, 2), ]
lm(gcse ~ lrt + factor(school), data = gcse_sub)

# Interaction: does LRT slope differ by gender?
lm(gcse ~ lrt * gender, data = gcse)
}
\keyword{datasets}
