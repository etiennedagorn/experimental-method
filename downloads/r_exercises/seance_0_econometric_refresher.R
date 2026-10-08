# Seance 0: Identification strategy and independence
# Student starter script. No external data files required.
# ggplot2 is optional and used only for visualisation.

# Aim of the script:
# 1. create the tiny training dataset used in the homework;
# 2. inspect the data;
# 3. draw visual comparisons for X and Y;
# 4. leave the numerical answers for you to compute.

dat <- data.frame(
  worker = 1:12,
  D = c(1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0),
  X = c(42, 41, 57, 56, 50, 49, 63, 62, 46, 47, 54, 55),
  Y = c(1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1)
)

cat("\nSeance 0 starter script\n")
cat("-----------------------\n")
cat("Dataset created as dat. First rows:\n")
print(head(dat))

cat("\nProcess:\n")
cat("1. Compare baseline X for D = 1 and D = 0.\n")
cat("2. Compare observed Y for D = 1 and D = 0.\n")
cat("3. Interpret the comparison using the independence assumption, not the R command alone.\n")

# TODO for students:
# Replace ___ in the lines below in your own copy, then run them.
#
# mean_X_treated <- mean(dat$X[dat$D == ___])
# mean_X_control <- mean(dat$X[dat$D == ___])
#
# mean_Y_treated <- mean(dat$Y[dat$D == ___])
# mean_Y_control <- mean(dat$Y[dat$D == ___])
#
# naive_difference <- mean_Y_treated - ___
#
# model <- lm(Y ~ ___, data = dat)
# summary(model)

cat("\nDataviz process:\n")
cat("Plot 1 compares baseline X by treatment status: balance is reassuring, but it is not proof of independence.\n")
cat("Plot 2 compares Y by treatment status: this is the observed contrast whose causal meaning depends on the identification strategy.\n")

if (requireNamespace("ggplot2", quietly = TRUE)) {
  library(ggplot2)

  # Give the binary treatment a readable label for the x-axis and legend.
  dat$D_label <- ifelse(dat$D == 1, "D = 1", "D = 0")

  # Baseline balance plot: do treated and control workers look similar in X?
  plot_balance_x <- ggplot(dat, aes(x = D_label, y = X, colour = D_label)) +
    geom_jitter(width = 0.08, height = 0, size = 2, alpha = 0.75) +
    stat_summary(fun = mean, geom = "point", size = 4, colour = "black") +
    labs(
      title = "Baseline comparison by treatment status",
      x = "Treatment status",
      y = "Baseline covariate X"
    ) +
    theme_minimal() +
    theme(legend.position = "none")

  # Outcome plot: this visualises the treated-control comparison before any causal claim.
  plot_outcome_y <- ggplot(dat, aes(x = D_label, y = Y, colour = D_label)) +
    geom_jitter(width = 0.08, height = 0.04, size = 2, alpha = 0.75) +
    stat_summary(fun = mean, geom = "point", size = 4, colour = "black") +
    labs(
      title = "Observed outcome comparison",
      x = "Treatment status",
      y = "Outcome Y"
    ) +
    theme_minimal() +
    theme(legend.position = "none")

  if (interactive()) {
    print(plot_balance_x)
    print(plot_outcome_y)
  } else {
    cat("Plots created as plot_balance_x and plot_outcome_y. Run the script in RStudio to display them.\n")
  }
} else {
  cat("ggplot2 is not installed. To draw the figures, run install.packages(\"ggplot2\") once, then rerun this script.\n")
}
