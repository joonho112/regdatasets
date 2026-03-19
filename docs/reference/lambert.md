# Lambert Longitudinal Study Data

Longitudinal data from the Lambert study, a Canadian prospective
investigation tracking 492 children from early childhood into adulthood.
The dataset contains 109 variables spanning multiple assessment waves
and covering behavioral ratings (aggression, attention, activity,
impulsivity), cognitive test scores, academic achievement, mental health
outcomes (depression, anxiety), substance use, and occupational
outcomes. Used in regression teaching to illustrate latent response
models, handling of large multivariate datasets, and longitudinal
predictor selection.

## Usage

``` r
lambert
```

## Format

A tibble with 492 rows and 109 columns. Key variables include:

- pupil:

  Student identifier code. Type: character.

- rclass:

  Classroom type at entry. Type: numeric. Range: (1, 7). Coded classroom
  assignment.

- byear:

  Birth year (last two digits). Type: numeric. Range: (59, 73). E.g., 65
  = 1965.

- b3005:

  Sex. Type: character. Values: "M" = male, "F" = female.

- ethnic:

  Ethnicity code. Type: numeric. Values: 1 through 5.

- hm1:

  Hyperactivity marker. Type: character. Values: "Y" = yes, "N" = no.

Factor score variables (standardized composites, mean approximately 0):

- fs001:

  Factor score 1 (cognitive/behavioral composite). Type: numeric. Range:
  (-1.60, 3.65).

- fs004:

  Factor score 4. Type: numeric. Range: (-2.09, 2.86).

- fs006:

  Factor score 6. Type: numeric. Range: (-2.53, 1.70).

- fs011:

  Factor score 11. Type: numeric. Range: (-3.59, 2.27).

- fs014:

  Factor score 14. Type: numeric. Range: (-3.02, 2.60).

- fs015:

  Factor score 15. Type: numeric. Range: (-2.06, 4.53).

Teacher-rated behavioral scales (teacher report):

- tbyear:

  Teacher birth year. Type: numeric. Range: (74, 80). 15 NA.

- tagg:

  Teacher-rated aggression score. Type: numeric. Range: (8, 32). 24 NA.

- tatt:

  Teacher-rated attention score. Type: numeric. Range: (5, 20). 25 NA.

- tact:

  Teacher-rated activity level score. Type: numeric. Range: (4, 16). 24
  NA.

- timp:

  Teacher-rated impulsivity score. Type: numeric. Range: (3, 12). 23 NA.

- tadd:

  Teacher-rated ADD composite score. Type: numeric. Range: (8, 32). 28
  NA.

- tadhd:

  Teacher-rated ADHD composite score. Type: numeric. Range: (15, 60). 37
  NA.

- tcyear:

  Teacher cohort year. Type: numeric. Range: (74, 77). 2 NA.

Parent-rated behavioral scales (parent report):

- pagg:

  Parent-rated aggression. Type: numeric. Range: (4, 16). 9 NA.

- patt:

  Parent-rated attention. Type: numeric. Range: (5, 20). 13 NA.

- pact:

  Parent-rated activity. Type: numeric. Range: (3, 12). 8 NA.

- pimp:

  Parent-rated impulsivity. Type: numeric. Range: (4, 16). 20 NA.

- padd:

  Parent-rated ADD composite. Type: numeric. Range: (9, 36). 31 NA.

- padhd:

  Parent-rated ADHD composite. Type: numeric. Range: (12, 48). 34 NA.

Childhood interview items (ic = interview child, wave 1):

- ic1cc:

  Child interview composite score, wave 1. Type: numeric. Range: (1,
  10). 135 NA.

- ic027:

  Child interview item 027. Type: numeric. Range: (1, 3). 136 NA.

- ic028:

  Child interview item 028. Type: numeric. Range: (1, 3). 139 NA.

- ic036:

  Item rated 1-5. Type: numeric. Range: (1, 5). 163 NA.

- ic037:

  Item rated 1-5. Type: numeric. Range: (1, 5). 163 NA.

- ic038:

  Item rated 1-5. Type: numeric. Range: (1, 5). 163 NA.

- ic039:

  Item rated 1-5. Type: numeric. Range: (1, 5). 163 NA.

Follow-up interview items (if = interview follow-up):

- ifage:

  Age at follow-up interview. Type: numeric. Range: (7, 20). 190 NA.

- if027:

  Follow-up interview item 027. Type: numeric. Range: (1, 3). 195 NA.

