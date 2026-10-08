# Week 08: Synthetic control, heterogeneity, and replication
# Student starter script. No external data files required.
# ggplot2 is optional and used only for visualisation.

# Aim of the script:
# 1. create a synthetic regional panel with one treated region;
# 2. inspect the donor pool visually before constructing a counterfactual;
# 3. create a small randomised subgroup example;
# 4. leave synthetic-control weights, gaps, placebo checks, and heterogeneity estimates for you to compute.

set.seed(20260908)

regions <- paste0("R", 1:8)
years <- 2014:2026
policy_year <- 2022

region_info <- data.frame(
  region = regions,
  base = c(55, 52, 57, 50, 60, 54, 48, 62),
  lambda1 = c(1.10, 1.00, 1.20, 0.80, 1.35, 1.05, 0.75, 1.45),
  lambda2 = c(3.0, 2.5, 3.5, 1.5, 4.0, 2.8, 1.0, 4.4)
)
time_info <- data.frame(
  year = years,
  f1 = years - min(years),
  f2 = sin(seq_along(years) / 2)
)

panel <- merge(
  expand.grid(region = regions, year = years, KEEP.OUT.ATTRS = FALSE),
  region_info,
  by = "region"
)
panel <- merge(panel, time_info, by = "year")
panel <- panel[order(panel$region, panel$year), ]
panel$treated_unit <- panel$region == "R1"
panel$post <- panel$year >= policy_year
outcome_without_policy <- panel$base + panel$lambda1 * panel$f1 +
  panel$lambda2 * panel$f2 + rnorm(nrow(panel), sd = 0.7)
policy_component <- ifelse(panel$treated_unit & panel$post,
                           -5 - 0.8 * (panel$year - policy_year), 0)
panel$Y <- outcome_without_policy + policy_component

wide <- reshape(panel[, c("region", "year", "Y")],
                idvar = "year", timevar = "region", direction = "wide")
wide <- wide[order(wide$year), ]
Y_mat <- as.matrix(wide[, paste0("Y.", regions)])
rownames(Y_mat) <- wide$year

theta_to_weights <- function(theta) {
  e <- exp(theta - max(theta))
  e / sum(e)
}

fit_synth <- function(Y_mat, treated_col, pre_rows,
                      donor_cols = setdiff(colnames(Y_mat), treated_col)) {
  y_treat_pre <- Y_mat[pre_rows, treated_col]
  y_donor_pre <- Y_mat[pre_rows, donor_cols, drop = FALSE]

  loss <- function(theta) {
    w <- theta_to_weights(theta)
    mean((as.vector(y_treat_pre) - as.vector(y_donor_pre %*% w))^2)
  }

  opt <- optim(rep(0, length(donor_cols)), loss, control = list(maxit = 2000))
  weights <- theta_to_weights(opt$par)
  names(weights) <- donor_cols
  synth <- as.vector(Y_mat[, donor_cols, drop = FALSE] %*% weights)

  list(weights = weights, synth = synth, donors = donor_cols)
}

# Short subgroup illustration: random assignment makes the interaction interpretable here.
n <- 600
X_subgroup <- rbinom(n, size = 1, prob = 0.45)
Z <- rbinom(n, size = 1, prob = 0.5)
D <- Z
subgroup_component <- ifelse(X_subgroup == 1, 6, 2)
outcome_without_treatment <- 30 + 4 * X_subgroup + rnorm(n, sd = 5)
Y <- outcome_without_treatment + subgroup_component * D
hte_dat <- data.frame(X_subgroup, Z, D, Y)

cat("\nWeek 08 starter script\n")
cat("----------------------\n")
cat("Regional panel created as panel and wide matrix created as Y_mat.\n")
cat("Subgroup example created as hte_dat.\n")
cat("First rows of panel:\n")
print(head(panel[, c("region", "year", "treated_unit", "post", "Y")]))

cat("\nProcess:\n")
cat("1. Inspect whether donor regions resemble the treated region before the policy.\n")
cat("2. Fit a synthetic control and report the largest donor weights.\n")
cat("3. Plot and interpret the treated-minus-synthetic gap.\n")
cat("4. Use placebo and leave-one-donor-out checks as diagnostics, not proofs.\n")
cat("5. Estimate the subgroup interaction in the randomised example.\n")

