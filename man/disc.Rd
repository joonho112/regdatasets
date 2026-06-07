% Please edit documentation in R/data.R
\docType{data}
\name{disc}
\alias{disc}
\title{NELS:88 Discipline and School Experiences Study}
\format{
A tibble with 2,000 rows and 15 columns:
\describe{
\item{bys55a}{Frequency of being sent to the office. Type: numeric.
Values: 0, 1, 2, 8. Where 0 = never, 1 = once or twice, 2 = more
than twice, 8 = missing/not applicable. Mean = 0.47.}
\item{bys12}{Family composition. Type: numeric. Values: 1, 2, 8.
Where 1 = two-parent family, 2 = other family structure,
8 = missing/not applicable.}
\item{bys31a}{Hours spent on homework per week. Type: numeric.
Range: (1, 8). Ordinal scale where higher values indicate more
homework hours, 8 = missing/not applicable.}
\item{bys34a}{Self-concept: English ability. Type: numeric.
Range: (1, 98). Ordinal self-rating, 98 = missing/not applicable.}
\item{bys34b}{Self-concept: math ability. Type: numeric.
Range: (1, 98). Ordinal self-rating, 98 = missing/not applicable.}
\item{bys35p}{Plans after high school. Type: numeric. Values: 1, 2,
3, 8. Where 1 = attend college, 8 = missing/not applicable.}
\item{bys36c}{Importance of good grades. Type: numeric.
Range: (1, 8). Ordinal scale, 8 = missing/not applicable.}
\item{sentoff}{Ever sent to the office for misbehavior. Type: numeric.
Binary indicator (0/1) where 1 = sent to the office at least once,
0 = never sent. NA = 28. This is the primary outcome variable for
logistic regression.}
\item{male}{Sex of student. Type: numeric. Binary indicator (0/1)
where 1 = male, 0 = female. NA = 20.}
\item{race}{Race/ethnicity. Type: numeric. Values: 1, 2, 3, 4.
Where 1 = Asian, 2 = Hispanic, 3 = Black, 4 = White. NA = 92.}
\item{fath_ed}{Father has at least a high school education. Type:
numeric. Binary indicator (0/1) where 1 = high school or above,
0 = less than high school. NA = 282.}
\item{moth_ed}{Mother has at least a high school education. Type:
numeric. Binary indicator (0/1) where 1 = high school or above,
0 = less than high school. NA = 208.}
\item{bedroom}{Has own bedroom. Type: numeric. Binary indicator (0/1)
where 1 = has own bedroom, 0 = does not. NA = 33.}
\item{discuss}{Frequently discusses school with parents. Type: numeric.
Binary indicator (0/1) where 1 = frequently discusses, 0 = does not.
NA = 33.}
\item{osentoff}{Ordinal version of sent to office. Type: numeric.
Values: 0, 1, 2. Where 0 = never, 1 = once or twice, 2 = more than
twice. NA = 28. Used for ordinal regression models.}
}
}
\source{
National Center for Education Statistics (1988). \emph{National
Education Longitudinal Study of 1988 (NELS:88)}. U.S. Department of
Education. Public-use data file. Original data file: \code{disc.dta}
}
\usage{
disc
}
\description{
A subset of 2,000 students from the National Education Longitudinal Study
of 1988 (NELS:88), focused on school discipline outcomes and their
predictors. The dataset includes student demographics, family background
variables, and school experience indicators related to disciplinary
actions. Variables use original NELS:88 variable naming conventions
(e.g., bys55a, bys12). This dataset is used for teaching logistic
regression with binary outcomes and handling missing data.
}
\details{
This dataset is used in Chapters 9-13 (Logistic Regression, Multiple
Logistic Regression, Model Fit, and Ordinal Response Models) to illustrate
binary and ordinal logistic regression. Key analyses include: fitting
simple and multiple logistic regression models predicting office referrals,
computing and interpreting odds ratios, likelihood ratio tests, and
ordinal regression using \code{osentoff} as the outcome.

Note that original NELS:88 sentinel missing codes (8, 98) in variables
\code{bys34a} and \code{bys34b} have been recoded to \code{NA} as of
v0.2.0. The \code{race} variable has been converted from integer codes
(1--4) to an unordered factor with levels: Asian, Hispanic, Black, White.
}
\section{Ethical context}{

These data involve race as a predictor of school disciplinary outcomes.
Racial disparities in school discipline are a well-documented phenomenon
in educational research, often discussed in the context of the
"school-to-prison pipeline." The race variable categories and coding
reflect the NELS:88 survey instrument from 1988 and should not be taken
as exhaustive or current representations of racial/ethnic identity.
Instructors are encouraged to situate analyses within the broader
literature on structural inequities in school discipline practices.
}

\examples{
data(disc)
head(disc)

# Logistic regression: gender effect on office referral
glm(sentoff ~ male, data = disc, family = binomial)

# Multiple logistic regression with demographics
glm(sentoff ~ male + race + fath_ed, data = disc, family = binomial)

}
\seealso{
\code{\link{disc2}} for the same 2,000 students with SES
composite and standardized test scores as continuous predictors.
}
\keyword{datasets}
