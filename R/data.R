# =============================================================================
# Roxygen2 documentation for regdatasets: Batch A (13 datasets)
# alcohol1_pp, berk_sub, berkeley, civic_ed, classdata_07, crime,
# disc, disc2, faculty, gcse, grades, gss_1, hsb_sub
# =============================================================================


# -----------------------------------------------------------------------------
# 1. alcohol1_pp
# -----------------------------------------------------------------------------

#' Adolescent Alcohol Use Person-Period Data
#'
#' Longitudinal person-period data from a study of adolescent alcohol use,
#' tracking 82 adolescents from age 14 to age 16. Each row represents one
#' person at one time point, resulting in 246 observations (82 persons x 3
#' occasions). The data include measures of alcohol consumption, peer alcohol
#' use, and whether the adolescent is a child of an alcoholic (COA). This
#' dataset is commonly used in multilevel/growth curve modeling textbooks to
#' illustrate individual growth trajectories and the effects of time-varying
#' and time-invariant predictors.
#'
#' @format A tibble with 246 rows and 9 columns:
#' \describe{
#'   \item{id}{Person identifier. Type: numeric. Range: (1, 82).
#'     Uniquely identifies each of the 82 adolescents.}
#'   \item{age}{Age in years at the time of measurement. Type: numeric.
#'     Values: 14, 15, 16. Three measurement occasions.}
#'   \item{coa}{Child of an alcoholic. Type: numeric. Binary indicator
#'     (0/1) where 1 = child of an alcoholic parent, 0 = not a child
#'     of an alcoholic. Time-invariant predictor.}
#'   \item{male}{Sex of adolescent. Type: numeric. Binary indicator
#'     (0/1) where 1 = male, 0 = female. Time-invariant predictor.}
#'   \item{age_14}{Age centered at 14 (i.e., age minus 14). Type: numeric.
#'     Values: 0, 1, 2. Used as the time variable in growth models so that
#'     the intercept represents alcohol use at age 14.}
#'   \item{alcuse}{Alcohol use composite score. Type: numeric.
#'     Range: (0.00, 3.61). Higher values indicate greater alcohol
#'     consumption. This is the primary outcome variable.}
#'   \item{peer}{Peer alcohol use score. Type: numeric.
#'     Range: (0.00, 2.53). Mean = 1.02. Higher values indicate greater
#'     peer alcohol use. Time-varying covariate.}
#'   \item{cpeer}{Peer alcohol use, grand-mean centered. Type: numeric.
#'     Range: (-1.02, 1.51). Mean approximately 0. This is the peer
#'     variable centered by subtracting the grand mean (1.02) to aid
#'     interpretation of the intercept in regression models.}
#'   \item{ccoa}{Child of alcoholic, grand-mean centered. Type: numeric.
#'     Values: -0.45, 0.55. Mean approximately 0. This is the COA variable
#'     centered by subtracting the grand mean (0.45) so that the intercept
#'     represents the expected outcome for an average person on this
#'     predictor rather than for a non-COA.}
#' }
#'
#' @details
#' This dataset is used in Chapters on interactions and multilevel modeling to
#' illustrate growth curve models and person-period data structures. Key
#' analyses include: fitting individual growth curves of alcohol use over time,
#' examining the effects of COA status and peer influence on alcohol use
#' trajectories, and demonstrating grand-mean centering of predictors.
#'
#' The centered variables (cpeer, ccoa) illustrate the common practice of
#' centering predictors to improve interpretability of the intercept in
#' multilevel and longitudinal models. Grand-mean centering shifts the
#' meaning of the intercept from the value when all predictors are zero to
#' the value at the sample average of the predictor.
#'
#' @source Singer, J. D., & Willett, J. B. (2003). *Applied Longitudinal
#'   Data Analysis: Modeling Change and Event Occurrence*. Oxford University
#'   Press. Original data file: `alcohol1_pp.dta`
#'
#' @examples
#' data(alcohol1_pp)
#' head(alcohol1_pp)
#'
#' # Growth model: alcohol use as a function of time and COA status
#' lm(alcuse ~ age_14 + ccoa, data = alcohol1_pp)
#'
#' # Interaction between time and centered peer alcohol use
#' lm(alcuse ~ age_14 * cpeer, data = alcohol1_pp)
"alcohol1_pp"


# -----------------------------------------------------------------------------
# 2. berk_sub
# -----------------------------------------------------------------------------

#' UC Berkeley Graduate Admissions Subset (Engineering and Psychology)
#'
#' A subset of UC Berkeley's 1973 graduate admissions data, restricted to
#' two departments (Engineering and Psychology) with 1,169 applicants. This
#' streamlined version of the Berkeley data is used to illustrate Simpson's
#' paradox and confounding in multiple logistic regression, where the apparent
#' association between gender and admission reverses after controlling for
#' department.
#'
#' @format A tibble with 1,169 rows and 3 columns:
#' \describe{
#'   \item{admitted}{Admission decision. Type: numeric. Binary indicator
#'     (0/1) where 1 = admitted, 0 = not admitted. This is the primary
#'     outcome variable. Overall admission rate is 44%.}
#'   \item{male}{Sex of applicant. Type: numeric. Binary indicator
#'     (0/1) where 1 = male, 0 = female. Approximately 64% of applicants
#'     are male.}
#'   \item{engineering}{Department applied to. Type: numeric. Binary
#'     indicator (0/1) where 1 = Engineering, 0 = Psychology. The two
#'     departments differ substantially in both gender composition and
#'     admission rates.}
#' }
#'
#' @details
#' This dataset is used in Chapter 10 (Multiple Logistic Regression) to
#' illustrate confounding and omitted variable bias in logistic regression.
#' Key analyses include: computing unadjusted odds ratios for admission by
#' gender, fitting a multiple logistic regression controlling for department,
#' and demonstrating how the apparent gender effect (unadjusted OR = 3.25)
#' largely disappears after adjusting for department (adjusted OR approximately
#' 1.1).
#'
#' The Engineering department has a much higher proportion of male applicants
#' (approximately 96%) compared to Psychology (approximately 33%), and also
#' has a higher overall admission rate (approximately 63%) than Psychology
#' (approximately 25%). This creates the conditions for Simpson's paradox:
#' the omitted variable (department) is both correlated with the predictor
#' (gender) and a predictor of the outcome (admission).
#'
#' @source Bickel, P. J., Hammel, E. A., & O'Connell, J. W. (1975). Sex
#'   bias in graduate admissions: Data from Berkeley. *Science*, 187(4175),
#'   398-404. Original data file: `berk_sub.dta`
#'
#' @examples
#' data(berk_sub)
#' head(berk_sub)
#'
#' # Unadjusted logistic regression: gender effect on admission
#' glm(admitted ~ male, data = berk_sub, family = binomial)
#'
#' # Adjusted logistic regression: controlling for department
#' glm(admitted ~ male + engineering, data = berk_sub, family = binomial)
#'
#' @seealso \code{\link{berkeley}} for the full five-department version of the
#'   Berkeley admissions data. Note that \code{berk_sub} uses \code{male}
#'   (1 = male) while \code{berkeley} uses \code{female} (1 = female).
"berk_sub"


# -----------------------------------------------------------------------------
# 3. berkeley
# -----------------------------------------------------------------------------

#' UC Berkeley Graduate Admissions Data (Five Departments)
#'
#' Data from UC Berkeley's 1973 graduate admissions across five departments,
#' with 3,593 individual applicant records. This is the classic dataset used
#' to demonstrate Simpson's paradox in the context of logistic regression:
#' the overall association between gender and admission appears to show bias
#' against women, but this effect reverses or disappears when controlling
#' for department. The department identifiers are anonymized.
#'
#' @format A tibble with 3,593 rows and 3 columns:
#' \describe{
#'   \item{department}{Department identifier. Type: numeric.
#'     Values: 1, 2, 3, 4, 5. Five anonymized departments that differ in
#'     their admission rates and gender composition of applicants.
#'     (Renamed from \code{departme} in v0.2.0.)}
#'   \item{female}{Sex of applicant. Type: numeric. Binary indicator
#'     (0/1) where 1 = female, 0 = male. Approximately 48% of applicants
#'     are female.}
#'   \item{admitted}{Admission decision. Type: numeric. Binary indicator
#'     (0/1) where 1 = admitted, 0 = not admitted. Overall admission rate
#'     is 32%.}
#' }
#'
#' @details
#' This dataset is used in Chapters 10-11 (Multiple Logistic Regression and
#' Model Fit/Diagnostics) to illustrate confounding in logistic regression
#' and Simpson's paradox. Key analyses include: computing odds ratios for
#' admission by gender within and across departments, fitting multiple
#' logistic regression models with department as a control variable,
#' performing likelihood ratio tests, and chi-squared goodness-of-fit tests.
#'
#' Note that this dataset uses \code{female} as the gender indicator (1 =
#' female), whereas \code{berk_sub} uses \code{male} (1 = male). The
#' department variable is coded numerically (1-5) rather than by department
#' name.
#'
#' @source Bickel, P. J., Hammel, E. A., & O'Connell, J. W. (1975). Sex
#'   bias in graduate admissions: Data from Berkeley. *Science*, 187(4175),
#'   398-404. Original data file: `berkeley.dta`
#'
#' @examples
#' data(berkeley)
#' head(berkeley)
#'
#' # Unadjusted model: gender only
#' glm(admitted ~ female, data = berkeley, family = binomial)
#'
#' # Adjusted model: controlling for department
#' glm(admitted ~ female + factor(department), data = berkeley, family = binomial)
#'
#' @seealso \code{\link{berk_sub}} for a two-department subset used to
#'   introduce Simpson's paradox. Also compare with base R's
#'   \code{\link[datasets]{UCBAdmissions}}, which provides the same data
#'   in aggregate contingency table form.
"berkeley"


# -----------------------------------------------------------------------------
# 4. civic_ed
# -----------------------------------------------------------------------------

