# Session 4 Homework: Compliance, IV, LATE, and External Validity

Estimated workload: 60-75 minutes, including 20-25 minutes in R.

Keep assignment or instrument `Z` distinct from treatment received `D`.

## Conceptual Reasoning

1. In an encouragement design, define `Z`, `D`, and `Y`. Why is the encouragement only a candidate instrument until assumptions are defended?

2. In a study, mean `Y` is 62 for `Z = 1` and 58 for `Z = 0`. Mean `D` is 0.70 for `Z = 1` and 0.20 for `Z = 0`. Compute the ITT on `Y`, the first stage, and the Wald estimand. Interpret the result as a LATE.

3. Classify these compliance types using `D(1)` and `D(0)`: always-taker, never-taker, complier, and defier. Which group identifies the LATE under the standard assumptions?

4. For each IV assumption - relevance, independence, exclusion, and monotonicity - give one plain-language violation in a training encouragement study.

5. Why is the treatment-on-the-treated effect not automatically the same as LATE under two-sided non-compliance?

## Applied Empirical Reasoning

A job centre randomly sends a personalised letter encouraging eligible workers to enrol in a training programme. Some workers enrol without the letter, and many letter recipients do not enrol. The letter also includes a confidence-building message that may affect job search even without enrolment.

Write 220-280 words that:

- identifies the source of variation;
- states the estimand;
- discusses exclusion and monotonicity;
- explains who the compliers might be;
- explains one external-validity concern.

## R Exercise

Open and run the starter script `r_exercises/week_04_iv_late.R`. It creates the encouragement-design dataset, shows the first-stage and ITT plots, and gives commented TODO lines for the numerical part.

Complete the TODO lines in your own copy and report:

- ITT on `Y`, first stage, Wald/LATE, and naive OLS;
- one reason the naive OLS comparison differs from the IV estimate;
- why the LATE refers to compliers even though individual compliance types are not observed in real data;
- one warning about treating a hand-computed Wald ratio as a complete IV analysis.
