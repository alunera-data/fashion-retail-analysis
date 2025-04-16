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
# Fokus: Rabatt, Produktkategorie und Zahlungsmethode / Focus: discount, category, payment method

# ─────────────────────────────────────────────────────────────
# STEP 1: Load all required packages
# Schritt 1: Notwendige R-Pakete laden
# Ziel: Bibliotheken einbinden, die für Datenbearbeitung, Visualisierung,
#       Statistik und Tabellenformatierung benötigt werden
# Purpose: Load libraries for wrangling, plotting, modeling, and tables
# ─────────────────────────────────────────────────────────────
library(tidyverse)   # Data manipulation and plotting
library(janitor)     # Clean column names
library(lubridate)   # Date handling
library(broom)       # Tidy regression output
library(gt)          # Formatted tables
library(scales)      # Axis formatting for plots
library(glue)        # String interpolation

# ─────────────────────────────────────────────────────────────
# STEP 2: Load and clean raw data
# Schritt 2: CSV-Dateien einlesen und aufbereiten
# Ziel: Alle Datensätze einlesen, Spalten bereinigen und Datentypen anpassen
# Purpose: Import CSVs and standardize structure and types
# ─────────────────────────────────────────────────────────────
stores       <- read_csv("data/stores.csv") |> clean_names()
products     <- read_csv("data/products.csv") |> clean_names()
transactions <- read_csv("data/transactions.csv") |> clean_names()
customers    <- read_csv("data/customers.csv") |> clean_names()
employees    <- read_csv("data/employees.csv") |> clean_names()
discounts    <- read_csv("data/discounts.csv") |> clean_names()

transactions <- transactions |> 
  mutate(
    transaction_type = as_factor(transaction_type),
    payment_method   = as_factor(payment_method),
    store_id         = as_factor(store_id),
    product_id       = as.factor(product_id),
    customer_id      = as.factor(customer_id),
    employee_id      = as.factor(employee_id),
    date             = as_date(date),
    discount_applied = if_else(discount > 0, "Yes", "No")
  )

products <- products |> 
  mutate(
    product_id   = as_factor(product_id),
    category     = as_factor(category),
    sub_category = as_factor(sub_category)
  )

cat("✔️ Data loaded and cleaned. / Daten geladen und bereinigt.\n")

# ─────────────────────────────────────────────────────────────
# STEP 3: Explorative Analyse / Exploratory Visualisation
# Ziel: Erste visuelle Auswertung zur Erkennung von Mustern und Ausreißern
# Purpose: Visual inspection to explore patterns and trends in the data
# ─────────────────────────────────────────────────────────────

# Plot 1: Top 10 Stores nach Umsatz / Top 10 Stores by Revenue
revenue_by_store <- transactions |> 
  group_by(store_id) |> 
  summarise(total_revenue = sum(line_total, na.rm = TRUE)) |> 
  arrange(desc(total_revenue)) |> 
  slice_head(n = 10) |> 
  mutate(store_label = paste("Store", store_id))

plot_top_stores <- ggplot(revenue_by_store, aes(x = fct_reorder(store_label, total_revenue), y = total_revenue)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "Top 10 Stores by Total Revenue", x = "Store ID", y = "Total Revenue")
print(plot_top_stores)

# Plot 2: Umsatzverlauf im Zeitverlauf / Revenue trend over time
transactions_by_month <- transactions |> 
  mutate(month = floor_date(date, unit = "month")) |> 
  group_by(month) |> 
  summarise(total_revenue = sum(line_total, na.rm = TRUE))

plot_revenue_over_time <- ggplot(transactions_by_month, aes(x = month, y = total_revenue)) +
  geom_line(color = "darkgreen", linewidth = 1) +
  labs(title = "Monthly Revenue Over Time", x = "Month", y = "Revenue")
print(plot_revenue_over_time)

# Plot 3: Durchschnittlicher Umsatz pro Kategorie / Revenue by category
revenue_by_category <- transactions |> 
  left_join(products, by = "product_id") |> 
  group_by(category) |> 
  summarise(avg_revenue = mean(line_total, na.rm = TRUE)) |> 
  arrange(desc(avg_revenue))

