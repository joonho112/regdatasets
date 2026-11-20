# Recipe: titanic
# Blank embarkation ports become NA (as in v0.2.0). `embarked` is then taken
# from the titanic3 source file (Vanderbilt Biostatistics), because the 2009
# course file had this column misaligned for 355 passengers (Gate B VAL-2).
# The rows are checked to be the same passengers, in the same order, first.
recipe <- function() {
  x  <- plain(read_raw("titanic.dta"))
  t3 <- utils::read.csv(source_file("titanic3.csv"), stringsAsFactors = FALSE,
                        na.strings = c("", "NA"))
  same_num <- function(a, b, tol) all((is.na(a) & is.na(b)) | (!is.na(a) & !is.na(b) & abs(a - b) < tol))
  stopifnot(
    nrow(t3) == nrow(x),
    all(t3$pclass == x$pclass),
    all(t3$survived == x$survived),
    all((t3$sex == "female") == (x$sex == 1L)),
    same_num(t3$fare, x$fare, 1e-3),
    same_num(t3$age, x$age, 5e-3)       # titanic3.csv rounds ages to 2 decimals
  )
  x$embarked <- t3$embarked
  x
}
