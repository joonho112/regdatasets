# Canadian Women's Labor Force Participation

Data on labor force participation of 263 married Canadian women,
including work status (not working, part-time, full-time), husband's
income, region of residence, and presence of children. This dataset is a
classic example for ordinal response modeling, as the three-level work
status variable represents an ordered outcome ranging from no labor
force participation to full-time employment.

## Usage

``` r
womenlf
```

## Format

A tibble with 263 rows and 5 columns:

- obs:

  Observation number. Type: numeric. Range: (1, 263).

- husbinc:

  Husband's annual income in thousands of Canadian dollars. Type:
  numeric. Range: (1, 45). Mean approximately \$14,760.

- region:

  Canadian region of residence. Type: character. Levels: "Atlantic" =
  Atlantic provinces, "Quebec" = Quebec, "Ontario" = Ontario, "Prairie"
  = Prairie provinces, "BC" = British Columbia.

- workstat:

  Work status (ordinal response variable). Type: numeric. Values: 0 =
  not working outside the home, 1 = working part-time, 2 = working
  full-time. Ordered from lowest to highest labor force participation.

- chilpres:

  Presence of children in the household. Type: numeric. Binary (0/1)
  where 1 = children present, 0 = no children present.

## Source

Fox, J. (2003). *Applied Regression Analysis and Generalized Linear
Models* (2nd ed.). Sage. Based on data from the 1977 Canadian Survey of
Consumer Finances. Original data file: `womenlf.dta`

## Details

This dataset is used in Chapter 13 (Models for Ordinal Responses) to
illustrate ordinal logistic regression and the proportional odds model.
The three-level ordered outcome (not working, part-time, full-time) is
modeled using cumulative logit links. Key analyses include: fitting the
proportional odds model with husband's income, region, and children
present as predictors, interpreting cumulative odds ratios, testing the
proportional odds assumption, and comparing ordinal logit versus ordinal
probit specifications.

## Examples

``` r
data(womenlf)
head(womenlf)
#> # A tibble: 6 × 5
#>     obs husbinc region  workstat chilpres
#>   <dbl>   <dbl> <chr>      <dbl>    <dbl>
#> 1     1      15 Ontario        0        1
#> 2     2      13 Ontario        0        1
#> 3     3      45 Ontario        0        1
#> 4     4      23 Ontario        0        1
#> 5     5      19 Ontario        0        1
#> 6     6       7 Ontario        0        1
table(womenlf$workstat)
#> 
#>   0   1   2 
#> 155  42  66 
# Ordinal logistic regression (requires MASS package)
# MASS::polr(factor(workstat) ~ husbinc + chilpres, data = womenlf)
```
