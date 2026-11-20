# data-raw: how the regdatasets data are built

`data/*.rda` are **build outputs**. Never edit them by hand.

## The one rule

> Edit `data-raw/` (recipes, codebook CSVs) or `inst/extdata/registry.csv`, then run
>
> ```r
> source("data-raw/build_all.R")   # rebuild data/ and the compiled metadata
> devtools::document()             # regenerate help pages
> devtools::check()                # contract tests + R CMD check
> ```
>
> from the package root. Nothing else.

## Layout

| Path | What it is |
|---|---|
| `source/*.dta`, `source/titanic3.csv` | Vendored raw files: the 22 original Stata files (2017) and the titanic3 source used to correct `embarked`. `lambert` and `civic_ed` are deliberately not vendored (no redistribution basis). Never edited. |
| `source/MANIFEST.csv` | SHA-256 checksum, size and origin of every raw file. The build refuses a file whose checksum does not match. |
| `recipes/<name>.R` | One recipe per dataset: a function `recipe(raw)` that turns the raw file into the shipped tibble. |
| `codebook/<name>.csv` | Curated variable metadata, one file per dataset (schema below). |
| `build_all.R` | Runs every recipe, checks the contract, saves `data/`, and compiles `inst/extdata/codebook.csv` and the registry dimensions. |
| `helpers.R` | Shared helpers used by the recipes (`read_raw()`, `codes_to_na()`, `assert_contract()`, …). |
| `CONTRACT.md` | The rules every shipped dataset must satisfy. |
| `audit/` | Audit scripts and their outputs: the v0.2.0 fingerprint, raw-vs-shipped diff, missing codes, anomalies, provenance, Gate B decisions, rebuild diff. |

## Schemas

### `inst/extdata/registry.csv`: one row per shipped dataset

| Column | Meaning | Filled by |
|---|---|---|
| `dataset` | object name | hand |
| `title` | short title (also the help-page title) | hand |
| `description` | one sentence for listings | hand |
| `topics` | `;`-separated terms from the vocabulary below | hand |
| `unit` | what one row is | hand |
| `n_rows`, `n_cols` | dimensions | **build** |
| `source_citation` | the original source (APA style) | hand, from `audit/provenance.csv` |
| `source_route` | how the data reached the package (textbook, companion data, course) | hand |
| `source_url` | where the original or its documentation lives | hand |
| `redistribution_basis` | why the package may ship it | hand |
| `provenance_status` | `verified` / `probable` | hand |
| `raw_file`, `raw_sha256` | the vendored raw file | **build** (from `source/MANIFEST.csv`) |
| `related` | `;`-separated related datasets | hand |
| `values_changed_in` | the last version that changed values (`1.0.0`, or blank) | hand |

### `data-raw/codebook/<name>.csv` → compiled `inst/extdata/codebook.csv`

| Column | Meaning |
|---|---|
| `dataset`, `variable`, `position` | identity (position = column order) |
| `type` | `integer`, `double`, `character` or `factor` (the contract type, C3) |
| `label` | short human label |
| `values` | value meanings, e.g. `0 = female; 1 = male`; for factors, the levels in order |
| `units` | e.g. `US dollars`, `years`, `score x 10` |
| `group` | section heading used to group variables on the help page of wide datasets |
| `recoded_to_na` | codes of the raw file that the build turns into `NA`, with cell counts, e.g. `8 {missing}: 112; 9 {legitimate skip}: 40` (a few were already `NA` in v0.2.0; `audit/rebuild_diff.csv` lists what changed against v0.2.0) |
| `notes` | anything a student should know |
| `na_count` | `NA`s in the shipped data (**build**) |

### Topics vocabulary

`simple-regression` · `ancova` · `anova` · `continuous-predictors` · `interactions` ·
`nonlinear` · `model-building` · `diagnostics` · `logistic` · `glm-latent` · `ordinal` ·
`multilevel-longitudinal`