#' Civic Education Study: Pre-Post Survey Data
#'
#' Pre-test and post-test survey data from a civic education study involving
#' 794 students across 16 schools. The study measured a wide range of civic
#' attitudes, knowledge, behaviors, and participation before and after a civic
#' education intervention. With 237 variables covering survey items (Likert
#' scales, binary, and open-ended), composite scale scores, and demographic
#' information, this dataset supports analyses of treatment effects,
#' regression to the mean, and scale construction.
#'
#' @format A tibble with 794 rows and 237 columns. Variables are organized
#' into the following groups:
#'
#' \strong{Identifiers and treatment indicators:}
#' \describe{
#'   \item{id_match}{Unique student identifier for matching pre and post
#'     records. Type: numeric. Range: (201180001, 351190031).}
#'   \item{school}{School identifier. Type: character. 16 unique schools
#'     coded as: 20, 21, 22, 23, 25, 26, 27, 29, and others.}
#'   \item{wtp}{We the People program participation. Type: numeric. Binary
#'     indicator (0/1) where 1 = participated in the civic education program,
#'     0 = comparison group. 63% participated.}
#'   \item{ap}{AP (Advanced Placement) class indicator. Type: numeric.
#'     Binary indicator (0/1) where 1 = AP class, 0 = non-AP class.}
#' }
#'
#' \strong{Pre-test survey items (t_q1 through t_q99):}
#' Variables prefixed with \code{t_} represent pre-test (Time 1) survey
#' responses. These include:
#' \describe{
#'   \item{t_q1 to t_q23}{Civic knowledge and attitude items. Type: numeric.
#'     Mostly 4-point Likert scales (1-4). Some items have 3-point scales
#'     (1-3). Small amounts of missing data (NA = 0 to 8).}
#'   \item{t_numorg}{Number of organizations participated in (pre-test).
#'     Type: numeric. Range: (0, 5).}
#'   \item{t_orgs_y}{Any organization membership (pre-test). Type: numeric.
#'     Binary (0/1) where 1 = member of at least one organization.}
#'   \item{t_q24}{Political interest item. Type: numeric. 6-point scale
#'     (1-6).}
#'   \item{t_q25 to t_q28}{Political activity items (pre-test). Type:
#'     numeric. Binary (0/1).}
#'   \item{t_numldr}{Number of leadership roles (pre-test). Type: numeric.
#'     Range: (0, 4).}
#'   \item{t_q29 to t_q35}{Civic activity items (pre-test). Type: numeric.
#'     Binary (0/1) with some missing values.}
#'   \item{t_numact}{Number of civic activities (pre-test). Type: numeric.
#'     Range: (0, 7).}
#'   \item{t_q36 to t_q47}{Civic attitude items. Type: numeric. 4-point
#'     Likert scales (1-4).}
#'   \item{t_q48, t_q49, t_q50}{Knowledge test items. Type: character.
#'     Multiple choice responses (A, B, C, D, E, F) with -1 indicating
#'     missing or no response.}
#'   \item{t_q51 to t_q52}{Attitude items. Type: numeric. 4-point scales
#'     (1-4).}
#'   \item{t_q53 to t_q64}{Political feeling thermometer items. Type:
#'     numeric. 7-point scales (1-7). Higher values indicate warmer feelings.}
#'   \item{t_q65 to t_q78}{Civic engagement and obligation items. Type:
#'     numeric. 4-point Likert scales (1-4).}
#'   \item{t_q79 to t_q84}{Additional feeling thermometer items. Type:
#'     numeric. 7-point scales (1-7).}
#'   \item{t_q85 to t_q89}{Tolerance and ambiguity items. Type: numeric.
#'     4- or 5-point scales.}
#'   \item{t_q92_a to t_q92_f}{Race/ethnicity indicators (pre-test). Type:
#'     numeric. Binary (0/1). Multiple categories (e.g., a = Asian, b = Black,
#'     c = Hispanic, etc.).}
#'   \item{t_q90, t_q91}{Media exposure items. Type: numeric. 6-point
#'     scales (0-5).}
#'   \item{t_q93}{Political discussion at home. Type: numeric. Binary (0/1)
#'     where 1 = discusses politics at home.}
#'   \item{t_q94}{Religious attendance. Type: numeric. Range: (0, 3).}
#'   \item{t_q95}{Self-reported grades. Type: numeric. Range: (1, 8).}
#'   \item{t_q96_a to t_q96_k}{Subject enrollment indicators. Type: numeric.
#'     Binary (0/1) for various courses taken.}
#'   \item{t_q97 to t_q99}{Additional survey items. Type: numeric. 4- or
#'     5-point scales.}
#' }
#'
#' \strong{Post-test survey items (r_q1 through r_q84):}
#' Variables prefixed with \code{r_} represent post-test (Time 2) survey
#' responses. These mirror the pre-test items with the same numbering
#' (e.g., \code{r_q1} corresponds to \code{t_q1}). Scales and coding are
#' identical to the pre-test versions.
#'
#' \strong{Demographic and background variables:}
#' \describe{
#'   \item{par_coll}{Parent has college education. Type: numeric. Binary
#'     (0/1) where 1 = at least one parent attended college. NA = 40.}
#'   \item{hi_math}{Highest math course taken. Type: numeric. Range: (0, 5).
#'     Higher values indicate more advanced math courses.}
#' }
#'
#' \strong{Composite scale scores (standardized, mean approximately 0):}
#' Variables ending in \code{_m} are IRT-based or factor-analytic composite
#' scores. Suffixes \code{_t} and \code{_r} indicate pre-test and post-test
#' respectively.
#' \describe{
#'   \item{attn_pre, attn_pos}{Attention to politics (pre and post). Type:
#'     numeric. Standardized scores approximately (-1.5, 1.8).}
#'   \item{inf_pre, inf_post}{Political information/knowledge (pre and
#'     post). Type: numeric. Standardized scores.}
#'   \item{ldr_t_m, ldr_r_m}{Leadership composite (pre and post). Type:
#'     numeric. Standardized.}
#'   \item{govm_t_m, govm_r_m}{Government knowledge (pre and post). Type:
#'     numeric. Standardized.}
#'   \item{posg_t_m, posg_r_m}{Positive government attitudes (pre and
#'     post). Type: numeric. Standardized.}
#'   \item{eff_t_m, eff_r_m}{Political efficacy (pre and post). Type:
#'     numeric. Standardized.}
#'   \item{res_t_m, res_r_m}{Political responsibility (pre and post). Type:
#'     numeric. Standardized.}
#'   \item{obl_t_m, obl_r_m}{Civic obligation (pre and post). Type:
#'     numeric. Standardized.}
#'   \item{tol_t_m, tol_r_m}{Political tolerance (pre and post). Type:
#'     numeric. Standardized.}
#'   \item{amb_t_m, amb_r_m}{Ambiguity tolerance (pre and post). Type:
#'     numeric. Standardized.}
#'   \item{comm_t_m, comm_r_m}{Community engagement (pre and post). Type:
#'     numeric. Standardized.}
#'   \item{all_t_m, all_r_m}{Overall civic competence composite (pre and
#'     post). Type: numeric. Standardized. No missing values.}
#'   \item{liked_cl}{Liked civic learning environment. Type: numeric.
#'     Standardized. Mean approximately 0.}
#' }
#'
#' @details
#' This dataset is used in Chapter 1 (Simple Linear Regression) to illustrate
#' regression to the mean with the civic education example: regressing post-test
#' attention to politics on pre-test attention yields a slope less than 1,
#' showing that students below average before the course tend to improve and
#' those above average tend to decline. The dataset also supports analyses
#' in later chapters including ANCOVA (comparing treatment and control groups
#' while controlling for pre-test scores), multiple regression with many
#' predictors, and model building.
#'
#' Key analyses include: simple regression of post-test on pre-test scores
#' to demonstrate regression to the mean, ANCOVA comparing WTP program
#' participants with comparison students, and exploring relationships among
#' multiple civic attitude dimensions.
#'
#' @source Tolo, K. W. (1999). *The Civic Education of American Youth: From
#'   State Policies to School District Practices*. Policy Research Project
#'   Report, Lyndon B. Johnson School of Public Affairs, The University of
#'   Texas at Austin. Original data file: `civic_ed.dta`
#'
#' @examples
#' data(civic_ed)
#'
#' # Regression to the mean: post-test on pre-test attention to politics
#' lm(attn_pos ~ attn_pre, data = civic_ed)
#'
#' # ANCOVA: treatment effect controlling for pre-test
#' lm(attn_pos ~ attn_pre + wtp, data = civic_ed)
"civic_ed"


# -----------------------------------------------------------------------------
# 5. classdata_07
# -----------------------------------------------------------------------------

#' Class Survey Data (2007)
#'
#' Survey data collected from 44 students enrolled in a statistics course in
#' 2007. The dataset contains self-reported information about study habits,
#' work hours, physical characteristics, and lifestyle behaviors. This small
#' classroom dataset is useful for introductory data exploration, simple
#' regression, and discussions about data quality issues (e.g., negative
#' values for alcohol consumption, missing data).
#'
#' @format A tibble with 44 rows and 12 columns:
#' \describe{
#'   \item{actual_study}{Actual hours spent studying per week. Type: numeric.
#'     Range: (0, 70). Mean = 21.5.}
#'   \item{desired_study}{Desired hours of study per week. Type: numeric.
#'     Range: (0, 100). Mean = 21.5. NA = 1.}
#'   \item{actual_work}{Actual hours spent working per week. Type: numeric.
#'     Range: (0, 72). Mean = 17.7.}
#'   \item{desired_work}{Desired hours of work per week. Type: numeric.
#'     Range: (0, 50). Mean = 12.8.}
#'   \item{gender}{Gender of student. Type: numeric. Binary indicator
#'     (0/1) where 1 = male, 0 = female. 27% male.}
#'   \item{height}{Height in inches. Type: numeric. Range: (60, 75).
#'     Mean = 66.6 inches.}
#'   \item{desired_weight}{Desired weight in pounds. Type: numeric.
#'     Range: (99, 200). Mean = 136.6.}
#'   \item{exer}{Hours of exercise per week. Type: numeric.
#'     Range: (0, 25). Mean = 4.7. NA = 1.}
#'   \item{sleep}{Hours of sleep per night. Type: numeric.
#'     Range: (6, 9). Mean = 7.0.}
#'   \item{alcohol}{Alcoholic drinks consumed per week. Type: numeric.
#'     Range: (-1, 10). Mean = 3.4. Note: Contains a negative value (-1)
#'     which may represent a data entry error, useful for teaching data
#'     cleaning.}
#'   \item{overage}{Whether the student is over the age threshold. Type:
#'     character. All values are "no" in this cohort.}
#'   \item{age}{Age category. Type: numeric. Values: 0, 1, 2. Coded as
#'     age group categories rather than exact age.}
#' }
#'
#' @details
#' This dataset is used for introductory regression exercises and data
#' exploration. Key analyses include: simple regression of actual study
#' hours on desired study hours, exploring the relationship between height
#' and desired weight, and identifying data quality issues such as the
#' anomalous negative value for alcohol consumption. The small sample size
#' (n = 44) makes it appropriate for classroom demonstrations.
#'
#' @source Class survey data collected by the instructor in 2007.
#'   Original data file: `classdata_07.dta`
#'
#' @examples
#' data(classdata_07)
#' head(classdata_07)
#'
#' # Simple regression: actual vs. desired study hours
#' lm(actual_study ~ desired_study, data = classdata_07)
#'
#' # Relationship between height and desired weight
#' lm(desired_weight ~ height + gender, data = classdata_07)
"classdata_07"


# -----------------------------------------------------------------------------
# 6. crime
# -----------------------------------------------------------------------------

#' Florida County Crime Rates
#'
#' Crime rate data for 67 Florida counties, including measures of crime
#' prevalence, education levels, high school completion rates, and
#' urbanization. This dataset is a central example in the course for
#' demonstrating multiple regression with two continuous predictors,
#' confounding/omitted variable bias, partial correlations, and interaction
#' effects between continuous variables.
#'
#' @format A tibble with 67 rows and 5 columns:
#' \describe{
#'   \item{county}{County name. Type: character. 67 unique Florida counties
#'     (e.g., ALACHUA, BAKER, BAY, BRADFORD, BREVARD, BROWARD).}
#'   \item{c}{Crime rate: number of crimes per year per 1,000 population.
#'     Type: numeric. Range: (0, 128). Mean = 52.4. This is the primary
#'     outcome variable.}
#'   \item{i}{Median household income in thousands of dollars. Type: numeric.
#'     Range: (15.4, 35.6). Mean = 24.5.}
#'   \item{hs}{Education: percentage of adults with at least a high school
#'     education. Type: numeric. Range: (54.5, 84.9). Mean = 69.5.}
#'   \item{u}{Urbanization: percentage of the population living in an urban
#'     environment. Type: numeric. Range: (0.0, 99.6). Mean = 49.6.}
#' }
#'
#' @details
#' This dataset is used in Chapter 4 (Continuous Predictors) and Chapter 5
#' (Interactions) to illustrate several key regression concepts. Key analyses
#' include:
#'
#' \strong{Confounding:} Education has a positive bivariate association
#' with crime rate (slope = 1.5), but after controlling for urbanization,
#' the effect reverses to negative (slope = -0.6). This demonstrates
#' omitted variable bias: urbanization is correlated with both education
#' and crime.
#'
#' \strong{Partial correlations:} The partial correlation between crime
#' rate and education controlling for urbanization is -0.15, compared to
#' the Pearson correlation of 0.47.
#'
#' \strong{Interaction:} The interaction model
#' \eqn{y = \alpha + \beta_1 x_1 + \beta_2 x_2 + \beta_3 x_1 x_2}
#' shows that the effect of education on crime depends on the level of
#' urbanization.
#'
#' @source Data on Florida county crime rates. Original data file:
#'   `crime.dta`
#'
#' @examples
#' data(crime)
#' head(crime)
#'
#' # Simple regression: education appears to increase crime
#' lm(c ~ hs, data = crime)
#'
#' # Multiple regression: controlling for urbanization reverses the effect
#' lm(c ~ hs + u, data = crime)
#'
#' # Interaction between education and urbanization
#' lm(c ~ hs * u, data = crime)
"crime"


# -----------------------------------------------------------------------------
# 7. disc
# -----------------------------------------------------------------------------

