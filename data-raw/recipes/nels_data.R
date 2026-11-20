# Recipe: nels_data
# NELS nonresponse codes ({missing}, {legitimate skip}, {multiple respnse},
# {test not comp}, {refusal}) become NA, driven by audit/missing_codes.csv
# (Gate B NR-1), and "don't know" on the ordered items bypared, bys34a, bys34b
# and f1s17 becomes NA (Gate B DK-1). "Don't know" on nominal items is kept.
recipe <- function() {
  codes_to_na(plain(read_raw("nels_data.dta")), "nels_data")
}
