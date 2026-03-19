# Bureau of Labor Statistics March 2000 CPS Individual Data

Individual-level data from the March 2000 Annual Demographic Supplement
of the Current Population Survey (CPS), conducted by the Bureau of Labor
Statistics (BLS). The sample includes 55,899 respondents with
information on earnings, education, sex, age, and job sector. This
large-scale survey dataset is used to illustrate interactions between
dummy variables (sex and job sector) in predicting income, and to
demonstrate two-way ANOVA via regression with unbalanced observational
data.

## Usage

``` r
individuals
```

## Format

A tibble with 55,899 rows and 6 columns:

- id:

  Individual identifier. Type: numeric. Range: (1, 55899).

- age:

  Age in years. Type: numeric. Range: (25, 65).

- educ:

  Education level. Type: numeric. Values: 1 = less than high school, 2 =
  high school diploma, 3 = some college, 4 = bachelor's degree, 5 =
  master's degree, 6 = professional/doctoral degree.

- sex:

  Sex of respondent. Type: numeric. Values: 1 = male, 2 = female.

- earn:

  Total annual earnings from all sources, in U.S. dollars. Type:
  numeric. Range: (-24998, 425510). Mean approximately \$37,865.

- job:

  Job sector. Type: numeric. Values: 5 = government, 6 = private sector,
  7 = self-employed.

## Source

U.S. Bureau of Labor Statistics. Current Population Survey, March 2000
Annual Demographic Supplement. U.S. Census Bureau. Original data file:
`individuals.dta`

## Details

This dataset is used in Chapter 5 (Interactions) to demonstrate
interactions between two dummy variables. The primary analysis focuses
on respondents with postgraduate degrees aged 30-40 working in the
private sector or government, examining how income depends on sex and
job sector. Key concepts illustrated include: interaction between dummy
variables, two-way ANOVA via regression, interaction diagrams,
unbalanced designs and the distinction between Type II and Type III sums
of squares, and interpretation of interaction coefficients as
differences in differences.

## Examples

``` r
data(individuals)
# Subset to postgraduate, ages 30-40, private/government
sub <- individuals[individuals$educ >= 5 &
                   individuals$age >= 30 &
                   individuals$age <= 40 &
                   individuals$job %in% c(5, 6), ]
sub$male <- ifelse(sub$sex == 1, 1, 0)
sub$private <- ifelse(sub$job == 6, 1, 0)
# Interaction model for income
lm(earn ~ male * private, data = sub)
#> 
#> Call:
#> lm(formula = earn ~ male * private, data = sub)
#> 
#> Coefficients:
#>  (Intercept)          male       private  male:private  
#>        42283         23849         -6324        -12922  
#> 
```
