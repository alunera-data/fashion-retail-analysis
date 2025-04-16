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

## 📏 Confidence Interval Calculation

In `04_model_ci.R`, 95% confidence intervals were calculated to evaluate the mean line revenue for transactions with and without discounts. The method follows the standard approach using the normal distribution and `qnorm()`.

First, the `qnorm()` function was applied exactly as required for theoretical demonstration:

```r
qnorm(c(0.025, 0.975), mean = 2, sd = 1.2)
```

This represents the confidence interval boundaries for a normally distributed variable with a mean of 2 and a standard deviation of 1.2.

Subsequently, the mean and standard deviation of actual transaction data (e.g. for `discount_applied == "Yes"`) were used in the same formula:

```r
qnorm(c(0.025, 0.975), mean = mean_value, sd = sd_value / sqrt(n))
```

This method was applied to both groups (`Yes`/`No`) and output in a table format using the `gt` package.

The resulting confidence intervals are narrow due to the large sample size (>1 million rows per group), but clearly show a lower mean line revenue for discounted transactions compared to full-price sales.  
Whether this difference is statistically significant will be examined further in the regression step.

---

## 📉 Linear Regression Model

In `05_model_lm.R`, a linear regression model was estimated to identify factors influencing the line-level revenue (`line_total`). The goal was to quantify the effect of discounts, product categories, and payment methods.

### Model formula:

```r
line_total ~ discount_applied + category + payment_method
```

The model was built using over 6 million transaction records. To ensure interpretability, only transactions with positive `line_total` were included.

### Key findings:

| Term                         | Effect                       | Interpretation                                 |
|------------------------------|-------------------------------|------------------------------------------------|
| `discount_appliedYes`        | −64.45                        | Discounts reduce average revenue significantly |
| `categoryMasculine`          | +21.43                        | Higher revenue compared to baseline category   |
| `categoryChildren`           | −20.74                        | Lower revenue for children's products          |
| `payment_methodCredit Card`  | +0.46                         | Slight positive effect vs. baseline method     |

- All predictors were statistically significant (**p < 0.05**)  
- The model explains approximately **2.7%** of the variance in line revenue (`R² = 0.0271`)  
- Output was formatted using the `broom` and `gt` packages

The results confirm the intuitive assumption that discounts reduce unit revenue and that product categories play a substantial role. The model provides a first approximation and will be extended or evaluated further if needed.

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