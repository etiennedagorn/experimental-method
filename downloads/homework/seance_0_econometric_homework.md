# Seance 0 Homework: Identification Strategy and Independence

Estimated workload: 45-60 minutes, including 15-25 minutes in R.

This homework is required. Submit short answers in complete sentences. Use the notation from the lecture: treatment `D`, outcome `Y`, baseline covariates `X`, and potential outcomes `Y(1)` and `Y(0)`.

## Exercise 1. What Makes a Comparison Causal?

An employment agency wants to know whether a job-training programme improves employment six months later. In the first year, participation is voluntary. The agency observes that workers who attended training have higher employment than workers who did not attend.

In the second year, demand is higher than the number of available places. Among eligible applicants, the agency assigns training places by lottery.

Answer the following questions.

1. In the voluntary-participation year, what is the observed comparison? Give one reason why this comparison may fail to identify the causal effect of training.

2. For workers who attend training, what is the missing counterfactual outcome?

3. In the lottery year, what is the identification strategy? Explain where the identifying variation comes from.

4. State the independence assumption in words. Then write it using potential-outcomes notation, for example with `D`, `Y(1)`, and `Y(0)`.

5. A researcher says: "The lottery estimate is causal because the standard error is small." Explain what is wrong with this statement, and give one more relevant reason why the lottery comparison might be credible.

## Exercise 2. Seeing Independence in a Small R Example

This exercise uses a tiny artificial dataset. The goal is to see how a randomised comparison can be inspected in R, and why balance checks are useful but not proof of identification.

The companion starter file is `r_exercises/seance_0_econometric_refresher.R`.

Copy the code below into R or RStudio and run it line by line. Replace the `___` blanks before running the last four lines.

```r
dat <- data.frame(
  worker = 1:12,
  D = c(1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0),
  X = c(42, 41, 57, 56, 50, 49, 63, 62, 46, 47, 54, 55),
  Y = c(1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1)
)

head(dat)

mean_X_treated <- mean(dat$X[dat$D == ___])
mean_X_control <- mean(dat$X[dat$D == ___])

mean_Y_treated <- mean(dat$Y[dat$D == ___])
mean_Y_control <- mean(dat$Y[dat$D == ___])

naive_difference <- mean_Y_treated - ___

model <- lm(Y ~ ___, data = dat)
summary(model)
```

Answer the following questions.

1. Compare the mean of `X` for `D = 1` and `D = 0`. Does this look consistent with random assignment? Why is it not proof of independence?

2. Report the mean of `Y` for `D = 1`, the mean of `Y` for `D = 0`, and the difference. What does this difference estimate if `D` is independent of `Y(1)` and `Y(0)`?

3. In the regression `lm(Y ~ D, data = dat)`, what does the coefficient on `D` measure? Why does its causal interpretation depend on the identification strategy rather than on the R command?