#' NELS:88 Discipline and School Experiences Study
#'
#' A subset of 2,000 students from the National Education Longitudinal Study
#' of 1988 (NELS:88), focused on school discipline outcomes and their
#' predictors. The dataset includes student demographics, family background
#' variables, and school experience indicators related to disciplinary
#' actions. Variables use original NELS:88 variable naming conventions
#' (e.g., bys55a, bys12). This dataset is used for teaching logistic
#' regression with binary outcomes and handling missing data.
#'
#' @format A tibble with 2,000 rows and 15 columns:
#' \describe{
#'   \item{bys55a}{Frequency of being sent to the office. Type: numeric.
#'     Values: 0, 1, 2, 8. Where 0 = never, 1 = once or twice, 2 = more
#'     than twice, 8 = missing/not applicable. Mean = 0.47.}
#'   \item{bys12}{Family composition. Type: numeric. Values: 1, 2, 8.
#'     Where 1 = two-parent family, 2 = other family structure,
#'     8 = missing/not applicable.}
#'   \item{bys31a}{Hours spent on homework per week. Type: numeric.
#'     Range: (1, 8). Ordinal scale where higher values indicate more
#'     homework hours, 8 = missing/not applicable.}
#'   \item{bys34a}{Self-concept: English ability. Type: numeric.
#'     Range: (1, 98). Ordinal self-rating, 98 = missing/not applicable.}
#'   \item{bys34b}{Self-concept: math ability. Type: numeric.
#'     Range: (1, 98). Ordinal self-rating, 98 = missing/not applicable.}
#'   \item{bys35p}{Plans after high school. Type: numeric. Values: 1, 2,
#'     3, 8. Where 1 = attend college, 8 = missing/not applicable.}
#'   \item{bys36c}{Importance of good grades. Type: numeric.
#'     Range: (1, 8). Ordinal scale, 8 = missing/not applicable.}
#'   \item{sentoff}{Ever sent to the office for misbehavior. Type: numeric.
#'     Binary indicator (0/1) where 1 = sent to the office at least once,
#'     0 = never sent. NA = 28. This is the primary outcome variable for
#'     logistic regression.}
#'   \item{male}{Sex of student. Type: numeric. Binary indicator (0/1)
#'     where 1 = male, 0 = female. NA = 20.}
#'   \item{race}{Race/ethnicity. Type: numeric. Values: 1, 2, 3, 4.
#'     Where 1 = Asian, 2 = Hispanic, 3 = Black, 4 = White. NA = 92.}
#'   \item{fath_ed}{Father has at least a high school education. Type:
#'     numeric. Binary indicator (0/1) where 1 = high school or above,
#'     0 = less than high school. NA = 282.}
#'   \item{moth_ed}{Mother has at least a high school education. Type:
#'     numeric. Binary indicator (0/1) where 1 = high school or above,
#'     0 = less than high school. NA = 208.}
#'   \item{bedroom}{Has own bedroom. Type: numeric. Binary indicator (0/1)
#'     where 1 = has own bedroom, 0 = does not. NA = 33.}
#'   \item{discuss}{Frequently discusses school with parents. Type: numeric.
#'     Binary indicator (0/1) where 1 = frequently discusses, 0 = does not.
#'     NA = 33.}
#'   \item{osentoff}{Ordinal version of sent to office. Type: numeric.
#'     Values: 0, 1, 2. Where 0 = never, 1 = once or twice, 2 = more than
#'     twice. NA = 28. Used for ordinal regression models.}
#' }
#'
#' @details
#' This dataset is used in Chapters 9-13 (Logistic Regression, Multiple
#' Logistic Regression, Model Fit, and Ordinal Response Models) to illustrate
#' binary and ordinal logistic regression. Key analyses include: fitting
#' simple and multiple logistic regression models predicting office referrals,
#' computing and interpreting odds ratios, likelihood ratio tests, and
#' ordinal regression using \code{osentoff} as the outcome.
#'
#' Note that original NELS:88 sentinel missing codes (8, 98) in variables
#' \code{bys34a} and \code{bys34b} have been recoded to \code{NA} as of
#' v0.2.0. The \code{race} variable has been converted from integer codes
#' (1--4) to an unordered factor with levels: Asian, Hispanic, Black, White.
#'
#' @section Ethical context:
#' These data involve race as a predictor of school disciplinary outcomes.
#' Racial disparities in school discipline are a well-documented phenomenon
#' in educational research, often discussed in the context of the
#' "school-to-prison pipeline." The race variable categories and coding
#' reflect the NELS:88 survey instrument from 1988 and should not be taken
#' as exhaustive or current representations of racial/ethnic identity.
#' Instructors are encouraged to situate analyses within the broader
#' literature on structural inequities in school discipline practices.
#'
#' @source National Center for Education Statistics (1988). *National
#'   Education Longitudinal Study of 1988 (NELS:88)*. U.S. Department of
#'   Education. Public-use data file. Original data file: `disc.dta`
#'
#' @examples
#' data(disc)
#' head(disc)
#'
#' # Logistic regression: gender effect on office referral
#' glm(sentoff ~ male, data = disc, family = binomial)
#'
#' # Multiple logistic regression with demographics
#' glm(sentoff ~ male + race + fath_ed, data = disc, family = binomial)
#'
#' @seealso \code{\link{disc2}} for the same 2,000 students with SES
#'   composite and standardized test scores as continuous predictors.
"disc"


# -----------------------------------------------------------------------------
# 8. disc2
# -----------------------------------------------------------------------------

#' NELS:88 Discipline Study with Achievement Scores
#'
#' An extended version of the NELS:88 discipline dataset (\code{disc}) with
#' 2,000 students, including standardized test scores in reading and math,
#' a composite SES (socioeconomic status) measure, and additional derived
#' variables. This version uses more intuitive variable names and includes
#' both base-year and follow-up reading scores, making it suitable for
#' analyses involving academic achievement as both a predictor and outcome.
#'
#' @format A tibble with 2,000 rows and 15 columns:
#' \describe{
#'   \item{male}{Sex of student. Type: numeric. Binary indicator (0/1)
#'     where 1 = male, 0 = female. NA = 20.}
#'   \item{notengl}{Non-English home language. Type: numeric. Binary
#'     indicator (0/1) where 1 = primary home language is not English,
#'     0 = English is primary. NA = 23.}
#'   \item{bedroom}{Has own bedroom. Type: numeric. Binary indicator (0/1)
#'     where 1 = has own bedroom, 0 = does not. NA = 33.}
#'   \item{osentoff}{Ordinal version of office referral. Type: numeric.
#'     Values: 0, 1, 2. Where 0 = never, 1 = once or twice, 2 = more than
#'     twice. NA = 28.}
#'   \item{ses}{Composite socioeconomic status score. Type: numeric.
#'     Range: (-2.89, 1.85). Mean = -0.06. Standardized composite of
#'     family income, parental education, and parental occupation.
#'     NA = 1.}
#'   \item{reading1}{Base-year (8th grade) standardized reading score.
#'     Type: numeric. Range: (31.95, 70.55). Mean = 50.95. Standardized
#'     with mean approximately 50 and SD approximately 10. NA = 77.}
#'   \item{math1}{Base-year (8th grade) standardized math score. Type:
#'     numeric. Range: (34.10, 77.20). Mean = 51.49. Standardized with
#'     mean approximately 50 and SD approximately 10. NA = 75.}
#'   \item{reading2}{Follow-up (10th grade) standardized reading score.
#'     Type: numeric. Range: (30.82, 68.91). Mean = 51.24. NA = 218.}
#'   \item{fath_coll}{Father has college education. Type: numeric. Binary
#'     indicator (0/1) where 1 = father has a college degree, 0 = no college
#'     degree. NA = 282.}
#'   \item{fath_ed}{Father has at least a high school education. Type:
#'     numeric. Binary indicator (0/1) where 1 = high school or above,
#'     0 = less than high school. NA = 282.}
#'   \item{moth_coll}{Mother has college education. Type: numeric. Binary
#'     indicator (0/1) where 1 = mother has a college degree, 0 = no college
#'     degree. NA = 208.}
#'   \item{moth_ed}{Mother has at least a high school education. Type:
#'     numeric. Binary indicator (0/1) where 1 = high school or above,
#'     0 = less than high school. NA = 208.}
#'   \item{minority}{Minority status. Type: numeric. Binary indicator (0/1)
#'     where 1 = racial/ethnic minority (non-White), 0 = White. NA = 24.}
#'   \item{race}{Race/ethnicity. Type: numeric. Values: 1, 2, 3, 4.
#'     Where 1 = Asian, 2 = Hispanic, 3 = Black, 4 = White. NA = 92.}
#'   \item{sentoff}{Ever sent to the office for misbehavior. Type: numeric.
#'     Binary indicator (0/1) where 1 = yes, 0 = no. NA = 28.}
#' }
#'
#' @details
#' This dataset is used alongside \code{disc} in Chapters 9-13 (Logistic
#' Regression and Ordinal Response Models). Key analyses include: examining
#' the relationship between SES, test scores, and discipline outcomes;
#' building multiple logistic regression models with continuous and
#' categorical predictors; and comparing base-year and follow-up reading
#' scores. The SES composite and standardized test scores provide continuous
#' predictors for logistic regression, complementing the categorical
#' predictors in \code{disc}. The \code{race} variable has been converted
#' to an unordered factor as of v0.2.0.
#'
#' @section Ethical context:
#' See \code{\link{disc}} for context on racial disparities in school
#' discipline and responsible use of race as a predictor variable.
#'
#' @source National Center for Education Statistics (1988). *National
#'   Education Longitudinal Study of 1988 (NELS:88)*. U.S. Department of
#'   Education. Public-use data file. Original data file: `disc2.dta`
#'
#' @examples
#' data(disc2)
#' head(disc2)
#'
#' # Logistic regression: SES effect on office referral
#' glm(sentoff ~ ses, data = disc2, family = binomial)
#'
#' # Multiple logistic regression with achievement and demographics
#' glm(sentoff ~ ses + reading1 + male + minority, data = disc2,
#'     family = binomial)
#'
#' @seealso \code{\link{disc}} for the same 2,000 students with original
#'   NELS:88 variable names and categorical predictors.
"disc2"


# -----------------------------------------------------------------------------
# 9. faculty
# -----------------------------------------------------------------------------

#' Faculty Salary Data
#'
#' Salary and career information for 514 faculty members, including years of
#' experience, academic rank, market conditions, and demographic variables.
#' This dataset is commonly used to examine gender salary disparities while
#' controlling for legitimate predictors of salary such as experience, rank,
#' and market factors. It provides a rich example for multiple regression
#' with a mix of continuous and binary predictors.
#'
#' @format A tibble with 514 rows and 10 columns:
#' \describe{
#'   \item{salary}{Annual salary in dollars. Type: numeric.
#'     Range: (29,000, 96,156). Mean = 50,864. This is the primary
#'     outcome variable.}
#'   \item{exprior}{Years of experience prior to current position. Type:
#'     numeric. Range: (0, 25). Mean = 2.9.}
#'   \item{yearsbg}{Years since earning the bachelor's degree. Type:
#'     numeric. Range: (0, 41). Mean = 12.9.}
#'   \item{yearsrank}{Years at current academic rank. Type: numeric.
#'     Range: (0, 28). Mean = 7.1.}
#'   \item{market}{Market adjustment factor reflecting disciplinary salary
#'     norms. Type: numeric. Range: (0.71, 1.33). Mean = 0.95. Values
#'     above 1.0 indicate fields with above-average market salaries.}
#'   \item{termdeg}{Holds a terminal degree (e.g., Ph.D.). Type: numeric.
#'     Binary indicator (0/1) where 1 = holds terminal degree,
#'     0 = does not. 99% hold a terminal degree.}
#'   \item{admin}{Holds an administrative appointment. Type: numeric.
#'     Binary indicator (0/1) where 1 = has administrative role,
#'     0 = does not. Only 3% have administrative roles.}
#'   \item{yearsdg}{Years since earning the highest degree. Type: numeric.
#'     Range: (0, 41). Mean = 15.3.}
#'   \item{rank}{Academic rank. Type: numeric. Values: 1, 2, 3. Where
#'     1 = Assistant Professor, 2 = Associate Professor, 3 = Full Professor.
#'     Mean = 2.1.}
#'   \item{male}{Sex of faculty member. Type: numeric. Binary indicator
#'     (0/1) where 1 = male, 0 = female. 75% are male.}
#' }
#'
#' @details
#' This dataset is used in Chapters 4-8 (Multiple Regression with Continuous
#' Predictors, Interactions, Nonlinear Relationships, Model Building, and
#' Model Diagnostics). Key analyses include: examining the gender salary gap
#' while controlling for experience, rank, and market factors; exploring
#' nonlinear relationships (e.g., diminishing returns to experience);
#' model building using forward selection and backward elimination; and
#' regression diagnostics including outlier detection and influential
#' observations.
#'
#' Note that the experience variables (exprior, yearsbg, yearsrank, yearsdg)
#' are correlated with each other and with rank, presenting opportunities
#' to discuss collinearity. The log transformation of salary may improve
#' model fit due to the right-skewed salary distribution.
#'
#' @source Faculty salary data from a university compensation study.
#'   Original data file: `faculty.dta`
#'
#' @examples
#' data(faculty)
#' head(faculty)
#'
#' # Gender salary gap, unadjusted
#' lm(salary ~ male, data = faculty)
#'
#' # Adjusted for rank, experience, and market
#' lm(salary ~ male + factor(rank) + yearsdg + market, data = faculty)
#'
#' # Log salary model
#' lm(log(salary) ~ male + factor(rank) + yearsdg + market, data = faculty)
"faculty"


# -----------------------------------------------------------------------------
# 10. gcse
# -----------------------------------------------------------------------------

#' GCSE and London Reading Test Data
#'
#' Student achievement data from 65 London secondary schools, containing
#' GCSE (General Certificate of Secondary Education) exam scores taken at
#' age 16 and London Reading Test (LRT) scores at age 11 for 4,059 students.
#' Both scores have been standardized to have mean 0 and standard deviation
#' approximately 10. This is the primary running example throughout the
#' course, used from simple linear regression through interactions and
#' model diagnostics.
#'
#' @format A tibble with 4,059 rows and 6 columns:
#' \describe{
#'   \item{school}{School identifier. Type: numeric. Values: 1 to 65.
#'     65 unique London secondary schools.}
#'   \item{student}{Student identifier within school. Type: numeric.
#'     Range: (1, 913). Not unique across schools.}
#'   \item{gcse}{GCSE examination score at age 16, standardized. Type:
#'     numeric. Range: (-36.66, 36.66). Mean approximately 0, SD
#'     approximately 10. This is the primary outcome variable.}
#'   \item{lrt}{London Reading Test score at age 11, standardized. Type:
#'     numeric. Range: (-29.35, 30.16). Mean approximately 0, SD
#'     approximately 10. This is the primary predictor for intake
#'     achievement.}
#'   \item{gender}{Gender of student. Type: numeric. Binary indicator
#'     (0/1) where 1 = female, 0 = male. 60% female.}
#'   \item{pred}{Predicted GCSE score from the regression model. Type:
#'     numeric. Range: (-1.91, 2.54). Pre-computed predicted values.}
#' }
#'
#' Note: Columns \code{u0}, \code{u1}, and \code{filter__} (Stata multilevel
#' model artifacts containing -1e30 placeholder values) were removed in v0.2.0.
#'
#' @details
#' This dataset is the primary running example used throughout the course.
#' It appears in virtually every chapter:
#'
#' \strong{Chapter 1 (Simple Linear Regression):} Regressing GCSE on LRT
#' for individual schools (e.g., Battersea, Chelsea) to introduce the
#' regression model, OLS estimation, R-squared, and inference.
#'
#' \strong{Chapter 2 (ANCOVA):} Comparing schools while controlling for
#' LRT intake scores. The unadjusted difference between Chelsea and
#' Battersea is 9.86 points, but the LRT-adjusted difference is 7.51.
#'
#' \strong{Chapter 5 (Interactions):} Testing whether the LRT slope
#' differs across schools (school-by-LRT interaction).
#'
#' \strong{Chapter 8 (Model Diagnostics):} Residual analysis, outlier
#' detection, and influence diagnostics.
#'
#' The variable \code{pred} contains pre-computed predicted values from
#' a regression model, included for pedagogical reference. For standard
#' regression analyses, the key variables are gcse, lrt, school, and gender.
#'
#' @source Goldstein, H., Rasbash, J., Yang, M., et al. (1993). A
#'   multilevel analysis of school examination results. \emph{Oxford Review
#'   of Education}, 19(4), 425--433. Original data file: \code{gcse.dta}
#'
#' @examples
#' data(gcse)
#' head(gcse)
#'
#' # Simple linear regression: GCSE on LRT
#' lm(gcse ~ lrt, data = gcse)
#'
#' # ANCOVA: school differences controlling for LRT
#' gcse_sub <- gcse[gcse$school %in% c(1, 2), ]
#' lm(gcse ~ lrt + factor(school), data = gcse_sub)
#'
#' # Interaction: does LRT slope differ by gender?
#' lm(gcse ~ lrt * gender, data = gcse)
"gcse"


