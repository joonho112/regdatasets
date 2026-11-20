# missing_codes.R ------------------------------------------------------------
# Step 2.3: classify every labelled NELS code in nels_data, disc and disc2.
#
# The source of truth is the raw files' own value labels, not guesses about
# values. NELS marks nonresponse codes with these braced labels:
#   "{missing}", "{refusal}", "{legitimate skip}", "{multiple respnse}",
#   "{test not comp}".
# Braces alone are NOT enough: six variables (birthmo, birthyr, byfamsiz,
# f1s110da/mo/yr) use braced labels for real values, e.g. "{1990}", "{april}".
#   nonresponse label        -> action "to_na"
#   "don't know"-type label  -> action "review" (decided at Gate B)
#   anything else            -> action "keep" (a substantive response)
# disc.dta has no value labels; its NELS variables (bys*) borrow the labels of
# the same-named nels_data variables.
#
# Usage (from the package root):
#   Rscript data-raw/audit/missing_codes.R
# Output:
#   data-raw/audit/missing_codes.csv
#     n_cells_raw     cells holding the code in the raw file
#     n_cells_shipped cells holding the code in the v0.2.0 shipped data
# ---------------------------------------------------------------------------

suppressPackageStartupMessages({
  library(haven)
  library(tibble)
})

read_raw <- function(ds) haven::read_dta(file.path("data-raw/source", paste0(ds, ".dta")))
load_shipped <- function(ds) { e <- new.env(); load(file.path("data", paste0(ds, ".rda")), envir = e); get(ds, envir = e) }

nonresponse_labels <- c("{missing}", "{refusal}", "{legitimate skip}",
                        "{multiple respnse}", "{test not comp}")
classify <- function(label) {
  l <- tolower(trimws(label))
  ifelse(l %in% nonresponse_labels, "nonresponse",
         ifelse(grepl("don.?t know|do not know|dont know", l), "dont_know", "substantive"))
}
action_for <- function(cls) c(nonresponse = "to_na", dont_know = "review", substantive = "keep")[cls]
rationale_for <- function(cls) c(
  nonresponse = "Raw value label marks this code as NELS nonresponse ({missing}, {refusal}, {legitimate skip}, {multiple respnse} or {test not comp})",
  dont_know   = "\"Don't know\" is a non-substantive answer on some items but meaningful on others; decide per variable at Gate B",
  substantive = "Substantive response category; kept as is"
)[cls]

count_code <- function(x, code) {
  if (is.null(x)) return(NA_integer_)
  if (inherits(x, "haven_labelled")) x <- haven::zap_labels(x)
  if (is.factor(x)) return(NA_integer_)
  as.integer(sum(as.numeric(unclass(x)) == code, na.rm = TRUE))
}

rows <- list()
emit <- function(ds, v, var_label, labels, raw_col, shp_col, label_source) {
  if (is.null(labels) || !length(labels)) return(invisible())
  cls <- classify(names(labels))
  rows[[length(rows) + 1]] <<- data.frame(
    dataset = ds, variable = v,
    var_label = if (is.null(var_label)) "" else var_label,
    code = unname(as.numeric(labels)), code_label = names(labels),
    class = cls, action = unname(action_for(cls)),
    n_cells_raw = vapply(as.numeric(labels), function(cd) count_code(raw_col, cd), integer(1)),
    n_cells_shipped = vapply(as.numeric(labels), function(cd) count_code(shp_col, cd), integer(1)),
    label_source = label_source,
    rationale = unname(rationale_for(cls)),
    stringsAsFactors = FALSE
  )
}

nels_raw <- read_raw("nels_data")
nels_shp <- load_shipped("nels_data")
for (v in names(nels_raw)) {
  emit("nels_data", v, attr(nels_raw[[v]], "label", exact = TRUE), attr(nels_raw[[v]], "labels"),
       nels_raw[[v]], nels_shp[[v]], "nels_data.dta")
}

disc_raw <- read_raw("disc")
disc_shp <- load_shipped("disc")
for (v in names(disc_raw)) {
  own <- attr(disc_raw[[v]], "labels")
  if (!is.null(own)) {
    emit("disc", v, attr(disc_raw[[v]], "label", exact = TRUE), own, disc_raw[[v]], disc_shp[[v]], "disc.dta")
  } else if (v %in% names(nels_raw) && !is.null(attr(nels_raw[[v]], "labels"))) {
    emit("disc", v, attr(nels_raw[[v]], "label", exact = TRUE), attr(nels_raw[[v]], "labels"),
         disc_raw[[v]], disc_shp[[v]], "borrowed from nels_data.dta (same NELS variable name)")
  }
}

disc2_raw <- read_raw("disc2")
disc2_shp <- load_shipped("disc2")
for (v in names(disc2_raw)) {
  emit("disc2", v, attr(disc2_raw[[v]], "label", exact = TRUE), attr(disc2_raw[[v]], "labels"),
       disc2_raw[[v]], disc2_shp[[v]], "disc2.dta (labels partly stale: see anomalies.csv)")
}

out <- do.call(rbind, rows)
out <- out[order(out$dataset, out$variable, out$code), ]
utils::write.csv(out, "data-raw/audit/missing_codes.csv", row.names = FALSE, na = "")

# console summary: cells that would change if every "to_na" row is applied
for (ds in unique(out$dataset)) {
  d <- out[out$dataset == ds, ]
  cat(sprintf("%-10s label pairs=%4d | to_na pairs=%3d in %3d vars, shipped cells=%6d (raw %6d) | review pairs=%2d, shipped cells=%5d (raw %5d)\n",
              ds, nrow(d),
              sum(d$action == "to_na"), length(unique(d$variable[d$action == "to_na"])),
              sum(d$n_cells_shipped[d$action == "to_na"], na.rm = TRUE), sum(d$n_cells_raw[d$action == "to_na"], na.rm = TRUE),
              sum(d$action == "review"),
              sum(d$n_cells_shipped[d$action == "review"], na.rm = TRUE), sum(d$n_cells_raw[d$action == "review"], na.rm = TRUE)))
}
