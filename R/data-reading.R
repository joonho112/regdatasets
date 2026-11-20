# reading -------------------------------------------------------------------

#' @eval rd_title_tag("reading")
#'
#' @description
#' Reading-comprehension scores from a randomized experiment that compared
#' three methods of teaching reading comprehension. Each row is one of 66
#' students, 22 of them randomly assigned to each method: Basal (the
#' traditional method), DRTA (Directed Reading-Thinking Activity) and Strat
#' (strategy instruction). The experiment was conducted by Baumann and Jones
#' at Purdue University and reported by Moore and McCabe (1993).
#'
#' @eval rd_format_tag("reading")
#'
#' @details
#' **Design.** Each student took two pretests before instruction and three
#' post-tests after it. `post1` repeats the measure of `pre1` (intruded
#' sentences) and `post2` the measure of `pre2`; `post3` is a third measure
#' with no pretest. Because the methods were randomly assigned, differences
#' between the groups' mean post-test scores estimate the effects of the
#' methods, and the equal group sizes make the design balanced.
#'
#' **Coding.** `group` and `method` carry the same factor: `group` as text
#' (`"Basal"`, `"DRTA"`, `"Strat"`) and `method` as a number (1, 2, 3). Use
#' `group`, or `factor(method)`; entering `method` as a number would fit a
#' straight line across the three methods. `lm()` turns `group` into a factor
#' with Basal, the traditional method, as the reference level. There are no
#' missing values. Version 1.0.0 changed no values; it corrects the source
#' cited in the v0.2.0 help page.
#'
#' **Suggested analyses.**
#'
#' - one-way ANOVA as a regression with dummy (or effect) coding, and the
#'   overall F-test;
#' - planned contrasts, e.g. Basal against the two innovative methods and
#'   DRTA against Strat, with adjustments for multiple comparisons;
#' - ANCOVA: a post-test adjusted for its pretest, e.g.
#'   `post1 ~ pre1 + group`, with a check of parallel slopes
#'   (`post1 ~ pre1 * group`).
#'
#' @eval rd_source_tag("reading")
#'
#' @seealso `carData::Baumann` on CRAN has the same data, with `group` as a
#'   factor and the tests named `pretest.1` to `post.test.3`. [codebook()]
#'   gives the variable table as a data frame, and [list_datasets()], e.g.
#'   `list_datasets(topic = "ancova")`, lists other datasets suited to
#'   ANCOVA.
#'
#' @examples
#' head(reading)
#'
#' # One-way ANOVA: post-test 1 by teaching method (Basal is the reference)
#' fit <- lm(post1 ~ group, data = reading)
#' anova(fit)
#'
#' # ANCOVA: post-test 1 adjusted for the matching pretest
#' summary(lm(post1 ~ pre1 + group, data = reading))
"reading"
