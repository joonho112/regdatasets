#' List All Datasets in regdatasets
#'
#' Returns a tibble summarizing all datasets in the package, including
#' their dimensions, primary chapter usage, and a brief description.
#'
#' @return A tibble with columns: \code{dataset} (character), \code{rows}
#'   (integer), \code{cols} (integer), \code{chapter} (character), and
#'   \code{description} (character).
#'
#' @examples
#' list_datasets()
#'
#' @export
list_datasets <- function() {
  tibble::tibble(
    dataset = c(
      "alcohol1_pp", "berk_sub", "berkeley", "civic_ed", "classdata_07",
      "crime", "disc", "disc2", "faculty", "gcse", "grades", "gss_1",
      "hsb_sub", "hsbs1", "individuals", "instruction", "lambert",
      "nels_data", "penalty", "pisa2000", "reading", "satisfaction",
      "titanic", "womenlf"
    ),
    rows = c(
      246L, 1169L, 3593L, 794L, 44L, 67L, 2000L, 2000L, 514L, 4059L,
      198L, 2832L, 188L, 350L, 55899L, 1190L, 492L, 2000L, 674L,
      4528L, 66L, 110L, 1309L, 263L
    ),
    cols = c(
      9L, 3L, 3L, 237L, 12L, 5L, 15L, 15L, 10L, 6L, 8L, 16L, 7L,
      16L, 6L, 12L, 109L, 299L, 3L, 15L, 8L, 3L, 6L, 5L
    ),
    chapter = c(
      "Supplementary", "Ch 10", "Ch 10-11", "Supplementary", "Ch 1",
      "Ch 4-5", "Ch 9-13", "Ch 9-13", "Ch 4-8", "Ch 1-2, 5",
      "Ch 12", "Ch 9", "Ch 6-7", "Ch 8", "Ch 5", "Ch 2-3",
      "Ch 12", "Ch 7-8", "Ch 11", "Ch 1", "Ch 3", "Ch 13",
      "Ch 9-11", "Ch 13"
    ),
    description = c(
      "Adolescent alcohol use (person-period longitudinal)",
      "Berkeley admissions subset (2 departments, Simpson's paradox)",
      "UC Berkeley admissions (5 departments)",
      "Civic education pre/post survey (16 schools)",
      "Class survey data (study habits, height, weight)",
      "Florida county crime rates",
      "NELS:88 school discipline (original NELS variable names)",
      "NELS:88 school discipline (with SES and test scores)",
      "Faculty salaries and experience",
      "GCSE and London Reading Test scores (65 schools)",
      "Essay grades and writing features",
      "General Social Survey 1982/1994",
      "High School and Beyond subset (5 schools, nested)",
      "High School and Beyond (diagnostics focus)",
      "BLS wage data by gender and sector",
      "Math achievement gains (multilevel, classrooms in schools)",
      "ADHD longitudinal study (childhood to adulthood)",
      "NELS:88 full dataset (model building, diagnostics)",
      "Death penalty sentencing by race",
      "OECD PISA 2000 reading scores (3 countries)",
      "Three-group reading instruction experiment",
      "Ordinal satisfaction survey (simulated)",
      "Titanic passenger survival",
      "Canadian women's labour-force participation"
    )
  )
}
