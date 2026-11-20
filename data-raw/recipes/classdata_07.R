# Recipe: classdata_07 (SIMULATED)
# The original 2007 class survey (UC Berkeley EDUC 293A) has no consent or
# release record, so v1.0.0 ships a seeded simulated look-alike instead
# (Gate B PROV-3): same 44 rows, column names, column types, codes and
# plausible ranges. The seed fixes the values, so every build is identical.
recipe <- function() {
  set.seed(20071001, kind = "Mersenne-Twister", normal.kind = "Inversion",
           sample.kind = "Rejection")
  n_f <- 32L; n_m <- 12L; n <- n_f + n_m
  clamp <- function(x, lo, hi) pmin(pmax(x, lo), hi)
  gender <- sample(c(rep(0L, n_f), rep(1L, n_m)))            # 0 = female, 1 = male
  height <- clamp(round(ifelse(gender == 1L, rnorm(n, 71, 2.8), rnorm(n, 65, 2.7)) * 2) / 2, 59, 77)
  desired_weight <- as.integer(clamp(round(ifelse(gender == 1L, rnorm(n, 168, 15), rnorm(n, 124, 13))), 95, 210))
  actual_study  <- as.integer(clamp(round(rgamma(n, shape = 2.6, scale = 8.3)), 0, 70))
  desired_study <- as.integer(clamp(actual_study + round(rnorm(n, 0, 6)), 0, 100))
  actual_work   <- as.integer(ifelse(runif(n) < 0.15, 0, clamp(round(rgamma(n, shape = 1.6, scale = 11)), 0, 72)))
  desired_work  <- as.integer(clamp(round(actual_work * runif(n, 0.4, 1)), 0, 50))
  exer    <- clamp(round(rgamma(n, shape = 2.2, scale = 2.1) * 2) / 2, 0, 25)
  sleep   <- sample(c(6, 6.5, 7, 7.5, 8, 9), n, replace = TRUE, prob = c(.2, .2, .25, .15, .15, .05))
  alcohol <- as.integer(clamp(rpois(n, 3.4), 0, 10))
  overage <- rep("no", n)
  age     <- sample(0:2, n, replace = TRUE, prob = c(.3, .3, .4))   # 0 = up to 27, 1 = 28-31, 2 = 32+
  tibble::tibble(actual_study, desired_study, actual_work, desired_work, gender,
                 height = as.double(height), desired_weight, exer = as.double(exer),
                 sleep = as.double(sleep), alcohol, overage, age = as.integer(age))
}