plot_avg_revenue_by_category <- ggplot(revenue_by_category, aes(x = fct_reorder(category, avg_revenue), y = avg_revenue)) +
  geom_col(fill = "coral") +
  coord_flip() +
  labs(title = "Average Revenue by Product Category", x = "Category", y = "Average Revenue")
print(plot_avg_revenue_by_category)

# Plot 4: Rabatt vs. kein Rabatt / Discount vs. No Discount
plot_discount_box <- transactions |> 
  filter(line_total > 0) |> 
  ggplot(aes(x = discount_applied, y = line_total)) +
  geom_boxplot(fill = "plum") +
  scale_y_log10() +
  labs(title = "Revenue Distribution by Discount Applied", x = "Discount Applied", y = "Line Total (log scale)")
print(plot_discount_box)

cat("✔️ Visualisations created. / Diagramme erfolgreich erstellt.\n")

# ─────────────────────────────────────────────────────────────
# STEP 4: Calculate confidence intervals with qnorm()
# Schritt 4: Konfidenzintervalle mit qnorm() berechnen
# ─────────────────────────────────────────────────────────────

# Beispielberechnung nach Anweisung / Required example
ci_example <- qnorm(c(0.025, 0.975), mean = 2, sd = 1.2)
print(ci_example)

# CI für Rabattgruppe 'Yes' / Confidence interval for 'Yes' group
discount_yes <- transactions |> 
  filter(discount_applied == "Yes") |> 
  summarise(
    n    = n(),
    mean = mean(line_total, na.rm = TRUE),
    sd   = sd(line_total, na.rm = TRUE)
  )

ci_discount_yes <- qnorm(
  c(0.025, 0.975),
  mean = discount_yes$mean,
  sd   = discount_yes$sd / sqrt(discount_yes$n)
)
print(ci_discount_yes)

# CI für beide Gruppen / For both groups
ci_discount <- transactions |> 
  group_by(discount_applied) |> 
  summarise(
    n        = n(),
    mean     = mean(line_total, na.rm = TRUE),
    sd       = sd(line_total, na.rm = TRUE),
    lower_ci = qnorm(0.025, mean, sd / sqrt(n)),
    upper_ci = qnorm(0.975, mean, sd / sqrt(n))
  )
print(ci_discount)

cat("✔️ Confidence intervals calculated. / Konfidenzintervalle berechnet.\n")

# ─────────────────────────────────────────────────────────────
# STEP 5: Estimate linear regression model
# Schritt 5: Lineares Regressionsmodell erstellen
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

print(summary(model_lm))        # Model summary
model_metrics <- glance(model_lm)
print(model_metrics)
tidy_model <- tidy(model_lm) |> arrange(desc(abs(estimate)))
print(tidy_model)

cat("✔️ Linear regression completed. / Lineare Regression abgeschlossen.\n")

# ─────────────────────────────────────────────────────────────
# STEP 6: Generate tables for report
# Schritt 6: Tabellen für Bericht erstellen
# ─────────────────────────────────────────────────────────────

ci_discount <- ci_discount |> rename(std_dev = sd)

ci_table <- gt(ci_discount) |> 
  tab_header(title = md("**95% Confidence Intervals**"), subtitle = "Grouped by Discount Status") |> 
  fmt_number(columns = c(mean, std_dev, lower_ci, upper_ci), decimals = 2) |> 
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
  summarise(
    avg_revenue = mean(line_total, na.rm = TRUE),
    n = n()
  ) |> 
  arrange(desc(avg_revenue)) |> 
  gt() |> 
  tab_header(title = md("**Average Line Revenue by Payment Method**")) |> 
  fmt_number(columns = c(avg_revenue), decimals = 2) |> 
  tab_source_note("Based on all valid transactions")
print(payment_summary)

# ─────────────────────────────────────────────────────────────
# DONE / FERTIG
# ─────────────────────────────────────────────────────────────

cat("✔️ Final pipeline executed successfully. / Pipeline erfolgreich ausgeführt.\n")

