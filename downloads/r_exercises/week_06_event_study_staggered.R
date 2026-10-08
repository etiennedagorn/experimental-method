# Week 06: Event studies and staggered DiD
# Student starter script. No external data files required.
# ggplot2 is optional and used only for visualisation.

# Aim of the script:
# 1. create a synthetic staggered-adoption panel;
# 2. build event-time indicators;
# 3. visualise a TWFE event-study and explicit group-time ATT(g,t) estimates;
# 4. leave the reported coefficients and support checks for you to compute.

set.seed(20260906)

n_units <- 90
years <- 2016:2023
unit_info <- data.frame(
  id = seq_len(n_units),
  cohort = rep(c(2019, 2021, Inf), each = 30),
  alpha = rnorm(n_units, sd = 5),
  slope = rnorm(n_units, mean = 0, sd = 0.25)
)

panel <- merge(
  expand.grid(id = seq_len(n_units), year = years, KEEP.OUT.ATTRS = FALSE),
  unit_info,
  by = "id"
)
panel$time <- panel$year - min(years)
panel$treated <- as.integer(is.finite(panel$cohort) & panel$year >= panel$cohort)
panel$event_time <- ifelse(is.finite(panel$cohort), panel$year - panel$cohort, NA)

policy_component <- ifelse(
  panel$treated == 1,
  2 + 1.5 * pmin(pmax(panel$event_time, 0), 3),
  0
)
outcome_without_policy <- 100 + panel$alpha + 1.4 * panel$time +
  panel$slope * panel$time + rnorm(nrow(panel), sd = 3)
panel$Y <- outcome_without_policy + policy_component

# Traditional TWFE event-study coding. Event time -1 is omitted.
panel$event_m2 <- as.integer(!is.na(panel$event_time) & panel$event_time == -2)
panel$event_0 <- as.integer(!is.na(panel$event_time) & panel$event_time == 0)
panel$event_1 <- as.integer(!is.na(panel$event_time) & panel$event_time == 1)
panel$event_2p <- as.integer(!is.na(panel$event_time) & panel$event_time >= 2)

unit_cohort <- unit_info$cohort
names(unit_cohort) <- unit_info$id

mean_outcome <- function(ids, yr) {
  mean(panel$Y[panel$id %in% ids & panel$year == yr])
}

att_gt_one <- function(g, t) {
  base_year <- g - 1
  treated_ids <- as.integer(names(unit_cohort)[unit_cohort == g])
  control_ids <- as.integer(names(unit_cohort)[unit_cohort > t | is.infinite(unit_cohort)])
  if (length(control_ids) == 0) return(NA_real_)
  (mean_outcome(treated_ids, t) - mean_outcome(treated_ids, base_year)) -
    (mean_outcome(control_ids, t) - mean_outcome(control_ids, base_year))
}

cat("\nWeek 06 starter script\n")
cat("----------------------\n")
cat("Panel dataset created as panel. First rows:\n")
print(head(panel[, c("id", "year", "cohort", "treated", "event_time", "Y")]))

cat("\nProcess:\n")
cat("1. Read event time as calendar year minus treatment cohort.\n")
cat("2. Interpret TWFE coefficients relative to omitted event time -1.\n")
cat("3. Compare those coefficients with explicit ATT(g,t) calculations.\n")
cat("4. Check which event times have weak support.\n")

# TODO for students:
# Replace ___ in the lines below in your own copy, then run them.
#
# fit_twfe <- lm(
#   Y ~ factor(id) + factor(year) + ___ + ___ + ___ + ___,
#   data = panel
# )
#
# event_coefs <- coef(summary(fit_twfe))[
#   c("event_m2", "event_0", "event_1", "event_2p"),
#   c("___", "___"),
#   drop = FALSE
# ]
# event_coefs
#
# one_att <- att_gt_one(g = ___, t = ___)
# one_att
#
# support <- aggregate(id ~ ___, data = subset(panel, !is.na(___)),
#                      function(x) length(unique(x)))
# names(support)[2] <- "number_of_units"
# support[order(support$___), ]

cat("\nDataviz process:\n")
cat("Plot 1 shows TWFE event-study coefficients relative to the omitted period, event time -1.\n")
cat("Plot 2 shows explicit group-time ATT(g,t) estimates, keeping cohort and calendar timing visible.\n")

if (requireNamespace("ggplot2", quietly = TRUE)) {
  library(ggplot2)

  local({
    fit_plot <- lm(
      Y ~ factor(id) + factor(year) + event_m2 + event_0 + event_1 + event_2p,
      data = panel
    )

    event_coefs_for_plot <- coef(summary(fit_plot))[
      c("event_m2", "event_0", "event_1", "event_2p"),
      c("Estimate", "Std. Error"),
      drop = FALSE
    ]
    event_plot_data <- data.frame(
      event_time = c(-2, 0, 1, 2),
      estimate = event_coefs_for_plot[, "Estimate"],
      se = event_coefs_for_plot[, "Std. Error"]
    )
    event_plot_data$lower <- event_plot_data$estimate - 1.96 * event_plot_data$se
    event_plot_data$upper <- event_plot_data$estimate + 1.96 * event_plot_data$se

    att_rows <- list()
    for (g in c(2019, 2021)) {
      for (t in years[years >= g]) {
        att_rows[[length(att_rows) + 1]] <- data.frame(
          cohort = g,
          year = t,
          event_time = t - g,
          att_gt = att_gt_one(g, t)
        )
      }
    }
    att_plot_data <- do.call(rbind, att_rows)

    # Coefficient plot: leads are diagnostic evidence, not proof of parallel trends.
    plot_twfe_event_study <- ggplot(event_plot_data, aes(x = event_time, y = estimate)) +
      geom_hline(yintercept = 0, colour = "grey55") +
      geom_vline(xintercept = -0.5, linetype = "dashed", colour = "grey35") +
      geom_pointrange(aes(ymin = lower, ymax = upper), colour = "#3266a8") +
      scale_x_continuous(breaks = event_plot_data$event_time) +
      labs(
        title = "Traditional TWFE event-study coefficients",
        x = "Event time",
        y = "Coefficient relative to event time -1"
      ) +
      theme_minimal()

    # ATT(g,t) plot: this makes the cohort-specific comparison explicit.
    plot_att_gt <- ggplot(att_plot_data, aes(x = event_time, y = att_gt, colour = factor(cohort))) +
      geom_hline(yintercept = 0, colour = "grey55") +
      geom_line(linewidth = 1) +
      geom_point(size = 2.5) +
      labs(
        title = "Group-time ATT(g,t) estimates",
        x = "Event time",
        y = "ATT(g,t)",
        colour = "Treatment cohort"
      ) +
      theme_minimal()

    if (interactive()) {
      print(plot_twfe_event_study)
      print(plot_att_gt)
    } else {
      cat("Plot code ran. Run the script in RStudio to display the two figures.\n")
    }
  })
} else {
  cat("ggplot2 is not installed. To draw the figures, run install.packages(\"ggplot2\") once, then rerun this script.\n")
}
