# 📊 Gender Pay Gap Switzerland (NDK HF Transferarbeit)

This project was developed as part of the **Transferarbeit** in the  
[Nachdiplomkurs HF Data Science (NDK HF)](https://www.ibaw.ch/bildung/weiterbildung/data-science).  
It explores the development of the **gender pay gap** in Switzerland over time  
based on publicly available data from the Federal Statistical Office (BFS).

---

## 🎯 Goal

The objective is to analyze the gender pay gap in Switzerland and investigate  
whether there are systematic differences in wage development by gender,  
across industries, and job requirement levels.

The report includes **visualizations**, **statistical modeling** (linear regression), and  
**confidence intervals** based on the normal distribution using `qnorm()`.

---

## 📚 Data Source

The dataset is provided by the [Swiss Federal Statistical Office (BFS)](https://www.bfs.admin.ch),  
based on the **Swiss Wage Structure Survey (LSE)**.

⚠️ **Note:** The dataset is **not included** in this repository.  
Please download the relevant Excel file from the BFS and convert it to CSV.

👉 [Download Original Data (BFS)](https://www.bfs.admin.ch/bfsstatic/dam/assets/24617864/master)

Place the file locally as:  
`data/bfs_gender_pay_gap.csv`

---

## 🗂️ Project Structure

| File                             | Description                                                   |
|----------------------------------|---------------------------------------------------------------|
| `scripts/01_load_data.R`         | Load packages and import BFS wage data                       |
| `scripts/02_clean_transform.R`   | Data wrangling: reshape, label variables, create factors      |
| `scripts/03_explore_data.R`      | Visualizations by gender, year, industry, requirement level   |
| `scripts/04_model_ci.R`          | Confidence intervals using `qnorm()`                          |
| `scripts/05_model_lm.R`          | Linear regression analysis on wage differences                |
| `scripts/06_tables_export.R`     | Create and export formatted summary tables                    |
| `07_final_pipeline.R`            | Compact pipeline version with all steps                       |
| `gender_pay_gap.qmd`             | Final Quarto report                                           |
| `gender_pay_gap.html`            | Rendered HTML version for submission                          |
| `data/bfs_gender_pay_gap.csv`    | Local copy of BFS dataset (excluded via `.gitignore`)         |
| `plots/`                         | Optional folder for exported `ggplot2` visualizations         |
| `.gitignore`                     | Excludes data and system-specific files                       |
| `README.md`                      | This project overview                                         |
| `LICENSE`                        | MIT License for reuse                                         |

---

## 📈 Key Results (Example)

| Element                | Description                                  |
|------------------------|----------------------------------------------|
| Time span              | 2010–2020                                    |
| Main metric            | Median wage difference (CHF, %)             |
| CI coverage            | 95 % using `qnorm()`                         |
| Regression             | Wage ~ Gender + Year + Industry              |
| Visual types           | Boxplots, Lines, Bars, Points (ggplot2)     |
| Table format           | `gt` table, formatted in Quarto report       |

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

- `gender_pay_gap.html`

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