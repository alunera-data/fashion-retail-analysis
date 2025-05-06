# ─────────────────────────────────────────────────────────────
# Project: Fashion Retail Analysis (NDK HF Transferarbeit)
# File:    05_model_lm.R
# Author:  Yvonne Kirschler
# Purpose: Run and interpret a linear regression model
#          Regressionsmodell berechnen und interpretieren
# ─────────────────────────────────────────────────────────────

# STEP 1: Load required packages
# Load libraries for modeling and report formatting
# Pakete zum Erstellen und Formatieren von Regressionsmodellen laden
# ─────────────────────────────────────────────────────────────
library(tidyverse)   # Data transformation and modeling
library(broom)       # Convert lm() output into tidy format
library(gt)          # Create clean, formatted regression tables

# STEP 2: Prepare data for modeling
# Join product information, remove invalid rows, set factors
# Produktdaten verknüpfen, ungültige Zeilen entfernen, Datentypen setzen
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

# STEP 3: Define and run regression model
# Define structure and run linear model
# Modellformel definieren und lineares Modell berechnen
# ─────────────────────────────────────────────────────────────
model_formula <- line_total ~ discount_applied + category + payment_method
model_lm <- lm(model_formula, data = model_data)

# STEP 4: Output model summary
# Show coefficients and fit metrics (R², adj. R² etc.)
# Modellzusammenfassung und Gütemasse anzeigen
# ─────────────────────────────────────────────────────────────
print(summary(model_lm))   # Full summary
print(glance(model_lm))    # Model diagnostics

# STEP 5: Format regression output for report
# Create tidy table sorted by effect size
# Formatierte Regressionsausgabe für Bericht generieren
# ─────────────────────────────────────────────────────────────
tidy_model <- tidy(model_lm) |> 
  arrange(desc(abs(estimate)))

reg_table <- tidy_model |> 
  gt() |> 
  tab_header(
    title = "Regression Results: Line Revenue Model",
    subtitle = "Estimated using lm() with n > 6 million rows"
  ) |> 
  fmt_number(columns = 2:5, decimals = 4) |> 
  tab_source_note("Model: Revenue ~ Discount + Category + Payment Method")

print(reg_table)

# STEP 6: Final confirmation
# Confirm successful regression execution
# Regressionsmodell erfolgreich abgeschlossen
# ─────────────────────────────────────────────────────────────
cat("✔️ Linear regression model estimated and summarised. / Regressionsmodell erfolgreich berechnet.\n")

