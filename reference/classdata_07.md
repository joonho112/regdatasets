# Class Survey Data (2007)

Survey data collected from 44 students enrolled in a statistics course
in 2007. The dataset contains self-reported information about study
habits, work hours, physical characteristics, and lifestyle behaviors.
This small classroom dataset is useful for introductory data
exploration, simple regression, and discussions about data quality
issues (e.g., negative values for alcohol consumption, missing data).

## Usage

``` r
classdata_07
```

## Format

A tibble with 44 rows and 12 columns:

- actual_study:

  Actual hours spent studying per week. Type: numeric. Range: (0, 70).
  Mean = 21.5.

- desired_study:

  Desired hours of study per week. Type: numeric. Range: (0, 100). Mean
  = 21.5. NA = 1.

- actual_work:

  Actual hours spent working per week. Type: numeric. Range: (0, 72).
  Mean = 17.7.

- desired_work:

  Desired hours of work per week. Type: numeric. Range: (0, 50). Mean =
  12.8.

- gender:

  Gender of student. Type: numeric. Binary indicator (0/1) where 1 =
  male, 0 = female. 27% male.

- height:

  Height in inches. Type: numeric. Range: (60, 75). Mean = 66.6 inches.

- desired_weight:

  Desired weight in pounds. Type: numeric. Range: (99, 200). Mean =
  136.6.

- exer:

  Hours of exercise per week. Type: numeric. Range: (0, 25). Mean = 4.7.
  NA = 1.

- sleep:

  Hours of sleep per night. Type: numeric. Range: (6, 9). Mean = 7.0.

- alcohol:

  Alcoholic drinks consumed per week. Type: numeric. Range: (-1, 10).
  Mean = 3.4. Note: Contains a negative value (-1) which may represent a
  data entry error, useful for teaching data cleaning.

- overage:

  Whether the student is over the age threshold. Type: character. All
  values are "no" in this cohort.

- age:

  Age category. Type: numeric. Values: 0, 1, 2. Coded as age group
  categories rather than exact age.

## Source

Class survey data collected by the instructor in 2007. Original data
file: `classdata_07.dta`

## Details

This dataset is used for introductory regression exercises and data
exploration. Key analyses include: simple regression of actual study
hours on desired study hours, exploring the relationship between height
and desired weight, and identifying data quality issues such as the
anomalous negative value for alcohol consumption. The small sample size
(n = 44) makes it appropriate for classroom demonstrations.

## Examples

``` r
data(classdata_07)
head(classdata_07)
#> # A tibble: 6 × 12
#>   actual_study desired_study actual_work desired_work gender height
#>          <int>         <int>       <int>        <int>  <int>  <dbl>
#> 1           50            65           0            0      0   64  
#> 2           40            25          10           20      0   63  
#> 3           16            25          20           20      0   67  
#> 4           30            30           0            0      0   67  
#> 5           25            15          13            5      0   65  
#> 6           20            10          10           10      0   63.5
#> # ℹ 6 more variables: desired_weight <int>, exer <dbl>, sleep <dbl>,
#> #   alcohol <int>, overage <chr>, age <int>

# Simple regression: actual vs. desired study hours
lm(actual_study ~ desired_study, data = classdata_07)
#> 
#> Call:
#> lm(formula = actual_study ~ desired_study, data = classdata_07)
#> 
#> Coefficients:
#>   (Intercept)  desired_study  
#>        9.6559         0.5755  
#> 

# Relationship between height and desired weight
lm(desired_weight ~ height + gender, data = classdata_07)
#> 
#> Call:
#> lm(formula = desired_weight ~ height + gender, data = classdata_07)
#> 
#> Coefficients:
#> (Intercept)       height       gender  
#>     -75.787        3.073       29.071  
#> 
```
