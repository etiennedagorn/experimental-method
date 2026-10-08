# R Exercises README

These starter scripts support the weekly homework sequence for the applied policy evaluation course. They create the data, show the empirical process, and provide visualisations, but they do not print the final homework answers.

## Requirements

- Base R is enough for the numerical calculations.
- `ggplot2` is used for optional visualisations.
- No external data files.
- Each script sets its own random seed and generates synthetic data internally.
- If `ggplot2` is not installed, the script prints the install command and still runs the numerical part.

Students can run a script from the repository root, for example:

```r
source("r_exercises/seance_0_econometric_refresher.R")
```

or from a terminal:

```sh
Rscript r_exercises/week_01_foundations.R
```

## Files

- `seance_0_econometric_refresher.R`: treated-control comparison, balance on `X`, simple regression, and the independence interpretation.
- `week_01_foundations.R`: offer `Z`, attendance `D`, target comparison, and the difference between policy assignment and receipt.
- `week_02_selection_matching.R`: omitted selection, adjusted regression, propensity scores, common support, subclassification.
- `week_03_rct_power.R`: simple and stratified randomisation, balance, treatment estimate, standard errors, MDE, cluster design effect.
- `week_04_iv_late.R`: encouragement design, ITT, first stage, Wald/LATE, naive OLS, and complier interpretation.
- `week_05_did_twfe.R`: 2x2 DiD, group-time means, interaction regression.
- `week_06_event_study_staggered.R`: event-time indicators, traditional TWFE event study, group-time `ATT(g,t)`, support.
- `week_07_rdd.R`: sharp RDD by bandwidth, covariate continuity, fuzzy-RDD Wald ratio.
- `week_08_scm_hte_replication.R`: synthetic control weights, pre-fit, post-treatment gap, placebo ranking, donor sensitivity, subgroup interaction.

## Design Notes

The scripts are intentionally small and transparent. They are not meant to teach advanced R programming. The goal is to connect code output to causal reasoning:

- What comparison is being made?
- What assumption would make it causal?
- What estimand or population does it describe?
- What diagnostic evidence is visible?
- What uncertainty or threat remains?

The scripts include `ggplot2` plotting blocks. These display graphs when sourced in an interactive R session such as RStudio, while keeping command-line runs clean. Students should complete the commented TODO lines in their own copy before writing up numerical answers.