- if028:

  Follow-up interview item 028. Type: numeric. Range: (1, 3). 196 NA.

- if036:

  Item rated 1-5. Type: numeric. Range: (1, 5). 194 NA.

- if037:

  Item rated 1-5. Type: numeric. Range: (1, 5). 195 NA.

- if038:

  Item rated 1-5. Type: numeric. Range: (1, 5). 196 NA.

- if039:

  Item rated 1-5. Type: numeric. Range: (1, 5). 195 NA.

Woodcock-Johnson achievement scores (wr prefix):

- wrage:

  Age at Woodcock-Johnson assessment. Type: numeric. Range: (5, 17). 180
  NA.

- wr016:

  WJ reading score, subtest 016. Type: numeric. Range: (49, 142). 180
  NA.

- wr017:

  WJ reading score, subtest 017. Type: numeric. Range: (46, 139). 180
  NA.

- wr018:

  WJ reading score, subtest 018. Type: numeric. Range: (43, 142). 180
  NA.

Classroom/teacher data (tr, cls prefix) at two time points:

- tr017_1:

  Teacher report item 017, time 1. Type: numeric. Range: (0, 96). 128
  NA.

- cls_ad_1:

  Classroom adaptive score, time 1. Type: numeric. Range: (25, 1200).
  128 NA.

- terper_1:

  Teacher perception score, time 1. Type: numeric. Range: (21, 900). 128
  NA.

- traper_1:

  Teacher-rated adaptive/perception, time 1. Type: numeric. Range: (47,
  1095). 129 NA.

- tr017_2:

  Teacher report item 017, time 2. Type: numeric. Range: (0, 12). 161
  NA.

- cls_ad_2:

  Classroom adaptive score, time 2. Type: numeric. Range: (0, 1150). 162
  NA.

- terper_2:

  Teacher perception score, time 2. Type: numeric. Range: (25, 840). 164
  NA.

- traper_2:

  Teacher-rated adaptive/perception, time 2. Type: numeric. Range: (0,
  1050). 166 NA.

IQ and cognitive assessment, wave 2 (i2 prefix):

- i21cc:

  Child interview composite score, wave 2. Type: numeric. Range: (1,
  10). 116 NA.

- i2004:

  IQ performance score. Type: numeric. Range: (6, 82). 115 NA.

- i2005:

  IQ verbal score. Type: numeric. Range: (1, 129). 115 NA.

- i2006:

  IQ composite percentile. Type: numeric. Range: (0, 99). 115 NA.

- i2007:

  IQ full scale standard score. Type: numeric. Range: (65, 135). 115 NA.

- i2014:

  Performance score, subtest. Type: numeric. Range: (18, 81). 125 NA.

- i2015:

  Verbal score, subtest. Type: numeric. Range: (19, 128). 125 NA.

- i2016:

  Composite percentile, subtest. Type: numeric. Range: (0, 99). 125 NA.

- i2017:

  Full scale standard score, subtest. Type: numeric. Range: (65, 135).
  125 NA.

Young adult well-being (wh prefix, self-report):

- wh1yy:

  Year of well-being assessment. Type: numeric. Range: (82, 86). 261 NA.

- wh024:

  Well-being item 024, rated 1-6. Type: numeric. 261 NA.

- wh025:

  Well-being item 025, rated 1-6. Type: numeric. 262 NA.

- wh036:

  Well-being item 036, rated 1-9. Type: numeric. 261 NA.

- wh038:

  Well-being item 038, rated 1-9. Type: numeric. 266 NA.

- wh054:

  Well-being item 054, rated 1-5. Type: numeric. 270 NA.

- wh060:

  Well-being item 060, rated 1-6. Type: numeric. 263 NA.

- wh061:

  Well-being item 061, rated 1-6. Type: numeric. 267 NA.

- wh093:

  Well-being item 093, rated 1-9. Type: numeric. 261 NA.

- wh239:

  Well-being item 239, rated 1-6. Type: numeric. 262 NA.

- wh240:

  Well-being item 240, rated 1-6. Type: numeric. 262 NA.

- wh241:

  Well-being item 241, rated 1-6. Type: numeric. 262 NA.

- wh242:

  Well-being item 242, rated 1-6. Type: numeric. 262 NA.

- wh243:

  Well-being item 243, rated 1-6. Type: numeric. 263 NA.

- wh244:

  Well-being item 244, rated 1-6. Type: numeric. 262 NA.

