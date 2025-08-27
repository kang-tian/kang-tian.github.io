---
title: "NLP Project: Review Sentiment Analysis for BestBuy"
---

# NLP Project: Review Sentiment Analysis for BestBuy

Customer reviews provide **valuable insights** into a company’s products and services. This project performs a **comprehensive sentiment analysis** on *BestBuy* reviews collected from **Trustpilot**, integrating **data collection, storage, cleaning, sentiment modeling, aspect-based analysis, topic modeling, and sentiment trend visualization**. The goal is to extract actionable insights for business improvement.

---

## 📌 Project Workflow and Importance

Understanding customer sentiment is crucial for **improving service quality and customer satisfaction**. The workflow includes:

1. **Data Collection** – Fetch reviews from Trustpilot, handling multiple pages efficiently.  
2. **Data Storage** – Store all reviews in **MongoDB** for persistent access.  
3. **Data Cleaning** – Preprocess text to remove noise and bias.  
4. **Sentiment Analysis** – Apply multiple models and evaluate performance.  
5. **Aspect-Based Sentiment Analysis (ABSA)** – Extract sentiment per service aspect.  
6. **Topic Modeling & Clustering** – Identify hidden themes in reviews.  
7. **Sentiment Trends Over Time** – Visualize changes in sentiment.

This workflow ensures a **comprehensive understanding of customer feedback**, helping businesses identify key issues and make **data-driven decisions**.

---

## 1️⃣ Data Collection

Reviews were collected from Trustpilot with a loop handling multiple pages. Each review is stored immediately in **MongoDB** to ensure **complete dataset coverage**.

**Graph 1 – Reviews per Page:**  
<p align="center">
  <img src="link-to-graph1" alt="Reviews per Page" width="600"/>
</p>

---

## 2️⃣ Data Storage and Access

All reviews are stored in **MongoDB**, which enables easy querying and analysis in Jupyter Notebook or other tools. This ensures the dataset is **structured and ready** for downstream NLP tasks.

**Graph 2 – Data in MongoDB:**  
<p align="center">
  <img src="link-to-graph2" alt="Data in MongoDB" width="600"/>
</p>

---

## 3️⃣ Data Cleaning

Text preprocessing prepares the reviews for accurate sentiment analysis:

- Convert all text to **lowercase**.  
- Replace mentions of "BestBuy" with a neutral placeholder (**COMPANY**) to **avoid bias**.  
- Remove **punctuation** and irrelevant characters.  
- Filter out **stopwords** to retain meaningful words.

This ensures the sentiment analysis focuses on the **actual content of customer feedback**.

---

## 4️⃣ Sentiment Analysis

Three models were used:

- **TextBlob** – rule-based model.  
- **DistilBERT SST-2** – transformer-based classifier.  
- **Multilingual BERT** – the most accurate model.

**Performance of Multilingual BERT:**  

| Metric      | Score  |
|------------|--------|
| **Accuracy**   | 92%    |
| **Precision**  | 0.62   |
| **Recall**     | 0.53   |
| **F1-score**   | 0.52   |

**Explanation of Metrics:**  
- **Accuracy:** Proportion of correct predictions.  
- **Precision:** Fraction of predicted positives that are correct.  
- **Recall:** Fraction of actual positives correctly identified.  
- **F1-score:** Harmonic mean of precision and recall.

**Graph 3 – Sentiment Distribution:**  
<p align="center">
  <img src="link-to-graph3" alt="Sentiment Distribution" width="600"/>
</p>

---

## 5️⃣ Aspect-Based Sentiment Analysis (ABSA)

ABSA focuses on **key service aspects** such as **delivery, price, quality, and service**. Each aspect is analyzed for sentiment based on keywords.

**Graph 4 – Aspect Sentiment Comparison:**  
<p align="center">
  <img src="link-to-graph4" alt="Aspect Sentiment Comparison" width="600"/>
</p>

**Graph 5 – Word Clouds per Aspect:**  
<p align="center">
  <img src="link-to-graph5" alt="Word Clouds per Aspect" width="600"/>
</p>

---

## 6️⃣ Topic Modeling & Clustering

Topic modeling uncovers **hidden themes** in customer reviews and helps identify **recurring patterns** and common concerns.

**Graph 6 – Topic Modeling:**  
<p align="center">
  <img src="link-to-graph6" alt="Topic Modeling" width="600"/>
</p>

---

## 7️⃣ Sentiment Trends Over Time

Analyzing sentiment trends provides insights into **changes in customer perception** over time. This helps monitor improvements or declines in service quality.

**Graph 7 – Sentiment Trends Over Time:**  
<p align="center">
  <img src="link-to-graph7" alt="Sentiment Trends" width="600"/>
</p>

---

## ✅ Conclusion

This project highlights the **power of NLP** in extracting actionable insights from customer reviews:

- Identifies **strengths and weaknesses** in BestBuy services.  
- Provides **detailed sentiment per aspect** of the service.  
- Tracks **trends in customer sentiment** over time.  

**Important Note:** Reviews on Trustpilot tend to be biased toward negative experiences, as customers with complaints are more likely to leave feedback. While not fully representative, the dataset provides **valuable insights into key service issues**.

---

## References

- [Trustpilot](https://www.trustpilot.com/) – Customer review platform  
- Python packages: Selenium, MongoDB, NLP libraries (TextBlob, Transformers, NLTK)
