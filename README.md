# 💰 Personal Finance Tracker | SQL + Excel + Power BI

This project is a complete personal finance analysis solution built using SQL, Excel, and Power BI to track income, expenses, budget variance, and savings trends over a six-month period. It consolidates and cleanses over 460 real-world transactions from credit, debit, and Splitwise sources—including the removal of duplicate Splitwise records—to create structured datasets for analysis.

By transforming raw financial data into actionable insights through SQL queries and interactive dashboards, this system enabled smarter budgeting decisions and led to a 78% improvement in monthly savings.

</br>
</br>
</br>


## 🔍 Project Overview

🔄 **Data Sources:** Credit card, debit card, and Splitwise exports.

🧹 **Data Cleaning:** Performed in Excel with structured formatting.

🧠 **SQL Analysis:** 11+ SQL queries uncovering trends, category-wise spend, savings, merchant insights, and more.

📊 **Dashboard:** Interactive Power BI visuals to track budgets, spending trends, and improve financial planning.

</br>
</br>
</br>

## 🧹 Data Cleaning Highlights

Cleaning the raw financial data was a critical step in ensuring accurate, insightful analysis. Here's how the data was transformed into a structured and reliable dataset:

✅ **Consolidated 460+ transactions** from credit card, debit card, and Splitwise exports into a unified format.

🔁 **Removed duplicate records** from Splitwise data to prevent inflation of shared expenses and ensure accuracy.

🔄 **Standardized column names and formats** across all sources for seamless integration (e.g., consistent date, amount, and category fields).

🗂️ **Classified all transactions** into 7+ spending categories such as Food, Grocery, Transportation, Utilities, etc.

📅 **Normalized date formats** and created a clean “Month-Year” field to support monthly trend analysis.

🔢 **Converted text-based numeric fields** into proper decimal values for reliable aggregation and calculations.

🧾 **Distinguished income and expenses** by transaction type to enable net savings and variance calculations.

🧪 Validated data consistency and completeness across sources before proceeding to analysis and dashboard creation.

This robust cleaning process ensured the data foundation was reliable, enabling impactful insights and accurate decision-making in the subsequent SQL and Power BI analysis.

</br>
</br>
</br>

## 📈 Sample SQL Insights

💸 **Top 5 Spending Categories**

🚗 **Transportation Expenses Over Time**

🛒 **Monthly Grocery Spend**

💰 **Net Monthly Savings**

📆 **Cumulative Spending Trends**


-- Sample: Monthly Net Savings

       SELECT Month, 
       
              ROUND(SUM(income),2) AS Total_income, 
              
              ROUND(SUM(expense),2) AS Total_spent, 
              
              ROUND(SUM(income - expense),2) AS Net_savings
              
       FROM (
       
         SELECT Month_year AS Month, amount_credit AS income, 0 AS expense
         
         FROM debitcarddata WHERE Transaction_type = 'income'
         
         UNION ALL
         
         SELECT Month_year AS Month, 0 AS income, amount_debit AS expense
         
         FROM creditcarddata WHERE Transaction_type = 'expense'
         
       ) summary
       
       GROUP BY Month
       
       ORDER BY STR_TO_DATE(Month, '%b-%Y');


</br>
</br>
</br>

## 📊 PowerBI Dashboard Snapshots

### 1. Savings vs Spending Behavior Dashboard

   Tracking budget adherence and highlighting the gap between potential and actual savings.


![image](https://github.com/user-attachments/assets/ac589ec4-1659-4023-b60e-2011abfcca4e)



### 2. Spending & Shared Contribution Dashboard


Visualizes shared expenses (via Splitwise), personal contributions, and category-wise breakdown.


![image](https://github.com/user-attachments/assets/95a47d0b-5071-4a9d-8ad4-5564d13360b9)


</br>
</br>
</br>

## ⚙️ Tools Used

**Excel:** Data formatting, transaction tagging, and pivot tables

**SQL (MySQL syntax):** Data cleaning, aggregation, insights

**Power BI:** KPIs, trend analysis, budget vs actual variance, contribution breakdown

</br>
</br>
</br>

## 🚀 Impact & Outcome

This project delivered measurable results by transforming raw financial data into clear, actionable insights:

📉 **Reduced manual effort** by **65%** through automated Excel reports and SQL-based insights.

💡 **Enabled smarter budgeting decisions** by identifying over-budget categories, tracking shared expenses, and uncovering hidden spending patterns.

📊 **Empowered data-driven financial planning** through dynamic Power BI dashboards that visualize trends, budget variance, and savings potential.

💰 **Achieved a 78% increase in monthly savings** over six months by tracking income vs. expenses and adjusting spending habits accordingly.

✅ Demonstrated end-to-end proficiency in **data cleaning, analysis, and visualization**—a complete showcase of applied Business Analyst skills.


