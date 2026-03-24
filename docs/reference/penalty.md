# Death Penalty Sentencing Data

Data on 674 homicide cases examining the relationship between death
penalty sentencing, defendant race, and victim race. This dataset is a
classic example in categorical data analysis used to illustrate logistic
regression goodness-of-fit testing, the effects of confounding
variables, and Simpson's paradox in the context of criminal justice. The
data show that the victim's race is a stronger predictor of death
penalty sentencing than the defendant's race.

## Usage

``` r
penalty
```

## Format

A tibble with 674 rows and 3 columns:

- def_bl:

  Defendant race indicator. Type: numeric. Binary (0/1) where 1 = Black
  defendant, 0 = White defendant.

- vic_bl:

  Victim race indicator. Type: numeric. Binary (0/1) where 1 = Black
  victim, 0 = White victim.

- death_pe:

  Death penalty sentencing outcome. Type: numeric. Binary (0/1) where 1
  = death penalty imposed, 0 = no death penalty.

## Source

Agresti, A. (2002). *Categorical Data Analysis* (2nd ed.). Wiley. Based
on data from Radelet, M. L. (1981). Racial characteristics and the
imposition of the death penalty. *American Sociological Review*, 46(6),
918-927. Original data file: `penalty.dta`

## Details

This dataset is used in Chapter 11 (Multiple Logistic Regression: Model
Fit and Diagnostics) to illustrate goodness-of-fit tests for logistic
regression models, including the Pearson chi-squared test and the
likelihood ratio test (deviance). The main-effects model with defendant
and victim race is tested against the saturated model. Key analyses
include: logistic regression with two binary predictors, Pearson and
deviance goodness-of-fit statistics, cross-tabulation of observed versus
expected frequencies, and assessment of whether the main-effects model
is adequate (it fits well, with Pearson X-squared = 0.20, p = 0.66).

## Examples

``` r
data(penalty)
head(penalty)
#> # A tibble: 6 × 3
#>   def_bl vic_bl death_pe
#>    <int>  <int>    <int>
#> 1      0      0        0
#> 2      0      1        0
#> 3      0      0        0
#> 4      0      0        0
#> 5      0      0        0
#> 6      0      0        0
# Logistic regression: death penalty ~ defendant race + victim race
glm(death_pe ~ def_bl + vic_bl, family = binomial, data = penalty)
#> 
#> Call:  glm(formula = death_pe ~ def_bl + vic_bl, family = binomial, 
#>     data = penalty)
#> 
#> Coefficients:
#> (Intercept)       def_bl       vic_bl  
#>     -2.0595       0.8678      -2.4044  
#> 
#> Degrees of Freedom: 673 Total (i.e. Null);  671 Residual
#> Null Deviance:       440.8 
#> Residual Deviance: 419   AIC: 425
```
