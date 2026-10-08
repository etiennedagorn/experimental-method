# Week 03: Randomised experiments, design, and power
# Student starter script. No external data files required.
# ggplot2 is optional and used only for visualisation.

# Aim of the script:
# 1. simulate simple and stratified random assignment;
# 2. visualise baseline balance under both designs;
# 3. visualise how sample size changes precision;
# 4. leave the requested estimates and interpretation for you to compute.

set.seed(20260903)

make_trial <- function(n, stratified = FALSE) {
  id <- seq_len(n)
  baseline <- rnorm(n, mean = 50, sd = 10)
  high_baseline <- as.integer(baseline >= median(baseline))

  Z <- integer(n)
  if (stratified) {
    for (s in sort(unique(high_baseline))) {
      idx <- which(high_baseline == s)
      Z[idx] <- sample(rep(c(0, 1), length.out = length(idx)))
    }
  } else {
    Z <- sample(rep(c(0, 1), length.out = n))
  }

  D <- Z
  outcome_without_assignment <- 45 + 0.55 * baseline + rnorm(n, sd = 8)
  assignment_component <- 5 * D
  Y <- outcome_without_assignment + assignment_component + rnorm(n, sd = 3)

  data.frame(id, baseline, high_baseline, Z, D, Y)
}

estimate_trial <- function(dat) {
  fit <- lm(Y ~ Z, data = dat)
  estimate <- unname(coef(fit)["Z"])
  se <- unname(coef(summary(fit))["Z", "Std. Error"])
  balance_diff <- mean(dat$baseline[dat$Z == 1]) -
    mean(dat$baseline[dat$Z == 0])
  c(estimate = estimate, se = se, balance_diff = balance_diff)
}

trial_simple <- make_trial(400, stratified = FALSE)
trial_stratified <- make_trial(400, stratified = TRUE)

cat("\nWeek 03 starter script\n")
cat("----------------------\n")
cat("Two trial datasets created: trial_simple and trial_stratified.\n")
cat("First rows of trial_simple:\n")
print(head(trial_simple))

cat("\nProcess:\n")
cat("1. Compare baseline means by assignment Z.\n")
cat("2. Estimate the effect of assignment with lm(Y ~ Z, data = trial_simple).\n")
cat("3. Compare precision across sample sizes.\n")
cat("4. Explain why power does not repair spillovers, attrition, or bad measurement.\n")

# TODO for students:
# Replace ___ in the lines below in your own copy, then run them.
#
# simple_balance <- mean(trial_simple$baseline[trial_simple$Z == ___]) -
#   mean(trial_simple$baseline[trial_simple$Z == ___])
# stratified_balance <- mean(trial_stratified$baseline[trial_stratified$Z == ___]) -
#   mean(trial_stratified$baseline[trial_stratified$Z == ___])
#
# simple_fit <- lm(Y ~ ___, data = trial_simple)
# simple_estimate <- coef(simple_fit)["Z"]
# simple_se <- coef(summary(simple_fit))["Z", "Std. Error"]
#
# simulate_se <- function(n, reps = 300) {
#   estimates <- replicate(reps, {
#     trial <- make_trial(n)
#     fit <- lm(Y ~ ___, data = trial)
#     coef(fit)["Z"]
#   })
#   sd(estimates)
# }
# sample_sizes <- c(100, 400, 1600)
# simulated_se <- sapply(sample_sizes, simulate_se)
# approx_mde <- 2.8 * simulated_se
# data.frame(n = sample_sizes, simulated_se = simulated_se, approx_mde = approx_mde)
#
# cluster_size <- 20
# icc <- 0.10
# design_effect <- 1 + (cluster_size - 1) * ___
# design_effect

cat("\nDataviz process:\n")
cat("Plot 1 checks baseline balance under simple and stratified randomisation.\n")
cat("Plot 2 shows how larger samples reduce the minimum detectable effect by improving precision.\n")

if (requireNamespace("ggplot2", quietly = TRUE)) {
  library(ggplot2)

  local({
    # Combine the two trial designs into one plotting dataset.
    plot_trials <- rbind(
      transform(trial_simple, design = "Simple randomisation"),
      transform(trial_stratified, design = "Stratified randomisation")
    )
    plot_trials$Z_label <- ifelse(plot_trials$Z == 1, "Z = 1 assigned", "Z = 0 control")

    # Balance plot: randomisation should make groups comparable on average, not identical in every sample.
    plot_balance_design <- ggplot(plot_trials, aes(x = Z_label, y = baseline, fill = Z_label)) +
      geom_boxplot(outlier.alpha = 0.25) +
      facet_wrap(~ design) +
      labs(
        title = "Baseline balance by assignment group",
        x = "Assignment",
        y = "Baseline score"
      ) +
      theme_minimal() +
      theme(legend.position = "none")

    simulate_se_for_plot <- function(n, reps = 150) {
      estimates <- replicate(reps, estimate_trial(make_trial(n))["estimate"])
      sd(estimates)
    }
    sample_sizes_plot <- c(100, 400, 1600)
    precision_plot_data <- data.frame(
      n = sample_sizes_plot,
      simulated_se = sapply(sample_sizes_plot, simulate_se_for_plot)
    )
    precision_plot_data$approx_mde_80_power <- 2.8 * precision_plot_data$simulated_se

    # Precision plot: a smaller MDE means the design can detect smaller effects.
    plot_mde <- ggplot(precision_plot_data, aes(x = n, y = approx_mde_80_power)) +
      geom_line(colour = "#3266a8") +
      geom_point(size = 2.5, colour = "#3266a8") +
      labs(
        title = "Approximate MDE by sample size",
        x = "Sample size",
        y = "Approximate MDE"
      ) +
      theme_minimal()

    if (interactive()) {
      print(plot_balance_design)
      print(plot_mde)
    } else {
      cat("Plot code ran. Run the script in RStudio to display the two figures.\n")
    }
  })
} else {
  cat("ggplot2 is not installed. To draw the figures, run install.packages(\"ggplot2\") once, then rerun this script.\n")
}
