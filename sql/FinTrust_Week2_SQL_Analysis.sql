/* =========================================================
   FINTRUST BANKING ANALYTICS
   WEEK 2 - SQL BUSINESS ANALYSIS
   AnalystLab Africa
   ========================================================= */
/* =========================================================
   DATA PREPARATION NOTE
   =========================================================

   Transaction_DateTime was imported from the cleaned CSV as
   text in M/D/YYYY H:MM format.

   All 12,000 values were successfully converted to MySQL
   DATETIME format after confirming zero conversion failures.

   Final transaction period:
   2026-01-01 00:00:00 to 2026-03-31 23:59:00.
*/

USE fintrust_analytics;
/* =========================================================
   BUSINESS QUESTION 1: OVERALL CUSTOMER & TRANSACTION ACTIVITY
   =========================================================

   Business Question:
   How many customers and transactions are represented in the
   FinTrust dataset, and what are the overall and average
   transaction values?
*/

SELECT
    (SELECT COUNT(*)
     FROM fintrust_customer) AS total_customers,
    COUNT(*) AS total_transactions,
    ROUND(SUM(Amount_NGN), 2) AS total_transaction_value_NGN,
    ROUND(AVG(Amount_NGN), 2) AS average_transaction_value_NGN
FROM fintrust_transaction;

/*
Result:
- Total Customers: 1,500
- Total Transactions: 12,000
- Total Transaction Value: NGN 560,477,354.85
- Average Transaction Value: NGN 46,706.45

Business Interpretation:
The dataset represents 1,500 customers who generated 12,000
transactions with a combined value of approximately NGN 560.48 million.
The average transaction value is NGN 46,706.45.

This provides FinTrust with a baseline view of the scale and monetary
value of transaction activity represented in the dataset. These metrics
can be used as reference points when comparing customer segments,
transaction types, channels and other areas of the business.
*/
/* =========================================================
   BUSINESS QUESTION 2: TRANSACTION TYPE ANALYSIS
   =========================================================

   Business Question:
   Which transaction types generate the highest transaction
   volume and transaction value?
*/

SELECT
    Transaction_Type,
    COUNT(*) AS transaction_count,
    ROUND(SUM(Amount_NGN), 2) AS total_transaction_value_NGN,
    ROUND(AVG(Amount_NGN), 2) AS average_transaction_value_NGN,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM fintrust_transaction),
        2
    ) AS percentage_of_transactions
FROM fintrust_transaction
GROUP BY Transaction_Type
ORDER BY total_transaction_value_NGN DESC;

/*
Result:
- Transfer: 3,549 transactions (29.58%), NGN 237,916,700.41 total value,
  NGN 67,037.67 average value.
- Deposit: 1,328 transactions (11.07%), NGN 130,985,059.85 total value,
  NGN 98,633.33 average value.
- Card Purchase: 3,033 transactions (25.28%), NGN 85,863,413.78 total value,
  NGN 28,309.73 average value.
- Cash Withdrawal: 1,430 transactions (11.92%), NGN 67,772,362.11 total value,
  NGN 47,393.26 average value.
- Bill Payment: 1,475 transactions (12.29%), NGN 28,163,647.51 total value,
  NGN 19,094.00 average value.
- Airtime/Data: 1,185 transactions (9.88%), NGN 9,776,171.19 total value,
  NGN 8,249.93 average value.

Business Interpretation:
Transfers are the largest transaction category in both frequency and
total monetary value, accounting for 29.58% of transactions and
approximately NGN 237.92 million in value. This indicates that transfers
are a major component of customer transaction activity in the dataset.

Deposits account for only 11.07% of transaction volume but have the
highest average transaction value at NGN 98,633.33. This indicates that
deposit transactions tend to involve substantially larger amounts than
the other transaction types.

Card purchases are also frequently used, representing 25.28% of all
transactions, but their average value is considerably lower than
transfers and deposits. FinTrust can therefore distinguish between
high-frequency transaction activities and transaction types associated
with larger monetary values when evaluating customer behaviour.
*/
/* =========================================================
   BUSINESS QUESTION 3: TRANSACTION CHANNEL ANALYSIS
   =========================================================

   Business Question:
   Which transaction channels are used most frequently, and
   which channels process the highest transaction value?
*/

SELECT
    Channel,
    COUNT(*) AS transaction_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM fintrust_transaction),
        2
    ) AS percentage_of_transactions,
    ROUND(SUM(Amount_NGN), 2) AS total_transaction_value_NGN,
    ROUND(AVG(Amount_NGN), 2) AS average_transaction_value_NGN
FROM fintrust_transaction
GROUP BY Channel
ORDER BY transaction_count DESC;

