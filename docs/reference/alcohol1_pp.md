# Adolescent Alcohol Use Person-Period Data

Longitudinal person-period data from a study of adolescent alcohol use,
tracking 82 adolescents from age 14 to age 16. Each row represents one
person at one time point, resulting in 246 observations (82 persons x 3
occasions). The data include measures of alcohol consumption, peer
alcohol use, and whether the adolescent is a child of an alcoholic
(COA). This dataset is commonly used in multilevel/growth curve modeling
textbooks to illustrate individual growth trajectories and the effects
of time-varying and time-invariant predictors.

## Usage

``` r
alcohol1_pp
```

## Format

A tibble with 246 rows and 9 columns:

- id:

  Person identifier. Type: numeric. Range: (1, 82). Uniquely identifies
  each of the 82 adolescents.

- age:

  Age in years at the time of measurement. Type: numeric. Values: 14,
  15, 16. Three measurement occasions.

- coa:

  Child of an alcoholic. Type: numeric. Binary indicator (0/1) where 1 =
  child of an alcoholic parent, 0 = not a child of an alcoholic.
  Time-invariant predictor.

- male:

  Sex of adolescent. Type: numeric. Binary indicator (0/1) where 1 =
  male, 0 = female. Time-invariant predictor.

- age_14:

  Age centered at 14 (i.e., age minus 14). Type: numeric. Values: 0,
  1, 2. Used as the time variable in growth models so that the intercept
  represents alcohol use at age 14.

- alcuse:

  Alcohol use composite score. Type: numeric. Range: (0.00, 3.61).
  Higher values indicate greater alcohol consumption. This is the
  primary outcome variable.

- peer:

  Peer alcohol use score. Type: numeric. Range: (0.00, 2.53). Mean =
  1.02. Higher values indicate greater peer alcohol use. Time-varying
  covariate.

- cpeer:

  Peer alcohol use, grand-mean centered. Type: numeric. Range: (-1.02,
  1.51). Mean approximately 0. This is the peer variable centered by
  subtracting the grand mean (1.02) to aid interpretation of the
  intercept in regression models.

- ccoa:

  Child of alcoholic, grand-mean centered. Type: numeric. Values: -0.45,
  0.55. Mean approximately 0. This is the COA variable centered by
  subtracting the grand mean (0.45) so that the intercept represents the
  expected outcome for an average person on this predictor rather than
  for a non-COA.

## Source

Singer, J. D., & Willett, J. B. (2003). *Applied Longitudinal Data
Analysis: Modeling Change and Event Occurrence*. Oxford University
Press. Original data file: `alcohol1_pp.dta`

## Details

This dataset is used in Chapters on interactions and multilevel modeling
to illustrate growth curve models and person-period data structures. Key
analyses include: fitting individual growth curves of alcohol use over
time, examining the effects of COA status and peer influence on alcohol
use trajectories, and demonstrating grand-mean centering of predictors.

The centered variables (cpeer, ccoa) illustrate the common practice of
centering predictors to improve interpretability of the intercept in
multilevel and longitudinal models. Grand-mean centering shifts the
meaning of the intercept from the value when all predictors are zero to
the value at the sample average of the predictor.

## Examples

``` r
data(alcohol1_pp)
head(alcohol1_pp)
#> # A tibble: 6 × 9
#>      id   age   coa  male age_14 alcuse  peer  cpeer  ccoa
#>   <dbl> <dbl> <dbl> <dbl>  <dbl>  <dbl> <dbl>  <dbl> <dbl>
#> 1     1    14     1     0      0   1.73 1.26   0.247 0.549
#> 2     1    15     1     0      1   2    1.26   0.247 0.549
#> 3     1    16     1     0      2   2    1.26   0.247 0.549
#> 4     2    14     1     1      0   0    0.894 -0.124 0.549
#> 5     2    15     1     1      1   0    0.894 -0.124 0.549
#> 6     2    16     1     1      2   1    0.894 -0.124 0.549

# Growth model: alcohol use as a function of time and COA status
lm(alcuse ~ age_14 + ccoa, data = alcohol1_pp)
#> 
#> Call:
#> lm(formula = alcuse ~ age_14 + ccoa, data = alcohol1_pp)
#> 
#> Coefficients:
#> (Intercept)       age_14         ccoa  
#>      0.6512       0.2707       0.6938  
#> 

# Interaction between time and centered peer alcohol use
lm(alcuse ~ age_14 * cpeer, data = alcohol1_pp)
#> 
#> Call:
#> lm(formula = alcuse ~ age_14 * cpeer, data = alcohol1_pp)
#> 
#> Coefficients:
#>  (Intercept)        age_14         cpeer  age_14:cpeer  
#>       0.6516        0.2706        0.7588       -0.1514  
#> 
```
