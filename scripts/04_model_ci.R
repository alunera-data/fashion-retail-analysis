# ─────────────────────────────────────────────────────────────
# Project: Fashion Retail Analysis (NDK HF Transferarbeit)
# File:    04_model_ci.R
# Author:  Yvonne Kirschler
# Purpose: Calculate 95% confidence intervals using qnorm()
#          Berechnung von 95%-Konfidenzintervallen mit qnorm()
# ─────────────────────────────────────────────────────────────

# STEP 1: Load required packages
# Load libraries for statistical calculation and table formatting
# Pakete für Statistik und Tabellenformatierung laden
# ─────────────────────────────────────────────────────────────
library(tidyverse)   # Data manipulation and summary
library(gt)          # Create formatted summary tables

# STEP 2: Demonstrate qnorm() with example
# Demonstration of required formula from assignment
# Vorgabe aus Transferauftrag (qnorm mit Beispielwerten)
# ─────────────────────────────────────────────────────────────
ci_example <- qnorm(c(0.025, 0.975), mean = 2, sd = 1.2)
print(ci_example)

# STEP 3: Calculate CI for "discount_applied = Yes"
# Compute group-specific confidence interval for discounted sales
# Konfidenzintervall für rabattierte Transaktionen berechnen
# ─────────────────────────────────────────────────────────────
discount_yes <- transactions |> 
  filter(discount_applied == "Yes") |> 
  summarise(
    n    = n(),
    mean = mean(line_total, na.rm = TRUE),
    sd   = sd(line_total, na.rm = TRUE)
  )

mean_value <- discount_yes$mean
sd_value   <- discount_yes$sd
n_value    <- discount_yes$n

ci_discount_yes <- qnorm(
  c(0.025, 0.975),
  mean = mean_value,
  sd   = sd_value / sqrt(n_value)
)
print(ci_discount_yes)

# STEP 4: Calculate CI for both discount groups
# Apply qnorm() to Yes/No discount groups
# Konfidenzintervalle für beide Rabattgruppen (Yes/No)
# ─────────────────────────────────────────────────────────────
ci_discount <- transactions |> 
  group_by(discount_applied) |> 
  summarise(
    n        = n(),
    mean     = mean(line_total, na.rm = TRUE),
    sd       = sd(line_total, na.rm = TRUE),
    lower_ci = qnorm(0.025, mean, sd / sqrt(n)),
    upper_ci = qnorm(0.975, mean, sd / sqrt(n))
  )

print(ci_discount)

# STEP 5: Create gt() summary table
# Format CI table for use in Quarto report
# Tabelle mit Konfidenzintervallen für den Bericht formatieren
# ─────────────────────────────────────────────────────────────
gt(ci_discount) |> 
  tab_header(
    title = "95% Confidence Intervals for Line Revenue",
    subtitle = "Grouped by Discount Status"
  ) |> 
  fmt_number(columns = 2:6, decimals = 2) |> 
  tab_source_note("Source: Fashion Retail Transaction Data (n ≈ 6.4 million)")

# STEP 6: Final confirmation
# Abschlussmeldung zur erfolgreichen Berechnung
# ─────────────────────────────────────────────────────────────
cat("✔️ 95% confidence intervals calculated using qnorm(). / Konfidenzintervalle berechnet.\n")

