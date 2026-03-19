# Dataset Overview and Course Mapping

## All 25 Datasets at a Glance

``` r

library(regdatasets)

# Build summary table
datasets <- c(
  "alcohol1_pp", "berk_sub", "berkeley", "civic_ed", "classdata_07",
  "crime", "disc", "disc2", "faculty", "gcse", "grades", "gss_1",
  "hsb_sub", "hsbs1", "individuals", "instruction", "lambert",
  "naep", "nels_data", "penalty", "pisa2000", "reading",
  "satisfaction", "titanic", "womenlf"
)

summary_df <- data.frame(
  Dataset = datasets,
  Rows = integer(length(datasets)),
  Cols = integer(length(datasets)),
  stringsAsFactors = FALSE
)

for (i in seq_along(datasets)) {
  data(list = datasets[i], package = "regdatasets")
  df <- get(datasets[i])
  summary_df$Rows[i] <- nrow(df)
  summary_df$Cols[i] <- ncol(df)
}

knitr::kable(summary_df, format = "html",
             caption = "Dimensions of all 25 datasets in regdatasets.",
             col.names = c("Dataset", "Observations", "Variables"))
```

| Dataset      | Observations | Variables |
|:-------------|-------------:|----------:|
| alcohol1_pp  |          246 |         9 |
| berk_sub     |         1169 |         3 |
| berkeley     |         3593 |         3 |
| civic_ed     |          794 |       237 |
| classdata_07 |           44 |        12 |
| crime        |           67 |         5 |
| disc         |         2000 |        15 |
| disc2        |         2000 |        15 |
| faculty      |          514 |        10 |
| gcse         |         4059 |         9 |
| grades       |          198 |         8 |
| gss_1        |         2832 |        16 |
| hsb_sub      |          188 |         7 |
| hsbs1        |          350 |        16 |
| individuals  |        55899 |         6 |
| instruction  |         1190 |        12 |
| lambert      |          492 |       109 |
| naep         |        17606 |       301 |
| nels_data    |         2000 |       299 |
| penalty      |          674 |         3 |
| pisa2000     |         4528 |        15 |
| reading      |           66 |         8 |
| satisfaction |          110 |         3 |
| titanic      |         1309 |         6 |
| womenlf      |          263 |         5 |

Dimensions of all 25 datasets in regdatasets. {.table}

## Course Chapter Mapping

The table below shows which datasets are used in each chapter of the
companion textbook.

| Chapter | Topic | Primary Datasets |
|:---|:---|:---|
| 1 | Simple Linear Regression | `gcse`, `classdata_07`, `pisa2000` |
| 2 | ANCOVA | `gcse`, `instruction` |
| 3 | One-way ANOVA | `reading`, `instruction` |
| 4 | Continuous Predictors | `crime` |
| 5 | Interactions | `gcse`, `individuals`, `faculty`, `crime` |
| 6 | Nonlinear Relationships | `naep` |
| 7 | Model Building | `nels_data`, `hsb_sub`, `civic_ed` |
| 8 | Model Diagnostics | `hsbs1`, `nels_data` |
| 9 | Simple Logistic Regression | `gss_1`, `disc`, `titanic` |
| 10 | Multiple Logistic Regression | `berkeley`, `berk_sub`, `disc2`, `titanic` |
| 11 | Logistic Model Fit | `penalty`, `disc` |
| 12 | Latent Response & GLM | `lambert`, `grades` |
| 13 | Ordinal Models | `womenlf`, `satisfaction`, `alcohol1_pp` |

## Datasets by Topic Area

### Linear Regression Foundation

These datasets support the core linear regression chapters (1-8):

- **`gcse`** (4,059 x 9): The primary running example. GCSE exam scores
  and London Reading Test scores from 65 schools. Used across Chapters
  1, 2, and 5 for SLR, ANCOVA, and interactions.

- **`crime`** (67 x 5): Florida county-level crime rates. Demonstrates
  the confounding/sign-reversal phenomenon between education and crime
  once urbanization is controlled.

- **`instruction`** (1,190 x 12): Math achievement gains nested in
  classrooms and schools. Supports ANOVA and ANCOVA demonstrations.

- **`reading`** (66 x 8): Three-group reading instruction experiment.
  Clean example for one-way ANOVA with clear group differences.

### Logistic Regression

These datasets support the binary outcome chapters (9-11):

- **`berkeley`** (3,593 x 3): The classic Simpson’s paradox dataset. UC
  Berkeley graduate admissions by gender and department.

- **`gss_1`** (2,832 x 16): General Social Survey 1982/1994. Attitude
  change over time as a simple logistic regression example.

- **`penalty`** (674 x 3): Death penalty sentencing data by defendant
  and victim race. Used for goodness-of-fit testing.

- **`titanic`** (1,309 x 6): Passenger survival data with class, sex,
  age, and fare as predictors.

### Ordinal and Advanced Models

- **`womenlf`** (263 x 5): Canadian women’s labor force participation
  with a three-level ordinal outcome.

- **`satisfaction`** (110 x 3): Four-level ordinal satisfaction data for
  ordinal logistic regression.

- **`lambert`** (492 x 109): Rich longitudinal dataset for latent
  response model demonstrations.

## Data Sources

Most datasets originate from published educational and social science
studies. Key sources include:

- **GCSE data**: Goldstein et al. (1993), UK examination council records
- **PISA 2000**: OECD Programme for International Student Assessment
- **Berkeley admissions**: Bickel, Hammel & O’Connell (1975)
- **General Social Survey**: NORC at the University of Chicago
- **NAEP**: National Center for Education Statistics
- **NELS:88**: National Education Longitudinal Study of 1988
- **Titanic**: British Board of Trade records

See individual dataset documentation (`?dataset_name`) for complete
source citations.
