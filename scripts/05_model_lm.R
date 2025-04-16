# ─────────────────────────────────────────────────────────────
# Project: Fashion Retail Analysis (NDK HF Transferarbeit)
# File:    05_model_lm.R
# Author:  Yvonne Kirschler
# Purpose: Run and interpret a linear regression model
#          Regressionsmodell berechnen und interpretieren
# ─────────────────────────────────────────────────────────────

# ─────────────────────────────────────────────────────────────
# STEP 1: Load required packages
# Schritt 1: Notwendige R-Pakete laden
# Load libraries for modeling and report formatting
# Pakete zum Erstellen und Formatieren von Regressionsmodellen laden
# ─────────────────────────────────────────────────────────────
library(tidyverse)   # Data transformation and base modeling
library(broom)       # Convert lm() output into tidy format
library(gt)          # Create clean, formatted regression tables

# ─────────────────────────────────────────────────────────────
# STEP 2: Prepare data for modeling
# Schritt 2: Daten für das Modell vorbereiten
# Join product information, filter out invalid values, set factor types
# Produktdaten verknüpfen, ungültige Zeilen entfernen, Datentypen anpassen
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
# STEP 3: Define and estimate the regression model
# Schritt 3: Regressionsmodell definieren und berechnen
# Model structure reflects expected revenue influencers
# Modellstruktur spiegelt Einflussgrössen auf Umsatz wider
# ─────────────────────────────────────────────────────────────
model_formula <- line_total ~ discount_applied + category + payment_method
model_lm <- lm(model_formula, data = model_data)

# ─────────────────────────────────────────────────────────────
# STEP 4: Print model summary and key metrics
# Schritt 4: Modellzusammenfassung und Qualitätskennzahlen anzeigen
# Show coefficients and model fit (R², adj. R², F-statistic, etc.)
# Regressionskoeffizienten und Modellgüte anzeigen
# ─────────────────────────────────────────────────────────────
print(summary(model_lm))        # full summary
print(glance(model_lm))         # model performance

# ─────────────────────────────────────────────────────────────
# STEP 5: Format model output as regression table
# Schritt 5: Ausgabe als formatierte Tabelle für Bericht
# Create tidy table sorted by effect size
# Formatierte Übersicht der geschätzten Effekte
# ─────────────────────────────────────────────────────────────
tidy_model <- tidy(model_lm) |> 
  arrange(desc(abs(estimate)))

reg_table <- gt(tidy_model) |> 
  tab_header(title = "Regression Results: Line Revenue Model")
print(reg_table)

# ─────────────────────────────────────────────────────────────
# STEP 6: Final confirmation
# Schritt 6: Abschlussmeldung
# Confirm successful model creation
# Abschluss der Regressionsanalyse bestätigen
# ─────────────────────────────────────────────────────────────
cat("✔️ Linear regression model estimated and summarised. / Regressionsmodell erfolgreich berechnet.\n")