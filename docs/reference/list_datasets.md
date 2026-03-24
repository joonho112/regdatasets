# List All Datasets in regdatasets

Returns a tibble summarizing all datasets in the package, including
their dimensions, primary chapter usage, and a brief description.

## Usage

``` r
list_datasets()
```

## Value

A tibble with columns: `dataset` (character), `rows` (integer), `cols`
(integer), `chapter` (character), and `description` (character).

## Examples

``` r
list_datasets()
#> # A tibble: 24 × 5
#>    dataset       rows  cols chapter       description                           
#>    <chr>        <int> <int> <chr>         <chr>                                 
#>  1 alcohol1_pp    246     9 Supplementary Adolescent alcohol use (person-period…
#>  2 berk_sub      1169     3 Ch 10         Berkeley admissions subset (2 departm…
#>  3 berkeley      3593     3 Ch 10-11      UC Berkeley admissions (5 departments)
#>  4 civic_ed       794   237 Supplementary Civic education pre/post survey (16 s…
#>  5 classdata_07    44    12 Ch 1          Class survey data (study habits, heig…
#>  6 crime           67     5 Ch 4-5        Florida county crime rates            
#>  7 disc          2000    15 Ch 9-13       NELS:88 school discipline (original N…
#>  8 disc2         2000    15 Ch 9-13       NELS:88 school discipline (with SES a…
#>  9 faculty        514    10 Ch 4-8        Faculty salaries and experience       
#> 10 gcse          4059     6 Ch 1-2, 5     GCSE and London Reading Test scores (…
#> # ℹ 14 more rows
```
