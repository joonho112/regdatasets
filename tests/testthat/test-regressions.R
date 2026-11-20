# Fixes that must stay fixed (contract C2, C4 and the Gate B decisions).

test_that("removed datasets and columns stay removed", {
  expect_false(any(c("lambert", "civic_ed", "naep") %in% shipped_datasets()))
  gcse <- get_dataset("gcse")
  expect_named(gcse, c("school", "student", "gcse", "lrt", "gender"))
  expect_false(any(c("u0", "u1", "filter__", "pred") %in% names(gcse)))
  for (v in names(gcse)) {
    if (is.numeric(gcse[[v]])) {
      expect_true(
        all(gcse[[v]] > -1e20 | is.na(gcse[[v]])),
        label = paste0("gcse$", v)
      )
    }
  }
  berkeley <- get_dataset("berkeley")
  expect_true("department" %in% names(berkeley))
  expect_false("departme" %in% names(berkeley))
})

test_that("C4: no blank or '-1' strings remain", {
  for (d in shipped_datasets()) {
    x <- get_dataset(d)
    for (v in names(x)[vapply(x, is.character, logical(1))]) {
      expect_false(any(x[[v]] %in% c("", "-1")), label = paste0(d, "$", v))
    }
  }
})

test_that("C4: every recoded NELS and disc nonresponse code is gone", {
  cb <- codebook_table()
  r <- cb[!is.na(cb$recoded_to_na), ]
  cache <- list()
  for (i in seq_len(nrow(r))) {
    d <- r$dataset[i]
    v <- r$variable[i]
    if (is.null(cache[[d]])) cache[[d]] <- get_dataset(d)
    col <- cache[[d]][[v]]
    parts <- trimws(strsplit(r$recoded_to_na[i], ";", fixed = TRUE)[[1]])
    codes <- as.numeric(sub(" .*$", "", parts))
    for (code in codes) {
      hit <- if (is.double(col)) {
        any(abs(col - code) < 5e-4, na.rm = TRUE)
      } else {
        any(col == code, na.rm = TRUE)
      }
      expect_false(hit, label = sprintf("%s$%s code %s", d, v, code))
    }
  }

  # Explicit spot checks for labelled, NR-1b float, and DK-1 ordered codes
  nels <- cache[["nels_data"]]
  expect_true(all(nels$bys12 %in% c(1L, 2L) | is.na(nels$bys12)))
  for (v in c(
    "bylocus1", "bylocus2", "bycncpt1", "bycncpt2", "byses", "by2xrstd",
    "by2xmstd", "by2xsstd", "by2xhstd", "f12xrstd", "f1ses", "f1locus1",
    "f1locus2", "f1cncpt1", "f1cncpt2"
  )) {
    expect_false(
      any(nels[[v]] > 99, na.rm = TRUE),
      label = paste("nels_data", v)
    )
  }
  expect_false(any(nels$bygrads > 4, na.rm = TRUE))
  expect_false(any(nels$bys34a %in% c(8, 97, 98)))
  expect_false(any(nels$bypared == 7, na.rm = TRUE))
  expect_false(any(nels$f1s17 == 6, na.rm = TRUE))
})

test_that("race has five levels in disc and disc2, for the same students", {
  lev <- c("Asian", "Hispanic", "Black", "White", "American Indian")
  disc <- get_dataset("disc")
  disc2 <- get_dataset("disc2")
  expect_equal(nrow(disc), nrow(disc2))
  expect_identical(levels(disc$race), lev)
  expect_identical(levels(disc2$race), lev)
  expect_identical(disc$race, disc2$race)
  expect_equal(sum(disc$race == "American Indian", na.rm = TRUE), 68)
  expect_equal(sum(is.na(disc$race)), 24)
})

test_that("titanic embarked is the corrected titanic3 column", {
  titanic <- get_dataset("titanic")
  expect_equal(sum(is.na(titanic$embarked)), 2)
  expect_setequal(unique(stats::na.omit(titanic$embarked)), c("C", "Q", "S"))
  expect_equal(as.vector(table(titanic$embarked)), c(270, 123, 914))
})

test_that("classdata_07 is the seeded simulation with the original structure", {
  cd <- get_dataset("classdata_07")
  expect_equal(dim(cd), c(44L, 12L))
  expect_equal(sum(cd$gender == 1L), 12)
  expect_true(all(cd$overage == "no"))
  expect_true(all(cd$alcohol >= 0 | is.na(cd$alcohol)))
})

test_that("binary indicators stay 0/1", {
  pairs <- list(
    c("berk_sub", "admitted"), c("berk_sub", "male"), c("berkeley", "female"),
    c("berkeley", "admitted"), c("titanic", "survived"), c("titanic", "sex"),
    c("penalty", "def_bl"), c("penalty", "vic_bl"), c("penalty", "death_pe"),
    c("disc", "male"), c("disc", "sentoff"), c("gcse", "gender")
  )
  for (p in pairs) {
    x <- get_dataset(p[1])[[p[2]]]
    expect_true(
      all(x %in% c(0L, 1L) | is.na(x)),
      label = paste(p, collapse = "$")
    )
  }
})
