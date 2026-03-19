# GCSE and London Reading Test Data

Student achievement data from 65 London secondary schools, containing
GCSE (General Certificate of Secondary Education) exam scores taken at
age 16 and London Reading Test (LRT) scores at age 11 for 4,059
students. Both scores have been standardized to have mean 0 and standard
deviation approximately 10. This is the primary running example
throughout the course, used from simple linear regression through
interactions and model diagnostics.

## Usage

``` r
gcse
```

## Format

A tibble with 4,059 rows and 9 columns:

- school:

  School identifier. Type: numeric. Values: 1 to 65. 65 unique London
  secondary schools.

- student:

  Student identifier within school. Type: numeric. Range: (1, 913). Not
  unique across schools.

- gcse:

  GCSE examination score at age 16, standardized. Type: numeric. Range:
  (-36.66, 36.66). Mean approximately 0, SD approximately 10. This is
  the primary outcome variable.

- lrt:

  London Reading Test score at age 11, standardized. Type: numeric.
  Range: (-29.35, 30.16). Mean approximately 0, SD approximately 10.
  This is the primary predictor for intake achievement.

- gender:

  Gender of student. Type: numeric. Binary indicator (0/1) where 1 =
  female, 0 = male. 60% female.

- pred:

  Predicted GCSE score from the regression model. Type: numeric. Range:
  (-1.91, 2.54). Pre-computed predicted values.

- u0:

  School-level random intercept. Type: numeric. Contains large negative
  placeholder values (-1e30) for most schools, indicating unestimated or
  filtered values. Valid range approximately (-0.65, 0.65) for estimated
  schools.

- u1:

  School-level random slope for LRT. Type: numeric. Contains large
  negative placeholder values (-1e30) for most schools. Valid range
  approximately (-0.35, 0.35) for estimated schools.

- filter\_\_:

  Filter variable. Type: numeric. Binary indicator (0/1) where 1 =
  included in a specific analysis subset (2% of observations), 0 = not
  included.

## Source

Goldstein, H., Rasbash, J., et al. London school effectiveness study
data. Original data file: `gcse.dta`

## Details

This dataset is the primary running example used throughout the course.
It appears in virtually every chapter:

**Chapter 1 (Simple Linear Regression):** Regressing GCSE on LRT for
individual schools (e.g., Battersea, Chelsea) to introduce the
regression model, OLS estimation, R-squared, and inference.

**Chapter 2 (ANCOVA):** Comparing schools while controlling for LRT
intake scores. The unadjusted difference between Chelsea and Battersea
is 9.86 points, but the LRT-adjusted difference is 7.51.

**Chapter 5 (Interactions):** Testing whether the LRT slope differs
across schools (school-by-LRT interaction).

**Chapter 8 (Model Diagnostics):** Residual analysis, outlier detection,
and influence diagnostics.

The variables u0, u1, pred, and filter\_\_ are pre-computed model
outputs included for pedagogical purposes. For standard regression
analyses, the key variables are gcse, lrt, school, and gender.

## Examples

``` r
data(gcse)
head(gcse)
#> # A tibble: 6 × 9
#>   school student   gcse    lrt gender   pred     u0     u1 filter__
#>    <dbl>   <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>    <dbl>
#> 1      1     143   2.61   6.19      1  0.785 0.375  0.125         0
#> 2      1     145   1.34   2.06      1  0.504 0.470  0.165         0
#> 3      1     142 -17.2  -13.6       0 -0.567 0.480  0.0809        0
#> 4      1     141   9.68   2.06      1  0.504 0.0350 0.127         0
#> 5      1     138   5.44   3.71      1  0.616 0.246  0.0721        0
#> 6      1     155  17.3   21.9       0  1.86  0.518  0.0586        0

# Simple linear regression: GCSE on LRT
lm(gcse ~ lrt, data = gcse)
#> 
#> Call:
#> lm(formula = gcse ~ lrt, data = gcse)
#> 
#> Coefficients:
#> (Intercept)          lrt  
#>    -0.01195      0.59506  
#> 

# ANCOVA: school differences controlling for LRT
gcse_sub <- gcse[gcse$school %in% c(1, 2), ]
lm(gcse ~ lrt + factor(school), data = gcse_sub)
#> 
#> Call:
#> lm(formula = gcse ~ lrt + factor(school), data = gcse_sub)
#> 
#> Coefficients:
#>     (Intercept)              lrt  factor(school)2  
#>          3.7937           0.7332           1.1402  
#> 

# Interaction: does LRT slope differ by gender?
lm(gcse ~ lrt * gender, data = gcse)
#> 
#> Call:
#> lm(formula = gcse ~ lrt * gender, data = gcse)
#> 
#> Coefficients:
#> (Intercept)          lrt       gender   lrt:gender  
#>   -1.030480     0.592813     1.699015    -0.004031  
#> 
```
