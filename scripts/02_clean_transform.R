# ─────────────────────────────────────────────────────────────
# Project: Fashion Retail Analysis (NDK HF Transferarbeit)
# File:    02_clean_transform.R
# Author:  Yvonne Kirschler
# Purpose: Clean and transform raw datasets for analysis
#          Bereinigung und Transformation der Rohdaten für die Analyse
# ─────────────────────────────────────────────────────────────

# STEP 1: Load required packages
# Load libraries needed for data cleaning and transformation
# Benötigte Pakete für Datenbereinigung und Umwandlung laden
# ─────────────────────────────────────────────────────────────
library(tidyverse)   # Data wrangling and manipulation | Datenmanipulation
library(janitor)     # Clean column names              | Spaltennamen bereinigen
library(lubridate)   # Handle and format dates         | Datum konvertieren

# STEP 2: Clean 'transactions' dataset
# Convert IDs and categorical variables to factors, format dates
# IDs und kategorische Variablen in Faktoren umwandeln, Datum formatieren
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

# STEP 3: Clean 'stores' dataset
# Factorize country/city/store ID, convert employee count to integer
# Land, Stadt und Store-ID als Faktoren, Mitarbeiterzahl als Ganzzahl
# ─────────────────────────────────────────────────────────────
stores <- stores |> 
  mutate(
    country             = as_factor(country),
    city                = as_factor(city),
    store_id            = as_factor(store_id),
    number_of_employees = as.integer(number_of_employees)
  )

# STEP 4: Clean 'customers' dataset
# Factorize customer ID and demographics, convert date of birth
# Kunden-ID und Demografie als Faktoren, Geburtsdatum formatieren
# ─────────────────────────────────────────────────────────────
customers <- customers |> 
  mutate(
    customer_id   = as_factor(customer_id),
    gender        = as_factor(gender),
    country       = as_factor(country),
    city          = as_factor(city),
    date_of_birth = as_date(date_of_birth)
  )

# STEP 5: Clean 'products' dataset
# Convert product ID, category, sub-category to factors
# Produkt-ID, Kategorie und Subkategorie in Faktoren umwandeln
# ─────────────────────────────────────────────────────────────
products <- products |> 
  mutate(
    product_id   = as.factor(product_id),
    category     = as_factor(category),
    sub_category = as_factor(sub_category)
  )

# STEP 6: Clean 'discounts' dataset
# Factorize discount category/sub-category, format start/end dates
# Rabattkategorie als Faktor, Start-/Enddatum als Datum formatieren
# ─────────────────────────────────────────────────────────────
discounts <- discounts |> 
  mutate(
    category     = as_factor(category),
    sub_category = as_factor(sub_category),
    start        = as_date(start),
    end          = as_date(end)
  )

# STEP 7: Clean 'employees' dataset
# Convert employee ID and store ID to factors
# Mitarbeiter-ID und Store-ID in Faktoren umwandeln
# ─────────────────────────────────────────────────────────────
employees <- employees |> 
  mutate(
    employee_id = as_factor(employee_id),
    store_id    = as_factor(store_id)
  )

# STEP 8: Check for missing values
# Check number of NAs in key datasets for transparency
# Fehlende Werte (NAs) je Datensatz prüfen (Transparenz)
# ─────────────────────────────────────────────────────────────
na_summary <- sapply(list(
  transactions = transactions,
  products     = products,
  discounts    = discounts
), \(df) sum(is.na(df)))

print(na_summary)

# STEP 9: Confirm completion
# Final confirmation message
# Abschliessende Bestätigung der erfolgreichen Transformation
# ─────────────────────────────────────────────────────────────
cat("✔️ Datasets cleaned and transformed. / Datensätze bereinigt und transformiert.\n")

