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
<br><br>
---

## 3. Data Handling
- **Missing values:** imputed missing data using median.
  ![missing1](/assets/images/td_missing1.png)
  ![missing2](/assets/images/td_missing2.png)
- **Outlier detection:** IQR-based method applied on numeric variables.
  ![Outlier](/assets/images/td_outlier.png)
- **Feature engineering:**
  - Choosing features for models after data exploration.
<br> <br>
---

## 4. Data Exploration and Visualization & Feature engineering:

I analyzed distributions and relationships using **matplotlib, seaborn, and plotly**.  
Below lists some different styles of graphs and techniques in data exploration 

**Graphs**:  

- Distribution of categorical variables (job, marital, education, housing loan).  
  ![Job Distribution](/assets/images/td_job_distribution.png)   
- Bar charts of categorical features vs deposit status.  
  ![Deposit of Categories bar](/assets/images/td_category_bar.png)
- Scatter plots of numeric features vs deposit status.  
  ![Scatters](/assets/images/td_scatter.png)

- Correlation heatmap (it is extremely important to detact the relationship between deposit features and other features.  
  ![Correlation Heatmap](/assets/images/td_heatmap.png) 
- Explore relationship between certain features (such as previous campaign outcome or month) and deposit status.  
  ![Donut](/assets/images/td_donut.png)
  ![Month](/assets/images/td_month.png)  
- Use k-means clustering(an unsupervised machine learning algorithm) group data points into K clusters based on similarity.  
  ![K-meas](/assets/images/td_k_means.png)  



> **Note:** Replace `/assets/images/*.png` with your generated graphs from Python.

---

## 5. Modeling
- **Data preparation:** Imputation, one-hot encoding, standardization, train-test split (70/30).  
- **Feature Selection:** Selected predictors based on chi-square, correlation, and heatmaps: duration, pdays, campaign, poutcome_success, contact, housing, loan, job categories, month categories.
  ![Selection0](/assets/images/td_top10_features.png)
  ![Selection1](/assets/images/td_selection1.png)  td_selection1
- **Models:** Logistic Regression, KNN, Decision Tree, SVM, XGBoost, KMeans clustering.  


---

## 6. Model Evaluation
- Metrics: Accuracy, ROC-AUC, confusion matrices.  
- **Graphs**:  
  - ROC-AUC comparison: ![ROC Curves](/assets/images/td_roc.png)  
  - Confusion matrices: ![Confusion Matrices](/assets/images/td_confusion.png)  

---

## 7. Conclusion
- Completed end-to-end ML workflow: data cleaning, EDA, feature engineering, modeling, evaluation.  
- Insights: duration, job type, and previous outcomes strongly influence deposit subscription.  
- Predictive framework can help target clients in future marketing campaigns.
