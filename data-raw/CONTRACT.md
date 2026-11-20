# regdatasets data contract (v1.0)

Every dataset shipped in `data/` must satisfy these rules. `data-raw/build_all.R`
refuses to save a dataset that breaks rules C1–C5 and C8. The test suite checks
C1–C8 on the installed data. C9 and C10 are checked by `data-raw/audit/` scripts
before every release.

Approved: Gate A and Gate B, 2026-11-20 (`data-raw/audit/gate_b_decisions.csv`).

| ID | Rule | Enforced by |
|----|------|-------------|
| **C1** | Each dataset is a `tbl_df` with at least one row. The package ships exactly the datasets listed in `inst/extdata/registry.csv` (22). | build assert · `test-contract.R` |
| **C2** | Column names and order are those of v0.2.0. Approved exception: `gcse` drops `pred` (COL-3). `lambert` and `civic_ed` are removed (PROV-1, PROV-2). | build assert against the codebook · `test-codebook.R` |
| **C3** | Column classes are those of v0.2.0: whole-number columns stay `integer`, others `double`, text stays `character`. `disc$race` and `disc2$race` are factors with levels `Asian`, `Hispanic`, `Black`, `White`, `American Indian` (DOC-1). | build assert against the codebook `type` · `test-codebook.R` |
| **C4** | No nonresponse code remains: no code with action `to_na` in `audit/missing_codes.csv`, no codebook code in `audit/missing_codes_codebook.csv` (NR-1b), no "don't know" code approved for `NA` (DK-1), no `""` string, no `"-1"` code string. | build assert · `test-regressions.R` |
| **C5** | Plain data: no attributes other than `names`, `row.names` and `class`, plus `levels` on factors. No `label`, `format.stata` or data-frame attributes. | build assert · `test-contract.R` |
| **C6** | Every column has exactly one codebook row, and every codebook row matches a column. | `test-codebook.R` |
| **C7** | Registry `n_rows` and `n_cols` equal the actual dimensions. | written by the build · `test-registry.R` |
| **C8** | Each file `data/<name>.rda` holds one object named `<name>`, saved with `compress = "xz"` and serialization version 3. | build · `test-contract.R` (via `tools::checkRdaFiles()`) |
| **C9** | Determinism: two consecutive builds produce identical value and object digests. | `audit/fingerprint.R` run twice (Step 4.5, release) |
| **C10** | Every value difference from v0.2.0 appears in `audit/rebuild_diff.csv` with an approved Gate B id. | `audit/rebuild_diff.R` (Step 4.5, release) |

## What "approved" means for values

A value may differ from v0.2.0 only through one of these Gate B items:

- **NR-1, NR-2:** NELS nonresponse codes → `NA` (`nels_data` 40,145 cells, `disc` 144).
- **NR-1b:** NELS codebook missing codes that are not integers (99.98, 99.99, 99.998, 9.8) in 14 continuous composites of `nels_data` → `NA` (1,356 cells); listed in `audit/missing_codes_codebook.csv`.
- **DK-1:** "don't know" on ordered scales → `NA` (`nels_data`: `bypared`, `bys34a`, `bys34b`, `f1s17`; 465 cells).
- **VAL-2:** `titanic$embarked` replaced from `source/titanic3.csv` (355 cells).
- **DOC-1:** `race` gains the level "American Indian" (68 students in `disc` and in `disc2`).
- **PROV-3:** `classdata_07` is a seeded simulated look-alike (every value).
- **COL-3:** `gcse$pred` dropped.
- **PROV-1, PROV-2:** `lambert` and `civic_ed` removed.

Anything else is a regression and must fail the build or the tests.
