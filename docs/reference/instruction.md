# Reading Instruction Methods Study

Data from an experimental study evaluating the effectiveness of
different reading instruction methods on mathematics achievement gains,
drawn from a multilevel education study. The dataset contains 1,190
students nested within 312 classrooms across 107 schools, with measures
of student demographics, classroom-level teacher characteristics, and
school-level poverty indicators. Used in regression teaching to
illustrate ANOVA with categorical predictors, ANCOVA controlling for
prior achievement, and nested data structures.

## Usage

``` r
instruction
```

## Format

A tibble with 1,190 rows and 12 columns:

- girl:

  Student gender indicator. Type: numeric. Binary (0/1) where 1 = girl,
  0 = boy.

- minority:

  Minority status indicator. Type: numeric. Binary (0/1) where 1 =
  minority student, 0 = non-minority.

- mathkind:

  Mathematics score at kindergarten entry. Type: numeric. Range: (290,
  629). Standardized test score.

- mathgain:

  Gain in mathematics score from kindergarten to first grade. Type:
  numeric. Range: (-110, 253). Computed as first grade score minus
  kindergarten score.

- ses:

  Socioeconomic status of the student's household. Type: numeric. Range:
  (-1.61, 3.21). Continuous standardized composite measure.

- yearstea:

  Teacher's years of teaching experience. Type: numeric. Range: (0, 40).
  Classroom-level variable.

- mathknow:

  Teacher's mathematical knowledge score. Type: numeric. Range: (-2.50,
  2.61). 109 missing values. Standardized measure of teacher content
  knowledge.

- housepov:

  Proportion of households in the school neighborhood below the poverty
  line. Type: numeric. Range: (0.01, 0.56). School-level variable.

- mathprep:

  Teacher's number of math content and methods courses. Type: numeric.
  Range: (1, 6). Classroom-level variable.

- classid:

  Classroom identifier. Type: numeric. Range: (1, 312).

- schoolid:

  School identifier. Type: numeric. Range: (1, 107).

- childid:

  Student identifier. Type: numeric. Range: (1, 1190).

## Source

Hill, H. C., Rowan, B., & Ball, D. L. (2005). Effects of teachers'
mathematical knowledge for teaching on student achievement. *American
Educational Research Journal*, 42(2), 371-406. Original data file:
`instruction.dta`

## Details

This dataset is used in Chapter 3 (ANOVA) and Chapter 2 (ANCOVA) to
illustrate one-way ANOVA comparing group means, ANCOVA adjusting for
covariates, and the use of dummy variables with categorical predictors.
Key analyses include: comparing math gains across groups, adjusting for
prior math scores (mathkind) and SES, examining teacher and school-level
predictors of student math gains, and nested data analysis.

## Examples

``` r
data(instruction)
head(instruction)
#> # A tibble: 6 × 12
#>    girl minority mathkind mathgain     ses yearstea mathknow housepov mathprep
#>   <dbl>    <dbl>    <dbl>    <dbl>   <dbl>    <dbl>    <dbl>    <dbl>    <dbl>
#> 1     1        1      448       32  0.460         1   NA       0.0820     2   
#> 2     0        1      460      109 -0.270         1   NA       0.0820     2   
#> 3     1        1      511       56 -0.0300        1   NA       0.0820     2   
#> 4     0        1      449       83 -0.380         2   -0.110   0.0820     3.25
#> 5     0        1      425       53 -0.0300        2   -0.110   0.0820     3.25
#> 6     1        1      450       65  0.760         2   -0.110   0.0820     3.25
#> # ℹ 3 more variables: classid <dbl>, schoolid <dbl>, childid <dbl>
# ANCOVA: math gain predicted by minority status, controlling for prior math
lm(mathgain ~ minority + mathkind, data = instruction)
#> 
#> Call:
#> lm(formula = mathgain ~ minority + mathkind, data = instruction)
#> 
#> Coefficients:
#> (Intercept)     minority     mathkind  
#>    266.4329      -8.7261      -0.4349  
#> 
```
