# Recipe: berkeley
# The raw Stata name `departme` (8-character limit) is restored to
# `department`, as in v0.2.0. Codes 1-5 are UCBAdmissions departments B-F.
recipe <- function() {
  x <- plain(read_raw("berkeley.dta"))
  names(x)[names(x) == "departme"] <- "department"
  x
}
