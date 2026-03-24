# National Education Longitudinal Study of 1988 (NELS:88)

Data from the National Education Longitudinal Study of 1988 (NELS:88), a
nationally representative longitudinal survey that followed 8th-grade
students through high school and beyond. This subsample of 2,000
students contains 299 variables spanning base-year (1988) and first
follow-up (1990) waves, including student demographics, family
background, school characteristics, attitudes, behaviors, and
standardized test scores. Used extensively in regression teaching for
model building, handling large variable sets, and longitudinal analysis
of educational achievement.

## Usage

``` r
nels_data
```

## Format

A tibble with 2,000 rows and 299 columns. Key variable groups:

Identifiers and demographics:

- id:

  Student identifier. Type: numeric. Range: (124966, 9199195).

- bys2a:

  Student sex. Type: numeric. Values: 1 = male, 2 = female. Code 8 =
  missing/refused.

- birthmo:

  Birth month. Type: numeric. Range: (1, 12). Code 98 = missing.

- birthyr:

  Birth year (last two digits). Type: numeric. Range: (72, 76). Code 98
  = missing.

Parent occupation and education (base year):

- bys4a:

  Father's education level. Type: numeric. Range: (1, 7). Codes 8, 9 =
  don't know/missing.

- bys4occ:

  Father's occupation code. Type: numeric. Range: (1, 18). Code 99 = not
  applicable.

- bys5a:

  Mother's education. Type: numeric. Range: (1, 7). Codes 8, 9 = don't
  know/missing.

- bys7a:

  Mother's occupation. Type: numeric. Range: (1, 7). Codes 8, 9 = don't
  know/missing.

- bys7occ:

  Mother's occupation code. Type: numeric. Range: (1, 18). Code 99 = not
  applicable.

Family structure and home environment:

- bys12:

  Family composition. Type: numeric. Values: 1 = two parents, 2 = other.
  Code 8 = missing.

- bys18:

  Number of siblings. Type: numeric. Code 99 = missing.

- bys20:

  Times changed schools. Type: numeric. Code 98 = missing.

- bys22:

  Home language. Type: numeric. Code 99 = missing.

Parental involvement items (`bys27a` through `bys27d`): Rated on a scale
where lower values indicate more involvement. Code 9 = missing.

Student attitudes and self-concept items:

- bys29:

  Educational expectations. Type: numeric. Code 9 = missing.

Television and homework habits (`bys31a` through `bys31d`): Hours spent
on various activities. Codes 8, 9, 99 = missing.

Extracurricular activities: `bys34a`, `bys34b` (participation codes, 98
= missing).

School-related items (`bys35a` through `bys39c`): Various school
experience and behavior items rated on Likert-type scales. Code 8 =
missing.

Time use items: `bys41` (hours working, code 8 = missing), `bys42a`,
`bys42b` (hours on activities, code 98 = missing), `bys43` (absences,
code 8 = missing).

School behavior items (`bys44a` through `bys44m`): Items measuring
academic and social behaviors, rated on Likert-type scales. Code 8 =
missing.

Additional student items: `bys45` through `bys46` (educational plans),
`bys52` through `bys54` (peer influences, codes 8/98 = missing),
`bys55a` through `bys55f` (risk behaviors, code 8 = missing), `bys56a`
through `bys56e` (parenting practices), `bys57a` through `bys57c`
(problem behaviors).

Locus of control and self-concept items (`bys58a` through `bys60d`):
Likert-type attitude items rated 1-4, with code 8 = missing.

Teacher report items (`bys66a` through `bys68b`): Teacher assessments of
student behavior. Code 8 = missing.

Drug/alcohol items (`bys74` through `bys77`): Risk behavior items. Code
8 = missing.

Behavioral ratings (`bys80`): Behavioral scale. Range: (0, 5). 90 NA.

Course-taking patterns (`bys81a` through `bys83j`): Items on courses
taken and academic track. Codes 8, 98 = missing.

Composite and derived variables:

- bys82a through bys82u:

  Self-concept items. Type: numeric. Rated 1-4. Code 8 = missing. 21
  items.

- bys83a through bys83j:

  Locus of control items. Type: numeric. Rated 1-4. Code 8 = missing. 10
  items.

- byscenrl:

  School enrollment size category. Type: numeric. Range: (1, 7).

- g8urban:

  Urbanicity. Type: numeric. Values: 1 = urban, 2 = suburban, 3 = rural.

- g8regon:

  Census region. Type: numeric. Range: (1, 4). Code 8 = missing.

- g8minor:

  Percent minority enrollment in school. Type: numeric. Code 998 =
  missing.

- g8lunch:

  Percent eligible for free lunch. Type: numeric. Code 998 = missing.

Psychometric composite scores (base year):

- bylocus1:

  Locus of control, IRT-based. Type: numeric. Code 99.98 = missing.

- bylocus2:

  Locus of control, standardized. Type: numeric. Code 99.98 = missing.

