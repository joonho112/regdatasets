# codebook_nels.R -------------------------------------------------------------
# Step 5.3: curate the nels_data codebook (299 variables) from the NELS:88
# labels in the raw file, which come from the NCES codebook.
# - labels: NCES wording, lightly cleaned (r's -> student's, Stata ^ -> ').
# - values: value labels, minus nonresponse codes and the ordered-scale
#   "don't know" codes recoded to NA (Gate B NR-1, NR-1b, DK-1).
# - group: questionnaire section, used to lay out the help page.
# - recoded_to_na: rebuilt from audit/recode_log.csv.
# Run from the package root after data-raw/codebook_draft.R.
# ---------------------------------------------------------------------------
draft  <- utils::read.csv("data-raw/codebook/nels_data.csv", stringsAsFactors = FALSE, na.strings = "")
recode <- utils::read.csv("data-raw/audit/recode_log.csv", stringsAsFactors = FALSE)
recode <- recode[recode$dataset == "nels_data", ]
mc     <- utils::read.csv("data-raw/audit/missing_codes.csv", stringsAsFactors = FALSE)
dk1 <- c("bypared", "bys34a", "bys34b", "f1s17")
dk2 <- unique(mc$variable[mc$dataset == "nels_data" & mc$action == "review" & !mc$variable %in% dk1])
nr1b <- unique(recode$variable[recode$gate_b == "NR-1b"])

clean_text <- function(x) {
  x <- ifelse(is.na(x), "", x)
  x <- gsub("\\^", "'", x)
  x <- gsub("\\br's\\b", "student's", x)
  x <- gsub("\\br\\b", "student", x)
  x <- gsub("\\bstudnt\\b", "student", x)
  x <- gsub("\\bsomethng\\b", "something", x, ignore.case = TRUE)
  x <- gsub("\\boccuptn\\b", "occupation", x, ignore.case = TRUE)
  x <- gsub("\\bthngs\\b", "things", x, ignore.case = TRUE)
  x <- gsub("\\bprnts\\b", "parents", x, ignore.case = TRUE)
  x <- gsub("\\bgettng\\b", "getting", x, ignore.case = TRUE)
  x <- gsub("\\bemployd\\b", "employed", x, ignore.case = TRUE)
  x <- gsub("\\bschl\\b", "school", x, ignore.case = TRUE)
  x <- gsub("\\bwth\\b", "with", x, ignore.case = TRUE)
  x <- gsub("\\bgrds\\b", "grades", x, ignore.case = TRUE)
  x <- gsub("\\bfrm\\b", "from", x, ignore.case = TRUE)
  x <- gsub("\\bspokn\\b", "spoken", x, ignore.case = TRUE)
  x <- gsub("\\badministratr\\b", "administrator", x, ignore.case = TRUE)
  x <- gsub("\\bbusinss\\b", "business", x, ignore.case = TRUE)
  x <- gsub("\\bguardn\\b", "guardian", x, ignore.case = TRUE)
  x <- gsub("\\bfrnds\\b", "friends", x, ignore.case = TRUE)
  x <- gsub("\\boftn\\b", "often", x, ignore.case = TRUE)
  x <- gsub("\\bprsnt\\b", "present", x, ignore.case = TRUE)
  x <- gsub("\\breportd\\b", "reported", x, ignore.case = TRUE)
  x <- gsub("\\bwrkd\\b", "worked", x, ignore.case = TRUE)
  x <- gsub("\\bchld\\b", "child", x, ignore.case = TRUE)
  x <- gsub("advancd,enrichd,accelertd", "advanced, enriched, accelerated", x, ignore.case = TRUE)
  x <- gsub("\\bstuds\\b", "students", x, ignore.case = TRUE)
  x <- gsub("\\benglish\\b", "English", x)
  x <- gsub("\\bi\\b", "I", x)
  x <- gsub("Socio-economic", "Socioeconomic", x, fixed = TRUE)
  x <- gsub("Self concept", "Self-concept", x, fixed = TRUE)
  x <- gsub("\\s+", " ", trimws(x))
  x
}
cap <- function(x) ifelse(nzchar(x), paste0(toupper(substr(x, 1, 1)), substr(x, 2, nchar(x))), x)

cb <- draft
cb$label <- cap(clean_text(sub("^(locus[12])\\s+", "", cb$label)))
cb$values <- clean_text(cb$values)

