# Recipe: hsbs1
# Values identical to v0.2.0; only Stata attributes are dropped (contract C5).
recipe <- function() {
  plain(read_raw("hsbs1.dta"))
}
