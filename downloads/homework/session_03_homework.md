# Session 3 Homework: Randomised Experiments, Design, and Power

Estimated workload: 55-70 minutes, including 20 minutes in R.

Focus on assignment `Z`. In a full-compliance experiment, treatment received is `D = Z`.

## Conceptual Reasoning

1. What does random assignment solve in relation to potential outcomes? What does it not automatically solve?

2. A tutoring intervention may change peer study habits within classrooms. Would you randomise pupils, classrooms, or schools? Defend one choice and name the tradeoff.

3. A balance table shows one statistically significant difference out of twenty baseline variables. Does this prove randomisation failed? What should the researcher do next?

4. An experiment has an MDE of 8 test-score points, but the policy would be worthwhile for effects of 3 points or more. Interpret this for a policymaker.

## Applied Empirical Reasoning

A ministry can randomise an education programme across 40 schools. The programme costs 100,000 euros per school, outcomes are measured one year later, and teachers may share materials across nearby schools.

Draft a five-line protocol:

1. unit of randomisation;
2. target estimand;
3. primary outcome and horizon;
4. main implementation threat;
5. inference level.

Then add three sentences explaining how power and spillovers affect the design.

## R Exercise

Open and run the starter script `r_exercises/week_03_rct_power.R`. It creates the trial datasets, shows the balance and precision plots, and gives commented TODO lines for the numerical part.

Complete the TODO lines in your own copy and report:

- the baseline-balance difference under simple and stratified randomisation;
- the estimated treatment effect and standard error in the simulated trial;
- the simulated standard error and approximate MDE for each sample size;
- one sentence explaining why larger samples improve precision but do not repair implementation bias.
