# Full-Stack Web Development 
## VisualBudget: Interactive Web Application for Income & Spending Visualization Automatically

**Note:** 
- This is a group project completed with two team members, **Jihee Seo** and **Yuanyuan Xi**.  
- My responsibilities included **idea generation (project design)** and **front-end development** (HTML pages, CSS, and part of JavaScript).
- For more details, please check the project repository on [GitHub](https://github.com/kang-tian/Full-Stack-Web-Development-Website-for-visualizing-financial-data-automatically).

<p> &nbsp;</p>  


## 1. Introduction

**Project Description:**  
VisualBudget is a web application that allows users to monitor and visualize their income and spending by category. Users can create an account to enter their income and spending data manually. The application automatically generates dashboards displaying financial situations using pie charts and bar charts, broken down by category for both income and spending.
<p> &nbsp;</p>  

**Purpose:**  
- Help users gain clear insights into their financial habits.  
- Encourage budgeting, investment tracking, and long-term financial planning.
- Facilitate the Visualization of the income and spending.
<p> &nbsp;</p>  

**Technical Implementation (Proposed):**  
- **Frontend:** HTML, CSS, JavaScript  
- **Backend:** PHP with a MariaDB database  
- **Hosting:** Local testing with XAMPP  
- **Data Visualization:** Chart.js  
<p> &nbsp;</p>  

## 2. Page Overview

### (1) Index Page
- Provides an introduction to VisualBudget.  
- “Get Started” button allows the user to begin using the application.
<p align="center">
  <img src="/projects/Full-Stack-Interactive-Web-Application-for-Finance-Visualization/images/Picture1.png" alt="Reviews per Page" width="70%"/>
</p>
<p> &nbsp;</p>  

### (2) Login Page
- Users log in using their email and password.  
- If they don’t have an account, they can navigate to the Sign-Up page.
<p align="center">
  <img src="/projects/Full-Stack-Interactive-Web-Application-for-Finance-Visualization/images/Picture2.png" alt="Reviews per Page" width="70%"/>
</p>
<p> &nbsp;</p>  

### (3) Sign-Up Page
- New users can create an account by entering personal information.  
- After registration, users log in using email and password.
<p align="center">
  <img src="/projects/Full-Stack-Interactive-Web-Application-for-Finance-Visualization/images/Picture3.png" alt="Reviews per Page" width="70%"/>
</p>
<p> &nbsp;</p>  

### (4) Data Input Page
- Users can enter financial data by clicking **Add Income** or **Add Spending**.  
- Date can be adjusted for each entry.  
- **Data Fields:**
  - Category (required)  
  - Amount (required)  
  - Note (optional)  
- **Validation:**
  - Warning shown if user leaves page without submitting.  
  - Required fields must be filled; otherwise, warning is displayed.  
  - Confirmation message displayed after successful submission.  
- **Navigation Options:**
  - View History Records – review and edit past entries.  
  - View Dashboard – visualize the data.
<p align="center">
  <img src="/projects/Full-Stack-Interactive-Web-Application-for-Finance-Visualization/images/Picture4.png" alt="Reviews per Page" width="70%"/>
</p>
<p> &nbsp;</p>  

### (5) History Page
- Accessible via **View History Records** from Data Input page.  
- Allows searching transactions using keywords.  
- Filter records by category.  
- Edit or delete existing records.  
- **Navigation Options:**
  - Insert New Data – return to Data Input page.  
  - View Dashboard – navigate to Dashboard page.
<p align="center">
  <img src="/projects/Full-Stack-Interactive-Web-Application-for-Finance-Visualization/images/Picture5.png" alt="Reviews per Page" width="70%"/>
</p>
<p> &nbsp;</p>  

### (6) Dashboard Page
- Displays financial data visually:  
  - Pie charts – spending and income distribution by category.  
  - Bar charts – amounts over time.  
- Users can select a time range to filter displayed data.

<p align="center">
  <img src="/projects/Full-Stack-Interactive-Web-Application-for-Finance-Visualization/images/Picture6.png" alt="Reviews per Page" width="70%"/>
</p>
<p> &nbsp;</p>  


## 3. Data Flow
<p align="center">
  <img src="/projects/Full-Stack-Interactive-Web-Application-for-Finance-Visualization/images/Picture8.png" alt="Reviews per Page" width="70%"/>
</p>
<p align="center">
  <img src="/projects/Full-Stack-Interactive-Web-Application-for-Finance-Visualization/images/Picture7.png" alt="Reviews per Page" width="70%"/>
</p>
<p> &nbsp;</p>  