# -----------------------------------------------------------------------------
# 11. grades
# -----------------------------------------------------------------------------

#' Essay Grades and Writing Features
#'
#' Data on 198 student essays, including the assigned grade and various
#' quantitative writing features such as word length, sentence length,
#' comma usage, grammatical errors, and preposition usage. This dataset is
#' useful for exploring multiple regression with continuous predictors
#' and for model building exercises aimed at predicting essay quality from
#' measurable text features.
#'
#' @format A tibble with 198 rows and 8 columns:
#' \describe{
#'   \item{essay}{Essay identifier. Type: numeric. Range: (1, 198).
#'     Sequential identifier for each essay.}
#'   \item{grade}{Essay grade assigned by instructor. Type: numeric.
#'     Values: 1, 2, 3, 4. Ordinal scale where higher values indicate
#'     better grades (e.g., 1 = lowest, 4 = highest). Mean = 2.28.}
#'   \item{wordlength}{Average word length (characters per word). Type:
#'     numeric. Range: (3.64, 5.30). Mean = 4.36. Longer average words
#'     may indicate more sophisticated vocabulary.}
#'   \item{sqrtwords}{Square root of the total word count. Type: numeric.
#'     Range: (3.32, 16.79). Mean = 9.38. The square root transformation
#'     is used to reduce skewness of the raw word count.}
#'   \item{commas}{Comma usage rate (commas per 100 words). Type: numeric.
#'     Range: (0.00, 14.70). Mean = 2.48. Higher values indicate more
#'     frequent comma use.}
#'   \item{errors}{Error rate (grammatical/spelling errors per 100 words).
#'     Type: numeric. Range: (0.00, 9.85). Mean = 1.99. Higher values
#'     indicate more errors.}
#'   \item{prepos}{Preposition usage rate (prepositions per 100 words).
#'     Type: numeric. Range: (0.00, 17.80). Mean = 9.78. Moderate
#'     preposition use is typical of academic writing.}
#'   \item{sentlength}{Average sentence length (words per sentence). Type:
#'     numeric. Range: (6.69, 45.45). Mean = 17.41. Longer sentences may
#'     indicate more complex writing.}
#' }
#'
#' @details
#' This dataset is used for model building exercises (Chapter 7) and as an
#' example of regression with ordinal outcomes (Chapter 13). Key analyses
#' include: building a multiple regression model to predict essay grade
#' from writing features, forward selection and backward elimination to
#' identify the most important predictors, and ordinal regression treating
#' grade as an ordered response. The dataset illustrates the challenge of
#' predicting a subjective outcome (essay grade) from objective text
#' features.
#'
#' @source Essay grading data from a writing assessment study.
#'   Original data file: `grades.dta`
#'
#' @examples
#' data(grades)
#' head(grades)
#'
#' # Multiple regression: predicting grade from writing features
#' lm(grade ~ wordlength + sqrtwords + errors + sentlength, data = grades)
#'
#' # Ordinal logistic regression
#' if (requireNamespace("MASS", quietly = TRUE)) {
#'   MASS::polr(factor(grade) ~ wordlength + errors + sentlength,
#'              data = grades)
#' }
"grades"


# -----------------------------------------------------------------------------
# 12. gss_1
# -----------------------------------------------------------------------------

#' General Social Survey Data
#'
#' A subset of 2,832 respondents from the General Social Survey (GSS),
#' containing variables on social attitudes, demographics, and behaviors.
#' The GSS is a nationally representative survey of U.S. adults that has
#' been conducted since 1972. This subset includes measures of attitudes
#' toward abortion, cohabitation, political conservatism, religiosity,
#' and demographic characteristics. It is used extensively for logistic
#' regression examples in the course.
#'
#' @format A tibble with 2,832 rows and 16 columns:
#' \describe{
#'   \item{abortion}{Abortion attitude scale. Type: numeric. Range: (0, 7).
#'     Count of the number of conditions (out of 7) under which the
#'     respondent believes abortion should be legal. Higher values indicate
#'     more permissive attitudes. NA = 964.}
#'   \item{cohabit}{Attitude toward cohabitation. Type: numeric.
#'     Range: (2, 10). Higher values indicate more favorable attitudes
#'     toward cohabitation. NA = 1,571.}
#'   \item{income}{Household income category. Type: numeric.
#'     Range: (1, 23). Ordinal income brackets where higher values
#'     indicate higher income. NA = 983.}
#'   \item{conserv}{Political conservatism. Type: numeric.
#'     Range: (1, 7). 7-point scale where 1 = extremely liberal and
#'     7 = extremely conservative. NA = 141.}
#'   \item{educat}{Respondent's years of education. Type: numeric.
#'     Range: (0, 20). Mean = 13.25. NA = 12.}
#'   \item{male}{Sex of respondent. Type: numeric. Binary indicator
#'     (0/1) where 1 = male, 0 = female. 44% male.}
#'   \item{maed}{Mother's years of education. Type: numeric.
#'     Range: (0, 20). Mean = 11.46. NA = 433.}
#'   \item{paed}{Father's years of education. Type: numeric.
#'     Range: (0, 20). Mean = 11.34. NA = 791.}
#'   \item{marital}{Marital status. Type: numeric. Values: 1, 2, 3, 4, 5.
#'     Where 1 = married, 2 = widowed, 3 = divorced, 4 = separated,
#'     5 = never married. NA = 1.}
#'   \item{partnrs5}{Number of sexual partners in the last 5 years. Type:
#'     numeric. Range: (0, 8). Where 8 = 8 or more. NA = 495.}
#'   \item{respage}{Respondent's age in years. Type: numeric.
#'     Range: (18, 89). Mean = 45.6.}
#'   \item{race}{Race of respondent. Type: numeric. Values: 1, 2, 3.
#'     Where 1 = White, 2 = Black, 3 = Other.}
#'   \item{black}{Black racial identification. Type: numeric. Binary
#'     indicator (0/1) where 1 = Black, 0 = not Black. 14% Black.}
#'   \item{othrace}{Other race identification. Type: numeric. Binary
#'     indicator (0/1) where 1 = Other race (not White or Black),
#'     0 = White or Black. 7% Other.}
#'   \item{relosity}{Religiosity composite score. Type: numeric.
#'     Range: (-8.68, 4.16). Mean approximately 0. Standardized composite
#'     measure of religious behavior and attitudes. Higher values indicate
#'     greater religiosity.}
#'   \item{religion}{Religious affiliation. Type: numeric.
#'     Values: 1, 2, 3, 4, 5. Where 1 = Protestant, 2 = Catholic,
#'     3 = Jewish, 4 = None, 5 = Other. NA = 35.}
#' }
#'
#' @details
#' This dataset is used in Chapters 9-11 (Simple and Multiple Logistic
#' Regression, Model Fit and Diagnostics) for logistic regression examples.
#' Key analyses include: modeling agreement with social policy statements
#' as a function of year (illustrated with a dummy variable for survey
#' year), computing and interpreting odds ratios, and examining how
#' attitudes toward abortion relate to conservatism, education, and
#' religiosity.
#'
#' The dataset has substantial missing data on several variables (e.g.,
#' cohabit with 55% missing, abortion with 34% missing), providing
#' opportunities to discuss missing data handling and its impact on
#' regression analysis.
#'
#' @source Smith, T. W., Davern, M., Stier, J., & Marsden, P. V. *General
#'   Social Surveys, 1972-2018*. National Opinion Research Center (NORC) at
#'   the University of Chicago. Original data file: `gss_1.dta`
#'
#' @examples
#' data(gss_1)
#' head(gss_1)
#'
#' # Logistic regression: conservatism predicting abortion attitude
#' gss_1$pro_abortion <- as.integer(gss_1$abortion >= 4)
#' glm(pro_abortion ~ conserv, data = gss_1, family = binomial)
#'
#' # Multiple regression: education and religiosity on abortion attitudes
#' lm(abortion ~ educat + relosity + conserv, data = gss_1)
"gss_1"


# -----------------------------------------------------------------------------
# 13. hsb_sub
# -----------------------------------------------------------------------------

#' High School and Beyond Subset
#'
#' A subset of 188 students from 5 schools drawn from the High School and
#' Beyond (HSB) study, a nationally representative survey of U.S. high
#' school students conducted by the National Center for Education Statistics.
#' The data include student-level variables (math achievement, SES,
#' demographics) and school-level variables (school size and sector). This
#' small subset is frequently used to introduce multilevel/hierarchical
#' concepts where students are nested within schools.
#'
#' @format A tibble with 188 rows and 7 columns:
#' \describe{
#'   \item{minority}{Minority status. Type: numeric. Binary indicator
#'     (0/1) where 1 = racial/ethnic minority, 0 = non-minority (White).
#'     52% minority.}
#'   \item{female}{Sex of student. Type: numeric. Binary indicator
#'     (0/1) where 1 = female, 0 = male. 63% female.}
#'   \item{ses}{Socioeconomic status composite. Type: numeric.
#'     Range: (-1.66, 1.51). Mean = -0.06. Standardized composite of
#'     family income, parental education, and parental occupation.}
#'   \item{mathach}{Mathematics achievement score. Type: numeric.
#'     Range: (-2.83, 24.99). Mean = 11.27. This is the primary outcome
#'     variable.}
#'   \item{size}{School enrollment size. Type: numeric.
#'     Range: (455, 1855). Mean = 1,088. 5 unique values corresponding
#'     to the 5 schools.}
#'   \item{sector}{School sector. Type: numeric. Binary indicator
#'     (0/1) where 1 = Catholic school, 0 = public school. 36% Catholic.}
#'   \item{schoolid}{School identifier. Type: numeric. Values: 1224, 1288,
#'     1296, 1308, 1317. Five unique school IDs from the HSB sampling
#'     frame.}
#' }
#'
#' @details
#' This dataset is used to illustrate regression concepts where observations
#' are nested within groups (students within schools). Key analyses include:
#' examining the relationship between SES and math achievement, comparing
#' public and Catholic school effects on achievement while controlling for
#' student demographics, and exploring school-level variation in the
#' SES-achievement relationship.
#'
#' The nesting structure (188 students in 5 schools) provides an
#' introduction to the concepts underlying multilevel modeling, even when
#' standard OLS regression is used. The sector variable allows for
#' ANCOVA-style analyses comparing school types.
#'
#' @source Raudenbush, S. W., & Bryk, A. S. (2002). *Hierarchical Linear
#'   Models: Applications and Data Analysis Methods* (2nd ed.). Sage
#'   Publications. Data originally from the High School and Beyond study,
#'   National Center for Education Statistics.
#'   Original data file: `hsb_sub.dta`
#'
#' @examples
#' data(hsb_sub)
#' head(hsb_sub)
#'
#' # SES effect on math achievement
#' lm(mathach ~ ses, data = hsb_sub)
#'
#' # ANCOVA: sector effect controlling for SES and demographics
#' lm(mathach ~ ses + minority + female + sector, data = hsb_sub)
#'
#' @seealso \code{\link{hsbs1}} for a larger HS&B subset (350 students,
#'   16 variables) used in model diagnostics (Chapter 8).
"hsb_sub"
# ============================================================================
# Dataset documentation: Datasets 14-25 of the regdatasets package
# File: R/data_B.R
# ============================================================================

# --------------------------------------------------------------------------
# 14. hsbs1
# --------------------------------------------------------------------------