/*
Result:
- Mobile App: 5,102 transactions (42.52%), NGN 240,104,365.19
  total value and NGN 47,060.83 average value.
- POS: 2,393 transactions (19.94%), NGN 104,346,681.23
  total value and NGN 43,604.96 average value.
- Web: 1,869 transactions (15.58%), NGN 89,324,999.94
  total value and NGN 47,792.94 average value.
- ATM: 1,747 transactions (14.56%), NGN 83,942,354.23
  total value and NGN 48,049.43 average value.
- USSD: 889 transactions (7.41%), NGN 42,758,954.26
  total value and NGN 48,097.81 average value.

Business Interpretation:
The Mobile App is the dominant transaction channel in the dataset,
accounting for 42.52% of all transactions and approximately
NGN 240.10 million in transaction value. This indicates substantial
customer usage of the mobile channel.

The average transaction values across the five channels are relatively
similar compared with the large differences in transaction counts.
Therefore, the Mobile App's leading total transaction value is primarily
associated with its much higher transaction volume rather than a much
higher average transaction size.

USSD has the lowest transaction volume at 7.41%, although its average
transaction value is slightly higher than the other channels. This
suggests that lower usage frequency does not necessarily correspond to
lower-value individual transactions.
*/
/* =========================================================
   BUSINESS QUESTION 4: TRANSACTION STATUS ANALYSIS
   =========================================================

   Business Question:
   What proportion of transactions are successful, failed,
   pending or reversed, and what is the overall transaction
   success rate?
*/

SELECT
    Transaction_Status,
    COUNT(*) AS transaction_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM fintrust_transaction),
        2
    ) AS percentage_of_transactions,
    ROUND(SUM(Amount_NGN), 2) AS total_transaction_value_NGN
FROM fintrust_transaction
GROUP BY Transaction_Status
ORDER BY transaction_count DESC;

/*
Result:
- Successful: 10,856 transactions (90.47%),
  NGN 510,807,441.46 in transaction value.
- Failed: 630 transactions (5.25%),
  NGN 24,825,751.10 in transaction value.
- Reversed: 326 transactions (2.72%),
  NGN 15,626,118.26 in transaction value.
- Pending: 188 transactions (1.57%),
  NGN 9,218,044.03 in transaction value.

Business Interpretation:
Successful transactions account for 90.47% of the 12,000 transactions
in the dataset, making successful transactions the dominant outcome.

The remaining 9.53% consist of failed, reversed and pending transactions.
Failed transactions form the largest non-successful category, with
630 transactions representing 5.25% of total transaction activity.

For FinTrust, these results provide a baseline for monitoring transaction
outcomes. The non-successful categories can be investigated further to
understand their causes, affected channels or transaction types and
whether particular customer groups experience them more frequently.
*/
/* =========================================================
   BUSINESS QUESTION 5: CUSTOMER SEGMENT ANALYSIS
   =========================================================

   Business Question:
   Which customer segments generate the most transaction
   activity and transaction value?
*/

SELECT
    c.Customer_Segment,
    COUNT(DISTINCT c.Customer_ID) AS customers,
    COUNT(t.Transaction_ID) AS transaction_count,
    ROUND(SUM(t.Amount_NGN), 2) AS total_transaction_value_NGN,
    ROUND(AVG(t.Amount_NGN), 2) AS average_transaction_value_NGN,
    ROUND(
        COUNT(t.Transaction_ID) * 1.0 /
        COUNT(DISTINCT c.Customer_ID),
        2
    ) AS transactions_per_customer
FROM fintrust_customer c
JOIN fintrust_transaction t
    ON c.Customer_ID = t.Customer_ID
GROUP BY c.Customer_Segment
ORDER BY total_transaction_value_NGN DESC;

/*
Result:
- Everyday: 711 customers, 5,644 transactions,
  NGN 261,458,920.99 total value, NGN 46,325.11 average value,
  and 7.94 transactions per customer.

- Premium: 295 customers, 2,361 transactions,
  NGN 107,751,195.82 total value, NGN 45,637.95 average value,
  and 8.00 transactions per customer.

- Student: 278 customers, 2,289 transactions,
  NGN 107,475,866.33 total value, NGN 46,953.20 average value,
  and 8.23 transactions per customer.

- SME: 216 customers, 1,706 transactions,
  NGN 83,791,371.71 total value, NGN 49,115.69 average value,
  and 7.90 transactions per customer.

Business Interpretation:
Everyday customers generate the largest total transaction volume and
value, with 5,644 transactions worth approximately NGN 261.46 million.
However, Everyday is also the largest customer segment, containing
711 of the 1,500 customers.

When transaction activity is considered on a per-customer basis, the
four segments are relatively close. Student customers recorded the
highest transaction frequency at 8.23 transactions per customer,
while SME customers recorded the highest average transaction value
at NGN 49,115.69.

This distinction helps FinTrust avoid interpreting total activity
without considering segment size. Segment-level totals and per-customer
behaviour provide complementary views of customer activity.
*/
/* =========================================================
   BUSINESS QUESTION 6: ACCOUNT TYPE & CUSTOMER BEHAVIOUR
   =========================================================

   Business Question:
   How does transaction activity and value differ across
   account types?
*/

