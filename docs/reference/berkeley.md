# UC Berkeley Graduate Admissions Data (Five Departments)

Data from UC Berkeley's 1973 graduate admissions across five
departments, with 3,593 individual applicant records. This is the
classic dataset used to demonstrate Simpson's paradox in the context of
logistic regression: the overall association between gender and
admission appears to show bias against women, but this effect reverses
or disappears when controlling for department. The department
identifiers are anonymized.

## Usage

``` r
berkeley
```

## Format

A tibble with 3,593 rows and 3 columns:

- departme:

  Department identifier. Type: numeric. Values: 1, 2, 3, 4, 5. Five
  anonymized departments that differ in their admission rates and gender
  composition of applicants.

- female:

  Sex of applicant. Type: numeric. Binary indicator (0/1) where 1 =
  female, 0 = male. Approximately 48% of applicants are female.

- admitted:

  Admission decision. Type: numeric. Binary indicator (0/1) where 1 =
  admitted, 0 = not admitted. Overall admission rate is 32%.

## Source

Bickel, P. J., Hammel, E. A., & O'Connell, J. W. (1975). Sex bias in
graduate admissions: Data from Berkeley. *Science*, 187(4175), 398-404.
Original data file: `berkeley.dta`

## Details

This dataset is used in Chapters 10-11 (Multiple Logistic Regression and
Model Fit/Diagnostics) to illustrate confounding in logistic regression
and Simpson's paradox. Key analyses include: computing odds ratios for
admission by gender within and across departments, fitting multiple
logistic regression models with department as a control variable,
performing likelihood ratio tests, and chi-squared goodness-of-fit
tests.

Note that this dataset uses `female` as the gender indicator (1 =
female), whereas `berk_sub` uses `male` (1 = male). The department
variable is coded numerically (1-5) rather than by department name.

## Examples

``` r
data(berkeley)
head(berkeley)
#> # A tibble: 6 × 3
#>   departme female admitted
#>      <dbl>  <dbl>    <dbl>
#> 1        1      0        0
#> 2        1      1        0
#> 3        2      0        0
#> 4        2      1        0
#> 5        3      0        0
#> 6        3      1        0

# Unadjusted model: gender only
glm(admitted ~ female, data = berkeley, family = binomial)
#> 
#> Call:  glm(formula = admitted ~ female, family = binomial, data = berkeley)
#> 
#> Coefficients:
#> (Intercept)       female  
#>     -0.5424      -0.4472  
#> 
#> Degrees of Freedom: 3592 Total (i.e. Null);  3591 Residual
#> Null Deviance:       4511 
#> Residual Deviance: 4472  AIC: 4476

# Adjusted model: controlling for department
glm(admitted ~ female + factor(departme), data = berkeley, family = binomial)
#> 
#> Call:  glm(formula = admitted ~ female + factor(departme), family = binomial, 
#>     data = berkeley)
#> 
#> Coefficients:
#>       (Intercept)             female  factor(departme)2  factor(departme)3  
#>           0.54418           -0.03069           -1.14008           -1.19456  
#> factor(departme)4  factor(departme)5  
#>          -1.61308           -3.20527  
#> 
#> Degrees of Freedom: 3592 Total (i.e. Null);  3587 Residual
#> Null Deviance:       4511 
#> Residual Deviance: 3974  AIC: 3986
```