#' High School and Beyond Survey (Full Sample)
#'
#' Data from the High School and Beyond (HS&B) longitudinal study, a nationally
#' representative survey of U.S. high school students conducted by the National
#' Center for Education Statistics (NCES). This full sample of 350 students
#' includes academic achievement scores, socioeconomic status, and school
#' program information. Used in regression teaching to illustrate model
#' diagnostics, multicollinearity among correlated achievement measures, and
#' multiple regression with both continuous and categorical predictors.
#'
#' @format A tibble with 350 rows and 16 columns:
#' \describe{
#'   \item{id}{Student identifier. Type: numeric. Range: (1, 599).}
#'   \item{gender}{Student gender. Type: numeric. Values: 1 = male, 2 = female.}
#'   \item{race}{Student race/ethnicity. Type: numeric. Values: 1 = Hispanic,
#'     2 = Asian, 3 = African American, 4 = White.}
#'   \item{ses}{Socioeconomic status. Type: numeric. Values: 1 = low,
#'     2 = middle, 3 = high.}
#'   \item{sch}{School type. Type: numeric. Values: 1 = public, 2 = private.}
#'   \item{prog}{Academic program. Type: numeric. Values: 1 = general,
#'     2 = academic, 3 = vocational.}
#'   \item{locus}{Locus of control composite score. Type: numeric.
#'     Range: (-2.23, 1.36). Higher values indicate more internal locus
#'     of control.}
#'   \item{concept}{Self-concept composite score. Type: numeric.
#'     Range: (-2.62, 1.19). Higher values indicate more positive
#'     self-concept.}
#'   \item{mot}{Motivation. Type: numeric. Range: (0, 1). Proportion-based
#'     measure of academic motivation.}
#'   \item{career}{Career choice code. Type: numeric. Range: (1, 17).
#'     Categorical code for intended career.}
#'   \item{read}{Reading achievement test score (standardized). Type: numeric.
#'     Range: (28.3, 73.3). Mean approximately 52.}
#'   \item{write}{Writing achievement test score (standardized). Type: numeric.
#'     Range: (28.1, 67.1). Mean approximately 52.}
#'   \item{math}{Mathematics achievement test score (standardized). Type: numeric.
#'     Range: (31.8, 75.5). Mean approximately 51.}
#'   \item{sci}{Science achievement test score (standardized). Type: numeric.
#'     Range: (26.0, 74.2). Mean approximately 52.}
#'   \item{ss}{Social studies achievement test score (standardized). Type: numeric.
#'     Range: (25.7, 70.5). Mean approximately 52.}
#'   \item{sample}{Sample weight indicator. Type: numeric. Constant value of 1
#'     for all observations in this subsample.}
#' }
#'
#' @details
#' This dataset is used in Chapter 8 (Model Diagnostics) to illustrate
#' regression diagnostic techniques including residual analysis, leverage
#' and influence measures, and detection of outliers. It also serves as a
#' demonstration dataset for model building with multiple correlated predictors
#' (the five achievement test scores) and for examining the effects of
#' categorical predictors such as program type and SES on academic outcomes.
#' Key analyses include: multiple regression of writing scores on reading and
#' math, residual plots, Cook's distance, leverage diagnostics, and VIF
#' assessment for multicollinearity.
#'
#' @source National Center for Education Statistics (NCES). High School and
#' Beyond (HS&B) Longitudinal Study. U.S. Department of Education.
#' Original data file: \code{hsbs1.dta}
#'
#' @examples
#' data(hsbs1)
#' head(hsbs1)
#' # Multiple regression of writing on reading and math
#' fit <- lm(write ~ read + math, data = hsbs1)
#' summary(fit)
#'
#' @seealso \code{\link{hsb_sub}} for a smaller HS&B subset (188 students,
#'   7 variables) used in model building (Chapters 6--7).
"hsbs1"


# --------------------------------------------------------------------------
# 15. individuals
# --------------------------------------------------------------------------

#' Bureau of Labor Statistics March 2000 CPS Individual Data
#'
#' Individual-level data from the March 2000 Annual Demographic Supplement of
#' the Current Population Survey (CPS), conducted by the Bureau of Labor
#' Statistics (BLS). The sample includes 55,899 respondents with information on
#' earnings, education, sex, age, and job sector. This large-scale survey
#' dataset is used to illustrate interactions between dummy variables (sex and
#' job sector) in predicting income, and to demonstrate two-way ANOVA via
#' regression with unbalanced observational data.
#'
#' @format A tibble with 55,899 rows and 6 columns:
#' \describe{
#'   \item{id}{Individual identifier. Type: numeric. Range: (1, 55899).}
#'   \item{age}{Age in years. Type: numeric. Range: (25, 65).}
#'   \item{educ}{Education level. Type: numeric. Values: 1 = less than high
#'     school, 2 = high school diploma, 3 = some college, 4 = bachelor's
#'     degree, 5 = master's degree, 6 = professional/doctoral degree.}
#'   \item{sex}{Sex of respondent. Type: numeric. Values: 1 = male, 2 = female.}
#'   \item{earn}{Total annual earnings from all sources, in U.S. dollars.
#'     Type: numeric. Range: (-24998, 425510). Mean approximately $37,865.}
#'   \item{job}{Job sector. Type: numeric. Values: 5 = government,
#'     6 = private sector, 7 = self-employed.}
#' }
#'
#' @details
#' This dataset is used in Chapter 5 (Interactions) to demonstrate interactions
#' between two dummy variables. The primary analysis focuses on respondents
#' with postgraduate degrees aged 30-40 working in the private sector or
#' government, examining how income depends on sex and job sector. Key concepts
#' illustrated include: interaction between dummy variables, two-way ANOVA via
#' regression, interaction diagrams, unbalanced designs and the distinction
#' between Type II and Type III sums of squares, and interpretation of
#' interaction coefficients as differences in differences.
#'
#' @source U.S. Bureau of Labor Statistics. Current Population Survey, March
#' 2000 Annual Demographic Supplement. U.S. Census Bureau.
#' Original data file: \code{individuals.dta}
#'
#' @examples
#' data(individuals)
#' # Subset to postgraduate, ages 30-40, private/government
#' sub <- individuals[individuals$educ >= 5 &
#'                    individuals$age >= 30 &
#'                    individuals$age <= 40 &
#'                    individuals$job %in% c(5, 6), ]
#' sub$male <- ifelse(sub$sex == 1, 1, 0)
#' sub$private <- ifelse(sub$job == 6, 1, 0)
#' # Interaction model for income
#' lm(earn ~ male * private, data = sub)
"individuals"


# --------------------------------------------------------------------------
# 16. instruction
# --------------------------------------------------------------------------

#' Reading Instruction Methods Study
#'
#' Data from an experimental study evaluating the effectiveness of different
#' reading instruction methods on mathematics achievement gains, drawn from
#' a multilevel education study. The dataset contains 1,190 students nested
#' within 312 classrooms across 107 schools, with measures of student
#' demographics, classroom-level teacher characteristics, and school-level
#' poverty indicators. Used in regression teaching to illustrate ANOVA with
#' categorical predictors, ANCOVA controlling for prior achievement, and
#' nested data structures.
#'
#' @format A tibble with 1,190 rows and 12 columns:
#' \describe{
#'   \item{girl}{Student gender indicator. Type: numeric. Binary (0/1) where
#'     1 = girl, 0 = boy.}
#'   \item{minority}{Minority status indicator. Type: numeric. Binary (0/1)
#'     where 1 = minority student, 0 = non-minority.}
#'   \item{mathkind}{Mathematics score at kindergarten entry. Type: numeric.
#'     Range: (290, 629). Standardized test score.}
#'   \item{mathgain}{Gain in mathematics score from kindergarten to first
#'     grade. Type: numeric. Range: (-110, 253). Computed as first grade
#'     score minus kindergarten score.}
#'   \item{ses}{Socioeconomic status of the student's household. Type: numeric.
#'     Range: (-1.61, 3.21). Continuous standardized composite measure.}
#'   \item{yearstea}{Teacher's years of teaching experience. Type: numeric.
#'     Range: (0, 40). Classroom-level variable.}
#'   \item{mathknow}{Teacher's mathematical knowledge score. Type: numeric.
#'     Range: (-2.50, 2.61). 109 missing values. Standardized measure of
#'     teacher content knowledge.}
#'   \item{housepov}{Proportion of households in the school neighborhood
#'     below the poverty line. Type: numeric. Range: (0.01, 0.56).
#'     School-level variable.}
#'   \item{mathprep}{Teacher's number of math content and methods courses.
#'     Type: numeric. Range: (1, 6). Classroom-level variable.}
#'   \item{classid}{Classroom identifier. Type: numeric. Range: (1, 312).}
#'   \item{schoolid}{School identifier. Type: numeric. Range: (1, 107).}
#'   \item{childid}{Student identifier. Type: numeric. Range: (1, 1190).}
#' }
#'
#' @details
#' This dataset is used in Chapter 3 (ANOVA) and Chapter 2 (ANCOVA) to
#' illustrate one-way ANOVA comparing group means, ANCOVA adjusting for
#' covariates, and the use of dummy variables with categorical predictors.
#' Key analyses include: comparing math gains across groups, adjusting for
#' prior math scores (mathkind) and SES, examining teacher and school-level
#' predictors of student math gains, and nested data analysis.
#'
#' @source Hill, H. C., Rowan, B., & Ball, D. L. (2005). Effects of
#' teachers' mathematical knowledge for teaching on student achievement.
#' \emph{American Educational Research Journal}, 42(2), 371-406.
#' Original data file: \code{instruction.dta}
#'
#' @examples
#' data(instruction)
#' head(instruction)
#' # ANCOVA: math gain predicted by minority status, controlling for prior math
#' lm(mathgain ~ minority + mathkind, data = instruction)
"instruction"


# --------------------------------------------------------------------------
# 17. lambert
# --------------------------------------------------------------------------

