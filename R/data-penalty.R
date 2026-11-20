# penalty -------------------------------------------------------------------

#' @eval rd_title_tag("penalty")
#'
#' @description
#' Death-penalty verdicts for the 674 defendants in Florida indictments for
#' multiple murders from 1976 to 1987, with the defendant's race and the
#' victim's race. Each row is a defendant; the rows write out the 2 x 2 x 2
#' table of counts from Radelet and Pierce (1991), as given in Agresti and
#' Finlay (1997, p. 585). The data are a classic example of confounding: the
#' association between the defendant's race and the verdict reverses once the
#' victim's race is taken into account (Simpson's paradox).
#'
#' @eval rd_format_tag("penalty")
#'
#' @details
#' **Structure.** All three variables are 0/1 dummies: `def_bl` and `vic_bl`
#' are 1 when the defendant or the victim is Black, and `death_pe` is 1 for a
#' death sentence. Because the rows reproduce the cell counts of a table, most
#' of them are exact duplicates, and there are only four covariate patterns.
#' There are no missing values, and version 1.0.0 changed no values.
#'
#' **What the table shows.** Overall, 11.0% of White defendants and 7.9% of
#' Black defendants were sentenced to death. Within each victim group the
#' order reverses: when the victim was White, 22.9% of Black and 11.3% of
#' White defendants were sentenced to death, and when the victim was Black,
#' 2.8% and 0%. Cases with White victims, where death sentences were far more
#' common (12.4% against 2.5%), mostly had White defendants.
#'
#' **Goodness of fit.** Compute goodness-of-fit statistics on the grouped data
#' (the four covariate patterns), not on the 674 rows: the residual deviance
#' of a fit to the individual rows is not a goodness-of-fit statistic. On the
#' grouped data the main-effects model fits well (Pearson X-squared = 0.20 and
#' deviance = 0.38 on 1 df; p = 0.66 and 0.54).
#'
#' **Suggested analyses.**
#'
#' - logistic regression with two binary predictors, and odds ratios;
#' - confounding and Simpson's paradox: compare `death_pe ~ def_bl` with
#'   `death_pe ~ def_bl + vic_bl`;
#' - Pearson and deviance goodness-of-fit tests for grouped binomial data.
#'
#' @section Ethical context:
#' These data document racial disparities in capital sentencing. They come
#' from Radelet and Pierce's (1991) study of race and the death penalty in
#' Florida and cover the 674 defendants indicted for multiple murders there
#' from 1976 to 1987. In these data, whatever the defendant's race, defendants
#' whose victims were White were far more likely to be sentenced to death than
#' those whose victims were Black. The study belongs to a broader body of
#' research on race and capital punishment, which includes the Baldus study of
#' Georgia cases cited in *McCleskey v. Kemp* (1987). Instructors should
#' provide appropriate historical context when assigning analyses of these
#' data and encourage students to consider the structural and institutional
#' factors that underlie these patterns.
#'
#' @eval rd_source_tag("penalty")
#'
#' @seealso [berk_sub] for another example of Simpson's paradox. On CRAN,
#'   `catdata::deathpenalty` and `asbio::death.penalty` hold the same table as
#'   eight rows of counts. [codebook()] gives the variable table as a data
#'   frame, and [list_datasets()] lists the other datasets.
#'
#' @examples
#' head(penalty)
#'
#' # Share sentenced to death, by victim's race (rows) and defendant's race
#' with(penalty, tapply(death_pe, list(vic_bl = vic_bl, def_bl = def_bl), mean))
#'
#' # Main-effects logistic regression and its odds ratios
#' fit <- glm(death_pe ~ def_bl + vic_bl, family = binomial, data = penalty)
#' exp(coef(fit))
#'
#' # Goodness of fit on the four covariate patterns
#' grouped <- aggregate(cbind(deaths = death_pe, cases = 1) ~ def_bl + vic_bl,
#'                      data = penalty, FUN = sum)
#' fit_g <- glm(cbind(deaths, cases - deaths) ~ def_bl + vic_bl,
#'              family = binomial, data = grouped)
#' sum(residuals(fit_g, type = "pearson")^2)  # Pearson X-squared, 1 df
#' deviance(fit_g)                            # deviance, 1 df
"penalty"
