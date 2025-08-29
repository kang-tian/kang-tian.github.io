# Customer Transaction Analysis & Segmentation (R)

## Keywords
Transaction Analysis · Customer Segmentation · RFM · Feature Engineering · KMeans Clustering · Silhouette Score · PCA Cluster Viz · Time Series · High-Value Prediction · Decision Tree · Random Forest   <br><br>

**Note**: This page provides an introduction to the project. For additional visualizations and the full source code, please visit the repository: https://github.com/kang-tian/Customer_Transaction_Analysis_Segmemtation_RFM_-R-   <br><br>

----   <br><br>

## 1) Overview

This project explores and segments customer transactions using an **ANZ dataset**.  
The workflow covers **data cleaning, transaction-level exploration, visualization, customer-level feature engineering, and RFM analysis**.  
The goal is to uncover behavioral patterns, identify high-value customers, and support customer segmentation strategies.    <br><br>

**Tech:** tidyverse, lubridate, caret, rpart, randomForest, pROC, cluster, factoextra, corrplot, ggpubr.     <br><br>

---   <br><br>

## 2) Data Ingestion & Setup

- Load CSV with robust type guessing and parsing checks.  
- Trim char fields; coerce numeric fields (amount, balance, card_present_flag).  
- Ensure `customer_id` exists and is character.  
- Parse dates with `mdy → dmy → ymd` fallback; derive `txn_date, year, month, day, hour, weekday`.  
- Derive `age_group` & `balance_group`.
- Missingness summary computed to prioritize fixes and understand data reliability.    <br><br>

---   <br><br>

## 3) Transaction-Level EDA

**Descriptive stats** (count, total, mean/median, sd, min/max, quantiles) plus demographics:  
- Customers by age group and gender.
- Distributions of transaction amounts (log-scale histogram + boxplot).  
- Daily trends (count & total amount) with LOESS smoothing.  
- Decomposition by movement (facet lines for count & amount).  
- Heatmaps.  
<p align="center">
  <img src="/projects/Customer_Transaction_Risk_Analysis_R/images/Picture1.png" alt="Reviews per Page" width="70%"/>
</p>
<p align="center">
  <img src="/projects/Customer_Transaction_Risk_Analysis_R/images/Picture2.png" alt="Reviews per Page" width="70%"/>
</p>

<p align="center">
  <img src="/projects/Customer_Transaction_Risk_Analysis_R/images/Picture3.png" alt="Reviews per Page" width="70%"/>
</p>

<p align="center">
  <img src="/projects/Customer_Transaction_Risk_Analysis_R/images/Picture4.png" alt="Reviews per Page" width="70%"/>
</p>
<p align="center">
  <img src="/projects/Customer_Transaction_Risk_Analysis_R/images/Picture5.png" alt="Reviews per Page" width="70%"/>
</p>     <br><br>


**Merchant insights:**  
- Pie: NA vs. valid merchants (share of total amount)  
- Top 15 merchants by total amount (bar, horizontal)  
- Category breakdowns: movement, status, txn_description, gender, age_group (value & count facets).  

<p align="center">
  <img src="/projects/Customer_Transaction_Risk_Analysis_R/images/Picture6.png" alt="Reviews per Page" width="70%"/>
</p>
<p align="center">
  <img src="/projects/Customer_Transaction_Risk_Analysis_R/images/Picture7.png" alt="Reviews per Page" width="70%"/>
</p>   <br><br>

---   <br><br>

## 4) Customer-Level Feature Engineering

Aggregate to one row per `customer_id`:  
- txn_count, total_amount, avg_amount, median_amount, max_amount  
- balance_mean, distinct_merchants, card_present_pct  
- Salary/Payroll detection via keywords; salary_txn_count  
- Activity window: first_txn, last_txn, days_active, recency_days  
- Activity rates: txn_per_day, txn_per_month  
<p align="center">
  <img src="/projects/Customer_Transaction_Risk_Analysis_R/images/Picture8.png" alt="Reviews per Page" width="70%"/>
</p>

---

## 5) Clustering (Unsupervised Segmentation)

**Goal:** group customers by behavior (volume, activity, recency, merchant diversity).

- **Features (scaled):** total_amount, txn_count, avg_amount, balance_mean, distinct_merchants, card_present_pct, txn_per_month, recency_days.  
- **Model selection:** KMeans with silhouette scores across k = 2..8 → choose best_k.  
- **Final model:** KMeans with best_k = 2.
- **Visualization:** PCA plot of clusters.  
- **Exports:** `customer_summary_with_clusters.csv`.

**Cluster profiling (per cluster):**  
- Size, avg_total_amount, avg_txn_count, avg_avg_amount, avg_balance, ...
- Profile charts.  

<p align="center">
  <img src="/projects/Customer_Transaction_Risk_Analysis_R/images/Picture9.png" alt="Reviews per Page" width="70%"/>
</p>
<p align="center">
  <img src="/projects/Customer_Transaction_Risk_Analysis_R/images/Picture10.png" alt="Reviews per Page" width="70%"/>
</p>
  

---

## 6) RFM Analysis (Segmentation)

**RFM metrics per customer:**  
- Recency (days since last txn), Frequency (txn count), Monetary (total spend).  

**Scoring:** 1 (worst) to 5 (best):  
**Segments (example scheme):**  
- 444–555 → Champions  
- 333–444 → Loyal Customers  
- High R, low F & M → Recent Customers  
- Low R, high F & M → Potential Loyalists  
- 111–222 → At Risk  
- Else → Others  

<p align="center">
  <img src="/projects/Customer_Transaction_Risk_Analysis_R/images/Picture11.png" alt="Reviews per Page" width="70%"/>
</p>
<p align="center">
  <img src="/projects/Customer_Transaction_Risk_Analysis_R/images/Picture12.png" alt="Reviews per Page" width="70%"/>
</p>    <br><br>
  

---

## 7) Predictive Modeling (High-Value Customers)

**Target definition:** High if total_amount in top 25% (≥ 75th percentile), else Low.  

**Data:** engineered customer features + (optional) cluster label.  
- **Train/Test Split:** 70/30 with stratification.  
- **Baseline Model:** Decision Tree (rpart, cp = 0.01)  
<p align="center">
  <img src="/projects/Customer_Transaction_Risk_Analysis_R/images/Picture13.png" alt="Reviews per Page" width="70%"/>
</p>
<p align="center">
  <img src="/projects/Customer_Transaction_Risk_Analysis_R/images/Picture14.png" alt="Reviews per Page" width="50%"/>
</p>

- **Ensemble Model:** Random Forest (caret::train, 5-fold CV, metric = ROC)  
  - Evaluation: confusion matrix + AUC  
  - Variable importance (top drivers)  
<p align="center">
  <img src="/projects/Customer_Transaction_Risk_Analysis_R/images/Picture15.png" alt="Reviews per Page" width="70%"/>
</p>    <br><br>


---

## 8) Salary Signal

If salary-like transactions exist, detect the frequency (monthly or bi-weekly) compute:  
- median_salary_txn and estimated_annual_salary = median_salary_txn * frequency.      <br><br>


---

## 9) Executive Takeaways 

- Behavioral segments from KMeans + RFM highlight clear groups (*champions, stable core, at-risk*).  
- Predictive models separate high-value customers with interpretable drivers (*frequency, recency, avg amount*).  
- **Actionable levers:** tailor offers by cluster/RFM, nudge at-risk, cultivate potential loyalists, and prioritize high-value predictions.     <br><br>