#' Lambert Longitudinal Study Data
#'
#' Longitudinal data from the Lambert study, a Canadian prospective
#' investigation tracking 492 children from early childhood into adulthood.
#' The dataset contains 109 variables spanning multiple assessment waves and
#' covering behavioral ratings (aggression, attention, activity, impulsivity),
#' cognitive test scores, academic achievement, mental health outcomes
#' (depression, anxiety), substance use, and occupational outcomes. Used in
#' regression teaching to illustrate latent response models, handling of
#' large multivariate datasets, and longitudinal predictor selection.
#'
#' @format A tibble with 492 rows and 109 columns. Key variables include:
#' \describe{
#'   \item{pupil}{Student identifier code. Type: character.}
#'   \item{rclass}{Classroom type at entry. Type: numeric. Range: (1, 7).
#'     Coded classroom assignment.}
#'   \item{byear}{Birth year (last two digits). Type: numeric. Range: (59, 73).
#'     E.g., 65 = 1965.}
#'   \item{b3005}{Sex. Type: character. Values: "M" = male, "F" = female.}
#'   \item{ethnic}{Ethnicity code. Type: numeric. Values: 1 through 5.}
#'   \item{hm1}{Hyperactivity marker. Type: character. Values: "Y" = yes,
#'     "N" = no.}
#' }
#'
#' Factor score variables (standardized composites, mean approximately 0):
#' \describe{
#'   \item{fs001}{Factor score 1 (cognitive/behavioral composite).
#'     Type: numeric. Range: (-1.60, 3.65).}
#'   \item{fs004}{Factor score 4. Type: numeric. Range: (-2.09, 2.86).}
#'   \item{fs006}{Factor score 6. Type: numeric. Range: (-2.53, 1.70).}
#'   \item{fs011}{Factor score 11. Type: numeric. Range: (-3.59, 2.27).}
#'   \item{fs014}{Factor score 14. Type: numeric. Range: (-3.02, 2.60).}
#'   \item{fs015}{Factor score 15. Type: numeric. Range: (-2.06, 4.53).}
#' }
#'
#' Teacher-rated behavioral scales (teacher report):
#' \describe{
#'   \item{tbyear}{Teacher birth year. Type: numeric. Range: (74, 80). 15 NA.}
#'   \item{tagg}{Teacher-rated aggression score. Type: numeric.
#'     Range: (8, 32). 24 NA.}
#'   \item{tatt}{Teacher-rated attention score. Type: numeric.
#'     Range: (5, 20). 25 NA.}
#'   \item{tact}{Teacher-rated activity level score. Type: numeric.
#'     Range: (4, 16). 24 NA.}
#'   \item{timp}{Teacher-rated impulsivity score. Type: numeric.
#'     Range: (3, 12). 23 NA.}
#'   \item{tadd}{Teacher-rated ADD composite score. Type: numeric.
#'     Range: (8, 32). 28 NA.}
#'   \item{tadhd}{Teacher-rated ADHD composite score. Type: numeric.
#'     Range: (15, 60). 37 NA.}
#'   \item{tcyear}{Teacher cohort year. Type: numeric. Range: (74, 77). 2 NA.}
#' }
#'
#' Parent-rated behavioral scales (parent report):
#' \describe{
#'   \item{pagg}{Parent-rated aggression. Type: numeric. Range: (4, 16). 9 NA.}
#'   \item{patt}{Parent-rated attention. Type: numeric. Range: (5, 20). 13 NA.}
#'   \item{pact}{Parent-rated activity. Type: numeric. Range: (3, 12). 8 NA.}
#'   \item{pimp}{Parent-rated impulsivity. Type: numeric. Range: (4, 16). 20 NA.}
#'   \item{padd}{Parent-rated ADD composite. Type: numeric. Range: (9, 36). 31 NA.}
#'   \item{padhd}{Parent-rated ADHD composite. Type: numeric. Range: (12, 48). 34 NA.}
#' }
#'
#' Childhood interview items (ic = interview child, wave 1):
#' \describe{
#'   \item{ic1cc}{Child interview composite score, wave 1. Type: numeric.
#'     Range: (1, 10). 135 NA.}
#'   \item{ic027}{Child interview item 027. Type: numeric. Range: (1, 3). 136 NA.}
#'   \item{ic028}{Child interview item 028. Type: numeric. Range: (1, 3). 139 NA.}
#'   \item{ic036}{Item rated 1-5. Type: numeric. Range: (1, 5). 163 NA.}
#'   \item{ic037}{Item rated 1-5. Type: numeric. Range: (1, 5). 163 NA.}
#'   \item{ic038}{Item rated 1-5. Type: numeric. Range: (1, 5). 163 NA.}
#'   \item{ic039}{Item rated 1-5. Type: numeric. Range: (1, 5). 163 NA.}
#' }
#'
#' Follow-up interview items (if = interview follow-up):
#' \describe{
#'   \item{ifage}{Age at follow-up interview. Type: numeric. Range: (7, 20). 190 NA.}
#'   \item{if027}{Follow-up interview item 027. Type: numeric. Range: (1, 3). 195 NA.}
#'   \item{if028}{Follow-up interview item 028. Type: numeric. Range: (1, 3). 196 NA.}
#'   \item{if036}{Item rated 1-5. Type: numeric. Range: (1, 5). 194 NA.}
#'   \item{if037}{Item rated 1-5. Type: numeric. Range: (1, 5). 195 NA.}
#'   \item{if038}{Item rated 1-5. Type: numeric. Range: (1, 5). 196 NA.}
#'   \item{if039}{Item rated 1-5. Type: numeric. Range: (1, 5). 195 NA.}
#' }
#'
#' Woodcock-Johnson achievement scores (wr prefix):
#' \describe{
#'   \item{wrage}{Age at Woodcock-Johnson assessment. Type: numeric.
#'     Range: (5, 17). 180 NA.}
#'   \item{wr016}{WJ reading score, subtest 016. Type: numeric.
#'     Range: (49, 142). 180 NA.}
#'   \item{wr017}{WJ reading score, subtest 017. Type: numeric.
#'     Range: (46, 139). 180 NA.}
#'   \item{wr018}{WJ reading score, subtest 018. Type: numeric.
#'     Range: (43, 142). 180 NA.}
#' }
#'
#' Classroom/teacher data (tr, cls prefix) at two time points:
#' \describe{
#'   \item{tr017_1}{Teacher report item 017, time 1. Type: numeric.
#'     Range: (0, 96). 128 NA.}
#'   \item{cls_ad_1}{Classroom adaptive score, time 1. Type: numeric.
#'     Range: (25, 1200). 128 NA.}
#'   \item{terper_1}{Teacher perception score, time 1. Type: numeric.
#'     Range: (21, 900). 128 NA.}
#'   \item{traper_1}{Teacher-rated adaptive/perception, time 1. Type: numeric.
#'     Range: (47, 1095). 129 NA.}
#'   \item{tr017_2}{Teacher report item 017, time 2. Type: numeric.
#'     Range: (0, 12). 161 NA.}
#'   \item{cls_ad_2}{Classroom adaptive score, time 2. Type: numeric.
#'     Range: (0, 1150). 162 NA.}
#'   \item{terper_2}{Teacher perception score, time 2. Type: numeric.
#'     Range: (25, 840). 164 NA.}
#'   \item{traper_2}{Teacher-rated adaptive/perception, time 2. Type: numeric.
#'     Range: (0, 1050). 166 NA.}
#' }
#'
#' IQ and cognitive assessment, wave 2 (i2 prefix):
#' \describe{
#'   \item{i21cc}{Child interview composite score, wave 2. Type: numeric.
#'     Range: (1, 10). 116 NA.}
#'   \item{i2004}{IQ performance score. Type: numeric. Range: (6, 82). 115 NA.}
#'   \item{i2005}{IQ verbal score. Type: numeric. Range: (1, 129). 115 NA.}
#'   \item{i2006}{IQ composite percentile. Type: numeric. Range: (0, 99). 115 NA.}
#'   \item{i2007}{IQ full scale standard score. Type: numeric.
#'     Range: (65, 135). 115 NA.}
#'   \item{i2014}{Performance score, subtest. Type: numeric.
#'     Range: (18, 81). 125 NA.}
#'   \item{i2015}{Verbal score, subtest. Type: numeric.
#'     Range: (19, 128). 125 NA.}
#'   \item{i2016}{Composite percentile, subtest. Type: numeric.
#'     Range: (0, 99). 125 NA.}
#'   \item{i2017}{Full scale standard score, subtest. Type: numeric.
#'     Range: (65, 135). 125 NA.}
#' }
#'
#' Young adult well-being (wh prefix, self-report):
#' \describe{
#'   \item{wh1yy}{Year of well-being assessment. Type: numeric.
#'     Range: (82, 86). 261 NA.}
#'   \item{wh024}{Well-being item 024, rated 1-6. Type: numeric. 261 NA.}
#'   \item{wh025}{Well-being item 025, rated 1-6. Type: numeric. 262 NA.}
#'   \item{wh036}{Well-being item 036, rated 1-9. Type: numeric. 261 NA.}
#'   \item{wh038}{Well-being item 038, rated 1-9. Type: numeric. 266 NA.}
#'   \item{wh054}{Well-being item 054, rated 1-5. Type: numeric. 270 NA.}
#'   \item{wh060}{Well-being item 060, rated 1-6. Type: numeric. 263 NA.}
#'   \item{wh061}{Well-being item 061, rated 1-6. Type: numeric. 267 NA.}
#'   \item{wh093}{Well-being item 093, rated 1-9. Type: numeric. 261 NA.}
#'   \item{wh239}{Well-being item 239, rated 1-6. Type: numeric. 262 NA.}
#'   \item{wh240}{Well-being item 240, rated 1-6. Type: numeric. 262 NA.}
#'   \item{wh241}{Well-being item 241, rated 1-6. Type: numeric. 262 NA.}
#'   \item{wh242}{Well-being item 242, rated 1-6. Type: numeric. 262 NA.}
#'   \item{wh243}{Well-being item 243, rated 1-6. Type: numeric. 263 NA.}
#'   \item{wh244}{Well-being item 244, rated 1-6. Type: numeric. 262 NA.}
#'   \item{wh245}{Well-being item 245, rated 1-4. Type: numeric. 262 NA.}
#' }
#'
#' Mental health outcomes:
#' \describe{
#'   \item{depress}{Depression scale score. Type: numeric.
#'     Range: (20, 58). 279 NA.}
#'   \item{anxiety}{Anxiety scale score. Type: numeric.
#'     Range: (7, 25). 268 NA.}
#' }
#'
#' Interpersonal and family variables:
#' \describe{
#'   \item{ip150}{Interpersonal functioning code. Type: character.
#'     Values: "A" through "G" and blank.}
#'   \item{fa128}{Family structure indicator. Type: numeric. Values: 1, 2. 131 NA.}
#'   \item{fa129a}{Family item 129a. Type: numeric. Range: (1, 8). 348 NA.}
#'   \item{fa129b}{Family item 129b. Type: character. Values: "A", "B", "C",
#'     and blank.}
#' }
#'
#' Occupational outcomes (oc prefix):
#' \describe{
#'   \item{oc0yy}{Year of occupational assessment. Type: numeric.
#'     Range: (91, 94). 113 NA.}
#'   \item{ocstatus}{Occupational status. Type: numeric. Range: (0, 4). 113 NA.}
#'   \item{oc014}{Occupational prestige, item 014. Type: numeric.
#'     Range: (1, 21). 137 NA.}
#'   \item{oc015}{Occupational prestige, item 015. Type: numeric.
#'     Range: (1, 17). 145 NA.}
#'   \item{oc032}{Occupational item 032. Type: numeric. Range: (1, 4). 135 NA.}
#'   \item{oc035}{Occupational item 035. Type: numeric. Range: (1, 5). 134 NA.}
#'   \item{oc036}{Occupational item 036. Type: numeric. Range: (1, 5). 134 NA.}
#' }
#'
#' Derived composite scores:
#' \describe{
#'   \item{edlevel}{Educational attainment level. Type: numeric.
#'     Range: (1, 10). 113 NA.}
#'   \item{actlevel}{Activity level composite. Type: numeric.
#'     Range: (3, 15). 23 NA.}
#'   \item{persist}{Persistence composite. Type: numeric.
#'     Range: (4, 19). 138 NA.}
#'   \item{adapt}{Adaptability composite. Type: numeric.
#'     Range: (4, 19). 126 NA.}
#'   \item{mood}{Mood composite. Type: numeric. Range: (4, 20). 9 NA.}
#'   \item{thold}{Threshold composite. Type: numeric. Range: (2, 10). 21 NA.}
#' }
#'
#' Substance use (dg prefix):
#' \describe{
#'   \item{dg001}{Substance use item 001. Type: numeric. Range: (1, 6). 109 NA.}
#'   \item{dg007}{Substance use item 007. Type: numeric. Range: (1, 6). 102 NA.}
#'   \item{dg009}{Substance use item 009 (age of first use). Type: character.
#'     Contains numeric ages or "NA"/blank.}
#'   \item{dg013}{Substance use item 013 (age of first use). Type: character.
#'     Contains numeric ages or blank.}
#' }
#'
#' DSM diagnostic indicators (dsm prefix, coded 1-5):
#' \describe{
#'   \item{dsmtob}{Tobacco use disorder. Type: numeric. Range: (1, 5). 112 NA.}
#'   \item{dsmgad}{Generalized anxiety disorder. Type: numeric.
#'     Range: (1, 5). 112 NA.}
#'   \item{dsmdep}{Major depression. Type: numeric. Range: (1, 5). 112 NA.}
#'   \item{dsmalc}{Alcohol use disorder. Type: numeric. Range: (1, 5). 112 NA.}
#'   \item{dsmasp}{Antisocial personality. Type: numeric. Range: (1, 5). 112 NA.}
#'   \item{dsmdg1}{Drug disorder 1. Type: numeric. Range: (1, 5). 113 NA.}
#'   \item{dsmdg2}{Drug disorder 2. Type: numeric. Range: (1, 5). 112 NA.}
#'   \item{dsmdg4}{Drug disorder 4. Type: numeric. Range: (1, 5). 113 NA.}
#'   \item{dsmdg5}{Drug disorder 5. Type: numeric. Range: (1, 5). 113 NA.}
#' }
#'
#' @details
#' This dataset is used in Chapter 12 (Latent Response Models and
#' Generalized Linear Models) to illustrate applications of latent variable
#' modeling and generalized linear models with longitudinal behavioral data.
#' Key analyses include: predicting adult outcomes from childhood behavioral
#' ratings, exploring the relationship between early ADHD symptoms and later
#' mental health, and handling substantial missing data across waves.
#'
#' @source Lambert, N. M. (1988). Adolescent outcomes for hyperactive
#' children. \emph{American Psychologist}, 43(10), 786-799.
#' Original data file: \code{lambert.dta}
#'
#' @examples
#' data(lambert)
#' # Predict depression from childhood ADHD ratings
#' sub <- lambert[!is.na(lambert$depress) & !is.na(lambert$tadhd), ]
#' lm(depress ~ tadhd, data = sub)
"lambert"


# --------------------------------------------------------------------------
# 18. nels_data (formerly 19)
# --------------------------------------------------------------------------

