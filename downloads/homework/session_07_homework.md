# Session 7 Homework: Regression Discontinuity

Estimated workload: 60-75 minutes, including 25 minutes in R.

In this session, `X` is the running variable and `W` is an auxiliary covariate.

## Conceptual Reasoning

1. For a scholarship awarded when an exam score crosses 70, define the running variable `X`, cutoff `c`, treatment received `D`, outcome `Y`, and cutoff-local estimand.

2. Distinguish the causal cutoff estimand from the observed discontinuity in mean outcomes at the cutoff. What assumption links them?

3. Why can a density jump in `X` around the cutoff threaten the design? Why does a donut RDD not automatically solve strategic manipulation?

4. Explain the bandwidth tradeoff in words. What is gained and lost when the bandwidth becomes narrower?

5. In a fuzzy RDD, what are `Delta_Y(c)` and `Delta_D(c)`? Why is their ratio a local IV estimand?

## Applied Empirical Reasoning

A university admits students automatically if their index score is at least 80. Students just above 80 receive admission, but some just below appeal successfully. A separate scholarship rule also changes at 80, and private schools help students prepare appeals.

Write 220-280 words that:

- classifies the design as sharp or fuzzy;
- states the local identifying assumptions;
- identifies two diagnostics;
- explains one threat from the scholarship rule or appeals;
- states the population to which the estimate applies.

## R Exercise

Open and run the starter script `r_exercises/week_07_rdd.R`. It creates the sharp and fuzzy RDD datasets, shows the cutoff and first-stage plots, and gives commented TODO lines for the numerical part.

Complete the TODO lines in your own copy and report:

- the sharp RDD estimates for bandwidths 10, 20, and 35;
- the covariate-continuity estimate for `W` at bandwidth 20;
- the fuzzy-RDD `Delta_Y(c)`, `Delta_D(c)`, and Wald ratio;
- one sentence explaining whether wider-bandwidth stability proves validity.