# ordered-scale "don't know" codes are now NA: drop them from the value list
for (v in dk1) {
  i <- which(cb$variable == v)
  parts <- strsplit(cb$values[i], "; ", fixed = TRUE)[[1]]
  cb$values[i] <- paste(parts[!grepl("don't know", parts, ignore.case = TRUE)], collapse = "; ")
}

# variables whose "value labels" were just braced copies of the values
months <- paste(sprintf("%d = %s", 1:12, month.name), collapse = "; ")
special <- list(
  birthmo  = list(values = months, units = ""),
  birthyr  = list(values = "72 = 1972 or earlier; 73 = 1973; 74 = 1974; 75 = 1975 or later", units = ""),
  byfamsiz = list(values = "2-9 = number of people in the household; 10 = 10 or more", units = "people"),
  f1s110mo = list(values = months, units = ""),
  f1s110da = list(values = "", units = "day of the month"),
  f1s110yr = list(values = "89 = 1989; 90 = 1990; 91 = 1991", units = "")
)
for (v in names(special)) {
  i <- which(cb$variable == v)
  cb$values[i] <- special[[v]]$values
  cb$units[i]  <- special[[v]]$units
}

# units for the continuous composites
units <- c(
  by2xrstd = "T-score (mean 50, SD 10)", by2xmstd = "T-score (mean 50, SD 10)",
  by2xsstd = "T-score (mean 50, SD 10)", by2xhstd = "T-score (mean 50, SD 10)",
  f12xrstd = "T-score (mean 50, SD 10)",
  byses = "standardized composite (z-score units)", f1ses = "standardized composite (z-score units)",
  bylocus1 = "standardized composite", bylocus2 = "standardized composite",
  bycncpt1 = "standardized composite", bycncpt2 = "standardized composite",
  f1locus1 = "standardized composite", f1locus2 = "standardized composite",
  f1cncpt1 = "standardized composite", f1cncpt2 = "standardized composite",
  bygrads = "grade-point scale (0.5 to 4.0)"
)
cb$units[match(names(units), cb$variable)] <- unname(units)

# questionnaire sections for the help page
v <- cb$variable
cb$group <- ifelse(v == "id", "Identifier",
  ifelse(grepl("^bys[0-9]", v), "Base year (1988, grade 8): student questionnaire",
  ifelse(v %in% c("byscenrl", "g8urban", "g8regon", "g8minor", "g8lunch"), "Base year: school characteristics",
  ifelse(grepl("^by2x", v), "Base year: cognitive tests",
  ifelse(grepl("^(by|birth)", v), "Base year: composites",
  ifelse(grepl("^f1s[0-9]", v), "First follow-up (1990, grade 10): student questionnaire",
  ifelse(v == "f12xrstd", "First follow-up: cognitive test",
  ifelse(grepl("^f1", v), "First follow-up: composites and status",
         "Not NELS:88 variables"))))))))

# what 1.0.0 recoded to NA, per variable
cb$recoded_to_na <- vapply(v, function(x) {
  r <- recode[recode$variable == x, ]
  if (!nrow(r)) return("")
  paste(sprintf("%s %s: %d", trimws(format(r$code, drop0trailing = TRUE)), gsub("\\^", "'", r$code_label), r$n_cells), collapse = "; ")
}, character(1))

cb$notes <- ""
cb$notes[v == "id"] <- "NELS:88 student ID (STU_ID in the NCES files)"
cb$label[v == "id"] <- "Student identifier"
for (x in c("year1", "year2")) {
  cb$label[v == x] <- "Undocumented variable"
  cb$notes[v == x] <- "Not a NELS:88 variable; its meaning is not documented in the course source"
}
cb$notes[v %in% dk1] <- "\"Don't know\" answers were recoded to NA in 1.0.0 because the scale is ordered"
cb$notes[v %in% dk2] <- "\"Don't know\" is kept as its own category; analyze this variable as a factor"
cb$notes[v %in% nr1b & cb$notes == ""] <- "Missing-value codes from the NELS codebook (e.g. 99.98) were recoded to NA in 1.0.0"

cb$status <- "curated"
cols <- c("dataset", "variable", "position", "type", "label", "values", "units",
          "group", "recoded_to_na", "notes", "status")
utils::write.csv(cb[, cols], "data-raw/codebook/nels_data.csv", row.names = FALSE, na = "", fileEncoding = "UTF-8")
cat(sprintf("nels_data codebook curated: %d variables, %d groups, %d with recoded_to_na, empty labels: %d\n",
            nrow(cb), length(unique(cb$group)), sum(nzchar(cb$recoded_to_na)), sum(!nzchar(cb$label))))
print(table(cb$group))
