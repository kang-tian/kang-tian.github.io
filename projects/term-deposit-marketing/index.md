---
layout: default
title: "Term Deposit Marketing Campaign"
permalink: /projects/term-deposit-marketing/
---

# Term Deposit Marketing Campaign

## 1. Introduction
The purpose of this project is to analyze bank client data and build predictive models to determine whether a client will subscribe to a term deposit.  
Key steps include exploring data, handling missing values/outliers, performing EDA, feature engineering, building models (Logistic Regression, KNN, Decision Tree, SVM, XGBoost), and evaluating them.

---

## 2. Data Description
The dataset includes:
- **Bank client data:** age, job, marital status, education, default, housing loan, personal loan, balance.
- **Last contact info:** contact type, last contact month/day, duration of last call.
- **Other campaign data:** number of contacts in campaign, days since last contact, previous outcomes.
- **Target variable:** deposit (yes/no).

---

## 3. Data Handling
- **Missing values:** Introduced artificially, then imputed using median/mean.
- **Outlier detection:** IQR-based method applied on numeric variables.
- **Feature engineering:**
  - Created `depositA` copy of deposit.
  - Grouped jobs: employed/unemployed/not in labor force.
  - Derived `duration_status` (above/below average).
  - Created `balance_group`, `age_group`, etc.

---

## 4. Data Exploration & Visualization

Here we analyze distributions and relationships using **matplotlib, seaborn, and plotly**.  

**Graphs**:  
- Distribution of categorical variables (job, marital, education, housing loan).  
  ![Job Distribution](/assets/images/td_job_distribution.png)  
- Scatter plots of duration vs balance, segmented by deposit outcome.  
  ![Duration vs Balance](/assets/images/td_duration_balance.png)  
- Bar plots of duration_status vs deposit.  
  ![Duration Status vs Deposit](/assets/images/td_duration_status.png)  
- Percentage of clients by job group.  
  ![Job Group Percentage](/assets/images/td_job_group.png)  
- Deposit count by age group.  
  ![Deposit by Age](/assets/images/td_deposit_age.png)  
- Correlation heatmap.  
  ![Correlation Heatmap](/assets/images/td_correlation.png)  

> **Note:** Replace `/assets/images/*.png` with your generated graphs from Python.

---

## 5. Modeling
- **Feature Selection:** Selected predictors based on chi-square, correlation, and heatmaps: duration, pdays, campaign, poutcome_success, contact, housing, loan, job categories, month categories.  
- **Models:** Logistic Regression, KNN, Decision Tree, SVM, XGBoost, KMeans clustering.  
- **Data preparation:** Imputation, one-hot encoding, standardization, train-test split (70/30).  

---

## 6. Model Evaluation
- Metrics: Accuracy, ROC-AUC, confusion matrices.  
- **Graphs**:  
  - ROC-AUC comparison: ![ROC Curves](/assets/images/td_roc_curves.png)  
  - Confusion matrices: ![Confusion Matrices](/assets/images/td_confusion.png)  

---

## 7. Conclusion
- Completed end-to-end ML workflow: data cleaning, EDA, feature engineering, modeling, evaluation.  
- Insights: duration, job type, and previous outcomes strongly influence deposit subscription.  
- Predictive framework can help target clients in future marketing campaigns.
