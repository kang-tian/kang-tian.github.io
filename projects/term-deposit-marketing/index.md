---
layout: default
title: "Term Deposit Marketing Campaign"
permalink: /projects/term-deposit-marketing/
---

# Term Deposit Marketing Campaign

<p> &nbsp;</p>  


## 1. Introduction  
This project looks at a bank marketing campaign and asks a simple question:  
**“Can we predict whether a client will agree to open a term deposit?”**  

To answer this, I worked through the full data science process:
- Understanding and cleaning the data  
- Exploring patterns with charts and statistics  
- Creating new features that make the data more useful  
- Building machine learning models (Logistic Regression, Decision Trees, SVM, XGBoost, etc.)  
- Comparing how well the models predict client decisions  

<p> &nbsp;</p>  

**Link to Code:** [GitHub](https://github.com/kang-tian/Machine-Learning-Term-Deposit-Marketing-Campaign)

<p> &nbsp;</p>  



## 2. Data Overview  
The dataset contains information about bank clients and previous campaigns.  
Key groups of information:  
- **Client profile:** age, job, marital status, education, loan status, account balance  
- **Contact details:** how and when the client was last contacted, and for how long  
- **Campaign history:** how many times the client was contacted before, and the outcome  
- **Target variable:** whether the client said *yes* or *no* to a term deposit  


<p> &nbsp;</p>  



## 3. Preparing the Data  

- **Handling missing values**: filled in missing numbers using medians so results wouldn’t be skewed  
  <img src="/assets/images/td_missing1.png" width="70%">  
  <img src="/assets/images/td_missing2.png" width="70%">  

<p> &nbsp;</p>  


- **Finding unusual values (outliers)**: spotted extreme numbers with boxplots  
  <img src="/assets/images/td_outlier.png" width="70%">  

<p> &nbsp;</p>  


- **Feature engineering**: created new, simplified variables (e.g., grouping jobs into broader categories, creating “above/below average duration” flags, etc.) to make the models more meaningful.  


<p> &nbsp;</p>  



## 4. Exploring the Data  

To better understand patterns in the data, I created visualizations:  

- **Who are the clients?**  
  <img src="/assets/images/td_job_distribution.png" width="70%">  

<p> &nbsp;</p>  


- **How client categories relate to deposits:**  
  <img src="/assets/images/td_category_bar.png" width="70%">  

<p> &nbsp;</p>  


- **Numeric factors (like call duration) vs. deposits:**  
  <img src="/assets/images/td_scatter.png" width="70%">  

<p> &nbsp;</p>  


- **Correlation heatmap** (to see which variables move together):  
  <img src="/assets/images/td_heatmap.png" width="70%">  

<p> &nbsp;</p>  


- **Previous campaign outcomes & seasonality (months):**  
  <img src="/assets/images/td_donut.png" width="70%">  
  <img src="/assets/images/td_month.png" width="70%">  

<p> &nbsp;</p>  


- **Unsupervised clustering** (K-means) to group similar clients:  
  <img src="/assets/images/td_k_means.png" width="70%">  


<p> &nbsp;</p>  



## 5. Building Models  

Steps before training:  
- Prepared the data (filled missing values, encoded categories, standardized numbers)  
- Selected the most important features (such as call duration, number of contacts, month, job group, and previous campaign outcome)  
  <img src="/assets/images/td_top10_features.png" width="70%">  
  <img src="/assets/images/td_selection1.png" width="70%">  

Models tested:  
- Logistic Regression (baseline, interpretable model)  
- K-Nearest Neighbors (KNN)  
- Decision Tree  
- Support Vector Machine (SVM)  
- XGBoost (boosted decision trees)  
- K-Means clustering (unsupervised segmentation)  


<p> &nbsp;</p>  



## 6. Model Evaluation  

To measure success, I used:  
- **Accuracy:** overall correctness  
- **ROC-AUC curves:** ability to distinguish “yes” vs. “no” clients  
- **Confusion matrices:** where models got predictions right or wrong  

Results:  
- Logistic Regression = simple and interpretable  
- XGBoost & Decision Trees = best accuracy and captured complex patterns  
- KNN & SVM = varied performance depending on parameters  

**Graphs:**  
- ROC Curves  
  <img src="/assets/images/td_roc.png" width="70%">  

- Confusion Matrices  
  <img src="/assets/images/td_confusion.png" width="70%">  


<p> &nbsp;</p>  



## 7. Conclusion  

This project showed the full journey from raw client data to predictive insights.  

**Main takeaways:**  
- Longer call duration, client job type, and past campaign outcomes are strong indicators of whether someone will subscribe.  
- Machine learning models like Decision Trees and XGBoost perform best for prediction.  
- The framework can help banks focus on clients most likely to say “yes” to a term deposit, making campaigns more efficient.  


<p> &nbsp;</p>  


