# Session 2 Homework: Selection, Regression, Matching, and Inference

Estimated workload: 60-70 minutes, including 20-25 minutes in R.

Use `D` for treatment received, `Y` for the outcome, `X` for observed pre-treatment covariates, and `W` or `U` for omitted variables.

## Conceptual Reasoning

1. A training programme reports higher earnings for participants than non-participants. Give one upward-selection story and one downward-selection story. For each, name the omitted variable and the expected sign of the bias.

2. Suppose the true model contains motivation `U`, but the regression omits it. Motivation raises both participation and earnings. What sign do you expect for omitted-variable bias in the coefficient on `D`? Explain without relying on statistical significance.

3. Classify each variable as a good pre-treatment control, bad control, or doubtful control: baseline earnings, age before treatment, job-search effort measured after the programme starts, interview confidence measured after coaching, local unemployment before treatment, and an unobserved family network.

4. State conditional independence and overlap in plain language for matching. Why do balance and common support diagnostics not prove identification?

## Applied Empirical Reasoning

An employment agency compares treated workers to untreated workers with the same sex, age group, and pre-treatment earnings band. After matching, the treated group earns 250 euros more per month. However, treated workers had more caseworker encouragement and stronger stated motivation before treatment, and high-earning untreated workers are rare in the data.

Write 200-250 words explaining:

- which estimand the matched comparison is most likely targeting;
- what identifying assumption is required;
- what overlap problem may change the population being described;
- whether the 250-euro estimate should be called causal;
- what standard errors can and cannot repair.

## R Exercise

Open and run the starter script `r_exercises/week_02_selection_matching.R`. It creates the dataset, estimates the propensity score for the overlap plot, and gives commented TODO lines for the numerical part.

Complete the TODO lines in your own copy and report:

- the naive difference, adjusted regression coefficient, and propensity-score subclassification estimate;
- the treated and control propensity-score ranges;
- whether the support restriction changes the treated population;
- one sentence on whether the remaining unobserved selection problem is solved.
