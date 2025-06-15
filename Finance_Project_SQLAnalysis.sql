CREATE DATABASE personal_finance;

USE personal_finance;
SHOW Tables;
DESCRIBE creditcarddata;
DESCRIBE debitcarddata;
ALTER TABLE creditcarddata
CHANGE COLUMN `Amount Debits` `amount_debit` TEXT; 
ALTER TABLE creditcarddata
CHANGE COLUMN `Amount Credits` `amount_credit` TEXT;
ALTER TABLE creditcarddata
CHANGE COLUMN `Transaction Type` `Transaction_type` TEXT; 
ALTER TABLE creditcarddata
CHANGE COLUMN `Month Year` `Month_Year` TEXT;
ALTER TABLE creditcarddata
CHANGE COLUMN `ï»¿Date` `Date` TEXT;

ALTER TABLE debitcarddata
CHANGE COLUMN `Amount Debits` `amount_debit` TEXT; 
ALTER TABLE debitcarddata
CHANGE COLUMN `Amount Credited` `amount_credit` TEXT;
ALTER TABLE debitcarddata
CHANGE COLUMN `Transaction Type` `Transaction_type` TEXT; 
ALTER TABLE debitcarddata
CHANGE COLUMN `Month-Year` `Month_Year` TEXT;
ALTER TABLE debitcarddata
CHANGE COLUMN `ï»¿Date` `Date` TEXT;

#Total Spent on Grocery Monthwise
SELECT Month_Year,ROUND(SUM(Amount_debit),2) AS Total_Spent
FROM creditcarddata
WHERE Transaction_type="expense" AND category="Grocery"
GROUP BY category,Month_Year
UNION ALL
SELECT Month_Year,ROUND(SUM(Amount_debit),2) AS Total_Spent
FROM debitcarddata
WHERE Transaction_type="expense" AND category="Grocery"
GROUP BY category,Month_Year
ORDER BY Month_year

#Total Spent On Transportation Monthwise
SELECT Month_Year,ROUND(SUM(Amount_debit),2) AS Total_Spent
FROM creditcarddata
WHERE Transaction_type="expense" AND category="Transportation"
GROUP BY category,Month_Year
UNION ALL
SELECT Month_Year,ROUND(SUM(Amount_debit),2) AS Total_Spent
FROM debitcarddata
WHERE Transaction_type="expense" AND category="Transportation"
GROUP BY category,Month_Year
ORDER BY Month_year

#Month having Highest spent amount(Creditcard)
SELECT Month_year, ROUND(SUM(amount_debit),2) AS Total_spent
FROM creditcarddata
WHERE Transaction_type="expense"
GROUP BY Month_year
ORDER BY Total_spent DESC
LIMIT 1

#Month having Highest spent amount(Debitcard)
SELECT Month_year,ROUND(SUM(amount_debit),2) AS Total_spent
FROM debitcarddata
WHERE transaction_type="expense"
GROUP BY Month_year
ORDER BY Total_spent DESC
LIMIT 1

#Average Spent per Category(Creditcard)
SELECT category, ROUND(AVG(amount_debit),2) AS Avg_spent_per_category
FROM creditcarddata
WHERE Transaction_type="expense"
GROUP BY category
ORDER BY Avg_spent_per_category DESC

#Average Spent per Category (Debitcard)
SELECT category, ROUND(AVG(amount_debit),2) AS Avg_spent_per_category
FROM debitcarddata
WHERE Transaction_type="expense"
GROUP BY category
ORDER BY Avg_spent_per_category DESC

#Total spending per Category
SELECT category, ROUND(SUM(amount),2) AS total_spent
FROM (
SELECT category, amount_debit AS amount FROM creditcarddata WHERE Transaction_type="expense"
UNION ALL
SELECT category,amount_debit AS amount FROM debitcarddata WHERE Transaction_type="expense") combined
GROUP BY category
ORDER BY total_spent DESC


#Monthly Spending Trend
SELECT Month, ROUND(SUM(amount),2) AS monthly_spent
FROM(
SELECT Month_year AS Month, amount_debit AS amount FROM creditcarddata WHERE Transaction_type = 'expense'
UNION ALL
SELECT Month_year AS Month, amount_debit AS amount FROM debitcarddata WHERE Transaction_type = 'expense')combined
GROUP BY Month
ORDER BY STR_TO_DATE(Month, '%b-%Y');


#Top 5 Merchants by Spending
SELECT Merchant, ROUND(SUM(amount_debit),2) AS Total_spent
FROM(
SELECT Merchant, amount_debit FROM creditcarddata WHERE Transaction_type = 'expense'
UNION ALL
SELECT Merchant, amount_debit FROM debitcarddata WHERE Transaction_type = 'expense') all_txn
GROUP BY Merchant
ORDER BY Total_spent DESC
LIMIT 5;


#Total Income Per Month
SELECT Month_year AS Month, ROUND(SUM(amount_credit),2) AS Total_income
FROM debitcarddata
WHERE Transaction_type = 'income'
GROUP BY Month
ORDER BY STR_TO_DATE(Month, '%b-%Y');


#Net Savings per Month
SELECT Month, ROUND(SUM(income),2) AS Total_income, ROUND(SUM(expense),2) AS Total_spent, ROUND(SUM(income - expense),2) AS net_savings
FROM (
SELECT Month_year AS Month, amount_credit AS income, 0 AS expense
FROM debitcarddata
WHERE Transaction_type = 'income'
UNION ALL
SELECT Month_year AS Month, 0 AS income, amount_debit AS expense
FROM creditcarddata
WHERE Transaction_type = 'expense') summary
GROUP BY Month
ORDER BY STR_TO_DATE(Month, '%b-%Y');


#Cumulative Spending Over Time
SELECT Month, monthly_spent, SUM(monthly_spent) OVER (ORDER BY STR_TO_DATE(Month, '%b-%Y') ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_spent
FROM (
  SELECT Month_year AS Month,ROUND(SUM(CAST(amount_debit AS DECIMAL(10,2))), 2) AS monthly_spent
  FROM debitcarddata
  WHERE LOWER(Transaction_type) = 'expense'
  GROUP BY Month_year
) sub;


