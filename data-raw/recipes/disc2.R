# Recipe: disc2
# disc2 holds the same 2,000 students as disc, in the same order. Its `race`
# factor is rebuilt from disc's NELS item bys31a so that American Indian
# students (bys31a = 5) get their own level instead of NA (Gate B DOC-1).
recipe <- function() {
  x <- plain(read_raw("disc2.dta"))
  bys31a <- as.integer(haven::zap_labels(read_raw("disc.dta")$bys31a))
  old <- x$race                                    # raw codes 1-4, NA otherwise
  stopifnot(all(is.na(old) | old == bys31a))       # same students, same coding
  x$race <- factor(ifelse(bys31a %in% 1:5, bys31a, NA), levels = 1:5,
                   labels = c("Asian", "Hispanic", "Black", "White", "American Indian"))
  x
}
