# National Assessment of Educational Progress (NAEP) Mathematics Data

Data from the 2005 National Assessment of Educational Progress (NAEP)
Grade 8 Mathematics assessment, containing 17,606 students with
demographic information, student/teacher/school questionnaire responses,
plausible values for mathematics proficiency, survey weights, and
replicate weights for variance estimation. This large-scale assessment
dataset is used in regression teaching to demonstrate analysis of
complex survey data, plausible value methodology, and weighted
regression.

## Usage

``` r
naep
```

## Format

A tibble with 17,606 rows and 301 columns. Key variable groups:

Demographic and classification variables:

- YEAR:

  Assessment year code. Type: numeric. Constant value 36.

- COHORT:

  Cohort indicator. Type: numeric. Constant value 2.

- SCRPSU:

  Primary sampling unit identifier. Type: numeric. Range: (5, 9903).

- DSEX:

  Student sex. Type: numeric. Values: 1 = male, 2 = female.

- IEP:

  Individualized Education Program status. Type: numeric. Values: 1 =
  yes, 2 = no. 8 NA.

- LEP:

  Limited English Proficiency status. Type: numeric. Values: 1 = yes,
  other codes for no/formerly. Range: (1, 8).

- ELL3:

  English Language Learner status (3-level). Type: numeric. Values: 1 =
  ELL, 2 = formerly ELL, 3 = never ELL. 5 NA.

- SDRACEM:

  Race/ethnicity. Type: numeric. Values: 1 = White, 2 = Black, 3 =
  Hispanic, 4 = Asian/Pacific Islander, 5 = American Indian/Alaska
  Native, 6 = other.

- PARED:

  Highest parental education level. Type: numeric. Range: (0, 8). Higher
  values indicate more education. 691 NA.

Student questionnaire items (B-prefix, 691 NA each):

- B003501:

  Mother's education level. Type: numeric. Range: (0, 8).

- B003601:

  Father's education level. Type: numeric. Range: (0, 8).

- B013801:

  Number of books in home. Type: numeric. Range: (0, 8).

- B017001:

  Frequency of reading for fun. Type: numeric. Range: (1, 8).

- B017101:

  Frequency of reading in school. Type: numeric. Range: (0, 8).

- B018101:

  Computer use at home. Type: numeric. Range: (0, 8).

- B018201:

  Computer use at school. Type: numeric. Range: (0, 8).

- B017451:

  Hours of TV watched per day. Type: numeric. Range: (0, 8).

Mathematics-specific student items (M815-prefix, 691 NA each):

- M815401:

  Math attitude item. Type: numeric. Range: (0, 8).

- M815501:

  Math attitude item. Type: numeric. Range: (0, 8).

- M815601:

  Math attitude item. Type: numeric. Range: (0, 8).

- M815801:

  Math homework hours per week. Type: numeric. Range: (0, 88).

- M815701:

  Math class time item. Type: numeric. Range: (0, 88).

Survey design and weighting variables:

- RPTSAMP:

  Reporting sample flag. Type: numeric. Values: 1 or 2.

- REPGRP1:

  Replicate group 1. Type: numeric. Range: (1, 62).

- REPGRP2:

  Replicate group 2. Type: numeric. Range: (1, 341).

- JKUNIT:

  Jackknife unit. Type: numeric. Values: 1 or 2.

- ORIGWT:

  Original sampling weight. Type: numeric. Range: (0.10, 6.03).

- SMSRSWT:

  Smoothed sampling weight. Type: numeric. Range: (0.27, 9.06).

Replicate weights for variance estimation: `SRWT01` through `SRWT62` are
62 jackknife replicate weights, each numeric with range approximately
(0, 9.5) and mean approximately 1.0. Used for proper standard error
estimation with the complex survey design.

Plausible values for mathematics proficiency (5 content strands x 5
plausible values each):

- MRPS11 through MRPS15:

  Number properties/operations, plausible values 1-5. Type: numeric.
  Range approximately (93, 412). 691 NA.

- MRPS21 through MRPS25:

  Measurement, plausible values 1-5. Type: numeric. Range approximately
  (55, 451). 691 NA.

- MRPS31 through MRPS35:

  Geometry, plausible values 1-5. Type: numeric. Range approximately
  (114, 431). 691 NA.

- MRPS41 through MRPS45:

  Data analysis/probability, plausible values 1-5. Type: numeric. Range
  approximately (91, 438). 691 NA.

- MRPS51 through MRPS55:

  Algebra, plausible values 1-5. Type: numeric. Range approximately
  (100, 429). 691 NA.

- MRPCM1 through MRPCM5:

  Composite (overall) mathematics proficiency, plausible values 1-5.
  Type: numeric. Range approximately (115, 411). 691 NA. Mean
  approximately 276.

Mathematics assessment items: Variables with the `M0xxxxx` and `M1xxxxx`
prefix are individual mathematics item responses, organized into
booklet-specific blocks. Each item is scored with values typically
ranging from 0 to 9, where low values represent correct/partially
correct responses, high values (8, 9) represent not reached or omitted,
and 0 may indicate incorrect. There are approximately 190 such item
variables, each with approximately 14,178 to 14,284 NA values
(reflecting the matrix-sampled booklet design where each student
receives only a subset of items).

Teacher questionnaire items (T-prefix, 2,515 NA each):

- YRSEXP:

  Teacher years of experience. Type: numeric. Range: (1, 8).

- YRSMATH:

  Teacher years teaching math. Type: numeric. Range: (1, 8).

- T089401:

  Teacher certification item. Type: numeric. Range: (0, 8).

- T088001:

  Teacher education level item. Type: numeric. Range: (1, 8).

Variables `T090801` through `T090806` are teacher practice items (rated
1-8), and `T087501` through `T091504` are additional teacher survey
items. All have 2,515 NA values.

School questionnaire items (C-prefix, 897 NA each):

- C052601:

  School urbanicity. Type: numeric. Range: (1, 8).

- C052701:

  School type (public/private). Type: numeric. Range: (1, 8).

- C046501:

  School enrollment size. Type: numeric. Range: (1, 88).

Variables `C052801` through `C052808` are school demographic composition
items, and `C044006`, `C044007`, `C052901`, `C053001`, `C053101` are
additional school characteristics. All have 897 NA values.

## Source

National Center for Education Statistics (NCES). National Assessment of
Educational Progress (NAEP), 2005 Mathematics Assessment. U.S.
Department of Education. Original data file: `naep.dta`

## Details

This dataset illustrates the analysis of large-scale educational
assessment data with complex survey designs. The NAEP uses a
matrix-sampled booklet design where each student responds to a subset of
items, and proficiency is reported through plausible values (multiple
imputations of the latent ability distribution). Proper analysis
requires using all five plausible values and applying jackknife
replicate weights for variance estimation. Key analyses include:
weighted regression of composite math proficiency on demographic
predictors, survey-weighted group comparisons, and understanding the
plausible values methodology.

## Examples

``` r
data(naep)
# Weighted mean of first plausible value for composite math
weighted.mean(naep$MRPCM1, naep$ORIGWT, na.rm = TRUE)
#> [1] 276.029
# Simple regression of composite math on sex
lm(MRPCM1 ~ DSEX, data = naep)
#> 
#> Call:
#> lm(formula = MRPCM1 ~ DSEX, data = naep)
#> 
#> Coefficients:
#> (Intercept)         DSEX  
#>    277.0124      -0.7687  
#> 
```
