# ─────────────────────────────────────────────────────────────
# Project: Fashion Retail Analysis (NDK HF Transferarbeit)
# File:    01_load_data.R
# Author:  Yvonne Kirschler
# Purpose: Load and preview all relevant CSV datasets
# ─────────────────────────────────────────────────────────────

# Load required packages
library(tidyverse)
library(janitor)
library(skimr)

# Define file paths (named list for clarity)
files <- list(
  stores = "data/stores.csv",
  products = "data/products.csv",
  transactions = "data/transactions.csv",
  customers = "data/customers.csv",
  employees = "data/employees.csv",
  discounts = "data/discounts.csv"
)

# Read CSV files and clean column names
stores       <- read_csv(files$stores) |> clean_names()
products     <- read_csv(files$products) |> clean_names()
transactions <- read_csv(files$transactions) |> clean_names()
customers    <- read_csv(files$customers) |> clean_names()
employees    <- read_csv(files$employees) |> clean_names()
discounts    <- read_csv(files$discounts) |> clean_names()

# Preview data structure
glimpse(stores)
glimpse(transactions)
glimpse(discounts)

# Summary of main transactional data
skim(transactions)

# Confirmation output
cat("✔️ Data successfully loaded:\n")
cat("- Stores:       ", nrow(stores), "rows\n")
cat("- Products:     ", nrow(products), "rows\n")
cat("- Transactions: ", nrow(transactions), "rows\n")
cat("- Customers:    ", nrow(customers), "rows\n")
cat("- Employees:    ", nrow(employees), "rows\n")
cat("- Discounts:    ", nrow(discounts), "rows\n")

