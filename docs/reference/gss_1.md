# General Social Survey Data

A subset of 2,832 respondents from the General Social Survey (GSS),
containing variables on social attitudes, demographics, and behaviors.
The GSS is a nationally representative survey of U.S. adults that has
been conducted since 1972. This subset includes measures of attitudes
toward abortion, cohabitation, political conservatism, religiosity, and
demographic characteristics. It is used extensively for logistic
regression examples in the course.

## Usage

``` r
gss_1
```

## Format

A tibble with 2,832 rows and 16 columns:

- abortion:

  Abortion attitude scale. Type: numeric. Range: (0, 7). Count of the
  number of conditions (out of 7) under which the respondent believes
  abortion should be legal. Higher values indicate more permissive
  attitudes. NA = 964.

- cohabit:

  Attitude toward cohabitation. Type: numeric. Range: (2, 10). Higher
  values indicate more favorable attitudes toward cohabitation. NA =
  1,571.

- income:

  Household income category. Type: numeric. Range: (1, 23). Ordinal
  income brackets where higher values indicate higher income. NA = 983.

- conserv:

  Political conservatism. Type: numeric. Range: (1, 7). 7-point scale
  where 1 = extremely liberal and 7 = extremely conservative. NA = 141.

- educat:

  Respondent's years of education. Type: numeric. Range: (0, 20). Mean =
  13.25. NA = 12.

- male:

  Sex of respondent. Type: numeric. Binary indicator (0/1) where 1 =
  male, 0 = female. 44% male.

- maed:

  Mother's years of education. Type: numeric. Range: (0, 20). Mean =
  11.46. NA = 433.

- paed:

  Father's years of education. Type: numeric. Range: (0, 20). Mean =
  11.34. NA = 791.

- marital:

  Marital status. Type: numeric. Values: 1, 2, 3, 4, 5. Where 1 =
  married, 2 = widowed, 3 = divorced, 4 = separated, 5 = never married.
  NA = 1.

- partnrs5:

  Number of sexual partners in the last 5 years. Type: numeric. Range:
  (0, 8). Where 8 = 8 or more. NA = 495.

- respage:

  Respondent's age in years. Type: numeric. Range: (18, 89). Mean =
  45.6.

- race:

  Race of respondent. Type: numeric. Values: 1, 2, 3. Where 1 = White, 2
  = Black, 3 = Other.

- black:

  Black racial identification. Type: numeric. Binary indicator (0/1)
  where 1 = Black, 0 = not Black. 14% Black.

- othrace:

  Other race identification. Type: numeric. Binary indicator (0/1) where
  1 = Other race (not White or Black), 0 = White or Black. 7% Other.

- relosity:

  Religiosity composite score. Type: numeric. Range: (-8.68, 4.16). Mean
  approximately 0. Standardized composite measure of religious behavior
  and attitudes. Higher values indicate greater religiosity.

- religion:

  Religious affiliation. Type: numeric. Values: 1, 2, 3, 4, 5. Where 1 =
  Protestant, 2 = Catholic, 3 = Jewish, 4 = None, 5 = Other. NA = 35.

## Source

Smith, T. W., Davern, M., Stier, J., & Marsden, P. V. *General Social
Surveys, 1972-2018*. National Opinion Research Center (NORC) at the
University of Chicago. Original data file: `gss_1.dta`

## Details

This dataset is used in Chapters 9-11 (Simple and Multiple Logistic
Regression, Model Fit and Diagnostics) for logistic regression examples.
Key analyses include: modeling agreement with social policy statements
as a function of year (illustrated with a dummy variable for survey
year), computing and interpreting odds ratios, and examining how
attitudes toward abortion relate to conservatism, education, and
religiosity.

The dataset has substantial missing data on several variables (e.g.,
cohabit with 55% missing, abortion with 34% missing), providing
opportunities to discuss missing data handling and its impact on
regression analysis.

## Examples

``` r
data(gss_1)
head(gss_1)
#> # A tibble: 6 × 16
#>   abortion cohabit income conserv educat  male  maed  paed marital partnrs5
#>      <dbl>   <int>  <int>   <int>  <int> <int> <int> <int>   <int>    <int>
#> 1    NA          7     18       4     12     1    12    12       3        1
#> 2    NA          9     11       2     17     0    NA    20       5        0
#> 3    NA          3     21       6     12     1    12    12       1        1
#> 4     3          8     11       2     13     1    12    NA       5        7
#> 5     7         NA     18       4     16     0    12    NA       5        2
#> 6     5.60      NA     NA       4     16     1     6     9       3        5
#> # ℹ 6 more variables: respage <dbl>, race <int>, black <int>, othrace <int>,
#> #   relosity <dbl>, religion <int>

# Logistic regression: conservatism predicting abortion attitude
gss_1$pro_abortion <- as.integer(gss_1$abortion >= 4)
glm(pro_abortion ~ conserv, data = gss_1, family = binomial)
#> 
#> Call:  glm(formula = pro_abortion ~ conserv, family = binomial, data = gss_1)
#> 
#> Coefficients:
#> (Intercept)      conserv  
#>      1.6297      -0.3908  
#> 
#> Degrees of Freedom: 1765 Total (i.e. Null);  1764 Residual
#>   (1066 observations deleted due to missingness)
#> Null Deviance:       2448 
#> Residual Deviance: 2324  AIC: 2328

# Multiple regression: education and religiosity on abortion attitudes
lm(abortion ~ educat + relosity + conserv, data = gss_1)
#> 
#> Call:
#> lm(formula = abortion ~ educat + relosity + conserv, data = gss_1)
#> 
#> Coefficients:
#> (Intercept)       educat     relosity      conserv  
#>      3.9630       0.1452      -0.2872      -0.4182  
#> 
```
