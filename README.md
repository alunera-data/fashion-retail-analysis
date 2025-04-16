# 🛍️ Fashion Retail Analysis (NDK HF Transfer Project)

This project was developed as part of the **Transferarbeit** in the  
[Nachdiplomkurs HF Data Science (NDK HF)](https://www.ibaw.ch/bildung/weiterbildung/data-science).  
It explores transaction-level data from global fashion retail, focusing on  
the effects of **discounts**, **product categories**, and **payment methods** on revenue.

---

## ❓ Research Question

**Which factors influence the revenue per transaction in fashion retail?**

The project investigates:
- Whether discounts reduce line-level revenue
- How product categories impact transaction value
- If payment method affects revenue patterns

---

## 📚 Data Source

The dataset is available via Kaggle:  
[Global Fashion Retail Stores Dataset](https://www.kaggle.com/datasets/ricgomes/global-fashion-retail-stores-dataset)

It includes synthetic but realistic data for:
- ~6.4 million transactions
- Product metadata
- Customer and store information
- Discounts and employees

⚠️ **Note:** Raw data is **not included** in this repository.  
To reproduce the analysis, place the original CSV files in the `data/` folder.

---

## 🔍 Analysis Overview

The following steps were implemented:

- Data loading, cleaning, and transformation (`tidyverse`, `janitor`)
- Exploratory data visualization using `ggplot2`
- Confidence interval calculation using `qnorm()` (as required)
- Linear regression model using `lm()`
- Reporting tables created with `gt` for HTML/PDF rendering
- All steps combined in `07_final_pipeline.R` for full reproducibility

---

## 📈 Visual Outputs

| Visualization                       | Type       | Purpose                                |
|------------------------------------|------------|----------------------------------------|
| Top 10 stores by revenue           | Bar plot   | Compare highest-earning stores         |
| Revenue over time (monthly)        | Line plot  | Identify trends and seasonal effects   |
| Revenue by product category        | Bar plot   | Understand category-specific behavior  |
| Revenue distribution by discount   | Boxplot    | Evaluate spread between groups         |

All plots were created with `ggplot2` and use clean, unicode-safe labeling.

---

## 📏 Statistical Results

- **Confidence intervals** were calculated using `qnorm()`,  
  both with an example (`mean = 2, sd = 1.2`) and real data
- A **linear regression model** was estimated to assess variable importance:
  
  ```r
  line_total ~ discount_applied + category + payment_method
  ```

- Key finding: Discounts significantly reduce average line revenue (−64.45)
- Product category has strong effects (e.g., +21.43 for "Masculine")
- Payment method (Credit Card) has a small but significant effect
- Adjusted R² = **2.7%** based on >6 million records

---

## 📋 Reporting Tables

Created using `gt`, the report includes:

- 95% confidence intervals (Yes vs. No discount)
- Regression coefficients (formatted via `broom::tidy()`)
- Summary of revenue by payment method

Tables are fully reproducible and embedded in the Quarto report.

---

## 📄 Report Versions

- `fashion_retail_analysis.qmd` → English version for GitHub and portfolio  
- `fashion_retail_analysis_DE.qmd` → German version for submission  

---

## ✅ NDK HF Checklist

| Requirement                                | Status |
|--------------------------------------------|--------|
| Research question formulated               | ✅     |
| Exploratory visualizations (5+)            | ✅     |
| 3+ `ggplot2` chart types                   | ✅     |
| Confidence interval with `qnorm()`         | ✅     |
| Linear regression with `lm()`              | ✅     |
| At least 1 formatted table (`gt`)          | ✅     |
| `.qmd` and reproducible `.html` output     | ✅     |
| All data handled locally                   | ✅     |

---

## 💾 Project Files

| File                             | Description                             |
|----------------------------------|-----------------------------------------|
| `scripts/01–06_*.R`              | Load, clean, visualize, model, export   |
| `07_final_pipeline.R`            | Complete execution of full analysis     |
| `fashion_retail_analysis.qmd`    | English Quarto source document          |
| `fashion_retail_analysis_DE.qmd` | German submission version               |
| `.gitignore`                     | Excludes local files (data, html, etc.) |
| `LICENSE`                        | MIT License for reuse                   |

---

## 💻 Requirements

- **R 4.4 or newer**  
- **RStudio**  
- Required packages:  
  - `tidyverse`  
  - `ggplot2`  
  - `janitor`  
  - `lubridate`  
  - `broom`  
  - `gt`  
  - `glue`  
  - `scales`

---

## 🧪 Reproducibility

This project follows edX/NDK HF guidelines for reproducibility.  
All code is visible (`echo = TRUE`) and documented.  
To reproduce the report locally, run:

```r
quarto::quarto_render("fashion_retail_analysis.qmd")
```

---

## 🪪 License

This project is licensed under the [MIT License](LICENSE).  
You are free to use, modify, and distribute this project for educational or non-commercial purposes,  
as long as proper credit is given to the author.

> _For code reuse or citation, please attribute: Yvonne Kirschler (2025)._

---

## 👩‍💻 Author

This project was created by **Yvonne Kirschler**  
as part of the NDK HF Data Science and is publicly available for educational and reference purposes.

> _This report was written and structured independently.  
> ChatGPT (OpenAI) was used as a tool to support planning, formulation, and quality control.  
> All statistical analysis, data work and conclusions were developed and reviewed by the author._