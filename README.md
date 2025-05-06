# 🛍️ Fashion Retail Analysis (NDK HF Transfer Project)

This project was developed as part of the **Transferarbeit** in the  
[Nachdiplomkurs HF Data Science (NDK HF)](https://www.ibaw.ch/bildung/weiterbildung/data-science).  
It explores transaction-level data from global fashion retail, focusing on  
the effects of **discounts**, **product categories**, and **payment methods** on revenue.

---

## ❓ Research Question

**Which factors influence the revenue per transaction in fashion retail?**

The project investigates:
- Whether discounts reduce average line revenue
- How product categories affect transaction value
- Whether payment method makes a measurable difference
- How statistical methods validate these effects

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
- Reporting tables created with `gt` for HTML rendering
- All steps combined in `07_final_pipeline.R` for full reproducibility

---

## 📈 Visual Outputs

| Visualization                       | Type       | Purpose                                |
|------------------------------------|------------|----------------------------------------|
| Top 10 stores by revenue           | Bar plot   | Compare highest-earning stores         |
| Revenue over time (monthly)        | Line plot  | Identify trends and seasonal effects   |
| Revenue by product category        | Bar plot   | Understand category-specific behavior  |
| Revenue distribution by discount   | Boxplot    | Evaluate spread between groups         |
| Revenue by store size              | Scatter    | Analyze size effect on performance     |

All plots were created with `ggplot2` and use clean, unicode-safe labeling.

---

## 📏 Statistical Results

- **Confidence intervals** were calculated using `qnorm()`,  
  both with an example (`mean = 2, sd = 1.2`) and actual data
- A **linear regression model** was estimated using:

```r
line_total ~ discount_applied + category + payment_method
```

- Key findings:
  - Discounts significantly reduce revenue (−64.45)
  - Product category has a strong impact (e.g., +21.43 for "Masculine")
  - Credit card payments show a slight but significant effect
- Adjusted R² = **2.7%** on >6 million transactions

---

## 📋 Reporting Tables

Generated using `gt`:

- 95% confidence intervals (Yes/No discount)
- Regression coefficients from `broom::tidy()`
- Revenue summary by payment method

Tables are embedded directly in the final Quarto report.

---

## 📄 Report Versions

- `fashion_retail_analysis.qmd` → English Quarto file for GitHub/portfolio  
- `fashion_retail_analysis_DE.qmd` → German version for NDK submission

---

## ✅ NDK HF Checklist

| Requirement                                | Status |
|--------------------------------------------|--------|
| Research question formulated               | ✅     |
| Exploratory visualizations (≥5)            | ✅     |
| Three ggplot2 chart types                  | ✅     |
| `qnorm()` for CI                           | ✅     |
| Linear regression with `lm()`              | ✅     |
| One or more formatted tables (`gt`)        | ✅     |
| Fully reproducible `.qmd` and `.html`      | ✅     |
| Local data usage confirmed                 | ✅     |

---

## 💾 Project Files

| File                             | Description                             |
|----------------------------------|-----------------------------------------|
| `scripts/01–06_*.R`              | Load, clean, visualize, model, export   |
| `07_final_pipeline.R`            | Complete execution of all steps         |
| `fashion_retail_analysis.qmd`    | English report (.qmd)                   |
| `fashion_retail_analysis_DE.qmd` | German version for NDK submission       |
| `fashion_retail_analysis.html`   | Rendered HTML report (English)          |
| `.gitignore`                     | Excludes data and HTML_DE files         |
| `LICENSE`                        | MIT License                             |

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

This project follows edX/NDK HF guidelines for full reproducibility.  
All code is visible (`echo = TRUE`) and well documented.  
To render the report locally:

```r
quarto::quarto_render("fashion_retail_analysis.qmd")
```

---

## 🪪 License

This project is licensed under the [MIT License](LICENSE).  
You may use, modify and share this content for educational purposes,  
as long as proper credit is given to the author.

> _Attribution: Yvonne Kirschler (2025)._

---

## 👩‍💻 Author

This project was created by **Yvonne Kirschler**  
as part of the NDK HF Data Science training and is available for educational and reference purposes.

GitHub: [@alunera-data](https://github.com/alunera-data)  
LinkedIn: [Yvonne Kirschler](https://www.linkedin.com/in/yvonne-kirschler-719224188/)

> _This report was independently written.  
> ChatGPT (OpenAI) was used to support structure, phrasing, and proofreading.  
> All analysis, modeling and interpretation were carried out by the author._