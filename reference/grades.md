# Essay Grades and Writing Features

Data on 198 student essays, including the assigned grade and various
quantitative writing features such as word length, sentence length,
comma usage, grammatical errors, and preposition usage. This dataset is
useful for exploring multiple regression with continuous predictors and
for model building exercises aimed at predicting essay quality from
measurable text features.

## Usage

``` r
grades
```

## Format

A tibble with 198 rows and 8 columns:

- essay:

  Essay identifier. Type: numeric. Range: (1, 198). Sequential
  identifier for each essay.

- grade:

  Essay grade assigned by instructor. Type: numeric. Values: 1, 2, 3, 4.
  Ordinal scale where higher values indicate better grades (e.g., 1 =
  lowest, 4 = highest). Mean = 2.28.

- wordlength:

  Average word length (characters per word). Type: numeric. Range:
  (3.64, 5.30). Mean = 4.36. Longer average words may indicate more
  sophisticated vocabulary.

- sqrtwords:

  Square root of the total word count. Type: numeric. Range: (3.32,
  16.79). Mean = 9.38. The square root transformation is used to reduce
  skewness of the raw word count.

- commas:

  Comma usage rate (commas per 100 words). Type: numeric. Range: (0.00,
  14.70). Mean = 2.48. Higher values indicate more frequent comma use.

- errors:

  Error rate (grammatical/spelling errors per 100 words). Type: numeric.
  Range: (0.00, 9.85). Mean = 1.99. Higher values indicate more errors.

- prepos:

  Preposition usage rate (prepositions per 100 words). Type: numeric.
  Range: (0.00, 17.80). Mean = 9.78. Moderate preposition use is typical
  of academic writing.

- sentlength:

  Average sentence length (words per sentence). Type: numeric. Range:
  (6.69, 45.45). Mean = 17.41. Longer sentences may indicate more
  complex writing.

## Source

Essay grading data from a writing assessment study. Original data file:
`grades.dta`

## Details

This dataset is used for model building exercises (Chapter 7) and as an
example of regression with ordinal outcomes (Chapter 13). Key analyses
include: building a multiple regression model to predict essay grade
from writing features, forward selection and backward elimination to
identify the most important predictors, and ordinal regression treating
grade as an ordered response. The dataset illustrates the challenge of
predicting a subjective outcome (essay grade) from objective text
features.

## Examples

``` r
data(grades)
head(grades)
#> # A tibble: 6 × 8
#>   essay grade wordlength sqrtwords commas errors prepos sentlength
#>   <int> <int>      <dbl>     <dbl>  <dbl>  <dbl>  <dbl>      <dbl>
#> 1     1     3       4.76     15.5    5.60   5.55    8         19.5
#> 2     2     3       4.24      9.06   3.60   1.27    9.5       16.4
#> 3     3     1       4.09     16.2    1.10   2.61   14         18.4
#> 4     4     2       4.36      7.55   1.80   1.81    0         14.6
#> 5     5     1       4.31      9.64   2.30   0      10         18.7
#> 6     6     3       4.51     11.9    1.30   0      11.1       20.0

# Multiple regression: predicting grade from writing features
lm(grade ~ wordlength + sqrtwords + errors + sentlength, data = grades)
#> 
#> Call:
#> lm(formula = grade ~ wordlength + sqrtwords + errors + sentlength, 
#>     data = grades)
#> 
#> Coefficients:
#> (Intercept)   wordlength    sqrtwords       errors   sentlength  
#>   -3.066849     0.776477     0.225671    -0.124213     0.005582  
#> 

# Ordinal logistic regression
if (requireNamespace("MASS", quietly = TRUE)) {
  MASS::polr(factor(grade) ~ wordlength + errors + sentlength,
             data = grades)
}
#> Call:
#> MASS::polr(formula = factor(grade) ~ wordlength + errors + sentlength, 
#>     data = grades)
#> 
#> Coefficients:
#>  wordlength      errors  sentlength 
#>  1.21867997 -0.22665852  0.02145606 
#> 
#> Intercepts:
#>      1|2      2|3      3|4 
#> 4.541847 5.620690 6.641347 
#> 
#> Residual Deviance: 520.9222 
#> AIC: 532.9222 
```
