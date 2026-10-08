# Session 1 Homework: Foundations of Policy Evaluation

Estimated workload: 45-60 minutes, including 15-25 minutes in R.

Submit short answers in complete sentences. Use the notation from the lecture: treatment `D`, outcome `Y`, potential outcomes `Y(1)` and `Y(0)`, and assignment `Z` only when a lottery or offer is discussed.

## Exercise 1. From a Policy Question to an Estimand

A city offers free after-school tutoring to eligible pupils. At the end of the year, pupils who attended tutoring have higher test scores than pupils who did not attend. The city is considering whether to expand the programme next year, but participation this year was voluntary.

Answer the following questions in short paragraphs.

1. Rewrite the city's question as an evaluation question. Name the unit, treatment `D`, outcome `Y`, target population, time horizon, and the estimand that best matches the expansion decision.

2. The phrase "attended tutoring" could mean attending once, attending at least ten sessions, or completing the full programme. Choose one definition of `D` and explain why a precise treatment definition matters for `Y(1)` and `Y(0)`.

3. For pupils who attended tutoring, what is the missing counterfactual? Explain why the city cannot observe it directly.

4. The city piloted tutoring in three motivated schools. What is one internal-validity concern and one external-validity concern for using this pilot to decide whether to expand citywide?

## Exercise 2. Offer, Attendance, and the Target Comparison

This exercise uses a tiny artificial dataset. The goal is to distinguish a random offer `Z` from actual attendance `D`, and to see why the comparison should match the policy question.

The companion starter file is `r_exercises/week_01_foundations.R`.

Copy the code below into R or RStudio and run it line by line. Replace the `___` blanks before running the final comparison lines.

```r
dat <- data.frame(
  pupil = paste0("P", 1:12),
  Z = c(1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0),
  D = c(1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0),
  X = c(70, 62, 58, 75, 66, 60, 68, 57, 74, 63, 71, 59),
  Y = c(78, 73, 64, 82, 69, 72, 70, 61, 76, 65, 72, 62)
)

head(dat)

takeup_offered <- mean(dat$D[dat$Z == ___])
takeup_not_offered <- mean(dat$D[dat$Z == ___])

offer_gap <- mean(dat$Y[dat$Z == ___]) - mean(dat$Y[dat$Z == ___])
attendance_gap <- mean(dat$Y[dat$D == ___]) - mean(dat$Y[dat$D == ___])

offer_model <- lm(Y ~ ___, data = dat)
attendance_model <- lm(Y ~ ___, data = dat)
```

Answer the following questions.

1. Report take-up among pupils with `Z = 1` and pupils with `Z = 0`. What does this say about the difference between being offered tutoring and attending tutoring?

2. Report the offer comparison and the attendance comparison. Which one matches the effect of being offered tutoring?

3. Why should the attendance comparison not automatically be interpreted as the causal effect of attending tutoring?
