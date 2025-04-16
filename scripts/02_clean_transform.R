# ─────────────────────────────────────────────────────────────
# Project: Fashion Retail Analysis (NDK HF Transferarbeit)
# File:    02_clean_transform.R
# Author:  Yvonne Kirschler
# Purpose: Clean and transform raw datasets for analysis
# ─────────────────────────────────────────────────────────────

# Load required packages
library(tidyverse)
library(janitor)
library(lubridate)

# ─────────────────────────────────────────────────────────────
# Clean 'transactions' dataset
# Convert IDs and categoricals to factors, ensure proper date format
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
# Clean 'stores' dataset
# ─────────────────────────────────────────────────────────────
stores <- stores |> 
  mutate(
    country             = as_factor(country),
    city                = as_factor(city),
    store_id            = as_factor(store_id),
    number_of_employees = as.integer(number_of_employees)
  )

# ─────────────────────────────────────────────────────────────
# Clean 'customers' dataset
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
# Clean 'products' dataset
# ─────────────────────────────────────────────────────────────
products <- products |> 
  mutate(
    product_id   = as.factor(product_id),
    category     = as_factor(category),
    sub_category = as_factor(sub_category)
  )

# ─────────────────────────────────────────────────────────────
# Clean 'discounts' dataset
# ─────────────────────────────────────────────────────────────
discounts <- discounts |> 
  mutate(
    category     = as_factor(category),
    sub_category = as_factor(sub_category),
    start        = as_date(start),
    end          = as_date(end)
  )

# ─────────────────────────────────────────────────────────────
# Clean 'employees' dataset
# ─────────────────────────────────────────────────────────────
employees <- employees |> 
  mutate(
    employee_id = as_factor(employee_id),
    store_id    = as_factor(store_id)
  )

# ─────────────────────────────────────────────────────────────
# Quick NA check for main datasets (for transparency)
# ─────────────────────────────────────────────────────────────
na_summary <- sapply(list(
  transactions = transactions,
  products     = products,
  discounts    = discounts
), \(df) sum(is.na(df)))

print(na_summary)

# ─────────────────────────────────────────────────────────────
# Final confirmation
# ─────────────────────────────────────────────────────────────
cat("✔️ Datasets cleaned and transformed.\n")