#' National Education Longitudinal Study of 1988 (NELS:88)
#'
#' Data from the National Education Longitudinal Study of 1988 (NELS:88),
#' a nationally representative longitudinal survey that followed 8th-grade
#' students through high school and beyond. This subsample of 2,000 students
#' contains 299 variables spanning base-year (1988) and first follow-up (1990)
#' waves, including student demographics, family background, school
#' characteristics, attitudes, behaviors, and standardized test scores. Used
#' extensively in regression teaching for model building, handling large
#' variable sets, and longitudinal analysis of educational achievement.
#'
#' @format A tibble with 2,000 rows and 299 columns. Key variable groups:
#'
#' Identifiers and demographics:
#' \describe{
#'   \item{id}{Student identifier. Type: numeric. Range: (124966, 9199195).}
#'   \item{bys2a}{Student sex. Type: numeric. Values: 1 = male, 2 = female.
#'     Code 8 = missing/refused.}
#'   \item{birthmo}{Birth month. Type: numeric. Range: (1, 12). Code 98 = missing.}
#'   \item{birthyr}{Birth year (last two digits). Type: numeric.
#'     Range: (72, 76). Code 98 = missing.}
#' }
#'
#' Parent occupation and education (base year):
#' \describe{
#'   \item{bys4a}{Father's education level. Type: numeric. Range: (1, 7).
#'     Codes 8, 9 = don't know/missing.}
#'   \item{bys4occ}{Father's occupation code. Type: numeric. Range: (1, 18).
#'     Code 99 = not applicable.}
#'   \item{bys5a}{Mother's education. Type: numeric. Range: (1, 7).
#'     Codes 8, 9 = don't know/missing.}
#'   \item{bys7a}{Mother's occupation. Type: numeric. Range: (1, 7).
#'     Codes 8, 9 = don't know/missing.}
#'   \item{bys7occ}{Mother's occupation code. Type: numeric. Range: (1, 18).
#'     Code 99 = not applicable.}
#' }
#'
#' Family structure and home environment:
#' \describe{
#'   \item{bys12}{Family composition. Type: numeric. Values: 1 = two parents,
#'     2 = other. Code 8 = missing.}
#'   \item{bys18}{Number of siblings. Type: numeric. Code 99 = missing.}
#'   \item{bys20}{Times changed schools. Type: numeric. Code 98 = missing.}
#'   \item{bys22}{Home language. Type: numeric. Code 99 = missing.}
#' }
#'
#' Parental involvement items (\code{bys27a} through \code{bys27d}): Rated
#' on a scale where lower values indicate more involvement. Code 9 = missing.
#'
#' Student attitudes and self-concept items:
#' \describe{
#'   \item{bys29}{Educational expectations. Type: numeric. Code 9 = missing.}
#' }
#'
#' Television and homework habits (\code{bys31a} through \code{bys31d}):
#' Hours spent on various activities. Codes 8, 9, 99 = missing.
#'
#' Extracurricular activities: \code{bys34a}, \code{bys34b} (participation
#' codes, 98 = missing).
#'
#' School-related items (\code{bys35a} through \code{bys39c}): Various
#' school experience and behavior items rated on Likert-type scales.
#' Code 8 = missing.
#'
#' Time use items: \code{bys41} (hours working, code 8 = missing),
#' \code{bys42a}, \code{bys42b} (hours on activities, code 98 = missing),
#' \code{bys43} (absences, code 8 = missing).
#'
#' School behavior items (\code{bys44a} through \code{bys44m}): Items
#' measuring academic and social behaviors, rated on Likert-type scales.
#' Code 8 = missing.
#'
#' Additional student items: \code{bys45} through \code{bys46} (educational
#' plans), \code{bys52} through \code{bys54} (peer influences, codes
#' 8/98 = missing), \code{bys55a} through \code{bys55f} (risk behaviors,
#' code 8 = missing), \code{bys56a} through \code{bys56e} (parenting
#' practices), \code{bys57a} through \code{bys57c} (problem behaviors).
#'
#' Locus of control and self-concept items (\code{bys58a} through
#' \code{bys60d}): Likert-type attitude items rated 1-4, with code
#' 8 = missing.
#'
#' Teacher report items (\code{bys66a} through \code{bys68b}): Teacher
#' assessments of student behavior. Code 8 = missing.
#'
#' Drug/alcohol items (\code{bys74} through \code{bys77}): Risk behavior
#' items. Code 8 = missing.
#'
#' Behavioral ratings (\code{bys80}): Behavioral scale. Range: (0, 5). 90 NA.
#'
#' Course-taking patterns (\code{bys81a} through \code{bys83j}): Items on
#' courses taken and academic track. Codes 8, 98 = missing.
#'
#' Composite and derived variables:
#' \describe{
#'   \item{bys82a through bys82u}{Self-concept items. Type: numeric.
#'     Rated 1-4. Code 8 = missing. 21 items.}
#'   \item{bys83a through bys83j}{Locus of control items. Type: numeric.
#'     Rated 1-4. Code 8 = missing. 10 items.}
#'   \item{byscenrl}{School enrollment size category. Type: numeric.
#'     Range: (1, 7).}
#'   \item{g8urban}{Urbanicity. Type: numeric. Values: 1 = urban,
#'     2 = suburban, 3 = rural.}
#'   \item{g8regon}{Census region. Type: numeric. Range: (1, 4).
#'     Code 8 = missing.}
#'   \item{g8minor}{Percent minority enrollment in school. Type: numeric.
#'     Code 998 = missing.}
#'   \item{g8lunch}{Percent eligible for free lunch. Type: numeric.
#'     Code 998 = missing.}
#' }
#'
#' Psychometric composite scores (base year):
#' \describe{
#'   \item{bylocus1}{Locus of control, IRT-based. Type: numeric.
#'     Code 99.98 = missing.}
#'   \item{bylocus2}{Locus of control, standardized. Type: numeric.
#'     Code 99.98 = missing.}
#'   \item{bycncpt1}{Self-concept, IRT-based. Type: numeric.
#'     Code 99.98 = missing.}
#'   \item{bycncpt2}{Self-concept, standardized. Type: numeric.
#'     Code 99.98 = missing.}
#'   \item{byses}{Socioeconomic status composite. Type: numeric.
#'     Range: (-2.89, 1.98). Code 100 = missing. Standardized composite
#'     of parental education, occupation, and family income.}
#'   \item{bypared}{Parental education (highest of either parent).
#'     Type: numeric. Range: (1, 7).}
#'   \item{byfamsiz}{Family size. Type: numeric. Code 98 = missing.}
#'   \item{byfcomp}{Family composition. Type: numeric. Code 98 = missing.}
#'   \item{byparmar}{Parental marital status. Type: numeric.
#'     Code 98 = missing.}
#'   \item{byfaminc}{Family income category. Type: numeric. Range: (1, 15).
#'     Code 98 = missing.}
#'   \item{byhmlang}{Home language. Type: numeric. Code 8 = missing.}
#'   \item{bypsepln}{Post-secondary education plans. Type: numeric.
#'     Code 98 = missing.}
#'   \item{byhomewk}{Hours of homework per week. Type: numeric.
#'     Code 98 = missing.}
#'   \item{bylep}{Limited English proficiency. Type: numeric. Binary
#'     (0/1). Code 8 = missing.}
#'   \item{bylm}{Language minority. Type: numeric. Binary (0/1).
#'     Code 8 = missing.}
#'   \item{bygrads}{GPA composite. Type: numeric. Range: (0.5, 9.8).}
#'   \item{byrisk}{Number of risk factors. Type: numeric. Range: (0, 5).}
#' }
#'
#' Base-year standardized test scores:
#' \describe{
#'   \item{by2xrstd}{Reading standardized score. Type: numeric.
#'     Range: (31.95, 70.55). 77 NA. Mean approximately 51.}
#'   \item{by2xmstd}{Mathematics standardized score. Type: numeric.
#'     Range: (34.10, 77.20). 75 NA. Mean approximately 51.}
#'   \item{by2xsstd}{Science standardized score. Type: numeric.
#'     Code 99.99 = missing.}
#'   \item{by2xhstd}{History standardized score. Type: numeric.
#'     Code 99.99 = missing.}
#'   \item{by2xrpro}{Reading proficiency level. Type: numeric.
#'     Range: (0, 4). Code 9 = missing.}
#'   \item{by2xmpro}{Math proficiency level. Type: numeric.
#'     Range: (0, 5). Code 9 = missing.}
#'   \item{by2xspro}{Science proficiency level. Type: numeric.
#'     Range: (0, 3). Code 9 = missing.}
#' }
#'
#' First follow-up (1990) student survey items (\code{f1s} prefix):
#' Items \code{f1s8a} through \code{f1s99s} cover attitudes, school
#' experiences, behavior, and educational plans at the first follow-up
#' wave (10th grade). Most items are rated on Likert-type scales (1-4 or
#' 1-6). Code 8 = missing/not applicable. Approximately 186 NA values per
#' item for students lost to follow-up.
#'
#' First follow-up derived variables:
#' \describe{
#'   \item{f1stat}{Follow-up status. Type: numeric. Range: (0, 5).}
#'   \item{f1dostat}{Dropout status. Type: numeric. Range: (0, 5).}
#'   \item{f1ses}{SES at follow-up. Type: numeric. Code 100 = missing.}
#'   \item{f1locus1}{Locus of control, follow-up. Type: numeric.
#'     Code 99.98 = missing.}
#'   \item{f1locus2}{Locus of control standardized, follow-up.
#'     Code 99.98 = missing.}
#'   \item{f1cncpt1}{Self-concept, follow-up. Code 99.98 = missing.}
#'   \item{f1cncpt2}{Self-concept standardized, follow-up.
#'     Code 99.98 = missing.}
#'   \item{f1drps89}{Dropout between base year and 1989. Type: numeric.
#'     Code 8 = missing.}
#'   \item{f1drpf89}{Dropout by fall 1989. Code 8 = missing.}
#'   \item{f1drps90}{Dropout by spring 1990. Code 8 = missing.}
#'   \item{f1hsprog}{High school program. Type: numeric. Code 8 = missing.}
#'   \item{f12xrstd}{Reading score at follow-up. Type: numeric.
#'     Code 99.99 = missing. Mean approximately 57.}
#'   \item{year2}{Derived time variable 2. Type: numeric.}
#'   \item{year1}{Derived time variable 1. Type: numeric.}
#' }
#'
#' @details
#' This dataset is used across multiple chapters for model building exercises,
#' particularly in Chapter 7 (Model Building) for variable selection and
#' in general regression contexts for examining predictors of educational
#' achievement. The large number of variables allows practice in identifying
#' relevant predictors from a rich set of candidates. Note that many variables
#' use special missing value codes (8, 9, 98, 99, 99.98, 99.99, 100, 998)
#' rather than NA, which requires careful data cleaning before analysis.
#' Key analyses include: predicting math achievement from SES and school
#' characteristics, stepwise and purposeful model building, and examining
#' longitudinal change in test scores from base year to follow-up.
#'
#' @source National Center for Education Statistics (NCES). National Education
#' Longitudinal Study of 1988 (NELS:88). U.S. Department of Education.
#' Original data file: \code{nels_data.dta}
#'
#' @examples
#' data(nels_data)
#' # Regression of math score on SES (after cleaning missing codes)
#' nels_clean <- nels_data[nels_data$byses < 90, ]
#' lm(by2xmstd ~ byses, data = nels_clean)
"nels_data"


# --------------------------------------------------------------------------
# 20. penalty
# --------------------------------------------------------------------------

#' Death Penalty Sentencing Data
#'
#' Data on 674 homicide cases examining the relationship between death
#' penalty sentencing, defendant race, and victim race. This dataset is a
#' classic example in categorical data analysis used to illustrate logistic
#' regression goodness-of-fit testing, the effects of confounding variables,
#' and Simpson's paradox in the context of criminal justice. The data show
#' that the victim's race is a stronger predictor of death penalty sentencing
#' than the defendant's race.
#'
#' @format A tibble with 674 rows and 3 columns:
#' \describe{
#'   \item{def_bl}{Defendant race indicator. Type: numeric. Binary (0/1)
#'     where 1 = Black defendant, 0 = White defendant.}
#'   \item{vic_bl}{Victim race indicator. Type: numeric. Binary (0/1)
#'     where 1 = Black victim, 0 = White victim.}
#'   \item{death_pe}{Death penalty sentencing outcome. Type: numeric.
#'     Binary (0/1) where 1 = death penalty imposed, 0 = no death penalty.}
#' }
#'
#' @details
#' This dataset is used in Chapter 11 (Multiple Logistic Regression: Model Fit
#' and Diagnostics) to illustrate goodness-of-fit tests for logistic regression
#' models, including the Pearson chi-squared test and the likelihood ratio test
#' (deviance). The main-effects model with defendant and victim race is tested
#' against the saturated model. Key analyses include: logistic regression with
#' two binary predictors, Pearson and deviance goodness-of-fit statistics,
#' cross-tabulation of observed versus expected frequencies, and assessment of
#' whether the main-effects model is adequate (it fits well, with Pearson
#' X-squared = 0.20, p = 0.66).
#'
#' @section Ethical context:
#' These data document racial disparities in the application of the death
#' penalty in Florida during the late 1970s. The original study by Radelet
#' (1981) found that cases involving White victims were significantly more
#' likely to result in a death sentence than cases involving Black victims,
#' after controlling for defendant race. This finding was part of a broader
#' body of research -- including the Baldus study cited in \emph{McCleskey v.
#' Kemp} (1987) -- that documented systemic racial bias in capital sentencing.
#' Instructors should provide appropriate historical context when assigning
#' analyses of this dataset and encourage students to consider the structural
#' and institutional factors that underlie these patterns.
#'
#' @source Agresti, A. (2002). \emph{Categorical Data Analysis} (2nd ed.).
#' Wiley. Based on data from Radelet, M. L. (1981). Racial characteristics
#' and the imposition of the death penalty.
#' \emph{American Sociological Review}, 46(6), 918-927.
#' Original data file: \code{penalty.dta}
#'
#' @examples
#' data(penalty)
#' head(penalty)
#' # Logistic regression: death penalty ~ defendant race + victim race
#' glm(death_pe ~ def_bl + vic_bl, family = binomial, data = penalty)
"penalty"


# --------------------------------------------------------------------------
# 21. pisa2000
# --------------------------------------------------------------------------

