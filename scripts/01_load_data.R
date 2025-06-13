# ─────────────────────────────────────────────────────────────
# Project: Fashion Retail Analysis (NDK HF Transferarbeit)
# File:    01_load_data.R
# Author:  Yvonne Kirschler
# Purpose: Load and preview all relevant CSV datasets
#          Einlesen und Vorschau aller relevanten CSV-Daten
# ─────────────────────────────────────────────────────────────

# ─────────────────────────────────────────────────────────────
# STEP 1: Load required packages
# Load libraries for importing, cleaning and inspecting data
# Pakete für Import, Bereinigung und Vorschau laden
# ─────────────────────────────────────────────────────────────
library(tidyverse)   # Data import and wrangling | Datenmanipulation
library(janitor)     # Clean column names        | Spaltennamen bereinigen
library(skimr)       # Summary statistics        | Übersicht und NA-Analyse

# ─────────────────────────────────────────────────────────────
# STEP 2: Define file paths
# Define expected CSV file locations in /data folder
# CSV-Dateien im lokalen /data-Verzeichnis benennen
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
# Read files into memory, suppress column specs, clean names
# Dateien einlesen, Spaltentypen-Nachricht unterdrücken, Namen bereinigen
# ─────────────────────────────────────────────────────────────
stores       <- read_csv(files$stores,        show_col_types = FALSE) |> clean_names()
products     <- read_csv(files$products,      show_col_types = FALSE) |> clean_names()
transactions <- read_csv(files$transactions,  show_col_types = FALSE) |> clean_names()
customers    <- read_csv(files$customers,     show_col_types = FALSE) |> clean_names()
employees    <- read_csv(files$employees,     show_col_types = FALSE) |> clean_names()
discounts    <- read_csv(files$discounts,     show_col_types = FALSE) |> clean_names()

# ─────────────────────────────────────────────────────────────
# STEP 4: Print structure of selected datasets
# Use glimpse() to check structure of selected tables
# Struktur wichtiger Tabellen mit glimpse() prüfen
# ─────────────────────────────────────────────────────────────
glimpse(stores)        # Store metadata
glimpse(transactions)  # Core transaction data
glimpse(discounts)     # Discount campaigns

# ─────────────────────────────────────────────────────────────
# STEP 5: Summarize transaction data
# Check types, missing values, and distributions
# Variablentypen, Verteilungen und NAs prüfen
# ─────────────────────────────────────────────────────────────
skim(transactions)

# ─────────────────────────────────────────────────────────────
# STEP 6: Confirm successful loading
# Output row count per table for confirmation
# Zeilenanzahl je Tabelle zur Bestätigung anzeigen
# ─────────────────────────────────────────────────────────────
cat("✔️ Data successfully loaded:\n")
cat("- Stores:       ", nrow(stores), "rows\n")
cat("- Products:     ", nrow(products), "rows\n")
cat("- Transactions: ", nrow(transactions), "rows\n")
cat("- Customers:    ", nrow(customers), "rows\n")
cat("- Employees:    ", nrow(employees), "rows\n")
cat("- Discounts:    ", nrow(discounts), "rows\n")

