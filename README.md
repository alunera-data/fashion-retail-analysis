# 🛍️ Fashion Retail Analysis (NDK HF Transferarbeit)

This project was developed as part of the **Transferarbeit** in the  
[Nachdiplomkurs HF Data Science (NDK HF)](https://www.ibaw.ch/bildung/weiterbildung/data-science).  
It explores the global distribution and characteristics of **fashion retail stores**,  
with a focus on **brand presence, store density, regional variation** and  
temporal patterns across different countries.

---

## 🎯 Goal

The objective is to analyze how global fashion brands have expanded geographically,  
which countries or cities have the highest store concentration, and whether store distribution  
is associated with brand, founding year, or region.

The report includes **visualizations**, **statistical modeling** (linear regression), and  
**confidence intervals** based on the normal distribution using `qnorm()`.

---

## 📚 Data Source

The dataset is provided via Kaggle:  
[Global Fashion Retail Stores Dataset](https://www.kaggle.com/datasets/ricgomes/global-fashion-retail-stores-dataset)

It contains information about more than 60,000 stores across 90+ countries, including:
- Brand
- Category
- Address (country, city)
- Store type
- Founding year

⚠️ **Note:** The dataset is **not included** in this repository.  
Please download the CSV manually from Kaggle and save it locally as:

```text
data/fashion_retail.csv
```

---

## 🗂️ Project Structure

| File                             | Description                                                   |
|----------------------------------|---------------------------------------------------------------|
| `scripts/01_load_data.R`         | Load packages and import retail dataset                       |
| `scripts/02_clean_transform.R`   | Data cleaning and preparation (e.g. renaming, types, filters) |
| `scripts/03_explore_data.R`      | Visualizations by brand, country, year, category              |
| `scripts/04_model_ci.R`          | Confidence intervals using `qnorm()`                          |
| `scripts/05_model_lm.R`          | Linear regression on store count or presence by factors       |
| `scripts/06_tables_export.R`     | Create and export formatted summary tables                    |
| `07_final_pipeline.R`            | Compact pipeline version with all steps                       |
| `fashion_retail_analysis.qmd`    | Final Quarto report                                           |
| `fashion_retail_analysis.html`   | Rendered HTML version for submission                          |
| `.gitignore`                     | Excludes data and system-specific files                       |
| `README.md`                      | This project overview                                         |
| `LICENSE`                        | MIT License for reuse                                         |

---

## 📈 Key Results (Example – Placeholder)

| Element                | Description                                         |
|------------------------|-----------------------------------------------------|
| Sample size            | ~60,000 stores across 90+ countries                 |
| Main metric            | Store count per country / brand                     |
| CI coverage            | 95 % using `qnorm()`                                |
| Regression             | Store count ~ Brand + Year + Continent              |
| Visual types           | Choropleth maps, Barplots, Line plots, Boxplots     |
| Table format           | `gt` table, formatted in Quarto report              |

---

## 💻 Requirements

- **R 4.4 or newer**  
- **RStudio**  
- Required R packages:  
  - `tidyverse`  
  - `ggplot2`  
  - `gt`  
  - `broom`  
  - `janitor`

---

## 📄 Report Access

The final report submitted for the NDK HF is available in HTML format:

- `fashion_retail_analysis.html`

It includes full documentation, data insights, statistical calculations,  
and interpretations for non-specialist audiences.

---

## 👩‍💻 Author and License

This project was created by **Yvonne Kirschler**  
as part of the NDK HF Data Science and is publicly available for educational purposes.

> _This project was developed independently and fulfills the transfer module requirements.  
> ChatGPT (OpenAI) was used to support planning, structure, and formulation.  
> All data handling, analysis, modeling, and interpretation were carried out by the author._

---