- wh245:

  Well-being item 245, rated 1-4. Type: numeric. 262 NA.

Mental health outcomes:

- depress:

  Depression scale score. Type: numeric. Range: (20, 58). 279 NA.

- anxiety:

  Anxiety scale score. Type: numeric. Range: (7, 25). 268 NA.

Interpersonal and family variables:

- ip150:

  Interpersonal functioning code. Type: character. Values: "A" through
  "G" and blank.

- fa128:

  Family structure indicator. Type: numeric. Values: 1, 2. 131 NA.

- fa129a:

  Family item 129a. Type: numeric. Range: (1, 8). 348 NA.

- fa129b:

  Family item 129b. Type: character. Values: "A", "B", "C", and blank.

Occupational outcomes (oc prefix):

- oc0yy:

  Year of occupational assessment. Type: numeric. Range: (91, 94). 113
  NA.

- ocstatus:

  Occupational status. Type: numeric. Range: (0, 4). 113 NA.

- oc014:

  Occupational prestige, item 014. Type: numeric. Range: (1, 21). 137
  NA.

- oc015:

  Occupational prestige, item 015. Type: numeric. Range: (1, 17). 145
  NA.

- oc032:

  Occupational item 032. Type: numeric. Range: (1, 4). 135 NA.

- oc035:

  Occupational item 035. Type: numeric. Range: (1, 5). 134 NA.

- oc036:

  Occupational item 036. Type: numeric. Range: (1, 5). 134 NA.

Derived composite scores:

- edlevel:

  Educational attainment level. Type: numeric. Range: (1, 10). 113 NA.

- actlevel:

  Activity level composite. Type: numeric. Range: (3, 15). 23 NA.

- persist:

  Persistence composite. Type: numeric. Range: (4, 19). 138 NA.

- adapt:

  Adaptability composite. Type: numeric. Range: (4, 19). 126 NA.

- mood:

  Mood composite. Type: numeric. Range: (4, 20). 9 NA.

- thold:

  Threshold composite. Type: numeric. Range: (2, 10). 21 NA.

Substance use (dg prefix):

- dg001:

  Substance use item 001. Type: numeric. Range: (1, 6). 109 NA.

- dg007:

  Substance use item 007. Type: numeric. Range: (1, 6). 102 NA.

- dg009:

  Substance use item 009 (age of first use). Type: character. Contains
  numeric ages or "NA"/blank.

- dg013:

  Substance use item 013 (age of first use). Type: character. Contains
  numeric ages or blank.

DSM diagnostic indicators (dsm prefix, coded 1-5):

- dsmtob:

  Tobacco use disorder. Type: numeric. Range: (1, 5). 112 NA.

- dsmgad:

  Generalized anxiety disorder. Type: numeric. Range: (1, 5). 112 NA.

- dsmdep:

  Major depression. Type: numeric. Range: (1, 5). 112 NA.

- dsmalc:

  Alcohol use disorder. Type: numeric. Range: (1, 5). 112 NA.

- dsmasp:

  Antisocial personality. Type: numeric. Range: (1, 5). 112 NA.

- dsmdg1:

  Drug disorder 1. Type: numeric. Range: (1, 5). 113 NA.

- dsmdg2:

  Drug disorder 2. Type: numeric. Range: (1, 5). 112 NA.

- dsmdg4:

  Drug disorder 4. Type: numeric. Range: (1, 5). 113 NA.

- dsmdg5:

  Drug disorder 5. Type: numeric. Range: (1, 5). 113 NA.

## Source

Lambert, N. M. (1988). Adolescent outcomes for hyperactive children.
*American Psychologist*, 43(10), 786-799. Original data file:
`lambert.dta`

## Details

This dataset is used in Chapter 12 (Latent Response Models and
Generalized Linear Models) to illustrate applications of latent variable
modeling and generalized linear models with longitudinal behavioral
data. Key analyses include: predicting adult outcomes from childhood
behavioral ratings, exploring the relationship between early ADHD
symptoms and later mental health, and handling substantial missing data
across waves.

## Examples

``` r
data(lambert)
# Predict depression from childhood ADHD ratings
sub <- lambert[!is.na(lambert$depress) & !is.na(lambert$tadhd), ]
lm(depress ~ tadhd, data = sub)
#> 
#> Call:
#> lm(formula = depress ~ tadhd, data = sub)
#> 
#> Coefficients:
#> (Intercept)        tadhd  
#>    33.74028      0.00367  
#> 
```
