# Week 05: Difference-in-differences and simple TWFE
# Student starter script. No external data files required.
# ggplot2 is optional and used only for visualisation.

# Aim of the script:
# 1. create a simple two-period regional panel;
# 2. visualise treated and control trends;
# 3. show the ingredients of a 2x2 DiD design;
# 4. leave the group means, DiD estimate, and regression coefficient for you to compute.

set.seed(20260905)

n_units <- 80
years <- c(2024, 2025)
unit_info <- data.frame(
  id = seq_len(n_units),
  treated = as.integer(seq_len(n_units) <= n_units / 2),
  alpha = rnorm(n_units, sd = 6)
)

panel <- merge(
  expand.grid(id = seq_len(n_units), year = years, KEEP.OUT.ATTRS = FALSE),
  unit_info,
  by = "id"
)
panel$post <- as.integer(panel$year == 2025)

outcome_without_policy <- 50 + panel$alpha + 4 * panel$post +
  rnorm(nrow(panel), sd = 4)
post_policy_component <- 6 * panel$treated * panel$post
panel$Y <- outcome_without_policy + post_policy_component

cat("\nWeek 05 starter script\n")
cat("----------------------\n")
cat("Panel dataset created as panel. First rows:\n")
print(head(panel[, c("id", "year", "treated", "post", "Y")]))

cat("\nProcess:\n")
cat("1. Compute the four group-time means.\n")
cat("2. Subtract pre from post within each group.\n")
cat("3. Subtract the control trend from the treated trend.\n")
cat("4. Check that the interaction coefficient gives the same 2x2 DiD estimate.\n")

# TODO for students:
# Replace ___ in the lines below in your own copy, then run them.
#
# means <- aggregate(___ ~ treated + post, data = panel, mean)
# means
#
# treated_pre <- means$Y[means$treated == ___ & means$post == ___]
# treated_post <- means$Y[means$treated == ___ & means$post == ___]
# control_pre <- means$Y[means$treated == ___ & means$post == ___]
# control_post <- means$Y[means$treated == ___ & means$post == ___]
#
# did_hand <- (___ - ___) - (___ - ___)
# did_hand
#
# fit <- lm(Y ~ ___ * ___, data = panel)
# summary(fit)
# coef(fit)["___"]

cat("\nDataviz process:\n")
cat("The line plot shows the two ingredients of DiD: the treated trend and the control trend.\n")
cat("Parallel trends is an assumption about the missing untreated trend for the treated group.\n")

if (requireNamespace("ggplot2", quietly = TRUE)) {
  library(ggplot2)

  local({
    # Group-time means are computed locally for the plot; students compute and report them in the TODO block.
    plot_means <- aggregate(Y ~ treated + post, data = panel, mean)
    plot_means$year <- ifelse(plot_means$post == 1, 2025, 2024)
    plot_means$group <- ifelse(plot_means$treated == 1, "Treated", "Control")

    # In a 2x2 design, the vertical gap between the two trend changes is the DiD estimate.
    plot_did_means <- ggplot(plot_means, aes(x = year, y = Y, colour = group, group = group)) +
      geom_line(linewidth = 1) +
      geom_point(size = 3) +
      scale_x_continuous(breaks = years) +
      labs(
        title = "Observed group means over time",
        x = "Year",
        y = "Mean outcome Y",
        colour = "Group"
      ) +
      theme_minimal()

    if (interactive()) {
      print(plot_did_means)
    } else {
      cat("Plot code ran. Run the script in RStudio to display the figure.\n")
    }
  })
} else {
  cat("ggplot2 is not installed. To draw the figure, run install.packages(\"ggplot2\") once, then rerun this script.\n")
}
