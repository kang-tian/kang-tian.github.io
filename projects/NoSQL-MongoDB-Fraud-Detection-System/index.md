# Financial Fraud Detection System


**Project Overview**  
This project simulates a banking environment and demonstrates how to detect fraudulent transactions using **MongoDB** and **Node.js**. It identifies anomalies in transaction patterns, implements real-time alerts, and performs batch aggregations to pinpoint high-risk users. The project showcases **NoSQL expertise, event-driven architecture, and backend development skills**.
<p> &nbsp;</p>
**Link to Code:** [GitHub](https://github.com/kang-tian/NoSQL-MongoDB-Financial-Fraud-Detection-System)
<p> &nbsp;</p>

## **Project Objectives**
- Simulate realistic bank transaction data for analysis.
- Detect fraud patterns using rule-based and event-driven approaches.
- Implement real-time alerts for suspicious activity using MongoDB Change Streams.
- Perform aggregations to compute user behavior metrics and identify high-risk accounts.
- Build an end-to-end pipeline including ETL, transformation, and reporting.
<p> &nbsp;</p>



## **Skills Practiced**
- **MongoDB Advanced Queries & Aggregations:** Compute metrics like total transactions, average amounts, and high-risk patterns.
- **Data Transformation & Normalization:** Process raw transaction data for analysis and anomaly detection.
- **Event-Driven Architecture:** Implement real-time fraud alerts using **Change Streams**.
- **Node.js Scripting:** Automate ETL processes, batch migrations, and alerting pipelines.
- **Optional Advanced Tools:** Redis caching, Kafka streams, and anomaly detection models.
<p> &nbsp;</p>


## **Dataset**

## **Methodology**

### **1. Database Setup**
- MongoDB installed locally or via MongoDB Atlas.
- Database: `BankDataset`
- Collection: `Bank`
- Ensure replica set is enabled for **Change Streams** to support real-time alerting.
- Environment variables stored in `.env`:
<p align="center">
  <img src="/projects/NoSQL-MongoDB-Fraud-Detection-System/images/Picture1.png" alt="Reviews per Page" width="70%"/>
</p>

The system uses a synthetic dataset with bank data from Kaggle and simulated data with nearly 1.3 million records.
<p> &nbsp;</p>

### 2. **Data Simulation & Loading (`simulate.js`)**
- Generate realistic users and transactions using **Faker.js**.
- Transform simulated data to match dataset schema.
- Load into MongoDB using Node.js scripts.
- Bulk inserts improve performance for large datasets.
<p align="center">
  <img src="/projects/NoSQL-MongoDB-Fraud-Detection-System/images/Picture2.png" alt="Reviews per Page" width="70%"/>
</p>
<p> &nbsp;</p>


### 3. **Data Analysis &  Data Reporting**
#### 1. Transaction Summary
- Uses the `$group` aggregation stage to compute:
  - **Total transaction amount** (`$sum: "$amt"`)
  - **Average transaction amount** (`$avg: "$amt"`)
  - **Total number of transactions** (`$sum: 1`)
- MongoDB calculates these metrics on the server, so no extra memory is used in Node.js.

#### 2. Top Customers by Spending
- Groups transactions by `cc_num` (credit card number) using `$group`.
- Computes **total spending per customer** using `$sum: "$amt"`.
- Sorts customers in descending order with `$sort` and selects top 5 using `$limit`.
- This helps to quickly identify **high-value customers** for further monitoring.

#### 3. Suspicious Transaction Detection
- Uses a MongoDB query with `$or`:
  - `amt ≥ 5000`
  - `is_fraud = 1`
- Returns transactions that meet either condition, enabling detection of potential fraud.
<p align="center">
  <img src="/projects/NoSQL-MongoDB-Fraud-Detection-System/images/Picture7.png" alt="Reviews per Page" width="70%"/>
</p>
<p> &nbsp;</p>

### 4. Anomaly Detection (`detect.js`)**
- Rule-based fraud detection:
- Transactions exceeding thresholds.
- Rapid repeated transactions.
<p align="center">
  <img src="/projects/NoSQL-MongoDB-Fraud-Detection-System/images/Picture3.png" alt="Reviews per Page" width="70%"/>
</p>
<p align="center">
  <img src="/projects/NoSQL-MongoDB-Fraud-Detection-System/images/Picture4.png" alt="Reviews per Page" width="70%"/>
</p>
<p> &nbsp;</p>


### 5. **Real-Time Alerts (`alerts.js`)**
- Monitor the `Bank` collection for new transactions using **Change Streams**.
- Automatically flag suspicious transactions and write to `alerts` collection.
- Alerts contain:
- Transaction ID
- User details
- Reason for flag (e.g., high amount, unusual frequency)
- Note: Requires MongoDB replica set or MongoDB Atlas to work.
<p align="center">
  <img src="/projects/NoSQL-MongoDB-Fraud-Detection-System/images/Picture5.png" alt="Reviews per Page" width="70%"/>
</p>
<p align="center">
  <img src="/projects/NoSQL-MongoDB-Fraud-Detection-System/images/Picture6.png" alt="Reviews per Page" width="70%"/>
</p>
<p> &nbsp;</p>




### 6. **Other Advanced Features**
- **Redis**: Cache frequent queries using Redis to reduce repeated computation and speed up analytics queries like top customers or total spending.
- **Machine Learning**: Interacting with Python. Build anomaly detection models (Isolation Forest, XGBoost) and store predictions in MongoDB.

<p> &nbsp;</p>

### 7. Conclusion
This project demonstrates the application of NoSQL databases, particularly MongoDB, in addressing the challenges of fraud detection and analytics in financial systems. Traditional relational databases often struggle with scalability, flexibility, and handling semi-structured or high-volume streaming data. By leveraging MongoDB’s document-oriented design, the system can efficiently store and query complex transactional data, enabling faster fraud detection and more comprehensive analysis.
  






