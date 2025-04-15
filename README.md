# 🧠 Autism Spectrum Analysis (NDK HF Transferarbeit)

This project was developed as part of the **Transferarbeit** in the  
[Nachdiplomkurs HF Data Science (NDK HF)](https://www.ibaw.ch/bildung/weiterbildung/data-science).  
It explores the expression of **autistic traits in adults**, with a special focus on  
**gender differences and psychological factors** based on the ABIDE dataset.

---

## 🎯 Goal

The objective is to analyze the demographic and cognitive characteristics  
associated with autism in adults, with particular attention to potential  
gender-related underdiagnosis and the interplay with mental health variables.

The report includes **visualizations**, **statistical modeling** (linear regression), and  
**confidence intervals** based on the normal distribution using `qnorm()`.

---

## 📚 Data Source

The dataset is provided via Kaggle as part of the  
[ABIDE (Autism Brain Imaging Data Exchange) competition](https://www.kaggle.com/competitions/abide/data).

📦 **Only the phenotypic CSV file is used in this project** (no imaging data).

⚠️ **Note:** The dataset is **not included** in this repository.  
Please download the phenotypic file manually and save it locally as:

```text
data/abide_phenotypic.csv
```

---

## 🗂️ Project Structure

| File                             | Description                                                   |
|----------------------------------|---------------------------------------------------------------|
| `scripts/01_load_data.R`         | Load packages and import ABIDE CSV dataset                    |
| `scripts/02_clean_transform.R`   | Data cleaning and preparation (e.g. rename, factor conversion)|
| `scripts/03_explore_data.R`      | Visualizations by diagnosis, sex, IQ, age                     |
| `scripts/04_model_ci.R`          | Confidence intervals using `qnorm()`                          |
| `scripts/05_model_lm.R`          | Linear regression on IQ, diagnosis, and gender                |
| `scripts/06_tables_export.R`     | Create and export formatted summary tables                    |
| `07_final_pipeline.R`            | Compact pipeline version with all steps                       |
| `autism_spectrum_analysis.qmd`   | Final Quarto report                                           |
| `autism_spectrum_analysis.html`  | Rendered HTML version for submission                          |
| `.gitignore`                     | Excludes data and system-specific files                       |
| `README.md`                      | This project overview                                         |
| `LICENSE`                        | MIT License for reuse                                         |

---

## 📈 Key Results (Example – Placeholder)

| Element                | Description                                         |
|------------------------|-----------------------------------------------------|
| Sample size            | ~1000 individuals                                   |
| Main metric            | Full IQ, diagnosis group (ASD / control)            |
| CI coverage            | 95 % using `qnorm()`                                |
| Regression             | IQ ~ Diagnosis + Gender + Age                       |
| Visual types           | Histograms, Boxplots, Scatterplots, Violin plots    |
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

- `autism_spectrum_analysis.html`

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