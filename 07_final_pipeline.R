# ─────────────────────────────────────────────────────────────
# Project: Fashion Retail Analysis (NDK HF Transferarbeit)
# File:    07_final_pipeline.R
# Author:  Yvonne Kirschler
# Purpose: Reproducible execution of all analysis steps
#          Vollständige Ausführung aller Analyseschritte
# ─────────────────────────────────────────────────────────────

# Research Question:
# Welche Faktoren beeinflussen den Umsatz pro Verkaufstransaktion im Modehandel?
# What factors influence the revenue per transaction in fashion retail?

# ─────────────────────────────────────────────────────────────
# STEP 1: Load packages
# ─────────────────────────────────────────────────────────────
library(tidyverse)
library(janitor)
library(lubridate)
library(broom)
library(gt)
library(scales)
library(glue)

# ─────────────────────────────────────────────────────────────
# STEP 2: Load and clean data
# ─────────────────────────────────────────────────────────────
stores       <- read_csv("data/stores.csv", show_col_types = FALSE) |> clean_names()
products     <- read_csv("data/products.csv", show_col_types = FALSE) |> clean_names()
transactions <- read_csv("data/transactions.csv", show_col_types = FALSE) |> clean_names()
customers    <- read_csv("data/customers.csv", show_col_types = FALSE) |> clean_names()
employees    <- read_csv("data/employees.csv", show_col_types = FALSE) |> clean_names()
discounts    <- read_csv("data/discounts.csv", show_col_types = FALSE) |> clean_names()

transactions <- transactions |> mutate(
  transaction_type = as_factor(transaction_type),
  payment_method   = as_factor(payment_method),
  store_id         = as_factor(store_id),
  product_id       = as_factor(product_id),
  customer_id      = as_factor(customer_id),
  employee_id      = as_factor(employee_id),
  date             = as_date(date),
  discount_applied = if_else(discount > 0, "Yes", "No")
)

products <- products |> mutate(
  product_id   = as_factor(product_id),
  category     = as_factor(category),
  sub_category = as_factor(sub_category)
)

cat("✔️ Data loaded and cleaned. / Daten geladen und bereinigt.\n")

# ─────────────────────────────────────────────────────────────
# STEP 3: Explorative Visualisierungen (5 Plots)
# ─────────────────────────────────────────────────────────────

# Plot 1: Top 10 Stores by revenue
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
  labs(title = "Top 10 Stores by Total Revenue", x = "Store ID", y = "Total Revenue")
print(plot_top_stores)

# Plot 2: Revenue trend over time
transactions_by_month <- transactions |> 
  mutate(month = floor_date(date, unit = "month")) |> 
  group_by(month) |> 
  summarise(total_revenue = sum(line_total, na.rm = TRUE))

plot_revenue_over_time <- ggplot(transactions_by_month, aes(x = month, y = total_revenue)) +
  geom_line(color = "darkgreen", linewidth = 1) +
  scale_y_continuous(labels = label_comma()) +
  labs(title = "Monthly Revenue Over Time", x = "Month", y = "Revenue")
print(plot_revenue_over_time)

# Plot 3: Revenue by product category
revenue_by_category <- transactions |> 
  left_join(products, by = "product_id") |> 
  group_by(category) |> 
  summarise(avg_revenue = mean(line_total, na.rm = TRUE)) |> 
  arrange(desc(avg_revenue))

plot_avg_revenue_by_category <- ggplot(revenue_by_category, aes(x = fct_reorder(category, avg_revenue), y = avg_revenue)) +
  geom_col(fill = "coral") +
  coord_flip() +
  scale_y_continuous(labels = label_comma()) +
  labs(title = "Average Revenue by Product Category", x = "Category", y = "Average Revenue")
print(plot_avg_revenue_by_category)

# Plot 4: Revenue distribution by discount
plot_discount_box <- transactions |> 
  filter(line_total > 0) |> 
  ggplot(aes(x = discount_applied, y = line_total)) +
  geom_boxplot(fill = "plum") +
  scale_y_log10(labels = label_comma()) +
  labs(title = "Revenue Distribution by Discount Applied", x = "Discount Applied", y = "Line Total (log10)")
