# Week 01: Foundations of policy evaluation
# Student starter script. No external data files required.
# ggplot2 is optional and used only for visualisation.

# Aim of the script:
# 1. create a tiny tutoring dataset with an offer Z and attendance D;
# 2. show how assignment, receipt, baseline X, and outcome Y can be inspected;
# 3. compare the offer contrast with the attendance contrast;
# 4. leave the numerical homework answers for you to compute.

# Homework Exercise 2: offer, attendance, and the target comparison
dat <- data.frame(
  pupil = paste0("P", 1:12),
  Z = c(1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0),
  D = c(1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0),
  X = c(70, 62, 58, 75, 66, 60, 68, 57, 74, 63, 71, 59),
  Y = c(78, 73, 64, 82, 69, 72, 70, 61, 76, 65, 72, 62)
)

cat("\nWeek 01 starter script\n")
cat("----------------------\n")
cat("Small homework dataset created as dat. First rows:\n")
print(head(dat))

cat("\nProcess:\n")
cat("1. Compare take-up D between offered and not-offered pupils.\n")
cat("2. Compare outcomes by offer status Z.\n")
cat("3. Compare outcomes by actual attendance D.\n")
cat("4. Decide which comparison matches the policy question.\n")

# TODO for students:
# Replace ___ in the lines below in your own copy, then run them.
#
# takeup_offered <- mean(dat$D[dat$Z == ___])
# takeup_not_offered <- mean(dat$D[dat$Z == ___])
#
# offer_gap <- mean(dat$Y[dat$Z == ___]) - mean(dat$Y[dat$Z == ___])
# attendance_gap <- mean(dat$Y[dat$D == ___]) - mean(dat$Y[dat$D == ___])
#
# offer_model <- lm(Y ~ ___, data = dat)
# attendance_model <- lm(Y ~ ___, data = dat)
# coef(offer_model)["Z"]
# coef(attendance_model)["D"]

cat("\nDataviz process for the homework comparison:\n")
cat("Plot 1 compares outcomes by offer status Z.\n")
cat("Plot 2 compares outcomes by attendance status D.\n")

if (requireNamespace("ggplot2", quietly = TRUE)) {
  library(ggplot2)

  local({
    # Labels make the comparison readable without memorising binary codes.
    plot_dat <- dat
    plot_dat$Z_label <- ifelse(plot_dat$Z == 1, "Z = 1 offered", "Z = 0 not offered")
    plot_dat$D_label <- ifelse(plot_dat$D == 1, "D = 1 attended", "D = 0 did not attend")

    # Offer plot: this is the comparison created by the allocation rule.
    plot_offer <- ggplot(plot_dat, aes(x = Z_label, y = Y, colour = Z_label)) +
      geom_point(size = 2, alpha = 0.75) +
      stat_summary(fun = mean, geom = "point", size = 4, colour = "black") +
      labs(
        title = "Outcome comparison by offer status",
        x = "Offer status",
        y = "End-of-year score Y"
      ) +
      theme_minimal() +
      theme(legend.position = "none")

    # Attendance plot: this is a useful description, but it is not automatically the policy estimand.
    plot_attendance <- ggplot(plot_dat, aes(x = D_label, y = Y, colour = D_label)) +
      geom_point(size = 2, alpha = 0.75) +
      stat_summary(fun = mean, geom = "point", size = 4, colour = "black") +
      labs(
        title = "Outcome comparison by attendance status",
        x = "Attendance status",
        y = "End-of-year score Y"
      ) +
      theme_minimal() +
      theme(legend.position = "none")

    if (interactive()) {
      print(plot_offer)
      print(plot_attendance)
    } else {
      cat("Plot code ran. Run the script in RStudio to display the two figures.\n")
    }
  })
} else {
  cat("ggplot2 is not installed. To draw the figures, run install.packages(\"ggplot2\") once, then rerun this script.\n")
}

# Optional exploration: a larger simulated example with the same Z versus D distinction.
# These generated data are not needed for the short homework answer.
set.seed(20260901)

n <- 500
id <- seq_len(n)
X <- rnorm(n, mean = 50, sd = 10)          # baseline score
motivation <- rnorm(n)                     # one reason attendance may differ after an offer

untreated_score <- 35 + 0.7 * X + 4 * motivation + rnorm(n, sd = 5)
tutoring_component <- 4 + 0.04 * (60 - X) + 1.5 * motivation
treated_score <- untreated_score + tutoring_component

Z <- rbinom(n, size = 1, prob = 0.5)
prob_D <- plogis(-2.2 + 1.8 * Z + 0.04 * X + 0.7 * motivation)
D <- rbinom(n, size = 1, prob = prob_D)
Y <- ifelse(D == 1, treated_score, untreated_score)

sim <- data.frame(id, X, Z, D, Y)

cat("\nOptional simulation created as sim.\n")
cat("The simulation keeps only observed-style variables in sim: id, X, Z, D, and Y.\n")

if (requireNamespace("ggplot2", quietly = TRUE)) {
  local({
    plot_sim <- sim
    plot_sim$Z_label <- ifelse(plot_sim$Z == 1, "Z = 1 offered", "Z = 0 not offered")
    plot_sim$D_label <- ifelse(plot_sim$D == 1, "D = 1 attended", "D = 0 did not attend")

    # This scatterplot shows that offer status and actual attendance are related but not identical.
    plot_offer_attendance <- ggplot(plot_sim, aes(x = X, y = Y, colour = Z_label, shape = D_label)) +
      geom_point(alpha = 0.6) +
      labs(
        title = "Offer status, attendance, and observed outcomes",
        x = "Baseline score X",
        y = "Observed outcome Y",
        colour = "Offer status",
        shape = "Attendance status"
      ) +
      theme_minimal()

    if (interactive()) {
      print(plot_offer_attendance)
    } else {
      cat("Optional plot code ran. Run the script in RStudio to display it.\n")
    }
  })
}
