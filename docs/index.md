# regdatasets

**regdatasets** provides a curated collection of 24 datasets for
teaching introductory and intermediate regression analysis in education
and social science contexts.

## Installation

Install the development version from GitHub:

``` r

# install.packages("devtools")
devtools::install_github("joonho112/regdatasets")
```

## Datasets

| Dataset | N | Variables | Topic |
|:---|---:|---:|:---|
| `gcse` | 4,059 | 9 | GCSE exam scores and London Reading Test (Chapters 1–2, 5) |
| `crime` | 67 | 5 | Florida county crime rates (Chapters 4–5) |
| `instruction` | 1,190 | 12 | Math achievement gains, multilevel (Chapters 2–3) |
| `reading` | 66 | 8 | Three-group reading instruction experiment (Chapter 3) |
| `pisa2000` | 4,528 | 15 | OECD PISA reading scores, 3 countries (Chapter 1) |
| `individuals` | 55,899 | 6 | BLS wage data by gender and sector (Chapter 5) |
| `faculty` | 514 | 10 | Faculty salaries and experience (Chapter 5) |
| `nels_data` | 2,000 | 299 | National Education Longitudinal Study (Chapters 7–8) |
| `hsbs1` | 350 | 16 | High School and Beyond survey (Chapter 8) |
| `gss_1` | 2,832 | 16 | General Social Survey 1982/1994 (Chapter 9) |
| `berkeley` | 3,593 | 3 | UC Berkeley admissions, Simpson’s paradox (Chapter 10) |
| `penalty` | 674 | 3 | Death penalty sentencing by race (Chapter 11) |
| `titanic` | 1,309 | 6 | Titanic passenger survival (Chapters 9–11) |
| `womenlf` | 263 | 5 | Women’s labor force participation (Chapter 13) |
| `satisfaction` | 110 | 3 | Ordinal satisfaction survey (Chapter 13) |
| `alcohol1_pp` | 246 | 9 | Adolescent alcohol use, person-period (Chapter 13) |
| `lambert` | 492 | 109 | Canadian longitudinal child study (Chapter 12) |
| `civic_ed` | 794 | 237 | Civic education pre/post study (Chapters 1, 7) |
| `disc` | 2,000 | 15 | NELS:88 discipline study (Chapters 9–10) |
| `disc2` | 2,000 | 15 | NELS:88 with achievement scores (Chapters 10–11) |
| `berk_sub` | 1,169 | 3 | Berkeley admissions subset (Chapter 10) |
| `hsb_sub` | 188 | 7 | High School and Beyond subset (Chapter 7) |
| `classdata_07` | 44 | 12 | Classroom survey data (Chapter 1) |
| `grades` | 198 | 8 | Essay grades and writing features (Chapter 12) |

## Quick Start

``` r

library(regdatasets)

# --- Simple linear regression ---
data(gcse)
model <- lm(gcse ~ lrt, data = gcse)
summary(model)

# --- Logistic regression: Simpson's paradox ---
data(berkeley)
# Unadjusted: gender appears to matter
crude <- glm(admitted ~ female, family = binomial, data = berkeley)
# Adjusted: gender effect disappears after controlling for department
adjusted <- glm(admitted ~ female + factor(department),
                family = binomial, data = berkeley)
exp(coef(crude)["female"])    # Crude OR ~ 0.64
exp(coef(adjusted)["female"]) # Adjusted OR ~ 0.97

# --- One-way ANOVA ---
data(reading)
model_anova <- lm(post1 ~ factor(group), data = reading)
anova(model_anova)
```

## Works Well With

**regdatasets** is designed to work seamlessly with modern R workflows:

``` r

library(tidyverse)   # dplyr, ggplot2, tibble, ...
library(easystats)   # parameters, performance, effectsize, see, ...
library(gtsummary)   # publication-ready tables
library(marginaleffects) # predictions, comparisons, slopes
```

Example using the **easystats** and **marginaleffects** ecosystem:

``` r

library(regdatasets)
library(easystats)
library(marginaleffects)

# Fit model
data(gcse)
model <- lm(gcse ~ lrt * school, data = gcse)

# easystats: model summary and diagnostics
model_parameters(model)
check_model(model)

# marginaleffects: predicted values and slopes
plot_predictions(model, condition = c("lrt", "school"))
avg_slopes(model, variables = "lrt", by = "school")
```

## Course Coverage

| Chapters | Topic | Datasets |
|:---|:---|:---|
| 1–2 | SLR, ANCOVA | `gcse`, `civic_ed`, `classdata_07`, `pisa2000` |
| 3 | One-way ANOVA | `reading`, `instruction` |
| 4 | Continuous predictors | `crime` |
| 5 | Interactions | `gcse`, `individuals`, `faculty`, `crime` |
| 6 | Nonlinear relationships | `nels_data`, `crime` |
| 7–8 | Model building & diagnostics | `nels_data`, `hsbs1`, `hsb_sub` |
| 9–11 | Logistic regression | `gss_1`, `berkeley`, `penalty`, `titanic`, `disc` |
| 12 | Latent response & GLM | `lambert`, `grades` |
| 13 | Ordinal models | `womenlf`, `satisfaction`, `alcohol1_pp` |

## Companion Textbook

This package accompanies [Regression Lecture
Notes](https://github.com/joonho112/regression-lecture-notes), a
Quarto-based interactive textbook for graduate-level regression analysis
in education and social science.

## License

MIT