SELECT
    c.Account_Type,
    COUNT(DISTINCT c.Customer_ID) AS customers,
    COUNT(t.Transaction_ID) AS transaction_count,
    ROUND(
        COUNT(t.Transaction_ID) * 1.0 /
        COUNT(DISTINCT c.Customer_ID),
        2
    ) AS transactions_per_customer,
    ROUND(SUM(t.Amount_NGN), 2) AS total_transaction_value_NGN,
    ROUND(AVG(t.Amount_NGN), 2) AS average_transaction_value_NGN
FROM fintrust_customer c
JOIN fintrust_transaction t
    ON c.Customer_ID = t.Customer_ID
GROUP BY c.Account_Type
ORDER BY total_transaction_value_NGN DESC;

/*
Result:
- Savings: 893 customers, 7,149 transactions, 8.01 transactions
  per customer, NGN 335,589,490.85 total value and
  NGN 46,942.16 average transaction value.

- Current: 378 customers, 3,023 transactions, 8.00 transactions
  per customer, NGN 143,438,941.34 total value and
  NGN 47,449.20 average transaction value.

- Premium: 229 customers, 1,828 transactions, 7.98 transactions
  per customer, NGN 81,448,922.66 total value and
  NGN 44,556.30 average transaction value.

Business Interpretation:
Savings accounts account for the largest transaction volume and total
value in the dataset, with 7,149 transactions worth approximately
NGN 335.59 million. However, Savings is also the largest account group,
with 893 customers.

After adjusting for the number of customers, transaction frequency is
very similar across all three account types, ranging from 7.98 to 8.01
transactions per customer.

Current accounts recorded the highest average transaction value at
NGN 47,449.20, although the differences in average value across account
types are relatively modest. This suggests that the large differences
in total transaction activity are mainly associated with the number of
customers in each account type rather than major differences in
transaction frequency per customer.
*/
/* =========================================================
   BUSINESS QUESTION 7: INTERNATIONAL TRANSACTION ANALYSIS
   =========================================================

   Business Question:
   What proportion of transactions are international, and how
   do their transaction values compare with domestic transactions?
*/

SELECT
    International_Transaction,
    COUNT(*) AS transaction_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM fintrust_transaction),
        2
    ) AS percentage_of_transactions,
    ROUND(SUM(Amount_NGN), 2) AS total_transaction_value_NGN,
    ROUND(AVG(Amount_NGN), 2) AS average_transaction_value_NGN
FROM fintrust_transaction
GROUP BY International_Transaction
ORDER BY transaction_count DESC;

/*
Result:
- Domestic transactions: 11,520 transactions (96.00%),
  NGN 540,481,570.98 total value and NGN 46,916.80
  average transaction value.

- International transactions: 480 transactions (4.00%),
  NGN 19,995,783.87 total value and NGN 41,657.88
  average transaction value.

Business Interpretation:
Domestic transactions dominate the dataset, representing 96% of all
transaction activity, while international transactions account for
only 4%.

International transactions also have a lower average transaction value
of NGN 41,657.88 compared with NGN 46,916.80 for domestic transactions.

This indicates that international activity represents a relatively
small share of both transaction frequency and monetary activity in
the dataset. FinTrust can use this as a baseline when examining the
behaviour and risk characteristics of international transactions.
*/
/* =========================================================
   BUSINESS QUESTION 8: RISK REVIEW BY TRANSACTION TYPE
   =========================================================

   Business Question:
   Which transaction types have the highest risk-review rates?
*/

