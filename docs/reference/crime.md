# Florida County Crime Rates

Crime rate data for 67 Florida counties, including measures of crime
prevalence, education levels, high school completion rates, and
urbanization. This dataset is a central example in the course for
demonstrating multiple regression with two continuous predictors,
confounding/omitted variable bias, partial correlations, and interaction
effects between continuous variables.

## Usage

``` r
crime
```

## Format

A tibble with 67 rows and 5 columns:

- county:

  County name. Type: character. 67 unique Florida counties (e.g.,
  ALACHUA, BAKER, BAY, BRADFORD, BREVARD, BROWARD).

- c:

  Crime rate: number of crimes per year per 1,000 population. Type:
  numeric. Range: (0, 128). Mean = 52.4. This is the primary outcome
  variable.

- i:

  Median household income in thousands of dollars. Type: numeric. Range:
  (15.4, 35.6). Mean = 24.5.

- hs:

  Education: percentage of adults with at least a high school education.
  Type: numeric. Range: (54.5, 84.9). Mean = 69.5.

- u:

  Urbanization: percentage of the population living in an urban
  environment. Type: numeric. Range: (0.0, 99.6). Mean = 49.6.

## Source

Data on Florida county crime rates. Original data file: `crime.dta`

## Details

This dataset is used in Chapter 4 (Continuous Predictors) and Chapter 5
(Interactions) to illustrate several key regression concepts. Key
analyses include:

**Confounding:** Education has a positive bivariate association with
crime rate (slope = 1.5), but after controlling for urbanization, the
effect reverses to negative (slope = -0.6). This demonstrates omitted
variable bias: urbanization is correlated with both education and crime.

**Partial correlations:** The partial correlation between crime rate and
education controlling for urbanization is -0.15, compared to the Pearson
correlation of 0.47.

**Interaction:** The interaction model \\y = \alpha + \beta_1 x_1 +
\beta_2 x_2 + \beta_3 x_1 x_2\\ shows that the effect of education on
crime depends on the level of urbanization.

## Examples

``` r
data(crime)
head(crime)
#> # A tibble: 6 × 5
#>   county       c     i    hs     u
#>   <chr>    <int> <dbl> <dbl> <dbl>
#> 1 ALACHUA    104  22.1  82.7  73.2
#> 2 BAKER       20  25.8  64.1  21.5
#> 3 BAY         64  24.7  74.7  85  
#> 4 BRADFORD    50  24.6  65    23.2
#> 5 BREVARD     64  30.5  82.3  91.9
#> 6 BROWARD     94  30.6  76.8  98.9

# Simple regression: education appears to increase crime
lm(c ~ hs, data = crime)
#> 
#> Call:
#> lm(formula = c ~ hs, data = crime)
#> 
#> Coefficients:
#> (Intercept)           hs  
#>     -50.857        1.486  
#> 

# Multiple regression: controlling for urbanization reverses the effect
lm(c ~ hs + u, data = crime)
#> 
#> Call:
#> lm(formula = c ~ hs + u, data = crime)
#> 
#> Coefficients:
#> (Intercept)           hs            u  
#>     59.1181      -0.5834       0.6825  
#> 

# Interaction between education and urbanization
lm(c ~ hs * u, data = crime)
#> 
#> Call:
#> lm(formula = c ~ hs * u, data = crime)
#> 
#> Coefficients:
#> (Intercept)           hs            u         hs:u  
#>    19.31754      0.03396      1.51431     -0.01205  
#> 
```
