# 🧠 Autism Spectrum Analysis (NDK HF Transferarbeit)

This project was developed as part of the **Transferarbeit** in the  
[Nachdiplomkurs HF Data Science (NDK HF)](https://www.ibaw.ch/bildung/weiterbildung/data-science).  
It explores the occurrence of **autistic traits in adults**, with a special focus on  
**female presentation and its connection to mental health factors**.

---

## 🎯 Goal

The objective is to investigate the relationship between autism screening scores,  
personality traits (OCEAN), and self-reported psychological burdens such as  
stress, anxiety, and depression – with a particular interest in **underdiagnosed autism in women**.

The report includes **visualizations**, **statistical modeling** (linear regression), and  
**confidence intervals** based on the normal distribution using `qnorm()`.

---

## 📚 Data Source

The dataset is provided via [Kaggle](https://www.kaggle.com/datasets/ntekie/autism-spectrum-disorder-traits)  
and includes the following variables:

- AQ-10 screening score (autistic traits)  
- Big Five personality scores (OCEAN)  
- Gender, age, and other demographics  
- Self-assessment of psychological burdens (stress, anxiety, etc.)

⚠️ **Note:** The dataset is **not included** in this repository.  
Please download the CSV manually from Kaggle and save it locally as:

```text
data/autism_traits.csv
```

---

## 🗂️ Project Structure

| File                             | Description                                                   |
|----------------------------------|---------------------------------------------------------------|
| `scripts/01_load_data.R`         | Load packages and import the autism traits dataset            |
| `scripts/02_clean_transform.R`   | Data cleaning and preparation (factor levels, renaming etc.)  |
| `scripts/03_explore_data.R`      | Visualizations by gender, AQ score, mental health indicators   |
| `scripts/04_model_ci.R`          | Confidence intervals using `qnorm()`                          |
| `scripts/05_model_lm.R`          | Linear regression analysis on AQ score and mental health      |
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
| Sample size            | ~300 individuals                                    |
| Main metric            | AQ-10 score (screening indicator)                   |
| CI coverage            | 95 % using `qnorm()`                                |
| Regression             | AQ ~ Gender + Stress + Depression + Personality     |
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