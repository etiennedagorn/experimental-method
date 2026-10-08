# Course Syllabus: Experimental Analysis of Public Policies

Course title: Experimental Analysis of Public Policies

Semester/Year: Spring semester (S2), 2026-2027; Master IE M1

Instructor name: Etienne Dagorn

Email: etienne.dagorn@univ-lille.fr

## Summary

This course provides a rigorous introduction to the experimental and quasi-experimental analysis of public policies, with a strong emphasis on applied reasoning. Students learn how to move from a policy question to a credible evaluation design by identifying the missing counterfactual, the source of identifying variation, the assumption that makes the comparison causal, and the estimand or population described by the result.

Each session combines:

- a collaborative group exercise in which students design, diagnose, or critique an evaluation protocol for a real-world policy intervention;
- a theoretical deep dive into the econometric method needed for that evaluation;
- a short empirical or R-based component focused on interpretation rather than programming.

The course covers randomised controlled trials, selection-on-observables strategies, instrumental variables, difference-in-differences, event studies, regression discontinuity, synthetic control, treatment-effect heterogeneity, external validity, and replication.

## Prerequisites

Students are expected to have prior knowledge of:

- basic concepts in descriptive and inferential statistics;
- introductory econometrics, including linear regression and hypothesis testing;
- basic familiarity with statistical software such as R or Stata.

## Learning Outcomes

By the end of this course, students will be able to:

- formulate a causal policy-evaluation question and define the relevant treatment, outcome, population, and estimand;
- distinguish description, prediction, estimation, inference, and causal identification;
- explain the missing counterfactual and the selection problem in potential-outcomes terms;
- design and assess randomised evaluations, including issues of power, attrition, spillovers, and non-compliance;
- apply core quasi-experimental methods, including matching, instrumental variables, difference-in-differences, event studies, regression discontinuity, and synthetic control;
- interpret local estimands such as ATT, LATE, and cutoff-specific RDD effects;
- diagnose threats to credibility without treating diagnostics as proof of identification;
- implement short empirical exercises in R and communicate results to technical and non-technical audiences.

## Programme

### Session 1. Foundations of Policy Evaluation

- Group work: turn a local education or tutoring policy into a complete evaluation question.
- Theory: causal questions, potential outcomes, estimands, the missing counterfactual, selection bias, and the experimental benchmark.
- Applied focus: distinguishing the treatment effect of interest from a naive comparison.

### Session 2. Selection Bias, Regression, Matching, and Inference

- Group work: design and critique an observational evaluation of an employment or job-search programme.
- Theory: naive comparisons, omitted-variable bias, regression as conditional comparison, bad controls, matching, propensity scores, common support, balance, and clustering.
- Applied focus: asking when conditioning on observables can reconstruct the missing counterfactual.

### Session 3. Randomised Experiments: Design and Power

- Group work: develop an RCT protocol for an education, health, or social-policy intervention.
- Theory: assignment mechanisms, simple randomisation, stratification, blocking, cluster randomisation, balance, spillovers, attrition, outcome measurement, statistical power, and minimum detectable effects.
- Applied focus: linking design choices to precision, feasibility, and interpretation.

### Session 4. Compliance, IV, LATE, and External Validity

- Group work: analyse an encouragement design where assignment and treatment receipt differ.
- Theory: assignment `Z` versus treatment `D`, intention-to-treat, first stage, Wald estimator, local average treatment effects, IV assumptions, weak instruments, exclusion threats, and scale-up.
- Applied focus: identifying who is moved by an instrument and what population the estimate describes.

### Session 5. Difference-in-Differences: 2x2 and TWFE

- Group work: construct a DiD evaluation for a labour-market or regional policy.
- Theory: before-after and treated-control comparisons, the 2x2 DiD estimator, graphical counterfactuals, parallel trends, simple two-way fixed effects, controls, serial correlation, and clustered inference.
- Applied focus: using untreated trends to reason about the missing counterfactual trend.

### Session 6. Event Studies and Staggered Difference-in-Differences

- Group work: read and diagnose an event-study graph from a staggered policy rollout.
- Theory: event time, leads and lags, dynamic effects, anticipation, pre-trend diagnostics, staggered adoption, comparison groups, heterogeneous effects, and group-time ATT.
- Applied focus: understanding why naive TWFE can mislead when treatment timing and effects vary.

### Session 7. Regression Discontinuity

- Group work: audit an institutional threshold such as a scholarship rule, eligibility cutoff, or regulatory threshold.
- Theory: running variable, cutoff, sharp and fuzzy RDD, continuity, local counterfactuals, bandwidth choice, local linear regression, manipulation, density checks, covariate continuity, placebo cutoffs, and external validity.
- Applied focus: interpreting RDD estimates as local effects around a threshold.

### Session 8. Synthetic Control, Heterogeneity, and Replication

- Group work: conduct a final evidence audit for a policy evaluation using the course design checklist.
- Theory: method choice, synthetic control, donor pools, predictor balance, pre-treatment fit, treatment gaps, placebo tests, donor sensitivity, heterogeneous treatment effects, external validity, robustness, and replication.
- Applied focus: synthesising, interpreting, and challenging causal evidence.

## Course Format

The course has 24 hours in total, organised as eight sessions of approximately three hours each. Sessions combine lectures, collaborative design exercises, short empirical interpretation tasks, and computer-based R exercises.

Weekly homework after Sessions 1-7 provides additional practice in causal reasoning and short R implementation. An optional Session 8 capstone homework is available for final revision. These exercises are designed to take approximately 45-75 minutes per week.

## Assessment

| Component | Weight | Format |
| --- | ---: | --- |
| In-class online QCM quizzes | 40% | One short quiz per session; best 6 of 8 retained |
| Final written exam | 60% | In-class written exam based on applied empirical-design scenarios |

The QCM quizzes assess core concepts and interpretation through short policy scenarios. The final exam asks students to reason through two or three empirical-design problems using the course structure: policy question, estimand, counterfactual, identifying variation, identifying assumption, main threat, inference, and interpretation.

## Recommended Resources

Introductory texts:

- Angrist, Joshua D., and Jörn-Steffen Pischke. *Mostly Harmless Econometrics: An Empiricist's Companion*. Princeton University Press, 2009.
- Cunningham, Scott. *Causal Inference: The Mixtape*. Yale University Press, 2021.
- Gertler, Paul J., Sebastian Martinez, Patrick Premand, Laura B. Rawlings, and Christel M. J. Vermeersch. *Impact Evaluation in Practice*. World Bank, 2016.

Additional readings:

- A selection of published articles and applied examples will be made available to students before or during the relevant sessions.
