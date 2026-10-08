# Session 5 Homework: Difference-in-Differences and Simple TWFE

Estimated workload: 55-70 minutes, including 20 minutes in R.

The clean 2x2 target is usually an ATT for treated units in the post-treatment period.

## Conceptual Reasoning

1. Explain why a before-after comparison can fail even when the same units are observed twice.

2. Explain why a post-treatment treated-control comparison can fail even when untreated units are observed at the same time.

3. Compute the DiD estimate from this table:

   | Group | Pre | Post |
   | --- | ---: | ---: |
   | Treated | 60 | 70 |
   | Control | 50 | 54 |

   Label the estimand and state the parallel-trends assumption in words.

4. Why do pre-trend checks and placebo outcomes support credibility but not prove parallel trends?

5. In a simple two-period panel, what does the interaction coefficient in `Y ~ treated + post + treated:post` estimate?

## Applied Empirical Reasoning

A region raises its minimum wage in 2025. A neighbouring region does not. Employment rose in both regions from 2024 to 2025, but more slowly in the treated region. Both regions also experienced different tourism shocks.

Write 200-250 words that:

- defines treated group, control group, outcome, and timing;
- explains the missing counterfactual trend;
- states the identifying assumption;
- names one diagnostic and one remaining threat;
- explains the appropriate clustering level.

## R Exercise

Open and run the starter script `r_exercises/week_05_did_twfe.R`. It creates the panel dataset, shows the treated and control trends, and gives commented TODO lines for the numerical part.

Complete the TODO lines in your own copy and report:

- the four group-time means;
- the hand-computed DiD estimate;
- the interaction coefficient from the regression;
- one sentence interpreting the estimate under parallel trends;
- one threat that the script cannot rule out.
