# Satisfaction Survey Data

Ordinal survey data from 110 respondents measuring job or life
satisfaction on a 4-point scale, along with gender and income level.
Used in regression teaching to illustrate ordinal logistic regression
(proportional odds model), the cumulative link formulation, and the
proportional odds assumption with a simple, interpretable dataset.

## Usage

``` r
satisfaction
```

## Format

A tibble with 110 rows and 3 columns:

- gender:

  Respondent gender. Type: character. Values: "F" = female, "M" = male.

- income:

  Income level (ordinal). Type: numeric. Values: 1 = low, 2 =
  medium-low, 3 = medium-high, 4 = high.

- satisfaction:

  Satisfaction rating (ordinal response variable). Type: numeric.
  Values: 1 = not satisfied, 2 = slightly satisfied, 3 = satisfied, 4 =
  very satisfied.

## Source

Simulated survey data for pedagogical purposes. Original data file:
`satisfaction.dta`

## Details

This dataset is used in Chapter 13 (Models for Ordinal Responses) to
illustrate the ordinal logistic regression (proportional odds) model.
The 4-level satisfaction outcome is modeled using the cumulative logit
formulation. Key analyses include: fitting the proportional odds model
with gender and income as predictors, interpreting cumulative odds
ratios, testing the proportional odds assumption, comparing ordinal
logit and ordinal probit models, and examining threshold (cut-point)
estimates.

## Examples

``` r
data(satisfaction)
head(satisfaction)
#> # A tibble: 6 × 3
#>   gender income satisfaction
#>   <chr>   <dbl>        <dbl>
#> 1 F           1            1
#> 2 F           2            1
#> 3 F           3            1
#> 4 F           4            1
#> 5 M           1            1
#> 6 M           2            1
table(satisfaction$satisfaction, satisfaction$gender)
#>    
#>      F  M
#>   1  5  4
#>   2  9  6
#>   3 40 23
#>   4 12 11
# Ordinal logistic regression (requires MASS package)
# MASS::polr(factor(satisfaction) ~ income + gender, data = satisfaction)
```
