# ─────────────────────────────────────────────────────────────
# Project: Fashion Retail Analysis (NDK HF Transferarbeit)
# File:    06_tables_export.R
# Author:  Yvonne Kirschler
# Purpose: Export formatted summary tables for reporting
#          Formatierte Ergebnistabellen für den Bericht exportieren
# ─────────────────────────────────────────────────────────────

# ─────────────────────────────────────────────────────────────
# STEP 1: Load required packages
# Schritt 1: Notwendige R-Pakete laden
# Load libraries for table formatting and tidy model output
# Pakete für Tabellenformatierung und saubere Modellzusammenfassungen laden
# ─────────────────────────────────────────────────────────────
library(tidyverse)   # Data manipulation and grouping
library(gt)          # Create formatted and styled tables
library(broom)       # Clean model output formatting

# ─────────────────────────────────────────────────────────────
# STEP 2: Create table for confidence intervals
# Schritt 2: Tabelle für Konfidenzintervalle erstellen
# Show CI values with group labels, formatted using gt()
# Konfidenzintervalle tabellarisch anzeigen und formatieren
# ─────────────────────────────────────────────────────────────
ci_discount <- ci_discount |> 
  rename(std_dev = sd)

ci_table <- gt(ci_discount) |> 
  tab_header(
    title = md("**95% Confidence Intervals**"),
    subtitle = "Grouped by Discount Status"
  ) |> 
  fmt_number(columns = c(mean, std_dev, lower_ci, upper_ci), decimals = 2) |> 
  tab_source_note("Source: Fashion Retail Transaction Data (n ≈ 6.4 million)")

print(ci_table)

# ─────────────────────────────────────────────────────────────
# STEP 3: Create regression output table
# Schritt 3: Regressionsausgabe als Tabelle formatieren
# Convert and sort coefficients from model, display with gt()
# Modellkoeffizienten tabellarisch darstellen und formatieren
# ─────────────────────────────────────────────────────────────
reg_table <- tidy(model_lm) |> 
  arrange(desc(abs(estimate))) |> 
  gt() |> 
  tab_header(
    title = md("**Regression Results: Line Revenue Model**")
  ) |> 
  fmt_number(columns = c(estimate, std.error, statistic, p.value), decimals = 4) |> 
  tab_source_note("Model fitted using linear regression (lm)")

print(reg_table)

# ─────────────────────────────────────────────────────────────
# STEP 4: Create summary table by payment method
# Schritt 4: Tabelle nach Zahlungsmethode erstellen
# Show average revenue and count per payment method
# Durchschnittsumsatz und Fallzahl pro Zahlungsmethode darstellen
# ─────────────────────────────────────────────────────────────
payment_summary <- transactions |> 
  filter(line_total > 0) |> 
  group_by(payment_method) |> 
  summarise(
    avg_revenue = mean(line_total, na.rm = TRUE),
    n = n()
  ) |> 
  arrange(desc(avg_revenue)) |> 
  gt() |> 
  tab_header(
    title = md("**Average Line Revenue by Payment Method**")
  ) |> 
  fmt_number(columns = c(avg_revenue), decimals = 2) |> 
  tab_source_note("Based on all valid transactions")

print(payment_summary)

# ─────────────────────────────────────────────────────────────
# STEP 5: Final confirmation
# Schritt 5: Abschlussmeldung
# Confirm that tables were created successfully
# Bestätigung der erfolgreichen Tabellenerstellung
# ─────────────────────────────────────────────────────────────
cat("✔️ Summary tables created for reporting. / Tabellen erfolgreich erstellt.\n")