- bycncpt1:

  Self-concept, IRT-based. Type: numeric. Code 99.98 = missing.

- bycncpt2:

  Self-concept, standardized. Type: numeric. Code 99.98 = missing.

- byses:

  Socioeconomic status composite. Type: numeric. Range: (-2.89, 1.98).
  Code 100 = missing. Standardized composite of parental education,
  occupation, and family income.

- bypared:

  Parental education (highest of either parent). Type: numeric. Range:
  (1, 7).

- byfamsiz:

  Family size. Type: numeric. Code 98 = missing.

- byfcomp:

  Family composition. Type: numeric. Code 98 = missing.

- byparmar:

  Parental marital status. Type: numeric. Code 98 = missing.

- byfaminc:

  Family income category. Type: numeric. Range: (1, 15). Code 98 =
  missing.

- byhmlang:

  Home language. Type: numeric. Code 8 = missing.

- bypsepln:

  Post-secondary education plans. Type: numeric. Code 98 = missing.

- byhomewk:

  Hours of homework per week. Type: numeric. Code 98 = missing.

- bylep:

  Limited English proficiency. Type: numeric. Binary (0/1). Code 8 =
  missing.

- bylm:

  Language minority. Type: numeric. Binary (0/1). Code 8 = missing.

- bygrads:

  GPA composite. Type: numeric. Range: (0.5, 9.8).

- byrisk:

  Number of risk factors. Type: numeric. Range: (0, 5).

Base-year standardized test scores:

- by2xrstd:

  Reading standardized score. Type: numeric. Range: (31.95, 70.55). 77
  NA. Mean approximately 51.

- by2xmstd:

  Mathematics standardized score. Type: numeric. Range: (34.10, 77.20).
  75 NA. Mean approximately 51.

- by2xsstd:

  Science standardized score. Type: numeric. Code 99.99 = missing.

- by2xhstd:

  History standardized score. Type: numeric. Code 99.99 = missing.

- by2xrpro:

  Reading proficiency level. Type: numeric. Range: (0, 4). Code 9 =
  missing.

- by2xmpro:

  Math proficiency level. Type: numeric. Range: (0, 5). Code 9 =
  missing.

- by2xspro:

  Science proficiency level. Type: numeric. Range: (0, 3). Code 9 =
  missing.

First follow-up (1990) student survey items (`f1s` prefix): Items
`f1s8a` through `f1s99s` cover attitudes, school experiences, behavior,
and educational plans at the first follow-up wave (10th grade). Most
items are rated on Likert-type scales (1-4 or 1-6). Code 8 = missing/not
applicable. Approximately 186 NA values per item for students lost to
follow-up.

First follow-up derived variables:

- f1stat:

  Follow-up status. Type: numeric. Range: (0, 5).

- f1dostat:

  Dropout status. Type: numeric. Range: (0, 5).

- f1ses:

  SES at follow-up. Type: numeric. Code 100 = missing.

- f1locus1:

  Locus of control, follow-up. Type: numeric. Code 99.98 = missing.

- f1locus2:

  Locus of control standardized, follow-up. Code 99.98 = missing.

- f1cncpt1:

  Self-concept, follow-up. Code 99.98 = missing.

- f1cncpt2:

  Self-concept standardized, follow-up. Code 99.98 = missing.

- f1drps89:

  Dropout between base year and 1989. Type: numeric. Code 8 = missing.

- f1drpf89:

  Dropout by fall 1989. Code 8 = missing.

- f1drps90:

  Dropout by spring 1990. Code 8 = missing.

- f1hsprog:

  High school program. Type: numeric. Code 8 = missing.

- f12xrstd:

  Reading score at follow-up. Type: numeric. Code 99.99 = missing. Mean
  approximately 57.

- year2:

  Derived time variable 2. Type: numeric.

- year1:

  Derived time variable 1. Type: numeric.

## Source

National Center for Education Statistics (NCES). National Education
Longitudinal Study of 1988 (NELS:88). U.S. Department of Education.
Original data file: `nels_data.dta`

## Details

This dataset is used across multiple chapters for model building
exercises, particularly in Chapter 7 (Model Building) for variable
selection and in general regression contexts for examining predictors of
educational achievement. The large number of variables allows practice
in identifying relevant predictors from a rich set of candidates. Note
that many variables use special missing value codes (8, 9, 98, 99,
99.98, 99.99, 100, 998) rather than NA, which requires careful data
cleaning before analysis. Key analyses include: predicting math
achievement from SES and school characteristics, stepwise and purposeful
model building, and examining longitudinal change in test scores from
base year to follow-up.

## Examples

``` r
data(nels_data)
# Regression of math score on SES (after cleaning missing codes)
nels_clean <- nels_data[nels_data$byses < 90, ]
lm(by2xmstd ~ byses, data = nels_clean)
#> 
#> Call:
#> lm(formula = by2xmstd ~ byses, data = nels_clean)
#> 
#> Coefficients:
#> (Intercept)        byses  
#>      51.821        6.423  
#> 
```
