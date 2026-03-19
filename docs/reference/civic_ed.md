# Civic Education Study: Pre-Post Survey Data

Pre-test and post-test survey data from a civic education study
involving 794 students across 16 schools. The study measured a wide
range of civic attitudes, knowledge, behaviors, and participation before
and after a civic education intervention. With 237 variables covering
survey items (Likert scales, binary, and open-ended), composite scale
scores, and demographic information, this dataset supports analyses of
treatment effects, regression to the mean, and scale construction.

## Usage

``` r
civic_ed
```

## Format

A tibble with 794 rows and 237 columns. Variables are organized into the
following groups:

**Identifiers and treatment indicators:**

- id_match:

  Unique student identifier for matching pre and post records. Type:
  numeric. Range: (201180001, 351190031).

- school:

  School identifier. Type: character. 16 unique schools coded as: 20,
  21, 22, 23, 25, 26, 27, 29, and others.

- wtp:

  We the People program participation. Type: numeric. Binary indicator
  (0/1) where 1 = participated in the civic education program, 0 =
  comparison group. 63% participated.

- ap:

  AP (Advanced Placement) class indicator. Type: numeric. Binary
  indicator (0/1) where 1 = AP class, 0 = non-AP class.

**Pre-test survey items (t_q1 through t_q99):** Variables prefixed with
`t_` represent pre-test (Time 1) survey responses. These include:

- t_q1 to t_q23:

  Civic knowledge and attitude items. Type: numeric. Mostly 4-point
  Likert scales (1-4). Some items have 3-point scales (1-3). Small
  amounts of missing data (NA = 0 to 8).

- t_numorg:

  Number of organizations participated in (pre-test). Type: numeric.
  Range: (0, 5).

- t_orgs_y:

  Any organization membership (pre-test). Type: numeric. Binary (0/1)
  where 1 = member of at least one organization.

- t_q24:

  Political interest item. Type: numeric. 6-point scale (1-6).

- t_q25 to t_q28:

  Political activity items (pre-test). Type: numeric. Binary (0/1).

- t_numldr:

  Number of leadership roles (pre-test). Type: numeric. Range: (0, 4).

- t_q29 to t_q35:

  Civic activity items (pre-test). Type: numeric. Binary (0/1) with some
  missing values.

- t_numact:

  Number of civic activities (pre-test). Type: numeric. Range: (0, 7).

- t_q36 to t_q47:

  Civic attitude items. Type: numeric. 4-point Likert scales (1-4).

- t_q48, t_q49, t_q50:

  Knowledge test items. Type: character. Multiple choice responses (A,
  B, C, D, E, F) with -1 indicating missing or no response.

- t_q51 to t_q52:

  Attitude items. Type: numeric. 4-point scales (1-4).

- t_q53 to t_q64:

  Political feeling thermometer items. Type: numeric. 7-point scales
  (1-7). Higher values indicate warmer feelings.

- t_q65 to t_q78:

  Civic engagement and obligation items. Type: numeric. 4-point Likert
  scales (1-4).

- t_q79 to t_q84:

  Additional feeling thermometer items. Type: numeric. 7-point scales
  (1-7).

- t_q85 to t_q89:

  Tolerance and ambiguity items. Type: numeric. 4- or 5-point scales.

- t_q92_a to t_q92_f:

  Race/ethnicity indicators (pre-test). Type: numeric. Binary (0/1).
  Multiple categories (e.g., a = Asian, b = Black, c = Hispanic, etc.).

- t_q90, t_q91:

  Media exposure items. Type: numeric. 6-point scales (0-5).

- t_q93:

  Political discussion at home. Type: numeric. Binary (0/1) where 1 =
  discusses politics at home.

- t_q94:

  Religious attendance. Type: numeric. Range: (0, 3).

- t_q95:

  Self-reported grades. Type: numeric. Range: (1, 8).

- t_q96_a to t_q96_k:

  Subject enrollment indicators. Type: numeric. Binary (0/1) for various
  courses taken.

