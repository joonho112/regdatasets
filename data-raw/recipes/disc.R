# Recipe: disc
# 1. `race` is rebuilt from the NELS item bys31a with five levels; American
#    Indian students (bys31a = 5) were NA in v0.2.0 (Gate B DOC-1).
# 2. NELS nonresponse codes become NA, driven by audit/missing_codes.csv
#    (Gate B NR-2), and "don't know" on the ordered parental-education items
#    bys34a/bys34b stays NA as in v0.2.0 (Gate B DK-1).
recipe <- function() {
  x <- plain(read_raw("disc.dta"))
  old <- x$race
  stopifnot(all(is.na(old) | old == x$bys31a))
  x$race <- factor(ifelse(x$bys31a %in% 1:5, x$bys31a, NA), levels = 1:5,
                   labels = c("Asian", "Hispanic", "Black", "White", "American Indian"))
  codes_to_na(x, "disc")
}
