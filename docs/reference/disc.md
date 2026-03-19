# NELS:88 Discipline and School Experiences Study

A subset of 2,000 students from the National Education Longitudinal
Study of 1988 (NELS:88), focused on school discipline outcomes and their
predictors. The dataset includes student demographics, family background
variables, and school experience indicators related to disciplinary
actions. Variables use original NELS:88 variable naming conventions
(e.g., bys55a, bys12). This dataset is used for teaching logistic
regression with binary outcomes and handling missing data.

## Usage

``` r
disc
```

## Format

A tibble with 2,000 rows and 15 columns:

- bys55a:

  Frequency of being sent to the office. Type: numeric. Values: 0, 1,
  2, 8. Where 0 = never, 1 = once or twice, 2 = more than twice, 8 =
  missing/not applicable. Mean = 0.47.

- bys12:

  Family composition. Type: numeric. Values: 1, 2, 8. Where 1 =
  two-parent family, 2 = other family structure, 8 = missing/not
  applicable.

- bys31a:

  Hours spent on homework per week. Type: numeric. Range: (1, 8).
  Ordinal scale where higher values indicate more homework hours, 8 =
  missing/not applicable.

- bys34a:

  Self-concept: English ability. Type: numeric. Range: (1, 98). Ordinal
  self-rating, 98 = missing/not applicable.

- bys34b:

  Self-concept: math ability. Type: numeric. Range: (1, 98). Ordinal
  self-rating, 98 = missing/not applicable.

- bys35p:

  Plans after high school. Type: numeric. Values: 1, 2, 3, 8. Where 1 =
  attend college, 8 = missing/not applicable.

- bys36c:

  Importance of good grades. Type: numeric. Range: (1, 8). Ordinal
  scale, 8 = missing/not applicable.

- sentoff:

  Ever sent to the office for misbehavior. Type: numeric. Binary
  indicator (0/1) where 1 = sent to the office at least once, 0 = never
  sent. NA = 28. This is the primary outcome variable for logistic
  regression.

- male:

  Sex of student. Type: numeric. Binary indicator (0/1) where 1 = male,
  0 = female. NA = 20.

- race:

  Race/ethnicity. Type: numeric. Values: 1, 2, 3, 4. Where 1 = Asian, 2
  = Hispanic, 3 = Black, 4 = White. NA = 92.

- fath_ed:

  Father has at least a high school education. Type: numeric. Binary
  indicator (0/1) where 1 = high school or above, 0 = less than high
  school. NA = 282.

- moth_ed:

  Mother has at least a high school education. Type: numeric. Binary
  indicator (0/1) where 1 = high school or above, 0 = less than high
  school. NA = 208.

- bedroom:

  Has own bedroom. Type: numeric. Binary indicator (0/1) where 1 = has
  own bedroom, 0 = does not. NA = 33.

- discuss:

  Frequently discusses school with parents. Type: numeric. Binary
  indicator (0/1) where 1 = frequently discusses, 0 = does not. NA = 33.

- osentoff:

  Ordinal version of sent to office. Type: numeric. Values: 0, 1, 2.
  Where 0 = never, 1 = once or twice, 2 = more than twice. NA = 28. Used
  for ordinal regression models.

## Source

National Center for Education Statistics (1988). *National Education
Longitudinal Study of 1988 (NELS:88)*. U.S. Department of Education.
Original data file: `disc.dta`

## Details

This dataset is used in Chapters 9-13 (Logistic Regression, Multiple
Logistic Regression, Model Fit, and Ordinal Response Models) to
illustrate binary and ordinal logistic regression. Key analyses include:
fitting simple and multiple logistic regression models predicting office
referrals, computing and interpreting odds ratios, likelihood ratio
tests, and ordinal regression using `osentoff` as the outcome.

Note that several variables use NELS:88 coding where 8 or 98 indicates
missing/not applicable rather than NA. The derived binary and ordinal
outcome variables (`sentoff`, `osentoff`) have been recoded with proper
NA values.

## Examples

``` r
data(disc)
head(disc)
#> # A tibble: 6 × 15
#>   bys55a bys12 bys31a bys34a bys34b bys35p bys36c sentoff  male  race fath_ed
#>    <dbl> <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>   <dbl> <dbl> <dbl>   <dbl>
#> 1      0     2      4      1      2      1      3       0     0     4       0
#> 2      0     1      4      2      2      1      3       0     1     4       1
#> 3      0     1      4      3      3      1      2       0     1     4       1
#> 4      0     1      4      2      2      1      3       0     1     4       1
#> 5      1     2      3      2      3      2      2       1     0     3       1
#> 6      0     1      4      4      1      1      3       0     1     4       1
#> # ℹ 4 more variables: moth_ed <dbl>, bedroom <dbl>, discuss <dbl>,
#> #   osentoff <dbl>

# Logistic regression: gender effect on office referral
glm(sentoff ~ male, data = disc, family = binomial)
#> 
#> Call:  glm(formula = sentoff ~ male, family = binomial, data = disc)
#> 
#> Coefficients:
#> (Intercept)         male  
#>      -1.626        1.209  
#> 
#> Degrees of Freedom: 1953 Total (i.e. Null);  1952 Residual
#>   (46 observations deleted due to missingness)
#> Null Deviance:       2313 
#> Residual Deviance: 2179  AIC: 2183

# Multiple logistic regression with demographics
glm(sentoff ~ male + factor(race) + fath_ed, data = disc, family = binomial)
#> 
#> Call:  glm(formula = sentoff ~ male + factor(race) + fath_ed, family = binomial, 
#>     data = disc)
#> 
#> Coefficients:
#>   (Intercept)           male  factor(race)2  factor(race)3  factor(race)4  
#>       -1.6235         1.2178         0.3775         1.2273         0.3771  
#>       fath_ed  
#>       -0.5617  
#> 
#> Degrees of Freedom: 1605 Total (i.e. Null);  1600 Residual
#>   (394 observations deleted due to missingness)
#> Null Deviance:       1892 
#> Residual Deviance: 1752  AIC: 1764
```
