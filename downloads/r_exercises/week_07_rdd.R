# Week 07: Regression discontinuity
# Student starter script. No external data files required.
# ggplot2 is optional and used only for visualisation.

# Aim of the script:
# 1. create a synthetic scholarship-cutoff dataset;
# 2. visualise the outcome jump at the cutoff;
# 3. visualise the fuzzy first stage;
# 4. leave the bandwidth estimates, covariate jump, and Wald ratio for you to compute.

set.seed(20260907)

n <- 2500
c <- 0
X <- runif(n, min = -50, max = 50)          # running variable centred at cutoff
X_c <- X - c
Z <- as.integer(X_c >= 0)                  # eligibility at the cutoff
D <- Z                                     # sharp RDD: treatment received equals eligibility
W <- 20 + 0.08 * X_c + rnorm(n, sd = 2)    # auxiliary covariate for a continuity diagnostic

outcome_without_scholarship <- 60 + 0.35 * X_c - 0.004 * X_c^2 +
  rnorm(n, sd = 4)
cutoff_component <- 7 * D
Y <- outcome_without_scholarship + cutoff_component

dat <- data.frame(X, X_c, Z, D, W, Y)

estimate_jump <- function(outcome, bandwidth, data = dat) {
  sub <- subset(data, abs(X_c) <= bandwidth)
  fit <- lm(as.formula(paste(outcome, "~ Z * X_c")), data = sub)
  coef(fit)["Z"]
}

# Fuzzy RDD extension: eligibility changes treatment probability but does not fully determine D.
prob_D_fuzzy <- ifelse(X_c < 0, 0.12 + 0.001 * (X_c + 50), 0.78 + 0.001 * X_c)
prob_D_fuzzy <- pmin(pmax(prob_D_fuzzy, 0.02), 0.98)
D_fuzzy <- rbinom(n, size = 1, prob = prob_D_fuzzy)
Y_fuzzy <- outcome_without_scholarship + 7 * D_fuzzy
dat_fuzzy <- data.frame(X, X_c, Z, D = D_fuzzy, W, Y = Y_fuzzy)

cat("\nWeek 07 starter script\n")
cat("----------------------\n")
cat("Sharp RDD data created as dat. Fuzzy RDD data created as dat_fuzzy.\n")
cat("First rows of dat:\n")
print(head(dat[, c("X_c", "Z", "D", "W", "Y")]))

cat("\nProcess:\n")
cat("1. Choose a bandwidth and keep observations near the cutoff.\n")
cat("2. Estimate the jump in Y at X = c using separate local linear trends.\n")
cat("3. Check whether the auxiliary covariate W also jumps at the cutoff.\n")
cat("4. For the fuzzy design, divide the outcome jump by the treatment jump.\n")

# TODO for students:
# Replace ___ in the lines below in your own copy, then run them.
#
# bandwidths <- c(10, 20, 35)
# sharp_estimates <- data.frame(
#   bandwidth = bandwidths,
#   rdd_estimate = sapply(bandwidths, function(h) estimate_jump("___", h))
# )
# sharp_estimates
#
# covariate_jump_W <- estimate_jump("___", 20)
# covariate_jump_W
#
# delta_y <- estimate_jump("___", 20, data = dat_fuzzy)
# delta_d <- estimate_jump("___", 20, data = dat_fuzzy)
# fuzzy_wald <- ___ / ___
# fuzzy_wald

cat("\nDataviz process:\n")
cat("Plot 1 shows the outcome discontinuity at the cutoff, using only observations close to the cutoff.\n")
cat("Plot 2 shows the fuzzy first stage: eligibility changes treatment probability, but not everyone complies.\n")

if (requireNamespace("ggplot2", quietly = TRUE)) {
  library(ggplot2)

  # Focus the picture on observations near the cutoff; far-away observations are less informative for local identification.
  dat_near <- subset(dat, abs(X_c) <= 30)
  dat_near$side <- ifelse(dat_near$Z == 1, "Eligible side", "Ineligible side")

  # Sharp RDD plot: fit separate local linear trends on the two sides of the cutoff.
  plot_sharp_rdd <- ggplot(dat_near, aes(x = X_c, y = Y, colour = side)) +
    geom_point(alpha = 0.25, size = 1) +
    geom_smooth(data = subset(dat_near, X_c < 0), method = "lm",
                formula = y ~ x, se = FALSE, colour = "grey25") +
    geom_smooth(data = subset(dat_near, X_c >= 0), method = "lm",
                formula = y ~ x, se = FALSE, colour = "#a84d77") +
    geom_vline(xintercept = 0, linetype = "dashed", colour = "grey35") +
    labs(
      title = "Sharp RDD near the cutoff",
      x = "Running variable X - c",
      y = "Outcome Y",
      colour = "Cutoff side"
    ) +
    theme_minimal()

  dat_fuzzy_near <- subset(dat_fuzzy, abs(X_c) <= 30)
  dat_fuzzy_near$side <- ifelse(dat_fuzzy_near$Z == 1, "Eligible side", "Ineligible side")

  # Fuzzy first-stage plot: the jump is in treatment probability, not necessarily from 0 to 1.
  plot_fuzzy_first_stage <- ggplot(dat_fuzzy_near, aes(x = X_c, y = D, colour = side)) +
    geom_jitter(height = 0.04, width = 0, alpha = 0.18, size = 1) +
    geom_smooth(data = subset(dat_fuzzy_near, X_c < 0), method = "lm",
                formula = y ~ x, se = FALSE, colour = "grey25") +
    geom_smooth(data = subset(dat_fuzzy_near, X_c >= 0), method = "lm",
                formula = y ~ x, se = FALSE, colour = "#a84d77") +
    geom_vline(xintercept = 0, linetype = "dashed", colour = "grey35") +
    labs(
      title = "Fuzzy RDD first stage near the cutoff",
      x = "Running variable X - c",
      y = "Treatment receipt D",
      colour = "Cutoff side"
    ) +
    theme_minimal()

  if (interactive()) {
    print(plot_sharp_rdd)
    print(plot_fuzzy_first_stage)
  } else {
    cat("Plots created as plot_sharp_rdd and plot_fuzzy_first_stage. Run the script in RStudio to display them.\n")
  }
} else {
  cat("ggplot2 is not installed. To draw the figures, run install.packages(\"ggplot2\") once, then rerun this script.\n")
}
