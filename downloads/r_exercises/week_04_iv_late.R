# Week 04: Compliance, IV, LATE, and external validity
# Student starter script. No external data files required.
# ggplot2 is optional and used only for visualisation.

# Aim of the script:
# 1. create a synthetic encouragement-design dataset;
# 2. keep assignment Z separate from treatment received D;
# 3. visualise the first stage and the ITT;
# 4. leave the IV estimates and interpretation for you to compute.

set.seed(20260904)

make_iv_data <- function(n = 1000) {
  id <- seq_len(n)
  X <- rnorm(n)
  Z <- rbinom(n, size = 1, prob = 0.5)

  latent_takeup <- runif(n)
  baseline_participation <- latent_takeup < 0.25
  responds_to_encouragement <- latent_takeup >= 0.25 & latent_takeup < 0.75
  low_participation <- latent_takeup >= 0.75

  D <- as.integer(baseline_participation | (responds_to_encouragement & Z == 1))

  outcome_without_programme <- 40 + 3 * X + 2 * baseline_participation -
    2 * low_participation + rnorm(n, sd = 5)
  programme_component <- 5 + 3 * responds_to_encouragement + 0.5 * X
  outcome_with_programme <- outcome_without_programme + programme_component
  Y <- ifelse(D == 1, outcome_with_programme, outcome_without_programme)

  # Return only observed-style variables. Latent response behaviour is part of the
  # simulation mechanism, but it is not observed in real data.
  data.frame(id, X, Z, D, Y)
}

dat <- make_iv_data()

cat("\nWeek 04 starter script\n")
cat("----------------------\n")
cat("Dataset created as dat. First rows:\n")
print(head(dat[, c("id", "X", "Z", "D", "Y")]))

cat("\nProcess:\n")
cat("1. Compute the ITT on Y by comparing mean Y across Z.\n")
cat("2. Compute the first stage by comparing mean D across Z.\n")
cat("3. Divide the ITT by the first stage to obtain the Wald/LATE estimate.\n")
cat("4. Compare that estimate with naive OLS and discuss the complier population.\n")

# TODO for students:
# Replace ___ in the lines below in your own copy, then run them.
#
# itt_y <- mean(dat$Y[dat$Z == ___]) - mean(dat$Y[dat$Z == ___])
# first_stage <- mean(dat$D[dat$Z == ___]) - mean(dat$D[dat$Z == ___])
# wald <- ___ / ___
# naive_ols <- coef(lm(Y ~ ___, data = dat))["D"]
#
cat("\nDataviz process:\n")
cat("Plot 1 shows the first stage: assignment Z changes treatment receipt D.\n")
cat("Plot 2 shows the ITT: assignment Z changes the outcome Y before dividing by the first stage.\n")

if (requireNamespace("ggplot2", quietly = TRUE)) {
  library(ggplot2)

  local({
    # Aggregate means by assignment status for plotting. In real data, Z and D are observed; compliance type is not.
    first_stage_data <- aggregate(D ~ Z, data = dat, mean)
    first_stage_data$Z_label <- ifelse(first_stage_data$Z == 1, "Z = 1 encouraged", "Z = 0 not encouraged")

    itt_data <- aggregate(Y ~ Z, data = dat, mean)
    itt_data$Z_label <- ifelse(itt_data$Z == 1, "Z = 1 encouraged", "Z = 0 not encouraged")

    # First-stage plot: the height difference is the change in treatment receipt caused by assignment.
    plot_first_stage <- ggplot(first_stage_data, aes(x = Z_label, y = D, fill = Z_label)) +
      geom_col(width = 0.65) +
      labs(
        title = "First stage: assignment and treatment receipt",
        x = "Assignment Z",
        y = "Mean treatment receipt D"
      ) +
      theme_minimal() +
      theme(legend.position = "none")

    # ITT plot: the height difference is the effect of assignment on the outcome.
    plot_itt <- ggplot(itt_data, aes(x = Z_label, y = Y, fill = Z_label)) +
      geom_col(width = 0.65) +
      labs(
        title = "ITT: assignment and outcomes",
        x = "Assignment Z",
        y = "Mean outcome Y"
      ) +
      theme_minimal() +
      theme(legend.position = "none")

    if (interactive()) {
      print(plot_first_stage)
      print(plot_itt)
    } else {
      cat("Plot code ran. Run the script in RStudio to display the two figures.\n")
    }
  })
} else {
  cat("ggplot2 is not installed. To draw the figures, run install.packages(\"ggplot2\") once, then rerun this script.\n")
}
