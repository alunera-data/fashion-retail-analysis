# ─────────────────────────────────────────────────────────────
# Project: Fashion Retail Analysis (NDK HF Transferarbeit)
# File:    03_explore_data.R
# Author:  Yvonne Kirschler
# Purpose: First exploratory visualizations and summaries
# ─────────────────────────────────────────────────────────────

# Load required packages
library(tidyverse)
library(janitor)
library(lubridate)
library(scales)
library(gt)

# ─────────────────────────────────────────────────────────────
# Top 10 stores by total revenue (simple, using store_id only)
# ─────────────────────────────────────────────────────────────

# Step 1: Calculate revenue per store
revenue_by_store <- transactions |>
  group_by(store_id) |>
  summarise(
    total_revenue = sum(line_total, na.rm = TRUE)
  ) |>
  arrange(desc(total_revenue)) |>
  slice_head(n = 10)

# Step 2: Create clean label using store_id
revenue_by_store <- revenue_by_store |>
  mutate(store_label = paste("Store", store_id))

# Step 3: Plot revenue by store
plot_top_stores <- ggplot(revenue_by_store, aes(x = fct_reorder(store_label, total_revenue), y = total_revenue)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  scale_y_continuous(labels = label_comma()) +
  labs(
    title = "Top 10 Stores by Total Revenue",
    x = "Store ID",
    y = "Total Revenue"
  )

plot_top_stores

# ─────────────────────────────────────────────────────────────
# Monthly revenue over time (trend)
# ─────────────────────────────────────────────────────────────

# Group transactions by month and summarize revenue
transactions_by_month <- transactions |>
  mutate(month = floor_date(date, unit = "month")) |>
  group_by(month) |>
  summarise(total_revenue = sum(line_total, na.rm = TRUE))

# Line plot over time
plot_revenue_over_time <- ggplot(transactions_by_month, aes(x = month, y = total_revenue)) +
  geom_line(color = "darkgreen", linewidth = 1) +
  scale_y_continuous(labels = label_comma()) +
  labs(
    title = "Monthly Revenue Over Time",
    x = "Month",
    y = "Revenue"
  )

plot_revenue_over_time

# ─────────────────────────────────────────────────────────────
# Average line revenue per product category
# ─────────────────────────────────────────────────────────────

# Join products to transactions and group by category
revenue_by_category <- transactions |>
  left_join(products, by = "product_id") |>
  group_by(category) |>
  summarise(avg_revenue = mean(line_total, na.rm = TRUE)) |>
  arrange(desc(avg_revenue))

# Barplot of average revenue per category
plot_avg_revenue_by_category <- ggplot(revenue_by_category, aes(x = fct_reorder(category, avg_revenue), y = avg_revenue)) +
  geom_col(fill = "coral") +
  coord_flip() +
  scale_y_continuous(labels = label_comma()) +
  labs(
    title = "Average Line Revenue by Product Category",
    x = "Product Category",
    y = "Average Line Revenue"
  )

plot_avg_revenue_by_category

# ─────────────────────────────────────────────────────────────
# Revenue distribution by discount (boxplot, log scale)
# ─────────────────────────────────────────────────────────────

# Create binary flag for discount applied
transactions <- transactions |>
  mutate(discount_applied = if_else(discount > 0, "Yes", "No"))

# Filter line_total > 0 for log transformation
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

plot_discount_box

# ─────────────────────────────────────────────────────────────
# Summary table: Discount yes/no (using gt)
# ─────────────────────────────────────────────────────────────

summary_discount <- transactions |>
  group_by(discount_applied) |>
  summarise(
    n = n(),
    avg_revenue = mean(line_total, na.rm = TRUE),
    median_revenue = median(line_total, na.rm = TRUE)
  ) |>
  arrange(desc(avg_revenue))

gt(summary_discount)

# ─────────────────────────────────────────────────────────────
# Confirmation
# ─────────────────────────────────────────────────────────────

cat("✔️ Visual exploration completed.\n")