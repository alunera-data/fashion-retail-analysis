# ─────────────────────────────────────────────────────────────
# Project: Fashion Retail Analysis (NDK HF Transferarbeit)
# File:    02_clean_transform.R
# Author:  Yvonne Kirschler
# Purpose: Clean and transform raw datasets for analysis
#          Bereinigung und Transformation der Rohdaten für die Analyse
# ─────────────────────────────────────────────────────────────

# ─────────────────────────────────────────────────────────────
# STEP 1: Load required packages
# Schritt 1: Notwendige R-Pakete laden
# Load libraries needed for cleaning, transformation and date handling
# Benötigte Pakete für Bereinigung, Umwandlung und Datumsverarbeitung laden
# ─────────────────────────────────────────────────────────────
library(tidyverse)   # Data wrangling and manipulation
library(janitor)     # Clean column names
library(lubridate)   # Convert and work with dates

# ─────────────────────────────────────────────────────────────
# STEP 2: Clean 'transactions' dataset
# Schritt 2: Transaktionsdaten bereinigen
# Convert all IDs and categorical variables to factors, parse date column
# Alle IDs und kategorialen Spalten in Faktoren umwandeln, Datum formatieren
# ─────────────────────────────────────────────────────────────
transactions <- transactions |> 
  mutate(
    transaction_type = as_factor(transaction_type),
    payment_method   = as_factor(payment_method),
    store_id         = as_factor(store_id),
    product_id       = as.factor(product_id),
    customer_id      = as.factor(customer_id),
    employee_id      = as.factor(employee_id),
    date             = as_date(date)
  )

# ─────────────────────────────────────────────────────────────
# STEP 3: Clean 'stores' dataset
# Schritt 3: Store-Daten bereinigen
# Factorize store-related fields and convert employee count to integer
# Spalten als Faktor setzen, Mitarbeiterzahl in Ganzzahl umwandeln
# ─────────────────────────────────────────────────────────────
stores <- stores |> 
  mutate(
    country             = as_factor(country),
    city                = as_factor(city),
    store_id            = as_factor(store_id),
    number_of_employees = as.integer(number_of_employees)
  )

# ─────────────────────────────────────────────────────────────
# STEP 4: Clean 'customers' dataset
# Schritt 4: Kundendaten bereinigen
# Set customer ID and demographics as factors, convert date of birth
# Kunden-ID und Demografie als Faktoren setzen, Geburtsdatum umwandeln
# ─────────────────────────────────────────────────────────────
customers <- customers |> 
  mutate(
    customer_id   = as_factor(customer_id),
    gender        = as_factor(gender),
    country       = as_factor(country),
    city          = as_factor(city),
    date_of_birth = as_date(date_of_birth)
  )

# ─────────────────────────────────────────────────────────────
# STEP 5: Clean 'products' dataset
# Schritt 5: Produktdaten bereinigen
# Factorize product ID, category and sub-category
# Produkt-ID, Kategorie und Subkategorie als Faktoren setzen
# ─────────────────────────────────────────────────────────────
products <- products |> 
  mutate(
    product_id   = as.factor(product_id),
    category     = as_factor(category),
    sub_category = as_factor(sub_category)
  )

# ─────────────────────────────────────────────────────────────
# STEP 6: Clean 'discounts' dataset
# Schritt 6: Rabattdaten bereinigen
# Convert discount categories to factors, format start and end dates
# Rabatt-Kategorien als Faktoren setzen, Start- und Enddatum formatieren
# ─────────────────────────────────────────────────────────────
discounts <- discounts |> 
  mutate(
    category     = as_factor(category),
    sub_category = as_factor(sub_category),
    start        = as_date(start),
    end          = as_date(end)
  )

# ─────────────────────────────────────────────────────────────
# STEP 7: Clean 'employees' dataset
# Schritt 7: Mitarbeiterdaten bereinigen
# Convert employee ID and store ID to factors
# Mitarbeiter- und Store-IDs als Faktoren setzen
# ─────────────────────────────────────────────────────────────
employees <- employees |> 
  mutate(
    employee_id = as_factor(employee_id),
    store_id    = as_factor(store_id)
  )

# ─────────────────────────────────────────────────────────────
# STEP 8: Check for missing values
# Schritt 8: Fehlende Werte prüfen
# Summarize the total number of NAs per selected dataset
# Fehlende Werte pro Datensatz berechnen (für Transparenz)
# ─────────────────────────────────────────────────────────────
na_summary <- sapply(list(
  transactions = transactions,
  products     = products,
  discounts    = discounts
), \(df) sum(is.na(df)))

print(na_summary)

# ─────────────────────────────────────────────────────────────
# STEP 9: Confirm completion
# Schritt 9: Bestätigung der Verarbeitung
# Final confirmation that datasets are ready for analysis
# Abschlieende Bestätigung der erfolgreichen Transformation
# ─────────────────────────────────────────────────────────────
cat("✔️ Datasets cleaned and transformed. / Datensätze bereinigt und transformiert.\n")