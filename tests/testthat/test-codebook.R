# Codebook (contract C2, C3, C6).

test_that("C6: one codebook row per column, in order", {
  cb <- codebook_table()
  for (d in shipped_datasets()) {
    x <- get_dataset(d)
    v <- cb[cb$dataset == d, ]
    v <- v[order(v$position), ]
    expect_identical(
      as.integer(v$position), seq_along(x),
      label = paste(d, "positions")
    )
    expect_identical(
      v$variable, names(x),
      label = paste(d, "codebook variables")
    )
  }
  expect_setequal(unique(cb$dataset), shipped_datasets())
})

test_that("C3: column types match the codebook", {
  cb <- codebook_table()
  for (d in shipped_datasets()) {
    x <- get_dataset(d)
    v <- cb[cb$dataset == d, ]
    v <- v[order(v$position), ]
    typ <- vapply(
      x,
      function(col) if (is.factor(col)) "factor" else typeof(col),
      character(1)
    )
    expect_identical(unname(typ), v$type, label = paste(d, "types"))
  }
})

test_that("codebook NA counts are current and every row is curated", {
  cb <- codebook_table()
  expect_true(all(cb$status == "curated"))
  expect_false(anyNA(cb$label))
  for (d in shipped_datasets()) {
    x <- get_dataset(d)
    v <- cb[cb$dataset == d, ]
    v <- v[order(v$position), ]
    expect_equal(
      unname(vapply(x, function(col) sum(is.na(col)), numeric(1))),
      v$na_count,
      label = paste(d, "na_count")
    )
  }
})

test_that("every observed code of a coded variable is explained", {
  cb <- codebook_table()
  for (i in which(!is.na(cb$values))) {
    x <- get_dataset(cb$dataset[i])[[cb$variable[i]]]
    if (is.double(x) || is.factor(x)) next
    obs <- sort(unique(stats::na.omit(x)))
    if (length(obs) > 15) next
    codes <- gsub(
      '^"|"$', "",
      trimws(sub("=.*$", "", strsplit(cb$values[i], ";", fixed = TRUE)[[1]]))
    )
    in_range <- function(o) {
      any(vapply(codes[grepl("^[0-9]+-[0-9]+$", codes)], function(rg) {
        b <- as.numeric(strsplit(rg, "-")[[1]])
        as.numeric(o) >= b[1] && as.numeric(o) <= b[2]
      }, logical(1)))
    }
    ok <- vapply(
      as.character(obs),
      function(o) o %in% codes || in_range(o),
      logical(1)
    )
    expect(
      all(ok),
      sprintf(
        "%s$%s: unexplained code(s) %s",
        cb$dataset[i], cb$variable[i], paste(obs[!ok], collapse = ", ")
      )
    )
  }
})

test_that("recode counts are consistent with the NA counts", {
  cb <- codebook_table()
  r <- cb[!is.na(cb$recoded_to_na), ]
  n <- vapply(
    strsplit(r$recoded_to_na, ";", fixed = TRUE),
    function(p) sum(as.numeric(sub(".*:[[:space:]]*", "", p))),
    numeric(1)
  )
  expect_false(anyNA(n))
  expect_true(all(r$na_count >= n))
  # totals from the build's recode log (raw file -> shipped data)
  expect_equal(sum(n[r$dataset == "nels_data"]), 42048)
  expect_equal(sum(n[r$dataset == "disc"]), 626)
  expect_setequal(unique(r$dataset), c("disc", "nels_data"))
})

test_that("no Stata label artifacts remain in the codebook text", {
  cb <- codebook_table()
  for (k in c("label", "values", "units", "notes", "recoded_to_na")) {
    expect_false(
      any(grepl("^", cb[[k]], fixed = TRUE)),
      label = paste("caret in", k)
    )
  }
})
