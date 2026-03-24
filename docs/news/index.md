# Changelog

## regdatasets 0.2.0

### Breaking Changes

- **`naep` dataset removed**: The NAEP 2005 Grade 8 Mathematics dataset
  (17,606 x 301) has been removed because respondent-level NAEP
  microdata with weights are restricted-use under NCES data licensing
  policy. The package now contains 24 datasets. For NAEP analyses, use
  the `EdSurvey` R package to access NAEP data directly from NCES.

- **`berkeley$departme` renamed to `department`**: The truncated Stata
  8-character variable name has been corrected. Code using
  `berkeley$departme` will need to be updated.

- **`gcse` reduced from 9 to 6 columns**: Removed `u0`, `u1`, and
  `filter__` columns, which contained Stata multilevel model artifacts
  (placeholder values of -1e30). Remaining columns: `school`, `student`,
  `gcse`, `lrt`, `gender`, `pred`.

### Data Cleaning

- **Sentinel missing values recoded to `NA`** in `disc` (variables
  `bys34a`, `bys34b`: codes 8 and 98) and `nels_data` (82 sentinel
  values across multiple variables: codes 99.98, 99.99, 99.998, 998,
  100).

- **`titanic$embarked`**: Two blank strings converted to `NA`.

- **`disc$race` and `disc2$race`**: Converted from integer codes (1-4)
  to unordered factor with levels: Asian, Hispanic, Black, White.

### New Features

- **[`list_datasets()`](https://joonho112.github.io/regdatasets/reference/list_datasets.md)
  function**: Returns a tibble summarizing all 24 datasets with name,
  dimensions, chapter mapping, and description.

- **`LICENSE.note`**: New file documenting data source provenance and
  redistribution basis for each dataset.

- **`inst/CITATION`**: Added so `citation("regdatasets")` returns a
  proper bibliographic entry.

### Documentation Improvements

- **Ethical context sections** added to `penalty` (racial disparities in
  capital sentencing, Radelet 1981, McCleskey v. Kemp), `disc` and
  `disc2` (school-to-prison pipeline, race in school discipline), and
  `titanic` (note of respect for individuals represented).

- **Cross-references** (`@seealso`) added linking related dataset pairs:
  `berk_sub`/`berkeley`, `disc`/`disc2`, `hsb_sub`/`hsbs1`, plus
  `womenlf`/[`carData::Womenlf`](https://rdrr.io/pkg/carData/man/Womenlf.html)
  overlap disclosure and
  `berkeley`/[`datasets::UCBAdmissions`](https://rdrr.io/r/datasets/UCBAdmissions.html)
  comparison.

- **`gcse` source citation** completed: Goldstein, H., Rasbash, J.,
  Yang, M., et al. (1993). Oxford Review of Education, 19(4), 425-433.

- Updated `disc`/`disc2` documentation to reflect sentinel value
  cleaning and race factor conversion.

### Package Engineering

- Added `tibble` to `Imports` in `DESCRIPTION` to ensure correct
  deserialization of tibble objects.

- **Expanded test suite**: From 73 lines / 4 tests to comprehensive
  coverage of all 24 datasets (tibble class, dimensions, column names,
  factor levels, sentinel value absence, binary variable validation,
  Stata artifact absence).

- Added `NEWS.md` (this file).

## regdatasets 0.1.0

- Initial release with 25 datasets for BER 640.
