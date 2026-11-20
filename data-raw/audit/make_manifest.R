# make_manifest.R -----------------------------------------------------------
# Checksum manifest of every vendored source file in data-raw/source/.
#
# Usage (from the package root):
#   Rscript data-raw/audit/make_manifest.R "<folder holding the original .dta files>"
#
# - Raw Stata files (role "raw") must be byte-identical to their originals
#   in the given folder; the script stops otherwise.
# - Auxiliary sources (role "auxiliary", e.g. titanic3.csv used to correct
#   titanic$embarked) are recorded with their checksum and origin URL.
# - Datasets removed at Gate B (lambert, civic_ed) and the original
#   classdata_07 class survey (replaced by a simulation) are deliberately NOT
#   vendored: they have no redistribution basis.
# Writes data-raw/source/MANIFEST.csv.
# ---------------------------------------------------------------------------
src <- commandArgs(trailingOnly = TRUE)[1]
sha_of <- function(p) digest::digest(file = p, algo = "sha256")

dta <- sort(list.files("data-raw/source", pattern = "[.]dta$"))
removed <- c("lambert.dta", "civic_ed.dta", "classdata_07.dta", "naep.dta")  # not redistributable (Gate B PROV-1/2/3)
stopifnot(!any(dta %in% removed))
ds <- sub("[.]dta$", "", dta)
ds[ds == "gss-1"] <- "gss_1"   # R object names cannot contain "-"
vendored <- vapply(file.path("data-raw/source", dta), sha_of, character(1))
original <- vapply(file.path(src, dta), sha_of, character(1))
stopifnot(identical(unname(vendored), unname(original)))

raw <- data.frame(
  dataset = ds, file = dta, role = "raw", sha256 = unname(vendored),
  bytes = unname(file.size(file.path("data-raw/source", dta))),
  origin = "course dataset folder (Stata files as distributed in UC Berkeley EDUC 275B)",
  origin_date = format(file.mtime(file.path(src, dta)), "%Y-%m-%d"),
  stringsAsFactors = FALSE
)
aux <- data.frame(
  dataset = "titanic", file = "titanic3.csv", role = "auxiliary",
  sha256 = sha_of("data-raw/source/titanic3.csv"),
  bytes = file.size("data-raw/source/titanic3.csv"),
  origin = "https://hbiostat.org/data/repo/titanic3.csv (Vanderbilt Biostatistics; T. Cason, 1999)",
  origin_date = "2026-11-20 (downloaded)",
  stringsAsFactors = FALSE
)
sim <- data.frame(
  dataset = "classdata_07", file = "(none)", role = "simulated", sha256 = "", bytes = 0,
  origin = "seeded simulation in data-raw/recipes/classdata_07.R (Gate B PROV-3); the 2007 class survey is not vendored",
  origin_date = "2026-11-20", stringsAsFactors = FALSE
)
m <- rbind(raw, aux, sim)
m <- m[order(m$dataset, m$role != "raw"), ]
utils::write.csv(m, "data-raw/source/MANIFEST.csv", row.names = FALSE)
cat(nrow(m), "rows (", sum(m$role == "raw"), "raw +", sum(m$role == "auxiliary"), "auxiliary +", sum(m$role == "simulated"), "simulated ),",
    round(sum(m$bytes) / 1024^2, 2), "MB; raw files byte-identical to the originals\n")
