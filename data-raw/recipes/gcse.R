# Recipe: gcse
# Drops the stored model output of the original course file: u0, u1 and
# filter__ (dropped in v0.2.0) and pred (dropped in v1.0.0, Gate B COL-3).
recipe <- function() {
  x <- plain(read_raw("gcse.dta"))
  x[, setdiff(names(x), c("u0", "u1", "filter__", "pred"))]
}
