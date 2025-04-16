# ─────────────────────────────────────────────────────────────
# Project: Fashion Retail Analysis (NDK HF Transferarbeit)
# File:    05_model_lm.R
# Author:  Yvonne Kirschler
# Purpose: Run and interpret a linear regression model
# ─────────────────────────────────────────────────────────────

# Load required packages
library(tidyverse)
library(broom)
library(gt)

# ─────────────────────────────────────────────────────────────
# Step 1: Prepare data for modeling
# Join product and transaction data, filter and convert types
# ─────────────────────────────────────────────────────────────

model_data <- transactions |>
  filter(line_total > 0) |>
  left_join(products, by = "product_id") |>
  mutate(
    discount_applied = as_factor(discount_applied),
    category         = as_factor(category),
    payment_method   = as_factor(payment_method)
  ) |>
  select(line_total, discount_applied, category, payment_method)

# ─────────────────────────────────────────────────────────────
# Step 2: Define and run the regression model
# ─────────────────────────────────────────────────────────────

model_formula <- line_total ~ discount_applied + category + payment_method
model_lm <- lm(model_formula, data = model_data)

# ─────────────────────────────────────────────────────────────
# Step 3: Output model summary and key metrics
# ─────────────────────────────────────────────────────────────

summary(model_lm)        # full summary
glance(model_lm)         # model metrics (R² etc.)

# ─────────────────────────────────────────────────────────────
# Step 4: Format model results as a report-ready table
# ─────────────────────────────────────────────────────────────

tidy_model <- tidy(model_lm) |>
  arrange(desc(abs(estimate)))

gt(tidy_model) |>
  tab_header(title = "Regression Results: Line Revenue Model")

# ─────────────────────────────────────────────────────────────
# Final confirmation
# ─────────────────────────────────────────────────────────────

cat("✔️ Linear regression model estimated and summarised.\n")

