# Recipe: alcohol1_pp
# Values identical to v0.2.0; only Stata attributes are dropped (contract C5).
recipe <- function() {
  plain(read_raw("alcohol1_pp.dta"))
}
