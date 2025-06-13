# ─────────────────────────────────────────────────────────────
# Project: Fashion Retail Analysis (NDK HF Transferarbeit)
# File:    03_explore_data.R
# Author:  Yvonne Kirschler
# Purpose: First exploratory visualizations and summaries
#          Erste explorative Visualisierungen und Auswertungen
# ─────────────────────────────────────────────────────────────

# STEP 1: Load required packages
# Load libraries for wrangling, plotting and table output
# Pakete für Datenaufbereitung, Visualisierung und Tabellen laden
# ─────────────────────────────────────────────────────────────
library(tidyverse)   # Data manipulation and ggplot2 visualization
library(janitor)     # Clean column names
library(lubridate)   # Date/time parsing
library(scales)      # Formatting for axis labels
library(gt)          # Reporting tables

# STEP 2: Top 10 stores by total revenue
# Identify the best-performing stores by revenue
# Die 10 umsatzstärksten Filialen anzeigen
# ─────────────────────────────────────────────────────────────
revenue_by_store <- transactions |> 
  group_by(store_id) |> 
  summarise(total_revenue = sum(line_total, na.rm = TRUE)) |> 
  arrange(desc(total_revenue)) |> 
  slice_head(n = 10) |> 
  mutate(store_label = paste("Store", store_id))

plot_top_stores <- ggplot(revenue_by_store, aes(x = fct_reorder(store_label, total_revenue), y = total_revenue)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  scale_y_continuous(labels = label_comma()) +
  labs(
    title = "Top 10 Stores by Total Revenue",
    x = "Store ID",
    y = "Total Revenue"
  )

print(plot_top_stores)

# STEP 3: Monthly revenue trend
# Show seasonal trends in monthly sales
# Monatlicher Umsatzverlauf – z. B. für Saisonalität
# ─────────────────────────────────────────────────────────────
transactions_by_month <- transactions |> 
  mutate(month = floor_date(date, unit = "month")) |> 
  group_by(month) |> 
  summarise(total_revenue = sum(line_total, na.rm = TRUE))

plot_revenue_over_time <- ggplot(transactions_by_month, aes(x = month, y = total_revenue)) +
  geom_line(color = "darkgreen", linewidth = 1) +
  scale_y_continuous(labels = label_comma()) +
  labs(
    title = "Monthly Revenue Over Time",
    x = "Month",
    y = "Revenue"
  )

print(plot_revenue_over_time)

# STEP 4: Average revenue per product category
# Compare categories by average transaction value
# Ø Umsatz nach Produktkategorie
# ─────────────────────────────────────────────────────────────
revenue_by_category <- transactions |> 
  left_join(products, by = "product_id") |> 
  group_by(category) |> 
  summarise(avg_revenue = mean(line_total, na.rm = TRUE)) |> 
  arrange(desc(avg_revenue))

plot_avg_revenue_by_category <- ggplot(revenue_by_category, aes(x = fct_reorder(category, avg_revenue), y = avg_revenue)) +
  geom_col(fill = "coral") +
  coord_flip() +
  scale_y_continuous(labels = label_comma()) +
  labs(
    title = "Average Line Revenue by Product Category",
    x = "Product Category",
    y = "Average Line Revenue"
  )

print(plot_avg_revenue_by_category)

# STEP 5: Revenue distribution with vs. without discount
# Boxplot shows spread between discounted and non-discounted sales
# Umsatzverteilung mit/ohne Rabatt (Boxplot)
# ─────────────────────────────────────────────────────────────
transactions <- transactions |> 
  mutate(discount_applied = if_else(discount > 0, "Yes", "No"))

plot_discount_box <- transactions |> 
  filter(line_total > 0) |> 
  ggplot(aes(x = discount_applied, y = line_total)) +
  geom_boxplot(fill = "plum") +
  scale_y_log10(labels = label_comma()) +
  labs(
    title = "Revenue Distribution by Discount Applied",
    x = "Discount Applied",
    y = "Line Total (log10)"
  )

print(plot_discount_box)

# STEP 6: NEW – Revenue by number of employees (scatterplot)
# Analyze relationship between store size and performance
# Zusammenhang zwischen Store-Grösse und Umsatz (Streudiagramm)
# ─────────────────────────────────────────────────────────────
revenue_by_store_size <- transactions |> 
  group_by(store_id) |> 
  summarise(total_revenue = sum(line_total, na.rm = TRUE)) |> 
  left_join(stores, by = "store_id") |>
  mutate(number_of_employees = as.numeric(number_of_employees))  # Ensure numeric axis

plot_revenue_vs_employees <- ggplot(revenue_by_store_size, aes(x = number_of_employees, y = total_revenue)) +
  geom_point(color = "#6BCABA", size = 2, alpha = 0.8) +
  scale_x_continuous(breaks = pretty_breaks()) +
  scale_y_continuous(labels = label_comma()) +
  labs(
    title = "Revenue by Store Size",
    x = "Number of Employees",
    y = "Total Revenue"
  )

print(plot_revenue_vs_employees)

# STEP 7: Summary table – revenue by discount status
# Display n, mean, median by discount group
# Tabelle zu Rabattgruppen mit n, Mittelwert, Median
# ─────────────────────────────────────────────────────────────
summary_discount <- transactions |> 
  group_by(discount_applied) |> 
  summarise(
    n = n(),
    avg_revenue = mean(line_total, na.rm = TRUE),
    median_revenue = median(line_total, na.rm = TRUE)
  ) |> 
  arrange(desc(avg_revenue))

print(gt(summary_discount))

# STEP 8: Done
# Final confirmation message
# Abschlussmeldung zur visuellen Exploration
# ─────────────────────────────────────────────────────────────
cat("✔️ Visual exploration completed. / Visuelle Analyse abgeschlossen.\n")