SELECT
    Transaction_Type,
    COUNT(*) AS total_transactions,
    SUM(CASE
        WHEN Risk_Review_Flag = 'Yes' THEN 1
        ELSE 0
    END) AS risk_reviewed_transactions,
    ROUND(
        SUM(CASE
            WHEN Risk_Review_Flag = 'Yes' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS risk_review_rate_percent
FROM fintrust_transaction
GROUP BY Transaction_Type
ORDER BY risk_review_rate_percent DESC;

/*
Result:
- Transfer: 1,011 of 3,549 transactions reviewed (28.49%).
- Cash Withdrawal: 362 of 1,430 transactions reviewed (25.31%).
- Deposit: 215 of 1,328 transactions reviewed (16.19%).
- Airtime/Data: 180 of 1,185 transactions reviewed (15.19%).
- Card Purchase: 395 of 3,033 transactions reviewed (13.02%).
- Bill Payment: 189 of 1,475 transactions reviewed (12.81%).

Business Interpretation:
Transfers have the highest risk-review rate at 28.49%, followed by
Cash Withdrawals at 25.31%. In contrast, Bill Payments have the lowest
risk-review rate at 12.81%.

Because these percentages are calculated within each transaction type,
they allow the categories to be compared despite differences in their
overall transaction volumes.

The results indicate that Transfers and Cash Withdrawals are more
frequently selected for risk review within this dataset. However,
a risk-review flag should not be interpreted as evidence of fraud.
It indicates that a transaction was selected for additional review.
FinTrust could investigate the factors associated with these higher
review rates to better understand its risk-review patterns.
*/
/* =========================================================
   BUSINESS QUESTION 9: RISK REVIEW BY TRANSACTION CHANNEL
   =========================================================

   Business Question:
   Which transaction channels have the highest risk-review rates?
*/

SELECT
    Channel,
    COUNT(*) AS total_transactions,
    SUM(CASE
        WHEN Risk_Review_Flag = 'Yes' THEN 1
        ELSE 0
    END) AS risk_reviewed_transactions,
    ROUND(
        SUM(CASE
            WHEN Risk_Review_Flag = 'Yes' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS risk_review_rate_percent
FROM fintrust_transaction
GROUP BY Channel
ORDER BY risk_review_rate_percent DESC;

/*
Result:
- Web: 399 of 1,869 transactions reviewed (21.35%).
- ATM: 370 of 1,747 transactions reviewed (21.18%).
- Mobile App: 990 of 5,102 transactions reviewed (19.40%).
- POS: 439 of 2,393 transactions reviewed (18.35%).
- USSD: 154 of 889 transactions reviewed (17.32%).

Business Interpretation:
Web transactions recorded the highest risk-review rate at 21.35%,
closely followed by ATM transactions at 21.18%. USSD recorded the
lowest risk-review rate at 17.32%.

Although the Mobile App produced the largest number of risk-reviewed
transactions (990), this reflects its much larger overall transaction
volume. Its risk-review rate was 19.40%.

This distinction shows why FinTrust should consider risk-review rates
alongside raw review counts when comparing channels. The results
indicate some variation in review patterns across channels, although
the risk-review flag alone does not indicate that a transaction was
fraudulent.
*/
/* =========================================================
   BUSINESS QUESTION 10: HIGH-VALUE CUSTOMER ACTIVITY
   =========================================================

   Business Question:
   Which customers generate the highest total transaction value,
   and what are their transaction patterns?
*/

SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.Customer_Segment,
    c.Account_Type,
    COUNT(t.Transaction_ID) AS transaction_count,
    ROUND(SUM(t.Amount_NGN), 2) AS total_transaction_value_NGN,
    ROUND(AVG(t.Amount_NGN), 2) AS average_transaction_value_NGN
FROM fintrust_customer c
JOIN fintrust_transaction t
    ON c.Customer_ID = t.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name,
    c.Customer_Segment,
    c.Account_Type
ORDER BY total_transaction_value_NGN DESC
LIMIT 10;

/*
Result:
The top three customers by total transaction value are:
- Ibrahim Mohammed: 10 transactions, NGN 1,713,942.51 total value,
  NGN 171,394.25 average value.
- Ada Garba: 18 transactions, NGN 1,713,516.28 total value,
  NGN 95,195.35 average value.
- Yusuf Ibrahim: 17 transactions, NGN 1,611,209.24 total value,
  NGN 94,777.01 average value.

Other customers in the top ten recorded total transaction values
between approximately NGN 1.32 million and NGN 1.52 million.

Business Interpretation:
High total transaction value is not necessarily driven by high
transaction frequency. For example, Ibrahim Mohammed recorded the
highest total transaction value with only 10 transactions because
his average transaction value was NGN 171,394.25. In comparison,
Ada Garba completed 18 transactions but had a lower average
transaction value of NGN 95,195.35.

The top-value customers also come from different customer segments
and account types. This suggests that high-value transaction activity
is not confined to one customer category in this dataset.

FinTrust can use both transaction frequency and monetary value when
identifying high-activity or high-value customer behaviour rather
than relying on transaction counts alone.
*/