# Titanic Passenger Survival Data

Passenger data from the RMS Titanic disaster of April 15, 1912,
containing survival status and demographic information for 1,309
passengers. This widely used dataset illustrates logistic regression
with both continuous and categorical predictors, and serves as a
compelling teaching example of how passenger class, sex, and age
influenced survival probability.

## Usage

``` r
titanic
```

## Format

A tibble with 1,309 rows and 6 columns:

- pclass:

  Passenger class (ticket class). Type: numeric. Values: 1 = 1st class
  (upper), 2 = 2nd class (middle), 3 = 3rd class (lower). Serves as a
  proxy for socioeconomic status.

- survived:

  Survival indicator. Type: numeric. Binary (0/1) where 1 = survived, 0
  = did not survive. Overall survival rate is approximately 38 percent.

- age:

  Passenger age in years. Type: numeric. Range: (0.17, 80.00). 263
  missing values. Fractional ages (e.g., 0.17) represent infants.

- fare:

  Passenger fare in British pounds. Type: numeric. Range: (0.00,
  512.33). 1 missing value. Varies substantially by class.

- embarked:

  Port of embarkation. Type: character. Values: S = Southampton, C =
  Cherbourg, Q = Queenstown (Cobh, Ireland). Two cases have missing
  embarkation port.

- sex:

  Passenger sex indicator. Type: numeric. Binary (0/1) where 1 = female,
  0 = male.

## Source

British Board of Trade (1990). *Report on the Loss of the "Titanic"
(S.S.)*. Compiled from various historical passenger records. Original
data file: `titanic.dta`

## Details

This dataset is used in Chapters 9-11 (Logistic Regression) to
illustrate simple and multiple logistic regression modeling. The
well-known "women and children first" evacuation policy makes this
dataset effective for demonstrating how sex, class, and age predict
binary outcomes. Key analyses include: simple logistic regression of
survival on sex, multiple logistic regression with class and age, odds
ratio interpretation, predicted probabilities, handling missing data in
age, and model comparison using likelihood ratio tests and AIC.

## Examples

``` r
data(titanic)
head(titanic)
#> # A tibble: 6 × 6
#>   pclass survived    age  fare embarked   sex
#>    <dbl>    <dbl>  <dbl> <dbl> <chr>    <dbl>
#> 1      1        1 29     211.  S            1
#> 2      1        1  0.917 152.  S            0
#> 3      1        0  2     152.  S            1
#> 4      1        0 30     152.  S            0
#> 5      1        0 25     152.  S            1
#> 6      1        1 48      26.5 S            0
# Logistic regression: survival predicted by sex and passenger class
glm(survived ~ sex + factor(pclass), family = binomial, data = titanic)
#> 
#> Call:  glm(formula = survived ~ sex + factor(pclass), family = binomial, 
#>     data = titanic)
#> 
#> Coefficients:
#>     (Intercept)              sex  factor(pclass)2  factor(pclass)3  
#>         -0.4059           2.5150          -0.8808          -1.7231  
#> 
#> Degrees of Freedom: 1308 Total (i.e. Null);  1305 Residual
#> Null Deviance:       1741 
#> Residual Deviance: 1257  AIC: 1265
```
