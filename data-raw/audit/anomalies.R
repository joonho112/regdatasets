# anomalies.R ----------------------------------------------------------------
# Step 2.4: everything (other than labelled NELS codes, see missing_codes.R)
# that violates a clean-data expectation in the 24 shipped datasets.
#
# Rows come from two places:
#   (1) automatic scans of the shipped data and the raw Stata labels;
#   (2) a short list of known items found during the diagnosis, defined below.
# Each row carries a proposed action and whether it needs a decision at
# Gate B. Rows whose `action_code` is "to_na" are applied by the Phase 4
# recipes together with missing_codes.csv.
#
# Usage (from the package root):
#   Rscript data-raw/audit/anomalies.R
# Output:
#   data-raw/audit/anomalies.csv
# ---------------------------------------------------------------------------

suppressPackageStartupMessages({
  library(haven)
  library(tibble)
})

manifest <- utils::read.csv("data-raw/source/MANIFEST.csv", stringsAsFactors = FALSE)
manifest <- manifest[manifest$role == "raw", ]  # auxiliary sources (titanic3.csv) are not Stata files
load_shipped <- function(ds) { e <- new.env(); load(file.path("data", paste0(ds, ".rda")), envir = e); get(ds, envir = e) }

rows <- list()
add <- function(dataset, variable, issue, evidence, n_cells, proposed_action, action_code,
                needs_decision, decided_by = "") {
  rows[[length(rows) + 1]] <<- data.frame(
    dataset = dataset, variable = variable, issue = issue, evidence = evidence,
    n_cells = n_cells, proposed_action = proposed_action, action_code = action_code,
    needs_decision = needs_decision, decided_by = decided_by, stringsAsFactors = FALSE
  )
}

nels_family <- c("nels_data", "disc", "disc2")

for (i in seq_len(nrow(manifest))) {
  ds  <- manifest$dataset[i]
  shp <- load_shipped(ds)
  raw <- haven::read_dta(file.path("data-raw/source", manifest$file[i]))

  # (a) blank strings and "-1" code strings in character columns
  for (v in names(shp)[vapply(shp, is.character, logical(1))]) {
    nb <- sum(shp[[v]] == "", na.rm = TRUE)
    if (nb > 0) add(ds, v, "blank strings used for missing", sprintf("%d cells equal \"\"", nb), nb,
                    "Recode \"\" to NA", "to_na", FALSE, "D3 (Gate A)")
    nm1 <- sum(shp[[v]] == "-1", na.rm = TRUE)
    if (nm1 > 0) add(ds, v, "string \"-1\" used for missing", sprintf("%d cells equal \"-1\"", nm1), nm1,
                     "Recode \"-1\" to NA", "to_na", FALSE, "D3 (Gate A)")
    vals <- unique(stats::na.omit(shp[[v]]))
    if (length(vals) && !all(vals == "") &&
        all(grepl("^-?[0-9]+(\\.[0-9]+)?$", vals[vals != "" & vals != "-1"]))) {
      add(ds, v, "numeric codes stored as text",
          sprintf("all %d distinct values are numerals (e.g. %s)", length(vals), paste(utils::head(vals, 3), collapse = ", ")),
          NA, "Keep as text (D4 preserves types); document the code meanings in the codebook",
          "document", FALSE, "D4 (Gate A)")
    }
  }

  # (b) constant columns
  for (v in names(shp)) {
    u <- unique(stats::na.omit(as.vector(if (is.factor(shp[[v]])) as.character(shp[[v]]) else unclass(shp[[v]]))))
    if (length(u) == 1) add(ds, v, "constant column",
                            sprintf("every non-missing value equals %s", format(u)), nrow(shp),
                            "Keep (D4 preserves columns) and document as constant; or drop it (breaking)",
                            "keep_or_drop", TRUE)
  }

  # (c) raw value labels that do not describe the shipped values (stale labels)
  if (!ds %in% "nels_data") {
    for (v in names(raw)) {
      lab <- attr(raw[[v]], "labels")
      if (is.null(lab) || !v %in% names(shp) || is.factor(shp[[v]]) || is.character(shp[[v]])) next
      obs <- sort(unique(stats::na.omit(as.numeric(unclass(shp[[v]])))))
      if (length(obs) > 12) next  # continuous variable with a few labelled codes
      unlabelled_obs <- setdiff(obs, as.numeric(lab))
      if (length(unlabelled_obs)) {
        add(ds, v, "raw value labels do not cover the observed values",
            sprintf("observed {%s}; labelled {%s}", paste(obs, collapse = ","),
                    paste(sprintf("%s=%s", unname(lab), names(lab)), collapse = "; ")),
            NA, "Curate value meanings in the codebook; never copy these raw labels verbatim",
            "curate_labels", FALSE, "codebook (Phase 5)")
      }
    }
  }

  # (d) "don't know" codes outside the NELS family (from raw value labels)
  if (!ds %in% nels_family) {
    for (v in names(raw)) {
      lab <- attr(raw[[v]], "labels")
      if (is.null(lab)) next
      dk <- lab[grepl("don.?t know", names(lab), ignore.case = TRUE)]
      for (k in seq_along(dk)) {
        n <- sum(as.numeric(unclass(shp[[v]])) == dk[[k]], na.rm = TRUE)
        add(ds, v, "\"don't know\" coded as a number",
            sprintf("%s = \"%s\"; %d cells", dk[[k]], names(dk)[k], n), n,
            "Decide: recode to NA, or keep as a category", "review", TRUE)
      }
    }
  }

  # (e) exact duplicate rows
  nd <- sum(duplicated(as.data.frame(shp)))
  if (nd > 0) add(ds, "", "exact duplicate rows",
                  sprintf("%d of %d rows duplicate an earlier row", nd, nrow(shp)), nd,
                  if (ncol(shp) <= 6) "Expected: individual records expanded from a contingency table or few variables; document the unit of analysis" else "Check whether duplicates are genuine records; document",
                  "document", FALSE)

  # (f) Stata residue and partial labels (removed under D5)
  nf <- sum(vapply(shp, function(c) !is.null(attr(c, "format.stata")), logical(1)))
  nl <- sum(vapply(shp, function(c) !is.null(attr(c, "label", exact = TRUE)), logical(1)))
  dfa <- setdiff(names(attributes(shp)), c("names", "row.names", "class"))
  if (nf + nl + length(dfa) > 0) {
    add(ds, "", "Stata attributes left on the data",
        sprintf("format.stata on %d columns; label on %d columns; data-frame attributes: %s",
                nf, nl, if (length(dfa)) paste(dfa, collapse = ", ") else "none"),
        NA, "Strip all attributes (plain tibble)", "strip_attributes", FALSE, "D5 (Gate A)")
  }
}