# TODO for students:
# Replace ___ in the lines below in your own copy, then run them.
#
# pre_rows <- years < ___
# main <- fit_synth(Y_mat, treated_col = "Y.___", pre_rows = pre_rows)
# gap <- as.vector(Y_mat[, "Y.___"]) - main$___
#
# weights <- data.frame(
#   region = sub("Y\\.", "", names(main$___)),
#   weight = as.numeric(main$___)
# )
# weights[order(-weights$weight), ]
#
# pre_mspe <- mean(gap[___]^2)
# post_avg_gap <- mean(gap[___])
# pre_mspe
# post_avg_gap
#
# placebo_rows <- lapply(colnames(Y_mat), function(treated_col) {
#   fit <- fit_synth(Y_mat, treated_col = treated_col, pre_rows = ___)
#   placebo_gap <- as.vector(Y_mat[, treated_col]) - fit$___
#   pre <- mean(placebo_gap[___]^2)
#   post <- mean(placebo_gap[___]^2)
#   data.frame(
#     region = sub("Y\\.", "", treated_col),
#     pre_mspe = pre,
#     post_mspe = post,
#     gap_ratio = ___ / ___,
#     avg_post_gap = mean(placebo_gap[___])
#   )
# })
# placebo_summary <- do.call(rbind, placebo_rows)
# placebo_summary[order(-placebo_summary$gap_ratio), ]
#
# largest_donor_col <- paste0("Y.", weights$region[___])
# loo_donors <- setdiff(main$donors, largest_donor_col)
# loo <- fit_synth(Y_mat, treated_col = "Y.___",
#                  pre_rows = pre_rows, donor_cols = loo_donors)
# gap_loo <- as.vector(Y_mat[, "Y.___"]) - loo$___
# mean(gap_loo[___])
#
# hte_fit <- lm(Y ~ ___ * ___, data = hte_dat)
# summary(hte_fit)

cat("\nDataviz process:\n")
cat("Plot 1 compares the treated region with the donor pool before and after the policy.\n")
cat("Plot 2 shows subgroup outcome distributions in the randomised example before estimating the interaction.\n")

if (requireNamespace("ggplot2", quietly = TRUE)) {
  library(ggplot2)

  # Donor-pool plot: visual inspection helps assess pre-treatment fit before SCM is estimated.
  panel$series <- ifelse(panel$treated_unit, "Treated region R1", "Potential donor")
  plot_donor_pool <- ggplot(panel, aes(x = year, y = Y, group = region, colour = series)) +
    geom_line(alpha = 0.75) +
    geom_vline(xintercept = policy_year - 0.5, linetype = "dashed", colour = "grey35") +
    labs(
      title = "Treated region and donor pool",
      x = "Year",
      y = "Outcome Y",
      colour = "Series"
    ) +
    theme_minimal()

  # Heterogeneity plot: visualise subgroup differences before interpreting an interaction coefficient.
  hte_dat$group <- ifelse(hte_dat$X_subgroup == 1, "Subgroup X = 1", "Subgroup X = 0")
  hte_dat$D_label <- ifelse(hte_dat$D == 1, "D = 1", "D = 0")
  plot_hte_groups <- ggplot(hte_dat, aes(x = D_label, y = Y, fill = D_label)) +
    geom_boxplot(outlier.alpha = 0.25) +
    facet_wrap(~ group) +
    labs(
      title = "Outcome by treatment and subgroup",
      x = "Treatment status",
      y = "Outcome Y"
    ) +
    theme_minimal() +
    theme(legend.position = "none")

  if (interactive()) {
    print(plot_donor_pool)
    print(plot_hte_groups)
  } else {
    cat("Plots created as plot_donor_pool and plot_hte_groups. Run the script in RStudio to display them.\n")
  }
} else {
  cat("ggplot2 is not installed. To draw the figures, run install.packages(\"ggplot2\") once, then rerun this script.\n")
}
