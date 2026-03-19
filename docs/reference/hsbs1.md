# High School and Beyond Survey (Full Sample)

Data from the High School and Beyond (HS&B) longitudinal study, a
nationally representative survey of U.S. high school students conducted
by the National Center for Education Statistics (NCES). This full sample
of 350 students includes academic achievement scores, socioeconomic
status, and school program information. Used in regression teaching to
illustrate model diagnostics, multicollinearity among correlated
achievement measures, and multiple regression with both continuous and
categorical predictors.

## Usage

``` r
hsbs1
```

## Format

A tibble with 350 rows and 16 columns:

- id:

  Student identifier. Type: numeric. Range: (1, 599).

- gender:

  Student gender. Type: numeric. Values: 1 = male, 2 = female.

- race:

  Student race/ethnicity. Type: numeric. Values: 1 = Hispanic, 2 =
  Asian, 3 = African American, 4 = White.

- ses:

  Socioeconomic status. Type: numeric. Values: 1 = low, 2 = middle, 3 =
  high.

- sch:

  School type. Type: numeric. Values: 1 = public, 2 = private.

- prog:

  Academic program. Type: numeric. Values: 1 = general, 2 = academic, 3
  = vocational.

- locus:

  Locus of control composite score. Type: numeric. Range: (-2.23, 1.36).
  Higher values indicate more internal locus of control.

- concept:

  Self-concept composite score. Type: numeric. Range: (-2.62, 1.19).
  Higher values indicate more positive self-concept.

- mot:

  Motivation. Type: numeric. Range: (0, 1). Proportion-based measure of
  academic motivation.

- career:

  Career choice code. Type: numeric. Range: (1, 17). Categorical code
  for intended career.

- read:

  Reading achievement test score (standardized). Type: numeric. Range:
  (28.3, 73.3). Mean approximately 52.

- write:

  Writing achievement test score (standardized). Type: numeric. Range:
  (28.1, 67.1). Mean approximately 52.

- math:

  Mathematics achievement test score (standardized). Type: numeric.
  Range: (31.8, 75.5). Mean approximately 51.

- sci:

  Science achievement test score (standardized). Type: numeric. Range:
  (26.0, 74.2). Mean approximately 52.

- ss:

  Social studies achievement test score (standardized). Type: numeric.
  Range: (25.7, 70.5). Mean approximately 52.

- sample:

  Sample weight indicator. Type: numeric. Constant value of 1 for all
  observations in this subsample.

## Source

National Center for Education Statistics (NCES). High School and Beyond
(HS&B) Longitudinal Study. U.S. Department of Education. Original data
file: `hsbs1.dta`

## Details

This dataset is used in Chapter 8 (Model Diagnostics) to illustrate
regression diagnostic techniques including residual analysis, leverage
and influence measures, and detection of outliers. It also serves as a
demonstration dataset for model building with multiple correlated
predictors (the five achievement test scores) and for examining the
effects of categorical predictors such as program type and SES on
academic outcomes. Key analyses include: multiple regression of writing
scores on reading and math, residual plots, Cook's distance, leverage
diagnostics, and VIF assessment for multicollinearity.

## Examples

``` r
data(hsbs1)
head(hsbs1)
#> # A tibble: 6 × 16
#>      id gender  race   ses   sch  prog  locus concept   mot career  read write
#>   <dbl>  <dbl> <dbl> <dbl> <dbl> <dbl>  <dbl>   <dbl> <dbl>  <dbl> <dbl> <dbl>
#> 1   303      2     4     1     1     1 -0.840 -0.240  1          4  54.8  64.5
#> 2   404      2     4     2     1     1 -0.380 -0.470  0.670      4  62.7  43.7
#> 3   225      1     4     2     1     2  0.890  0.590  0.670      6  60.6  56.7
#> 4   553      1     4     2     2     2  0.710  0.280  0.670     16  62.7  56.7
#> 5   433      2     4     2     1     3 -0.640  0.0300 1          4  41.6  46.3
#> 6   189      2     4     3     1     2  1.11   0.900  0.330      6  62.7  64.5
#> # ℹ 4 more variables: math <dbl>, sci <dbl>, ss <dbl>, sample <dbl>
# Multiple regression of writing on reading and math
fit <- lm(write ~ read + math, data = hsbs1)
summary(fit)
#> 
#> Call:
#> lm(formula = write ~ read + math, data = hsbs1)
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -18.1588  -4.8532   0.1208   4.9720  17.4686 
#> 
#> Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept) 13.87143    2.29829   6.036 4.07e-09 ***
#> read         0.35117    0.05323   6.597 1.57e-10 ***
#> math         0.39387    0.05852   6.730 7.01e-11 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 7.205 on 347 degrees of freedom
#> Multiple R-squared:  0.4539, Adjusted R-squared:  0.4507 
#> F-statistic: 144.2 on 2 and 347 DF,  p-value: < 2.2e-16
#> 
```
