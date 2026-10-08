# Optional Session 8 Homework: Synthesis, SCM, Heterogeneity, and Replication

Estimated workload: 70-90 minutes, including 25-35 minutes in R. This is an optional capstone task.

## Conceptual Reasoning

1. For each design - RCT, IV, DiD, staggered DiD, RDD, and SCM - name the source of identifying variation and the main identifying assumption.

2. Why is good pre-treatment fit in synthetic control a diagnostic rather than proof of identification?

3. Give one credible and one weak heterogeneity claim. Explain how the underlying design affects whether subgroup differences can be interpreted causally.

4. What is the difference between a robustness check, a placebo check, and a replication audit?

## Applied Empirical Reasoning

A single region introduces carbon pricing in 2022. Other regions are untreated, but some share electricity markets with the treated region and one introduces a green-subsidy package in 2023.

Prepare a one-page evidence audit covering:

- treated unit and donor pool;
- outcome and pre-treatment predictors;
- constructed counterfactual;
- identifying assumption;
- placebo or sensitivity evidence;
- estimand and external-validity limits;
- one remaining reason to doubt the design.

## R Exercise

Open and run the starter script `r_exercises/week_08_scm_hte_replication.R`. It creates the regional panel and subgroup dataset, shows donor-pool and subgroup plots, and gives commented TODO lines for the numerical part.

Complete the TODO lines in your own copy and report:

- the largest donor weights in the synthetic control;
- pre-treatment MSPE and average post-treatment gap;
- the treated unit's placebo rank or gap-ratio comparison;
- the leave-one-donor-out sensitivity result;
- one interpretation of the subgroup interaction in the final simulated RCT section.