#' PISA 2000 International Reading Assessment Data
#'
#' Data from the Programme for International Student Assessment (PISA) 2000,
#' an international assessment coordinated by the Organisation for Economic
#' Co-operation and Development (OECD). This subsample of 4,528 fifteen-year-old
#' students from three countries (United Kingdom, Germany, and United States)
#' includes reading literacy scores, parental occupational status, immigration
#' background, and school identifiers. Used in regression teaching to
#' illustrate multiple regression with continuous and binary predictors across
#' countries.
#'
#' @format A tibble with 4,528 rows and 15 columns:
#' \describe{
#'   \item{country}{Country code (ISO 3166 numeric). Type: character.
#'     Values: "826" = United Kingdom, "276" = Germany, "840" = United States.}
#'   \item{female}{Student gender indicator. Type: numeric. Binary (0/1)
#'     where 1 = female, 0 = male.}
#'   \item{isei}{International Socio-Economic Index of Occupational Status,
#'     based on highest parental occupation. Type: numeric. Range: (16, 90).
#'     Higher values indicate higher occupational status.}
#'   \item{wleread}{Weighted likelihood estimate of reading proficiency.
#'     Type: numeric. Range: (161.39, 881.39). PISA scale with international
#'     mean approximately 500 and SD approximately 100.}
#'   \item{high_sch}{Parental education: high school only indicator.
#'     Type: numeric. Binary (0/1) where 1 = highest parental education
#'     is high school.}
#'   \item{college}{Parental education: college or higher indicator.
#'     Type: numeric. Binary (0/1) where 1 = at least one parent has
#'     college degree.}
#'   \item{one_for}{Immigration status: one parent foreign-born.
#'     Type: numeric. Binary (0/1) where 1 = one parent foreign-born.}
#'   \item{both_for}{Immigration status: both parents foreign-born.
#'     Type: numeric. Binary (0/1) where 1 = both parents foreign-born.}
#'   \item{test_lan}{Test language spoken at home. Type: numeric.
#'     Binary (0/1) where 1 = language of the test is the primary language
#'     spoken at home.}
#'   \item{reading}{Reading proficiency level (ordinal). Type: numeric.
#'     Range: (0, 5). PISA reading proficiency level where 0 = below Level 1,
#'     1 = Level 1, ..., 5 = Level 5.}
#'   \item{pass_rea}{Pass reading benchmark indicator. Type: numeric.
#'     Binary (0/1) where 1 = proficiency at or above Level 3.}
#'   \item{id_schoo}{School identifier. Type: numeric. Range: (1, 990).}
#'   \item{uk}{Country dummy for United Kingdom. Type: numeric. Binary (0/1)
#'     where 1 = student from UK.}
#'   \item{germany}{Country dummy for Germany. Type: numeric. Binary (0/1)
#'     where 1 = student from Germany.}
#'   \item{usa}{Country dummy for United States. Type: numeric. Binary (0/1)
#'     where 1 = student from USA.}
#' }
#'
#' @details
#' This dataset supports analyses across multiple chapters for demonstrating
#' regression with international education data. The PISA 2000 assessment
#' measured reading, mathematics, and science literacy of 15-year-olds in
#' participating OECD and partner countries. Key analyses include: multiple
#' regression of reading scores on SES and demographic predictors, logistic
#' regression predicting passage of reading benchmarks, country comparisons
#' using dummy variables, and examining the effects of immigration background
#' and parental education on student achievement. The country dummies
#' (uk, germany, usa) sum to 1 for all rows, with one serving as the
#' reference category.
#'
#' @source OECD (2002). \emph{PISA 2000 Technical Report}. Paris: OECD
#' Publishing. Programme for International Student Assessment.
#' Original data file: \code{pisa2000.dta}
#'
#' @examples
#' data(pisa2000)
#' head(pisa2000)
#' # Regression of reading on socioeconomic status and gender
#' lm(wleread ~ isei + female, data = pisa2000)
"pisa2000"


# --------------------------------------------------------------------------
# 22. reading
# --------------------------------------------------------------------------

#' Reading Comprehension Instruction Experiment
#'
#' Data from an experiment comparing three methods of reading instruction on
#' reading comprehension outcomes. Sixty-six second-grade students were
#' randomly assigned to one of three instructional methods: Basal (traditional),
#' DRTA (Directed Reading-Thinking Activity), and Strat (Strategies
#' instruction). Pre-test and post-test scores were measured on multiple
#' reading comprehension assessments. This is a primary teaching dataset used
#' throughout the course for ANOVA, dummy variable coding, and planned
#' comparisons.
#'
#' @format A tibble with 66 rows and 8 columns:
#' \describe{
#'   \item{subject}{Student identifier. Type: numeric. Range: (1, 66).}
#'   \item{group}{Instruction method group label. Type: character.
#'     Levels: "Basal" = standard/traditional method (reference group),
#'     "DRTA" = Directed Reading-Thinking Activity (new method),
#'     "Strat" = Strategies instruction (new method).}
#'   \item{pre1}{Pre-test score, measure 1 (reading comprehension).
#'     Type: numeric. Range: (4, 16).}
#'   \item{pre2}{Pre-test score, measure 2 (reading comprehension).
#'     Type: numeric. Range: (1, 13).}
#'   \item{post1}{Post-test score, measure 1 (intruded sentences test).
#'     Type: numeric. Range: (1, 15). Primary outcome variable.}
#'   \item{post2}{Post-test score, measure 2 (reading comprehension).
#'     Type: numeric. Range: (0, 13).}
#'   \item{post3}{Post-test score, measure 3 (reading comprehension,
#'     standardized). Type: numeric. Range: (30, 57). Mean approximately 44.}
#'   \item{method}{Numeric code for instruction method. Type: numeric.
#'     Values: 1 = Basal, 2 = DRTA, 3 = Strat.}
#' }
#'
#' @details
#' This dataset is used in Chapter 3 (Multiple Linear Regression: ANOVA) to
#' illustrate one-way ANOVA as a regression with dummy variables, and to
#' demonstrate planned comparisons versus post-hoc tests. Key analyses
#' include: dummy variable coding for three-group comparisons (Basal as
#' reference), F-test for overall group differences, planned comparisons
#' (e.g., new methods vs. traditional, DRTA vs. Strat), Bonferroni and
#' Scheffe adjustments for multiple comparisons, ANCOVA controlling for
#' pre-test scores, and effect coding as an alternative to dummy coding.
#'
#' @source Schmitt, M. C. (1987). The effects of an elaborated directed
#' reading activity on the metacomprehension skills of third graders.
#' Cited in Raudenbush, S. W. & Bryk, A. S. (2002).
#' \emph{Hierarchical Linear Models} (2nd ed.). Sage.
#' Original data file: \code{reading.dta}
#'
#' @examples
#' data(reading)
#' head(reading)
#' # One-way ANOVA: post-test score by instruction method
#' lm(post1 ~ group, data = reading)
"reading"


# --------------------------------------------------------------------------
# 23. satisfaction
# --------------------------------------------------------------------------

#' Satisfaction Survey Data
#'
#' Ordinal survey data from 110 respondents measuring job or life satisfaction
#' on a 4-point scale, along with gender and income level. Used in regression
#' teaching to illustrate ordinal logistic regression (proportional odds
#' model), the cumulative link formulation, and the proportional odds
#' assumption with a simple, interpretable dataset.
#'
#' @format A tibble with 110 rows and 3 columns:
#' \describe{
#'   \item{gender}{Respondent gender. Type: character. Values: "F" = female,
#'     "M" = male.}
#'   \item{income}{Income level (ordinal). Type: numeric. Values: 1 = low,
#'     2 = medium-low, 3 = medium-high, 4 = high.}
#'   \item{satisfaction}{Satisfaction rating (ordinal response variable).
#'     Type: numeric. Values: 1 = not satisfied, 2 = slightly satisfied,
#'     3 = satisfied, 4 = very satisfied.}
#' }
#'
#' @details
#' This dataset is used in Chapter 13 (Models for Ordinal Responses) to
#' illustrate the ordinal logistic regression (proportional odds) model.
#' The 4-level satisfaction outcome is modeled using the cumulative logit
#' formulation. Key analyses include: fitting the proportional odds model
#' with gender and income as predictors, interpreting cumulative odds ratios,
#' testing the proportional odds assumption, comparing ordinal logit and
#' ordinal probit models, and examining threshold (cut-point) estimates.
#'
#' @source Simulated survey data for pedagogical purposes.
#' Original data file: \code{satisfaction.dta}
#'
#' @examples
#' data(satisfaction)
#' head(satisfaction)
#' table(satisfaction$satisfaction, satisfaction$gender)
#' # Ordinal logistic regression (requires MASS package)
#' # MASS::polr(factor(satisfaction) ~ income + gender, data = satisfaction)
"satisfaction"


# --------------------------------------------------------------------------
# 24. titanic
# --------------------------------------------------------------------------

#' Titanic Passenger Survival Data
#'
#' Passenger data from the RMS Titanic disaster of April 15, 1912, containing
#' survival status and demographic information for 1,309 passengers. This
#' widely used dataset illustrates logistic regression with both continuous
#' and categorical predictors, and serves as a compelling teaching example
#' of how passenger class, sex, and age influenced survival probability.
#'
#' @format A tibble with 1,309 rows and 6 columns:
#' \describe{
#'   \item{pclass}{Passenger class (ticket class). Type: numeric.
#'     Values: 1 = 1st class (upper), 2 = 2nd class (middle),
#'     3 = 3rd class (lower). Serves as a proxy for socioeconomic status.}
#'   \item{survived}{Survival indicator. Type: numeric. Binary (0/1) where
#'     1 = survived, 0 = did not survive. Overall survival rate is approximately
#'     38 percent.}
#'   \item{age}{Passenger age in years. Type: numeric. Range: (0.17, 80.00).
#'     263 missing values. Fractional ages (e.g., 0.17) represent infants.}
#'   \item{fare}{Passenger fare in British pounds. Type: numeric.
#'     Range: (0.00, 512.33). 1 missing value. Varies substantially by
#'     class.}
#'   \item{embarked}{Port of embarkation. Type: character.
#'     Values: S = Southampton, C = Cherbourg, Q = Queenstown
#'     (Cobh, Ireland). Two cases have missing embarkation port.}
#'   \item{sex}{Passenger sex indicator. Type: numeric. Binary (0/1)
#'     where 1 = female, 0 = male.}
#' }
#'
#' @details
#' This dataset is used in Chapters 9-11 (Logistic Regression) to illustrate
#' simple and multiple logistic regression modeling. The well-known "women
#' and children first" evacuation policy makes this dataset effective for
#' demonstrating how sex, class, and age predict binary outcomes. Key analyses
#' include: simple logistic regression of survival on sex, multiple logistic
#' regression with class and age, odds ratio interpretation, predicted
#' probabilities, handling missing data in age, and model comparison using
#' likelihood ratio tests and AIC.
#'
#' @section Note:
#' This dataset represents real individuals who perished in or survived
#' a maritime disaster. The data are used for statistical education with
#' respect for those involved. The \code{embarked} variable contains 2
#' missing values (converted from blank strings to \code{NA} in v0.2.0).
#'
#' @source British Board of Trade (1990). \emph{Report on the Loss of the
#' "Titanic" (S.S.)}. Compiled from various historical passenger records.
#' Original data file: \code{titanic.dta}
#'
#' @examples
#' data(titanic)
#' head(titanic)
#' # Logistic regression: survival predicted by sex and passenger class
#' glm(survived ~ sex + factor(pclass), family = binomial, data = titanic)
"titanic"


# --------------------------------------------------------------------------
# 25. womenlf
# --------------------------------------------------------------------------

#' Canadian Women's Labor Force Participation
#'
#' Data on labor force participation of 263 married Canadian women, including
#' work status (not working, part-time, full-time), husband's income, region
#' of residence, and presence of children. This dataset is a classic example
#' for ordinal response modeling, as the three-level work status variable
#' represents an ordered outcome ranging from no labor force participation
#' to full-time employment.
#'
#' @format A tibble with 263 rows and 5 columns:
#' \describe{
#'   \item{obs}{Observation number. Type: numeric. Range: (1, 263).}
#'   \item{husbinc}{Husband's annual income in thousands of Canadian dollars.
#'     Type: numeric. Range: (1, 45). Mean approximately $14,760.}
#'   \item{region}{Canadian region of residence. Type: character.
#'     Levels: "Atlantic" = Atlantic provinces, "Quebec" = Quebec,
#'     "Ontario" = Ontario, "Prairie" = Prairie provinces, "BC" = British
#'     Columbia.}
#'   \item{workstat}{Work status (ordinal response variable). Type: numeric.
#'     Values: 0 = not working outside the home, 1 = working part-time,
#'     2 = working full-time. Ordered from lowest to highest labor
#'     force participation.}
#'   \item{chilpres}{Presence of children in the household. Type: numeric.
#'     Binary (0/1) where 1 = children present, 0 = no children present.}
#' }
#'
#' @details
#' This dataset is used in Chapter 13 (Models for Ordinal Responses) to
#' illustrate ordinal logistic regression and the proportional odds model.
#' The three-level ordered outcome (not working, part-time, full-time) is
#' modeled using cumulative logit links. Key analyses include: fitting
#' the proportional odds model with husband's income, region, and children
#' present as predictors, interpreting cumulative odds ratios,
#' testing the proportional odds assumption, and comparing ordinal logit
#' versus ordinal probit specifications.
#'
#' @source Fox, J. (2003). \emph{Applied Regression Analysis and Generalized
#' Linear Models} (2nd ed.). Sage. Based on data from the 1977 Canadian
#' Survey of Consumer Finances.
#' Original data file: \code{womenlf.dta}
#'
#' @examples
#' data(womenlf)
#' head(womenlf)
#' table(womenlf$workstat)
#' # Ordinal logistic regression (requires MASS package)
#' # MASS::polr(factor(workstat) ~ husbinc + chilpres, data = womenlf)
#'
#' @seealso A version of this dataset also appears as \code{Womenlf} in the
#'   \code{carData} package (GPL >= 2).
"womenlf"
