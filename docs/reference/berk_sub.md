# UC Berkeley Graduate Admissions Subset (Engineering and Psychology)

A subset of UC Berkeley's 1973 graduate admissions data, restricted to
two departments (Engineering and Psychology) with 1,169 applicants. This
streamlined version of the Berkeley data is used to illustrate Simpson's
paradox and confounding in multiple logistic regression, where the
apparent association between gender and admission reverses after
controlling for department.

## Usage

``` r
berk_sub
```

## Format

A tibble with 1,169 rows and 3 columns:

- admitted:

  Admission decision. Type: numeric. Binary indicator (0/1) where 1 =
  admitted, 0 = not admitted. This is the primary outcome variable.
  Overall admission rate is 44%.

- male:

  Sex of applicant. Type: numeric. Binary indicator (0/1) where 1 =
  male, 0 = female. Approximately 64% of applicants are male.

- engineering:

  Department applied to. Type: numeric. Binary indicator (0/1) where 1 =
  Engineering, 0 = Psychology. The two departments differ substantially
  in both gender composition and admission rates.

## Source

Bickel, P. J., Hammel, E. A., & O'Connell, J. W. (1975). Sex bias in
graduate admissions: Data from Berkeley. *Science*, 187(4175), 398-404.
Original data file: `berk_sub.dta`

## Details

This dataset is used in Chapter 10 (Multiple Logistic Regression) to
illustrate confounding and omitted variable bias in logistic regression.
Key analyses include: computing unadjusted odds ratios for admission by
gender, fitting a multiple logistic regression controlling for
department, and demonstrating how the apparent gender effect (unadjusted
OR = 3.25) largely disappears after adjusting for department (adjusted
OR approximately 1.1).

The Engineering department has a much higher proportion of male
applicants (approximately 96%) compared to Psychology (approximately
33%), and also has a higher overall admission rate (approximately 63%)
than Psychology (approximately 25%). This creates the conditions for
Simpson's paradox: the omitted variable (department) is both correlated
with the predictor (gender) and a predictor of the outcome (admission).

## Examples

``` r
data(berk_sub)
head(berk_sub)
#> # A tibble: 6 × 3
#>   admitted  male engineering
#>      <dbl> <dbl>       <dbl>
#> 1        0     1           1
#> 2        0     0           1
#> 3        0     1           0
#> 4        0     0           0
#> 5        1     1           1
#> 6        1     0           1

# Unadjusted logistic regression: gender effect on admission
glm(admitted ~ male, data = berk_sub, family = binomial)
#> 
#> Call:  glm(formula = admitted ~ male, family = binomial, data = berk_sub)
#> 
#> Coefficients:
#> (Intercept)         male  
#>      -1.017        1.180  
#> 
#> Degrees of Freedom: 1168 Total (i.e. Null);  1167 Residual
#> Null Deviance:       1605 
#> Residual Deviance: 1520  AIC: 1524

# Adjusted logistic regression: controlling for department
glm(admitted ~ male + engineering, data = berk_sub, family = binomial)
#> 
#> Call:  glm(formula = admitted ~ male + engineering, family = binomial, 
#>     data = berk_sub)
#> 
#> Coefficients:
#> (Intercept)         male  engineering  
#>     -1.1309       0.1241       1.5551  
#> 
#> Degrees of Freedom: 1168 Total (i.e. Null);  1166 Residual
#> Null Deviance:       1605 
#> Residual Deviance: 1428  AIC: 1434
```
