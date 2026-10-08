# Week 02: Selection, regression, matching, and inference
# Student starter script. No external data files required.
# ggplot2 is optional and used only for visualisation.

# Aim of the script:
# 1. create a synthetic employment programme dataset;
# 2. estimate propensity scores so overlap can be visualised;
# 3. show the process for checking support and balance;
# 4. leave the requested estimates for you to compute.

set.seed(20260902)

make_selection_data <- function(n = 800) {
  id <- seq_len(n)
  X <- rnorm(n, mean = 50, sd = 10)        # observed baseline skill
  female <- rbinom(n, size = 1, prob = 0.55)
  U <- rnorm(n)                            # unobserved motivation/network

  earnings_without_programme <- 1600 + 22 * X + 120 * female +
    350 * U + rnorm(n, sd = 350)
  programme_component <- 220 + 60 * (X < 50)
  prob_D <- plogis(-5.2 + 0.075 * X + 0.85 * U - 0.25 * female)
  D <- rbinom(n, size = 1, prob = prob_D)
  Y <- earnings_without_programme + programme_component * D

  # Return only variables a researcher could plausibly observe.
  data.frame(id, X, female, D, Y)
}

dat <- make_selection_data()

cat("\nWeek 02 starter script\n")
cat("----------------------\n")
cat("Dataset created as dat. First rows:\n")
print(head(dat))

cat("\nProcess:\n")
cat("1. Estimate the naive treated-control comparison.\n")
cat("2. Add observed controls X and female.\n")
cat("3. Estimate a propensity score and inspect common support.\n")
cat("4. Remember that observed balance does not remove unobserved selection.\n")

# Propensity scores are estimated here because they are needed for the overlap plot.
# They use only observed pre-treatment variables.
ps_model <- glm(D ~ X + female, data = dat, family = binomial())
dat$ps <- fitted(ps_model)

# TODO for students:
# Replace ___ in the lines below in your own copy, then run them.
#
# naive <- coef(lm(Y ~ ___, data = dat))["D"]
# adjusted <- coef(lm(Y ~ D + ___ + ___, data = dat))["D"]
#
# treated_range <- range(dat$ps[dat$D == ___])
# control_range <- range(dat$ps[dat$D == ___])
# rbind(
#   treated = treated_range,
#   control = control_range
# )
#
# support_lower <- max(treated_range[___], control_range[___])
# support_upper <- min(treated_range[___], control_range[___])
# dat_support <- subset(dat, ps >= ___ & ps <= ___)
#
# breaks <- unique(quantile(dat_support$ps, probs = seq(0, 1, 0.2), na.rm = TRUE))
# dat_support$ps_bin <- cut(dat_support$ps, breaks = breaks, include.lowest = TRUE)
# bins <- split(dat_support, dat_support$ps_bin)
# bin_att <- sapply(bins, function(b) {
#   if (length(unique(b$D)) < 2) return(NA_real_)
#   mean(b$Y[b$D == ___]) - mean(b$Y[b$D == ___])
# })
# bin_weights <- sapply(bins, function(b) sum(b$D == ___))
# matched_att <- weighted.mean(bin_att, bin_weights, na.rm = TRUE)
# matched_att

cat("\nDataviz process:\n")
cat("The propensity-score plot checks overlap: do treated and untreated observations exist in the same regions of X?\n")
cat("The dashed lines mark the common-support interval used before subclassification.\n")

if (requireNamespace("ggplot2", quietly = TRUE)) {
  library(ggplot2)

  local({
    # Label D so the legend reads like the empirical comparison.
    plot_dat <- dat
    plot_dat$D_label <- ifelse(plot_dat$D == 1, "D = 1 treated", "D = 0 control")
    treated_range <- range(plot_dat$ps[plot_dat$D == 1])
    control_range <- range(plot_dat$ps[plot_dat$D == 0])
    support_lines <- c(max(treated_range[1], control_range[1]),
                       min(treated_range[2], control_range[2]))

    # Overlap plot: poor overlap warns us that the estimand may become more local.
    plot_propensity_overlap <- ggplot(plot_dat, aes(x = ps, fill = D_label)) +
      geom_histogram(position = "identity", bins = 30, alpha = 0.55) +
      geom_vline(xintercept = support_lines,
                 linetype = "dashed", colour = "grey30") +
      labs(
        title = "Propensity-score overlap",
        x = "Estimated propensity score",
        y = "Number of observations",
        fill = "Treatment status"
      ) +
      theme_minimal()

    # Balance plot: this shows observed X before any claim about unobserved U.
    plot_x_by_treatment <- ggplot(plot_dat, aes(x = D_label, y = X, colour = D_label)) +
      geom_boxplot(outlier.alpha = 0.35) +
      labs(
        title = "Observed baseline skill by treatment status",
        x = "Treatment status",
        y = "Observed covariate X"
      ) +
      theme_minimal() +
      theme(legend.position = "none")

    if (interactive()) {
      print(plot_propensity_overlap)
      print(plot_x_by_treatment)
    } else {
      cat("Plot code ran. Run the script in RStudio to display the two figures.\n")
    }
  })
} else {
  cat("ggplot2 is not installed. To draw the figures, run install.packages(\"ggplot2\") once, then rerun this script.\n")
}
