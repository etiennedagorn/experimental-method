# Session 6 Homework: Event Studies and Staggered DiD

Estimated workload: 65-75 minutes, including 25-30 minutes in R.

Use event time carefully. Dynamic and staggered designs require naming the comparison group.

## Conceptual Reasoning

1. Define event time for a unit treated in 2021 and observed from 2018 to 2024. Which period is commonly omitted in an event-study regression, and why?

2. A lead coefficient is positive two years before treatment. Give three possible interpretations: one about failed parallel trends, one about anticipation, and one about sampling noise.

3. Why can already-treated units be problematic controls when effects are heterogeneous over time?

4. Define `ATT(g,t)` in words after a cohort `g` first receives treatment. What population and time period does it describe?

5. Why should an event-study graph report the estimator and comparison group, not only dots and confidence intervals?

## Applied Empirical Reasoning

Three regions adopt a policy at different times:

| Region | Adoption year |
| --- | ---: |
| A | 2020 |
| B | 2022 |
| C | never |

For calendar years 2019, 2020, 2021, and 2022, identify which regions can be untreated controls for region A under a not-yet-treated or never-treated comparison rule. Then explain how your answer changes for region B.

## R Exercise

Open and run the starter script `r_exercises/week_06_event_study_staggered.R`. It creates the staggered-adoption panel, shows the event-study and `ATT(g,t)` plots, and gives commented TODO lines for the numerical part.

Complete the TODO lines in your own copy and report:

- the event-study coefficients for event times -2, 0, 1, and 2+;
- one `ATT(g,t)` estimate from the group-time table;
- whether the traditional TWFE coefficients and group-time comparisons tell the same story;
- one sentence about support at long leads or lags.
