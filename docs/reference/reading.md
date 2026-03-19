# Reading Comprehension Instruction Experiment

Data from an experiment comparing three methods of reading instruction
on reading comprehension outcomes. Sixty-six second-grade students were
randomly assigned to one of three instructional methods: Basal
(traditional), DRTA (Directed Reading-Thinking Activity), and Strat
(Strategies instruction). Pre-test and post-test scores were measured on
multiple reading comprehension assessments. This is a primary teaching
dataset used throughout the course for ANOVA, dummy variable coding, and
planned comparisons.

## Usage

``` r
reading
```

## Format

A tibble with 66 rows and 8 columns:

- subject:

  Student identifier. Type: numeric. Range: (1, 66).

- group:

  Instruction method group label. Type: character. Levels: "Basal" =
  standard/traditional method (reference group), "DRTA" = Directed
  Reading-Thinking Activity (new method), "Strat" = Strategies
  instruction (new method).

- pre1:

  Pre-test score, measure 1 (reading comprehension). Type: numeric.
  Range: (4, 16).

- pre2:

  Pre-test score, measure 2 (reading comprehension). Type: numeric.
  Range: (1, 13).

- post1:

  Post-test score, measure 1 (intruded sentences test). Type: numeric.
  Range: (1, 15). Primary outcome variable.

- post2:

  Post-test score, measure 2 (reading comprehension). Type: numeric.
  Range: (0, 13).

- post3:

  Post-test score, measure 3 (reading comprehension, standardized).
  Type: numeric. Range: (30, 57). Mean approximately 44.

- method:

  Numeric code for instruction method. Type: numeric. Values: 1 = Basal,
  2 = DRTA, 3 = Strat.

## Source

Schmitt, M. C. (1987). The effects of an elaborated directed reading
activity on the metacomprehension skills of third graders. Cited in
Raudenbush, S. W. & Bryk, A. S. (2002). *Hierarchical Linear Models*
(2nd ed.). Sage. Original data file: `reading.dta`

## Details

This dataset is used in Chapter 3 (Multiple Linear Regression: ANOVA) to
illustrate one-way ANOVA as a regression with dummy variables, and to
demonstrate planned comparisons versus post-hoc tests. Key analyses
include: dummy variable coding for three-group comparisons (Basal as
reference), F-test for overall group differences, planned comparisons
(e.g., new methods vs. traditional, DRTA vs. Strat), Bonferroni and
Scheffe adjustments for multiple comparisons, ANCOVA controlling for
pre-test scores, and effect coding as an alternative to dummy coding.

## Examples

``` r
data(reading)
head(reading)
#> # A tibble: 6 × 8
#>   subject group  pre1  pre2 post1 post2 post3 method
#>     <dbl> <chr> <dbl> <dbl> <dbl> <dbl> <dbl>  <dbl>
#> 1       1 Basal     4     3     5     4    41      1
#> 2       2 Basal     6     5     9     5    41      1
#> 3       3 Basal     9     4     5     3    43      1
#> 4       4 Basal    12     6     8     5    46      1
#> 5       5 Basal    16     5    10     9    46      1
#> 6       6 Basal    15    13     9     8    45      1
# One-way ANOVA: post-test score by instruction method
lm(post1 ~ group, data = reading)
#> 
#> Call:
#> lm(formula = post1 ~ group, data = reading)
#> 
#> Coefficients:
#> (Intercept)    groupDRTA   groupStrat  
#>       6.682        3.091        1.091  
#> 
```
