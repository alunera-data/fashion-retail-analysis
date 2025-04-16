# ─────────────────────────────────────────────────────────────
# Project: Fashion Retail Analysis (NDK HF Transferarbeit)
# File:    03_explore_data.R
# Author:  Yvonne Kirschler
# Purpose: First exploratory visualizations and summaries
#          Erste explorative Visualisierungen und Auswertungen
# ─────────────────────────────────────────────────────────────

# ─────────────────────────────────────────────────────────────
# STEP 1: Load required packages
# Schritt 1: Notwendige R-Pakete laden
# Load libraries used for data wrangling, visualizations and table output
# Pakete laden, die für Datenbearbeitung, Visualisierung und Tabellenformatierung benötigt werden
# ─────────────────────────────────────────────────────────────
library(tidyverse)   # Core data manipulation and ggplot2 visualization
library(janitor)     # Clean column names (snake_case)
library(lubridate)   # Handle and transform date/time variables
library(scales)      # Format axes and labels in ggplot2
library(gt)          # Create clean and styled summary tables

# ─────────────────────────────────────────────────────────────
# STEP 2: Top 10 stores by total revenue
# Schritt 2: Top 10 Stores nach Gesamtumsatz anzeigen
# Goal: Identify the best-performing stores by total transaction revenue
# Ziel: Die umsatzstärksten Stores anhand des Transaktionsumsatzes identifizieren
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

# ─────────────────────────────────────────────────────────────
# STEP 3: Monthly revenue trend
# Schritt 3: Umsatzverlauf pro Monat darstellen
# Goal: Detect trends or seasonal effects in total monthly revenue
# Ziel: Monatliche Umsatzveränderungen und saisonale Muster erkennen
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

# ─────────────────────────────────────────────────────────────
# STEP 4: Average revenue per product category
# Schritt 4: Durchschnittlicher Umsatz pro Produktkategorie
# Goal: Understand category-based differences in transaction value
# Ziel: Unterschiede im Umsatz je Kategorie analysieren
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

# ─────────────────────────────────────────────────────────────
# STEP 5: Revenue distribution by discount (boxplot)
# Schritt 5: Umsatzverteilung mit/ohne Rabatt (Boxplot)
# Goal: Compare value spread for discounted vs. full-price sales
# Ziel: Unterschiede in der Streuung bei rabattierten Verkäufen erkennen
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

# ─────────────────────────────────────────────────────────────
# STEP 6: Summary table – Revenue by discount
# Schritt 6: Zusammenfassung – Umsatz mit/ohne Rabatt
# Goal: Tabular comparison of average and median revenue
# Ziel: Durchschnitts- und Medianwerte je Rabattgruppe tabellarisch darstellen
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

# ─────────────────────────────────────────────────────────────
# STEP 7: Confirmation
# Schritt 7: Abschlussmeldung
# Final confirmation that visual exploration is completed
# Abschlieende Bestätigung der abgeschlossenen Analyse
# ─────────────────────────────────────────────────────────────
cat("✔️ Visual exploration completed. / Visuelle Analyse abgeschlossen.\n")