# (2) known items from the diagnosis ------------------------------------------
add("classdata_07", "alcohol", "impossible value -1",
    "1 of 44 students reports -1 (drinks); every other value is 0-10", 1,
    "Recode -1 to NA (most likely a missing-value code)", "to_na_value:-1", TRUE)
add("individuals", "earn", "negative earnings",
    "170 of 55,899 values are negative (minimum -24,998)", 170,
    "Keep: negative earnings are possible in CPS income (e.g. business losses); document", "document", FALSE)
add("gss_1", "abortion", "fractional values on a count-like scale",
    "172 values are non-integers (e.g. 1.17, 2.33, 4.67); range 0-7", 172,
    "Keep: looks like a prorated scale score for respondents with partial item data; confirm and document", "document", FALSE)
add("gcse", "pred", "possible stored model prediction",
    "2,028 distinct values in [-1.91, 2.54]; same origin as the u0/u1 model columns removed in 0.2.0; not mentioned in course materials", 4059,
    "Decide: keep and document what it is, or drop (breaking: column count changes)", "keep_or_drop", TRUE)
add("berkeley", "department", "codes without meanings",
    "values 1-5 with no value labels in the raw file; the classic UCBAdmissions table has 6 departments (A-F)", NA,
    "Establish the code -> department mapping (provenance research) and document it", "document", FALSE)
add("disc", "bys34a, bys34b", "inconsistent 0.2.0 cleaning",
    "0.2.0 recoded 8 (\"don't know\") and 98 ({missing}) to NA but kept 97 ({refusal}) on a 1-7 scale; see missing_codes.csv", NA,
    "Apply the label-based rule from missing_codes.csv; the 8 = \"don't know\" treatment is a Gate B decision", "see_missing_codes", TRUE)
for (ds_race in c("disc", "disc2")) {
  add(ds_race, "race", "American Indian students coded as missing",
      "race is derived from NELS bys31a (1 = Asian/Pacific Islander, 2 = Hispanic, 3 = Black, 4 = White); the 68 American Indian students (bys31a = 5) and 24 nonrespondents are NA (92 NA in total). Verified against the raw files; the 0.2.0 factor labels match the codes", 68,
      "Decide: document the exclusion clearly (no value change), or add an \"American Indian\" level (changes factor levels)", "document_or_add_level", TRUE)
}
add("reading", "group, method", "same information coded twice",
    "group (text: Basal/DRTA/Strat) and method (1/2/3) carry identical information", NA,
    "Keep both (D4); document that they are the same factor", "document", FALSE)

out <- do.call(rbind, rows)
out <- out[order(out$dataset, out$variable, out$issue), ]
utils::write.csv(out, "data-raw/audit/anomalies.csv", row.names = FALSE, na = "")
cat(sprintf("anomalies.csv: %d rows (%d need a decision at Gate B)\n", nrow(out), sum(out$needs_decision)))
print(table(out$action_code))
