# ─────────────────────────────────────────────────────────────
# Project: Fashion Retail Analysis (NDK HF Transferarbeit)
# File:    04_model_ci.R
# Author:  Yvonne Kirschler
# Purpose: Calculate 95% confidence intervals using qnorm()
#          Berechnung von 95%-Konfidenzintervallen mit qnorm()
# ─────────────────────────────────────────────────────────────

# ─────────────────────────────────────────────────────────────
# STEP 1: Load required packages
# Schritt 1: Notwendige R-Pakete laden
# Load libraries for statistical calculation and table formatting
# Pakete für statistische Berechnung und tabellarische Darstellung laden
# ─────────────────────────────────────────────────────────────
library(tidyverse)   # Data manipulation and summary
library(gt)          # Create formatted summary tables

# ─────────────────────────────────────────────────────────────
# STEP 2: Demonstrate qnorm() with given parameters
# Schritt 2: qnorm() demonstrieren mit Beispielwerten
# Required: Show understanding of the confidence interval formula
# Vorgabe: Konfidenzintervallformel exemplarisch anwenden
# ─────────────────────────────────────────────────────────────
ci_example <- qnorm(c(0.025, 0.975), mean = 2, sd = 1.2)
print(ci_example)

# ─────────────────────────────────────────────────────────────
# STEP 3: Calculate CI for group "discount_applied = Yes"
# Schritt 3: Konfidenzintervall für rabattierte Transaktionen
# Calculate mean and SD, apply qnorm with SE
# Mittelwert und Standardabweichung berechnen, qnorm anwenden
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

# ─────────────────────────────────────────────────────────────
# STEP 4: Calculate CI for both groups using qnorm()
# Schritt 4: Konfidenzintervalle für beide Gruppen berechnen
# Apply qnorm to both discount groups (Yes/No)
# Berechnung für beide Gruppen auf Basis der Gruppenmittelwerte
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

# ─────────────────────────────────────────────────────────────
# STEP 5: Create formatted summary table
# Schritt 5: Formatierte Tabelle für Bericht erzeugen
# Show results in clean report format (e.g. Quarto)
# Darstellung der Ergebnisse in lesbarer Tabellenform
# ─────────────────────────────────────────────────────────────
gt(ci_discount) |> 
  tab_header(title = "95% Confidence Intervals for Line Revenue")

# ─────────────────────────────────────────────────────────────
# STEP 6: Final confirmation
# Schritt 6: Abschlussmeldung
# Confirm that calculations are complete
# Ausgabe zur erfolgreichen Berechnung
# ─────────────────────────────────────────────────────────────
cat("✔️ 95% confidence intervals calculated using qnorm(). / Konfidenzintervalle berechnet.\n")