# High School and Beyond Subset

A subset of 188 students from 5 schools drawn from the High School and
Beyond (HSB) study, a nationally representative survey of U.S. high
school students conducted by the National Center for Education
Statistics. The data include student-level variables (math achievement,
SES, demographics) and school-level variables (school size and sector).
This small subset is frequently used to introduce
multilevel/hierarchical concepts where students are nested within
schools.

## Usage

``` r
hsb_sub
```

## Format

A tibble with 188 rows and 7 columns:

- minority:

  Minority status. Type: numeric. Binary indicator (0/1) where 1 =
  racial/ethnic minority, 0 = non-minority (White). 52% minority.

- female:

  Sex of student. Type: numeric. Binary indicator (0/1) where 1 =
  female, 0 = male. 63% female.

- ses:

  Socioeconomic status composite. Type: numeric. Range: (-1.66, 1.51).
  Mean = -0.06. Standardized composite of family income, parental
  education, and parental occupation.

- mathach:

  Mathematics achievement score. Type: numeric. Range: (-2.83, 24.99).
  Mean = 11.27. This is the primary outcome variable.

- size:

  School enrollment size. Type: numeric. Range: (455, 1855). Mean =
  1,088. 5 unique values corresponding to the 5 schools.

- sector:

  School sector. Type: numeric. Binary indicator (0/1) where 1 =
  Catholic school, 0 = public school. 36% Catholic.

- schoolid:

  School identifier. Type: numeric. Values: 1224, 1288, 1296,
  1308, 1317. Five unique school IDs from the HSB sampling frame.

## Source

Raudenbush, S. W., & Bryk, A. S. (2002). *Hierarchical Linear Models:
Applications and Data Analysis Methods* (2nd ed.). Sage Publications.
Data originally from the High School and Beyond study, National Center
for Education Statistics. Original data file: `hsb_sub.dta`

## Details

This dataset is used to illustrate regression concepts where
observations are nested within groups (students within schools). Key
analyses include: examining the relationship between SES and math
achievement, comparing public and Catholic school effects on achievement
while controlling for student demographics, and exploring school-level
variation in the SES-achievement relationship.

The nesting structure (188 students in 5 schools) provides an
introduction to the concepts underlying multilevel modeling, even when
standard OLS regression is used. The sector variable allows for
ANCOVA-style analyses comparing school types.

## Examples

``` r
data(hsb_sub)
head(hsb_sub)
#> # A tibble: 6 × 7
#>   minority female     ses mathach  size sector schoolid
#>      <dbl>  <dbl>   <dbl>   <dbl> <dbl>  <dbl>    <dbl>
#> 1        0      1 -1.53      5.88   842      0     1224
#> 2        0      1 -0.588    19.7    842      0     1224
#> 3        0      0 -0.528    20.3    842      0     1224
#> 4        0      0 -0.668     8.78   842      0     1224
#> 5        0      0 -0.158    17.9    842      0     1224
#> 6        0      0  0.0220    4.58   842      0     1224

# SES effect on math achievement
lm(mathach ~ ses, data = hsb_sub)
#> 
#> Call:
#> lm(formula = mathach ~ ses, data = hsb_sub)
#> 
#> Coefficients:
#> (Intercept)          ses  
#>      11.457        3.307  
#> 

# ANCOVA: sector effect controlling for SES and demographics
lm(mathach ~ ses + minority + female + sector, data = hsb_sub)
#> 
#> Call:
#> lm(formula = mathach ~ ses + minority + female + sector, data = hsb_sub)
#> 
#> Coefficients:
#> (Intercept)          ses     minority       female       sector  
#>      12.545        1.681       -3.196       -1.549        3.981  
#> 
```
