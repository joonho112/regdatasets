# Faculty Salary Data

Salary and career information for 514 faculty members, including years
of experience, academic rank, market conditions, and demographic
variables. This dataset is commonly used to examine gender salary
disparities while controlling for legitimate predictors of salary such
as experience, rank, and market factors. It provides a rich example for
multiple regression with a mix of continuous and binary predictors.

## Usage

``` r
faculty
```

## Format

A tibble with 514 rows and 10 columns:

- salary:

  Annual salary in dollars. Type: numeric. Range: (29,000, 96,156). Mean
  = 50,864. This is the primary outcome variable.

- exprior:

  Years of experience prior to current position. Type: numeric. Range:
  (0, 25). Mean = 2.9.

- yearsbg:

  Years since earning the bachelor's degree. Type: numeric. Range: (0,
  41). Mean = 12.9.

- yearsrank:

  Years at current academic rank. Type: numeric. Range: (0, 28). Mean =
  7.1.

- market:

  Market adjustment factor reflecting disciplinary salary norms. Type:
  numeric. Range: (0.71, 1.33). Mean = 0.95. Values above 1.0 indicate
  fields with above-average market salaries.

- termdeg:

  Holds a terminal degree (e.g., Ph.D.). Type: numeric. Binary indicator
  (0/1) where 1 = holds terminal degree, 0 = does not. 99% hold a
  terminal degree.

- admin:

  Holds an administrative appointment. Type: numeric. Binary indicator
  (0/1) where 1 = has administrative role, 0 = does not. Only 3% have
  administrative roles.

- yearsdg:

  Years since earning the highest degree. Type: numeric. Range: (0, 41).
  Mean = 15.3.

- rank:

  Academic rank. Type: numeric. Values: 1, 2, 3. Where 1 = Assistant
  Professor, 2 = Associate Professor, 3 = Full Professor. Mean = 2.1.

- male:

  Sex of faculty member. Type: numeric. Binary indicator (0/1) where 1 =
  male, 0 = female. 75% are male.

## Source

Faculty salary data from a university compensation study. Original data
file: `faculty.dta`

## Details

This dataset is used in Chapters 4-8 (Multiple Regression with
Continuous Predictors, Interactions, Nonlinear Relationships, Model
Building, and Model Diagnostics). Key analyses include: examining the
gender salary gap while controlling for experience, rank, and market
factors; exploring nonlinear relationships (e.g., diminishing returns to
experience); model building using forward selection and backward
elimination; and regression diagnostics including outlier detection and
influential observations.

Note that the experience variables (exprior, yearsbg, yearsrank,
yearsdg) are correlated with each other and with rank, presenting
opportunities to discuss collinearity. The log transformation of salary
may improve model fit due to the right-skewed salary distribution.

## Examples

``` r
data(faculty)
head(faculty)
#> # A tibble: 6 × 10
#>   salary exprior yearsbg yearsrank market termdeg admin yearsdg  rank  male
#>    <dbl>   <dbl>   <dbl>     <dbl>  <dbl>   <dbl> <dbl>   <dbl> <dbl> <dbl>
#> 1 38362.       0      14         2  0.720       1     0      14     2     0
#> 2 68906        2      29        20  1           1     0      31     3     1
#> 3 55979        0      14         3  1.04        1     0      14     3     1
#> 4 61008        0       3         3  1.24        1     0       2     1     1
#> 5 42977        5       7         1  0.990       1     0      12     2     1
#> 6 51640        4      13         5  0.990       1     0      17     3     0

# Gender salary gap, unadjusted
lm(salary ~ male, data = faculty)
#> 
#> Call:
#> lm(formula = salary ~ male, data = faculty)
#> 
#> Coefficients:
#> (Intercept)         male  
#>       42917        10583  
#> 

# Adjusted for rank, experience, and market
lm(salary ~ male + factor(rank) + yearsdg + market, data = faculty)
#> 
#> Call:
#> lm(formula = salary ~ male + factor(rank) + yearsdg + market, 
#>     data = faculty)
#> 
#> Coefficients:
#>   (Intercept)           male  factor(rank)2  factor(rank)3        yearsdg  
#>         986.8         1084.1         3100.3        11132.8          556.4  
#>        market  
#>       36931.7  
#> 

# Log salary model
lm(log(salary) ~ male + factor(rank) + yearsdg + market, data = faculty)
#> 
#> Call:
#> lm(formula = log(salary) ~ male + factor(rank) + yearsdg + market, 
#>     data = faculty)
#> 
#> Coefficients:
#>   (Intercept)           male  factor(rank)2  factor(rank)3        yearsdg  
#>       9.79315        0.02274        0.09411        0.24440        0.01048  
#>        market  
#>       0.74433  
#> 
```
