# NELS:88 Discipline Study with Achievement Scores

An extended version of the NELS:88 discipline dataset (`disc`) with
2,000 students, including standardized test scores in reading and math,
a composite SES (socioeconomic status) measure, and additional derived
variables. This version uses more intuitive variable names and includes
both base-year and follow-up reading scores, making it suitable for
analyses involving academic achievement as both a predictor and outcome.

## Usage

``` r
disc2
```

## Format

A tibble with 2,000 rows and 15 columns:

- male:

  Sex of student. Type: numeric. Binary indicator (0/1) where 1 = male,
  0 = female. NA = 20.

- notengl:

  Non-English home language. Type: numeric. Binary indicator (0/1) where
  1 = primary home language is not English, 0 = English is primary. NA =
  23.

- bedroom:

  Has own bedroom. Type: numeric. Binary indicator (0/1) where 1 = has
  own bedroom, 0 = does not. NA = 33.

- osentoff:

  Ordinal version of office referral. Type: numeric. Values: 0, 1, 2.
  Where 0 = never, 1 = once or twice, 2 = more than twice. NA = 28.

- ses:

  Composite socioeconomic status score. Type: numeric. Range: (-2.89,
  1.85). Mean = -0.06. Standardized composite of family income, parental
  education, and parental occupation. NA = 1.

- reading1:

  Base-year (8th grade) standardized reading score. Type: numeric.
  Range: (31.95, 70.55). Mean = 50.95. Standardized with mean
  approximately 50 and SD approximately 10. NA = 77.

- math1:

  Base-year (8th grade) standardized math score. Type: numeric. Range:
  (34.10, 77.20). Mean = 51.49. Standardized with mean approximately 50
  and SD approximately 10. NA = 75.

- reading2:

  Follow-up (10th grade) standardized reading score. Type: numeric.
  Range: (30.82, 68.91). Mean = 51.24. NA = 218.

- fath_coll:

  Father has college education. Type: numeric. Binary indicator (0/1)
  where 1 = father has a college degree, 0 = no college degree. NA =
  282.

- fath_ed:

  Father has at least a high school education. Type: numeric. Binary
  indicator (0/1) where 1 = high school or above, 0 = less than high
  school. NA = 282.

- moth_coll:

  Mother has college education. Type: numeric. Binary indicator (0/1)
  where 1 = mother has a college degree, 0 = no college degree. NA =
  208.

- moth_ed:

  Mother has at least a high school education. Type: numeric. Binary
  indicator (0/1) where 1 = high school or above, 0 = less than high
  school. NA = 208.

- minority:

  Minority status. Type: numeric. Binary indicator (0/1) where 1 =
  racial/ethnic minority (non-White), 0 = White. NA = 24.

- race:

  Race/ethnicity. Type: numeric. Values: 1, 2, 3, 4. Where 1 = Asian, 2
  = Hispanic, 3 = Black, 4 = White. NA = 92.

- sentoff:

  Ever sent to the office for misbehavior. Type: numeric. Binary
  indicator (0/1) where 1 = yes, 0 = no. NA = 28.

## Source

National Center for Education Statistics (1988). *National Education
Longitudinal Study of 1988 (NELS:88)*. U.S. Department of Education.
Original data file: `disc2.dta`

## Details

This dataset is used alongside `disc` in Chapters 9-13 (Logistic
Regression and Ordinal Response Models). Key analyses include: examining
the relationship between SES, test scores, and discipline outcomes;
building multiple logistic regression models with continuous and
categorical predictors; and comparing base-year and follow-up reading
scores. The SES composite and standardized test scores provide
continuous predictors for logistic regression, complementing the
categorical predictors in `disc`.

## Examples

``` r
data(disc2)
head(disc2)
#> # A tibble: 6 × 15
#>    male notengl bedroom osentoff     ses reading1 math1 reading2 fath_coll
#>   <int>   <int>   <int>    <int>   <dbl>    <dbl> <dbl>    <dbl>     <int>
#> 1     0       0       1        0 -0.601      66.8  58.6     50.2         0
#> 2     1       0       1        0 -0.0700     58.6  59.8     61.6         0
#> 3     1       0       1        0  0.0960     49.5  49.7     44           0
#> 4     1       0       1        0 -0.715      55.6  49.1     40.7         0
#> 5     0       0       0        1  0.205      56.3  44.5     53.7         0
#> 6     1       0       1        0  0.355      52.2  54.8     43.3         0
#> # ℹ 6 more variables: fath_ed <int>, moth_coll <int>, moth_ed <int>,
#> #   minority <int>, race <fct>, sentoff <int>

# Logistic regression: SES effect on office referral
glm(sentoff ~ ses, data = disc2, family = binomial)
#> 
#> Call:  glm(formula = sentoff ~ ses, family = binomial, data = disc2)
#> 
#> Coefficients:
#> (Intercept)          ses  
#>     -0.9879      -0.3921  
#> 
#> Degrees of Freedom: 1970 Total (i.e. Null);  1969 Residual
#>   (29 observations deleted due to missingness)
#> Null Deviance:       2336 
#> Residual Deviance: 2297  AIC: 2301

# Multiple logistic regression with achievement and demographics
glm(sentoff ~ ses + reading1 + male + minority, data = disc2,
    family = binomial)
#> 
#> Call:  glm(formula = sentoff ~ ses + reading1 + male + minority, family = binomial, 
#>     data = disc2)
#> 
#> Coefficients:
#> (Intercept)          ses     reading1         male     minority  
#>     0.51829     -0.23894     -0.04409      1.23041     -0.01177  
#> 
#> Degrees of Freedom: 1870 Total (i.e. Null);  1866 Residual
#>   (129 observations deleted due to missingness)
#> Null Deviance:       2200 
#> Residual Deviance: 1977  AIC: 1987
```
