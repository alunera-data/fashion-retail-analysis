# ─────────────────────────────────────────────────────────────
# Project: Fashion Retail Analysis (NDK HF Transferarbeit)
# File:    06_tables_export.R
# Author:  Yvonne Kirschler
# Purpose: Export formatted summary tables for reporting
#          Formatierte Ergebnistabellen für den Bericht exportieren
# ─────────────────────────────────────────────────────────────

# STEP 1: Load required packages
# Load libraries for table formatting and tidy model output
# Pakete für Tabellenformatierung und Modellausgabe laden
# ─────────────────────────────────────────────────────────────
library(tidyverse)   # Data wrangling and summarisation
library(gt)          # Pretty tables for reports
library(broom)       # Clean model summaries

# STEP 2: Format confidence interval table
# Create formatted table of confidence intervals by discount group
# Konfidenzintervalle nach Rabattstatus sauber tabellarisch darstellen
# ─────────────────────────────────────────────────────────────
ci_discount <- ci_discount |> rename(std_dev = sd)

ci_table <- gt::gt(ci_discount) |> 
  gt::tab_header(
    title = md("**95% Confidence Intervals for Line Revenue**"),
    subtitle = "Grouped by Discount Status"
  ) |> 
  gt::fmt_number(columns = 2:6, decimals = 2) |>  # <- korrigiert auf columns = 2:6
  gt::tab_source_note("Source: Fashion Retail Transaction Data (n ≈ 6.4 million)")

print(ci_table)

# STEP 3: Format regression results table
# Present linear model output as readable regression summary
# Regressionsmodell tabellarisch aufbereiten für den Bericht
# ─────────────────────────────────────────────────────────────
reg_table <- broom::tidy(model_lm) |> 
  arrange(desc(abs(estimate))) |> 
  gt::gt() |> 
  gt::tab_header(
    title = md("**Regression Results: Line Revenue Model**")
  ) |> 
  gt::fmt_number(columns = c(estimate, std.error, statistic, p.value), decimals = 4) |> 
  gt::tab_source_note("Model fitted using linear regression (lm)")

print(reg_table)

# STEP 4: Summary table by payment method
# Show avg revenue and observation count by payment method
# Durchschnittlicher Umsatz pro Zahlungsmethode als Tabelle
# ─────────────────────────────────────────────────────────────
payment_summary <- transactions |> 
  filter(line_total > 0) |> 
  group_by(payment_method) |> 
  summarise(
    avg_revenue = mean(line_total, na.rm = TRUE),
    n = n()
  ) |> 
  arrange(desc(avg_revenue)) |> 
  gt::gt() |> 
  gt::tab_header(
    title = md("**Average Line Revenue by Payment Method**")
  ) |> 
  gt::fmt_number(columns = c(avg_revenue), decimals = 2) |> 
  gt::tab_source_note("Based on all valid transactions")

print(payment_summary)

# STEP 5: Completion confirmation
# Confirm that tables have been created and printed
# Ausgabe zur erfolgreichen Erstellung der Ergebnis-Tabellen
# ─────────────────────────────────────────────────────────────
cat("✔️ Summary tables created for reporting. / Tabellen erfolgreich erstellt.\n")