- t_q97 to t_q99:

  Additional survey items. Type: numeric. 4- or 5-point scales.

**Post-test survey items (r_q1 through r_q84):** Variables prefixed with
`r_` represent post-test (Time 2) survey responses. These mirror the
pre-test items with the same numbering (e.g., `r_q1` corresponds to
`t_q1`). Scales and coding are identical to the pre-test versions.

**Demographic and background variables:**

- par_coll:

  Parent has college education. Type: numeric. Binary (0/1) where 1 = at
  least one parent attended college. NA = 40.

- hi_math:

  Highest math course taken. Type: numeric. Range: (0, 5). Higher values
  indicate more advanced math courses.

**Composite scale scores (standardized, mean approximately 0):**
Variables ending in `_m` are IRT-based or factor-analytic composite
scores. Suffixes `_t` and `_r` indicate pre-test and post-test
respectively.

- attn_pre, attn_pos:

  Attention to politics (pre and post). Type: numeric. Standardized
  scores approximately (-1.5, 1.8).

- inf_pre, inf_post:

  Political information/knowledge (pre and post). Type: numeric.
  Standardized scores.

- ldr_t_m, ldr_r_m:

  Leadership composite (pre and post). Type: numeric. Standardized.

- govm_t_m, govm_r_m:

  Government knowledge (pre and post). Type: numeric. Standardized.

- posg_t_m, posg_r_m:

  Positive government attitudes (pre and post). Type: numeric.
  Standardized.

- eff_t_m, eff_r_m:

  Political efficacy (pre and post). Type: numeric. Standardized.

- res_t_m, res_r_m:

  Political responsibility (pre and post). Type: numeric. Standardized.

- obl_t_m, obl_r_m:

  Civic obligation (pre and post). Type: numeric. Standardized.

- tol_t_m, tol_r_m:

  Political tolerance (pre and post). Type: numeric. Standardized.

- amb_t_m, amb_r_m:

  Ambiguity tolerance (pre and post). Type: numeric. Standardized.

- comm_t_m, comm_r_m:

  Community engagement (pre and post). Type: numeric. Standardized.

- all_t_m, all_r_m:

  Overall civic competence composite (pre and post). Type: numeric.
  Standardized. No missing values.

- liked_cl:

  Liked civic learning environment. Type: numeric. Standardized. Mean
  approximately 0.

## Source

Tolo, K. W. (1999). *The Civic Education of American Youth: From State
Policies to School District Practices*. Policy Research Project Report,
Lyndon B. Johnson School of Public Affairs, The University of Texas at
Austin. Original data file: `civic_ed.dta`

## Details

This dataset is used in Chapter 1 (Simple Linear Regression) to
illustrate regression to the mean with the civic education example:
regressing post-test attention to politics on pre-test attention yields
a slope less than 1, showing that students below average before the
course tend to improve and those above average tend to decline. The
dataset also supports analyses in later chapters including ANCOVA
(comparing treatment and control groups while controlling for pre-test
scores), multiple regression with many predictors, and model building.

Key analyses include: simple regression of post-test on pre-test scores
to demonstrate regression to the mean, ANCOVA comparing WTP program
participants with comparison students, and exploring relationships among
multiple civic attitude dimensions.

## Examples

``` r
data(civic_ed)

# Regression to the mean: post-test on pre-test attention to politics
lm(attn_pos ~ attn_pre, data = civic_ed)
#> 
#> Call:
#> lm(formula = attn_pos ~ attn_pre, data = civic_ed)
#> 
#> Coefficients:
#> (Intercept)     attn_pre  
#>   -0.003737     0.771140  
#> 

# ANCOVA: treatment effect controlling for pre-test
lm(attn_pos ~ attn_pre + wtp, data = civic_ed)
#> 
#> Call:
#> lm(formula = attn_pos ~ attn_pre + wtp, data = civic_ed)
#> 
#> Coefficients:
#> (Intercept)     attn_pre          wtp  
#>    -0.07049      0.75878      0.10703  
#> 
```
