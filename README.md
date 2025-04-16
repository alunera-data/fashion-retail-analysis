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

## 📈 Dataset Overview and Key Results (Preview)

| Dataset             | Rows       | Description                                      |
|---------------------|------------|--------------------------------------------------|
| `transactions.csv`  | 6,416,827  | Line-level transactions with products, prices, discounts, and timestamps |
| `customers.csv`     | 1,643,306  | Customer profiles incl. demographics and location |
| `products.csv`      | 17,940     | Products with multilingual descriptions and pricing |
| `stores.csv`        | 35         | Global store locations incl. geo-coordinates     |
| `employees.csv`     | 404        | Employees with role and store assignment         |
| `discounts.csv`     | 181        | Time-based promotions by category and sub-category |

---

| Element               | Description                                           |
|------------------------|-------------------------------------------------------|
| Sample size            | >6.4 million transactions, 1.6 million customers       |
| Focus                  | Store-level performance and revenue influencers        |
| Regression             | Revenue ~ Store Type + Year + Discount + Country      |
| CI usage               | Confidence intervals on revenue per store category     |
| Visual types           | Barplots, Boxplots, Line plots, Density plots          |
| Table format           | Clean summary tables created using `gt`               |
| Label strategy         | Unicode-safe: plots use `Store {store_id}` as labels  |

---

📊 This project demonstrates how transactional and categorical data from global fashion retail  
can be combined to gain insights into store performance, pricing effects, and customer behavior.  
It is designed to meet the requirements of the NDK HF Transferarbeit and follows edX reproducibility standards  
(Quarto, R, `.qmd`, `.html`, local CSVs).

---

## 🧼 Data Cleaning & Preparation

In `02_clean_transform.R`, all raw datasets were structurally transformed to ensure consistency and usability in later analyses:

- Categorical variables such as `store_id`, `product_id`, `transaction_type`, and `gender` were converted to **factors**
- Date columns like `date`, `date_of_birth`, `start`, and `end` were converted to **Date** class using `lubridate`
- ID fields were converted to factors to support grouping operations
- Column names were cleaned and standardized using `janitor::clean_names()`

A quick NA check confirmed:

| Dataset         | Missing Values |
|------------------|----------------|
| `transactions`   | 4,763,885      |
| `products`       | 14,515         |
| `discounts`      | 20             |

These values will be addressed during exploration or model preparation, depending on their analytical relevance.

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