print(plot_discount_box)

# Plot 5: Revenue vs. Store Size (corrected axis types)
revenue_by_store_size <- transactions |> 
  group_by(store_id) |> 
  summarise(total_revenue = sum(line_total, na.rm = TRUE)) |> 
  mutate(store_id = as.numeric(as.character(store_id))) |>  # Convert factor to numeric
  left_join(stores |> mutate(store_id = as.numeric(store_id)), by = "store_id")

plot_store_size <- ggplot(revenue_by_store_size, aes(x = number_of_employees, y = total_revenue)) +
  geom_point(alpha = 0.6, color = "#6BCABA", size = 2) +
  scale_y_continuous(labels = label_comma()) +
  labs(title = "Revenue by Store Size", x = "Number of Employees", y = "Total Revenue")
print(plot_store_size)

cat("✔️ Visualisations created. / Diagramme erfolgreich erstellt.\n")

# ─────────────────────────────────────────────────────────────
# STEP 4: Confidence Intervals with qnorm()
# ─────────────────────────────────────────────────────────────
ci_example <- qnorm(c(0.025, 0.975), mean = 2, sd = 1.2)
print(ci_example)

discount_yes <- transactions |> 
  filter(discount_applied == "Yes") |> 
  summarise(n = n(), mean = mean(line_total, na.rm = TRUE), sd = sd(line_total, na.rm = TRUE))

ci_discount_yes <- qnorm(c(0.025, 0.975), mean = discount_yes$mean, sd = discount_yes$sd / sqrt(discount_yes$n))
print(ci_discount_yes)

ci_discount <- transactions |> 
  group_by(discount_applied) |> 
  summarise(
    n = n(),
    mean = mean(line_total, na.rm = TRUE),
    sd = sd(line_total, na.rm = TRUE),
    lower_ci = qnorm(0.025, mean, sd / sqrt(n)),
    upper_ci = qnorm(0.975, mean, sd / sqrt(n))
  )
print(ci_discount)
cat("✔️ Confidence intervals calculated. / Konfidenzintervalle berechnet.\n")

# ─────────────────────────────────────────────────────────────
# STEP 5: Linear Regression
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

model_formula <- line_total ~ discount_applied + category + payment_method
model_lm <- lm(model_formula, data = model_data)

print(summary(model_lm))
model_metrics <- glance(model_lm)
print(model_metrics)
tidy_model <- tidy(model_lm) |> arrange(desc(abs(estimate)))
print(tidy_model)
cat("✔️ Linear regression completed. / Lineare Regression abgeschlossen.\n")

# ─────────────────────────────────────────────────────────────
# STEP 6: Summary Tables
# ─────────────────────────────────────────────────────────────
ci_discount <- ci_discount |> rename(std_dev = sd)

ci_table <- gt(ci_discount) |> 
  tab_header(title = md("**95% Confidence Intervals**"), subtitle = "Grouped by Discount Status") |> 
  fmt_number(columns = 2:6, decimals = 2) |> 
  tab_source_note("Source: Fashion Retail Transaction Data (n ≈ 6.4 million)")
print(ci_table)

reg_table <- gt(tidy_model) |> 
  tab_header(title = md("**Regression Results: Line Revenue Model**")) |> 
  fmt_number(columns = c(estimate, std.error, statistic, p.value), decimals = 4) |> 
  tab_source_note("Model fitted using linear regression (lm)")
print(reg_table)

payment_summary <- transactions |> 
  filter(line_total > 0) |> 
  group_by(payment_method) |> 
  summarise(avg_revenue = mean(line_total, na.rm = TRUE), n = n()) |> 
  arrange(desc(avg_revenue)) |> 
  gt() |> 
  tab_header(title = md("**Average Line Revenue by Payment Method**")) |> 
  fmt_number(columns = c(avg_revenue), decimals = 2) |> 
  tab_source_note("Based on all valid transactions")
print(payment_summary)

# DONE
cat("✔️ Final pipeline executed successfully. / Pipeline erfolgreich ausgeführt.\n")