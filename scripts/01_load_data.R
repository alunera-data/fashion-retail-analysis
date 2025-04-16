# ─────────────────────────────────────────────────────────────
# Project: Fashion Retail Analysis (NDK HF Transferarbeit)
# File:    01_load_data.R
# Author:  Yvonne Kirschler
# Purpose: Load and preview all relevant CSV datasets
#          Einlesen und erste Vorschau aller relevanten CSV-Daten
# ─────────────────────────────────────────────────────────────

# ─────────────────────────────────────────────────────────────
# STEP 1: Load required packages
# Schritt 1: Notwendige R-Pakete laden
# Load libraries for importing, cleaning and inspecting data
# Pakete für den Datenimport, die Bereinigung und die Strukturvorschau laden
# ─────────────────────────────────────────────────────────────
library(tidyverse)   # Data import and wrangling
library(janitor)     # Clean column names
library(skimr)       # Summary statistics

# ─────────────────────────────────────────────────────────────
# STEP 2: Define file paths
# Schritt 2: Dateipfade definieren
# Define the expected CSV files in the local /data folder
# CSV-Dateien, die im lokalen /data-Ordner liegen, benennen
# ─────────────────────────────────────────────────────────────
files <- list(
  stores        = "data/stores.csv",
  products      = "data/products.csv",
  transactions  = "data/transactions.csv",
  customers     = "data/customers.csv",
  employees     = "data/employees.csv",
  discounts     = "data/discounts.csv"
)

# ─────────────────────────────────────────────────────────────
# STEP 3: Read CSVs and clean column names
# Schritt 3: CSVs einlesen und Spaltennamen bereinigen
# Read all files into memory and standardize column names
# Alle Dateien einlesen und Spaltennamen im Tidy-Format bereinigen
# ─────────────────────────────────────────────────────────────
stores       <- read_csv(files$stores) |> clean_names()
products     <- read_csv(files$products) |> clean_names()
transactions <- read_csv(files$transactions) |> clean_names()
customers    <- read_csv(files$customers) |> clean_names()
employees    <- read_csv(files$employees) |> clean_names()
discounts    <- read_csv(files$discounts) |> clean_names()

# ─────────────────────────────────────────────────────────────
# STEP 4: Print structure of selected datasets
# Schritt 4: Struktur ausgewählter Tabellen anzeigen
# Use glimpse() to get a quick overview of selected key tables
# Die Struktur wichtiger Tabellen zur Sichtprüfung ausgeben
# ─────────────────────────────────────────────────────────────
glimpse(stores)        # Store metadata
glimpse(transactions)  # Core transaction records
glimpse(discounts)     # Promotional campaigns

# ─────────────────────────────────────────────────────────────
# STEP 5: Summarize transaction data
# Schritt 5: Transaktionsdaten zusammenfassen
# Use skimr to summarize variable types, distributions and NAs
# Mit skimr Variablentypen, Verteilungen und fehlende Werte prüfen
# ─────────────────────────────────────────────────────────────
skim(transactions)

# ─────────────────────────────────────────────────────────────
# STEP 6: Confirm loading results
# Schritt 6: Datenlade-Ergebnisse bestätigen
# Show the number of rows per table as a loading confirmation
# Zeilenzahl jeder Tabelle zur Bestätigung ausgeben
# ─────────────────────────────────────────────────────────────
cat("✔️ Data successfully loaded:\n")
cat("- Stores:       ", nrow(stores), "rows\n")
cat("- Products:     ", nrow(products), "rows\n")
cat("- Transactions: ", nrow(transactions), "rows\n")
cat("- Customers:    ", nrow(customers), "rows\n")
cat("- Employees:    ", nrow(employees), "rows\n")
cat("- Discounts:    ", nrow(discounts), "rows\n")