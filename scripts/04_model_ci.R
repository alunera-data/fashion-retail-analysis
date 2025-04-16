# ─────────────────────────────────────────────────────────────
# Project: Fashion Retail Analysis (NDK HF Transferarbeit)
# File:    04_model_ci.R
# Author:  Yvonne Kirschler
# Purpose: Calculate 95% confidence intervals using qnorm()
# ─────────────────────────────────────────────────────────────

# Load required packages
library(tidyverse)
library(gt)

# ─────────────────────────────────────────────────────────────
# Step 1: Demonstration of qnorm() for 95% confidence interval
# (as explicitly required by assignment instructions)
# This shows how qnorm is used to calculate CI bounds directly
# ─────────────────────────────────────────────────────────────

# Example: Calculate CI for mean = 2, sd = 1.2
qnorm(c(0.025, 0.975), mean = 2, sd = 1.2)

# Interpretation:
# This represents the theoretical 95% CI around a mean of 2 
# with a standard deviation of 1.2 (sample size not involved here)

# ─────────────────────────────────────────────────────────────
# Step 2: Calculate mean and SD from actual data
# and use qnorm() to calculate CI (based on SE)
# ─────────────────────────────────────────────────────────────

# Calculate stats for transactions with discount applied = "Yes"
discount_yes <- transactions |>
  filter(discount_applied == "Yes") |>
  summarise(
    n    = n(),
    mean = mean(line_total, na.rm = TRUE),
    sd   = sd(line_total, na.rm = TRUE)
  )

# Extract numeric values
mean_value <- discount_yes$mean
sd_value   <- discount_yes$sd
n_value    <- discount_yes$n

# Calculate confidence interval using qnorm() with standard error
ci_discount_yes <- qnorm(c(0.025, 0.975), mean = mean_value, sd = sd_value / sqrt(n_value))
print(ci_discount_yes)

# ─────────────────────────────────────────────────────────────
# Step 3: Calculate CI for both groups (Yes/No) using qnorm()
# ─────────────────────────────────────────────────────────────

ci_discount <- transactions |>
  group_by(discount_applied) |>
  summarise(
    n    = n(),
    mean = mean(line_total, na.rm = TRUE),
    sd   = sd(line_total, na.rm = TRUE),
    lower_ci = qnorm(0.025, mean, sd / sqrt(n)),
    upper_ci = qnorm(0.975, mean, sd / sqrt(n))
  )

# Print table
print(ci_discount)

# ─────────────────────────────────────────────────────────────
# Step 4: Format result as gt table (for Quarto report)
# ─────────────────────────────────────────────────────────────

gt(ci_discount) |>
  tab_header(title = "95% Confidence Intervals for Line Revenue")

# ─────────────────────────────────────────────────────────────
# Final confirmation
# ─────────────────────────────────────────────────────────────

cat("✔️ 95% confidence intervals calculated using qnorm().\n")