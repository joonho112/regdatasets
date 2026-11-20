# Recipe: gss_1 (raw file gss-1.dta)
# Values identical to v0.2.0; only Stata attributes are dropped (contract C5).
recipe <- function() {
  plain(read_raw("gss-1.dta"))
}
