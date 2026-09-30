-- =====================================================
-- ANALYSIS 1: CUSTOMER TRANSACTION BEHAVIOUR BY SEGMENT
-- =====================================================
SELECT
    c.Customer_Segment,
    COUNT(DISTINCT c.Customer_ID) AS Total_Customers,
    COUNT(t.Transaction_ID) AS Total_Transactions,
    ROUND(SUM(t.Amount_NGN), 2) AS Total_Transaction_Value_NGN,
    ROUND(AVG(t.Amount_NGN), 2) AS Average_Transaction_Value_NGN,
    ROUND(
        COUNT(t.Transaction_ID) / COUNT(DISTINCT c.Customer_ID),
        2
    ) AS Transactions_Per_Customer
FROM fintrust_customer c
JOIN fintrust_transaction t
    ON c.Customer_ID = t.Customer_ID
GROUP BY c.Customer_Segment
ORDER BY Total_Transaction_Value_NGN DESC;
/*
BUSINESS INTERPRETATION:

Everyday customers represent the largest customer segment, with 711
customers generating 5,644 transactions worth approximately NGN 261.46
million. This makes the Everyday segment the largest contributor to
overall transaction volume and value.

However, Student customers recorded the highest transaction frequency
per customer at 8.23 transactions, compared with Premium (8.00),
Everyday (7.94), and SME (7.90).

SME customers recorded the highest average transaction value at
approximately NGN 49,115.69 despite having the smallest customer
population and the lowest total number of transactions.

This indicates that segment size alone does not fully explain customer
transaction behaviour. Everyday customers drive overall activity because
of their larger population, while Student customers are slightly more
active per customer and SME customers transact at higher average values.
*/
-- =====================================================
-- ANALYSIS 2: TRANSACTION PERFORMANCE BY CHANNEL
-- =====================================================
SELECT
    Channel,
    COUNT(Transaction_ID) AS Total_Transactions,
    ROUND(SUM(Amount_NGN), 2) AS Total_Transaction_Value_NGN,
    ROUND(AVG(Amount_NGN), 2) AS Average_Transaction_Value_NGN,

    SUM(
        CASE
            WHEN Transaction_Status = 'Successful' THEN 1
            ELSE 0
        END
    ) AS Successful_Transactions,

    SUM(
        CASE
            WHEN Transaction_Status = 'Failed' THEN 1
            ELSE 0
        END
    ) AS Failed_Transactions,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN Transaction_Status = 'Successful' THEN 1
                ELSE 0
            END
        ) / COUNT(Transaction_ID),
        2
    ) AS Success_Rate_Percent

FROM fintrust_transaction
GROUP BY Channel
ORDER BY Total_Transaction_Value_NGN DESC;
/*
BUSINESS INTERPRETATION:

The Mobile App is the dominant transaction channel, processing 5,102
transactions worth approximately NGN 240.10 million. This confirms that
the Mobile App is FinTrust's most heavily used channel by both transaction
volume and total transaction value.

However, the Mobile App recorded the lowest success rate among the five
channels at 89.75%. ATM recorded the highest success rate at 91.70%,
while POS and Web both recorded 90.85%, and USSD recorded 90.33%.

USSD recorded the highest average transaction value at approximately
NGN 48,097.81, closely followed by ATM at NGN 48,049.43 and Web at
NGN 47,792.94.

The results show that channel performance differs depending on the metric.
Although the Mobile App leads strongly in usage and total transaction
value, its comparatively lower success rate suggests that transaction
outcomes on this high-volume channel should be examined more closely.
*/
-- =====================================================
-- ANALYSIS 3: MONTHLY TRANSACTION TREND AND GROWTH
-- =====================================================
WITH Monthly_Performance AS (
    SELECT
        DATE_FORMAT(Transaction_DateTime, '%Y-%m') AS Transaction_Month,
        COUNT(Transaction_ID) AS Total_Transactions,
        ROUND(SUM(Amount_NGN), 2) AS Total_Value_NGN,
        ROUND(AVG(Amount_NGN), 2) AS Average_Value_NGN
    FROM fintrust_transaction
    GROUP BY DATE_FORMAT(Transaction_DateTime, '%Y-%m')
),

Monthly_Comparison AS (
    SELECT
        Transaction_Month,
        Total_Transactions,
        Total_Value_NGN,
        Average_Value_NGN,
        LAG(Total_Transactions) OVER (
            ORDER BY Transaction_Month
        ) AS Previous_Month_Transactions,
        LAG(Total_Value_NGN) OVER (
            ORDER BY Transaction_Month
        ) AS Previous_Month_Value
    FROM Monthly_Performance
)

SELECT
    Transaction_Month,
    Total_Transactions,
    Total_Value_NGN,
    Average_Value_NGN,
    Previous_Month_Transactions,

    ROUND(
        100.0 * (Total_Transactions - Previous_Month_Transactions)
        / Previous_Month_Transactions,
        2
    ) AS Transaction_Count_Change_Percent,

    Previous_Month_Value,

    ROUND(
        100.0 * (Total_Value_NGN - Previous_Month_Value)
        / Previous_Month_Value,
        2
    ) AS Transaction_Value_Change_Percent

FROM Monthly_Comparison
ORDER BY Transaction_Month;
/*
BUSINESS INTERPRETATION:

Transaction activity declined from January to February before recovering
strongly in March.

January recorded 4,133 transactions worth approximately NGN 188.49
million. In February, transaction volume decreased by 9.65% to 3,734
transactions, while total transaction value decreased by 6.74% to
approximately NGN 175.79 million.

March recorded a strong recovery. Transaction volume increased by
10.69% from February to 4,133 transactions, while total transaction
value increased by 11.61% to approximately NGN 196.20 million.

Although January and March recorded the same number of transactions
(4,133), March generated approximately NGN 7.71 million more in total
transaction value. Average transaction value also increased from
NGN 45,605.96 in January to NGN 47,471.82 in March.

This indicates that the higher transaction value recorded in March was
not driven by a higher transaction count relative to January, but by
higher average transaction values.

The February decline should be interpreted cautiously because February
contains fewer calendar days than January and March. A daily-normalized
analysis would be required before concluding that customer activity
actually weakened during February.
*/
-- =====================================================
-- ANALYSIS 4: HIGH-VALUE TRANSACTION PATTERNS
-- =====================================================
WITH Overall_Average AS (
    SELECT
        AVG(Amount_NGN) AS Average_Transaction_Value
    FROM fintrust_transaction
),

High_Value_Transactions AS (
    SELECT
        t.Transaction_ID,
        t.Transaction_Type,
        t.Channel,
        t.Amount_NGN,
        t.Transaction_Status,
        t.Risk_Review_Flag
    FROM fintrust_transaction t
    CROSS JOIN Overall_Average a
    WHERE t.Amount_NGN > a.Average_Transaction_Value
)

SELECT
    Transaction_Type,
    COUNT(Transaction_ID) AS High_Value_Transaction_Count,
    ROUND(SUM(Amount_NGN), 2) AS High_Value_Total_NGN,
    ROUND(AVG(Amount_NGN), 2) AS High_Value_Average_NGN,

    SUM(
        CASE
            WHEN Transaction_Status = 'Successful' THEN 1
            ELSE 0
        END
    ) AS Successful_High_Value_Transactions,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN Risk_Review_Flag = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(Transaction_ID),
        2
    ) AS Risk_Review_Rate_Percent

FROM High_Value_Transactions
GROUP BY Transaction_Type
ORDER BY High_Value_Total_NGN DESC;
/*
BUSINESS INTERPRETATION:

Using transactions above the overall average transaction value as the
analytical definition of high-value activity, 3,071 transactions were
identified across the six transaction types.

Transfers dominate high-value activity, with 1,207 high-value
transactions worth approximately NGN 214.54 million. Their average
high-value transaction amount was approximately NGN 177,748.74.

Deposits recorded 522 high-value transactions worth approximately
NGN 121.69 million. Although Deposits had fewer high-value transactions
than Transfers, they recorded the highest average high-value transaction
amount at approximately NGN 233,124.49.

Transfers also recorded the highest risk-review rate among high-value
transactions at 32.64%, followed by Cash Withdrawals at 26.81% and
Deposits at 23.18%.

Airtime/Data recorded only 12 transactions above the overall average,
which is consistent with this transaction type generally involving
smaller monetary amounts.

Overall, the results show that high-value activity is concentrated
primarily in Transfers and Deposits. Transfers lead in both high-value
transaction count and total value, while Deposits involve the largest
average amounts among high-value transactions.

For this analysis, "high-value" is defined only as a transaction above
the dataset's overall average transaction value. It is an analytical
benchmark and should not be interpreted as an official FinTrust
high-value transaction threshold.
*/
-- =====================================================
-- ANALYSIS 5: CUSTOMER TRANSACTION VALUE RANKING
-- =====================================================
WITH Customer_Performance AS (
    SELECT
        c.Customer_ID,
        c.Customer_Name,
        c.Customer_Segment,
        COUNT(t.Transaction_ID) AS Total_Transactions,
        ROUND(SUM(t.Amount_NGN), 2) AS Total_Transaction_Value_NGN,
        ROUND(AVG(t.Amount_NGN), 2) AS Average_Transaction_Value_NGN
    FROM fintrust_customer c
    JOIN fintrust_transaction t
        ON c.Customer_ID = t.Customer_ID
    GROUP BY
        c.Customer_ID,
        c.Customer_Name,
        c.Customer_Segment
),

Ranked_Customers AS (
    SELECT
        *,
        DENSE_RANK() OVER (
            ORDER BY Total_Transaction_Value_NGN DESC
        ) AS Value_Rank
    FROM Customer_Performance
)

SELECT
    Value_Rank,
    Customer_ID,
    Customer_Name,
    Customer_Segment,
    Total_Transactions,
    Total_Transaction_Value_NGN,
    Average_Transaction_Value_NGN
FROM Ranked_Customers
WHERE Value_Rank <= 10
ORDER BY Value_Rank;
/*
BUSINESS INTERPRETATION:

The customer-level ranking shows that the highest total transaction
value was generated by FT-C01075, an Everyday customer, with 10
transactions worth approximately NGN 1.71 million and an average
transaction value of NGN 171,394.25.

FT-C00357 ranked second with approximately NGN 1.71 million across
18 transactions, while FT-C00816 ranked third with approximately
NGN 1.61 million across 17 transactions.

Six of the Top 10 customers by total transaction value belong to the
Everyday segment. The remaining Top 10 customers consist of two Premium
customers, one SME customer and one Student customer.

The results also demonstrate that high total transaction value can arise
from different transaction behaviours. For example, FT-C00357 generated
18 transactions with an average value of NGN 95,195.35, while the
highest-ranked customer generated only 10 transactions but had a much
higher average transaction value of NGN 171,394.25.

This indicates that customer value should not be assessed using
transaction frequency alone. Both transaction frequency and transaction
amount contribute to overall customer transaction value.

The ranking describes transaction activity within the available
January-March 2026 dataset and should not be interpreted as a measure
of customer profitability or lifetime value.
*/
-- =====================================================
-- ANALYSIS 6: RISK-REVIEW PATTERNS BY CUSTOMER SEGMENT
-- =====================================================
SELECT
    c.Customer_Segment,
    COUNT(t.Transaction_ID) AS Total_Transactions,

    SUM(
        CASE
            WHEN t.Risk_Review_Flag = 'Yes' THEN 1
            ELSE 0
        END
    ) AS Risk_Reviewed_Transactions,

    SUM(
        CASE
            WHEN t.Risk_Review_Flag = 'No' THEN 1
            ELSE 0
        END
    ) AS Not_Risk_Reviewed_Transactions,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN t.Risk_Review_Flag = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(t.Transaction_ID),
        2
    ) AS Risk_Review_Rate_Percent,

    ROUND(
        SUM(
            CASE
                WHEN t.Risk_Review_Flag = 'Yes'
                THEN t.Amount_NGN
                ELSE 0
            END
        ),
        2
    ) AS Risk_Reviewed_Value_NGN

FROM fintrust_customer c
JOIN fintrust_transaction t
    ON c.Customer_ID = t.Customer_ID

GROUP BY c.Customer_Segment
ORDER BY Risk_Review_Rate_Percent DESC;
/*
BUSINESS INTERPRETATION:

Risk-review rates are relatively similar across all four customer
segments, ranging from 19.29% to 20.33%.

Premium customers recorded the highest risk-review rate at 20.33%,
with 480 of 2,361 transactions flagged for review. Student customers
followed at 19.75%, SME customers at 19.40%, and Everyday customers
at 19.29%.

Although Everyday customers generated the largest number of
risk-reviewed transactions (1,089) and the highest risk-reviewed
transaction value at approximately NGN 78.10 million, this is largely
associated with the much larger transaction volume of the Everyday
segment. Their risk-review rate was actually the lowest of the four
segments.

The narrow range of risk-review rates across segments suggests that
customer segment alone does not show a strong difference in the
likelihood of a transaction being flagged for risk review within this
dataset.

This contrasts with other transaction characteristics identified in
the analysis, such as international transaction status and transaction
type, where larger differences in risk-review rates were observed.

Risk_Review_Flag is a synthetic educational indicator and should not
be interpreted as confirmation of fraud or suspicious customer
behaviour.
*/
-- =====================================================
-- ANALYSIS 7: INTERNATIONAL VS DOMESTIC PERFORMANCE
-- =====================================================
SELECT
    International_Transaction,

    COUNT(Transaction_ID) AS Total_Transactions,

    ROUND(SUM(Amount_NGN), 2) AS Total_Transaction_Value_NGN,

    ROUND(AVG(Amount_NGN), 2) AS Average_Transaction_Value_NGN,

    SUM(
        CASE
            WHEN Transaction_Status = 'Successful' THEN 1
            ELSE 0
        END
    ) AS Successful_Transactions,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN Transaction_Status = 'Successful' THEN 1
                ELSE 0
            END
        ) / COUNT(Transaction_ID),
        2
    ) AS Success_Rate_Percent,

    SUM(
        CASE
            WHEN Risk_Review_Flag = 'Yes' THEN 1
            ELSE 0
        END
    ) AS Risk_Reviewed_Transactions,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN Risk_Review_Flag = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(Transaction_ID),
        2
    ) AS Risk_Review_Rate_Percent

FROM fintrust_transaction
GROUP BY International_Transaction
ORDER BY International_Transaction;
/*
BUSINESS INTERPRETATION:

Domestic transactions account for the majority of transaction activity,
with 11,520 transactions worth approximately NGN 540.48 million.
International transactions account for 480 transactions worth
approximately NGN 20.00 million.

International transactions recorded a risk-review rate of 36.88%,
compared with 18.88% for domestic transactions. This independently
confirms the Week 2 finding that international transactions are reviewed
at a substantially higher rate within the dataset.

However, international transactions recorded a higher transaction
success rate of 93.13%, compared with 90.36% for domestic transactions.

Domestic transactions also had a higher average transaction value of
approximately NGN 46,916.80, compared with NGN 41,657.88 for
international transactions.

The results therefore show that the higher risk-review rate associated
with international transactions does not correspond to a lower
transaction success rate in this dataset. Risk review and transaction
success represent different dimensions of transaction activity and
should not be treated as equivalent measures.

The analysis identifies an association between international transaction
status and risk-review frequency but does not establish why international
transactions are reviewed more frequently.

Risk_Review_Flag is a synthetic educational indicator and does not
represent a confirmed fraud determination.
*/
-- =====================================================
-- ANALYSIS 8: TRANSACTION TYPE PERFORMANCE BY SEGMENT
-- =====================================================
WITH Segment_Type_Performance AS (
    SELECT
        c.Customer_Segment,
        t.Transaction_Type,
        COUNT(t.Transaction_ID) AS Total_Transactions,
        ROUND(SUM(t.Amount_NGN), 2) AS Total_Value_NGN,
        ROUND(AVG(t.Amount_NGN), 2) AS Average_Value_NGN
    FROM fintrust_customer c
    JOIN fintrust_transaction t
        ON c.Customer_ID = t.Customer_ID
    GROUP BY
        c.Customer_Segment,
        t.Transaction_Type
),

Ranked_Performance AS (
    SELECT
        *,
        DENSE_RANK() OVER (
            PARTITION BY Customer_Segment
            ORDER BY Total_Value_NGN DESC
        ) AS Value_Rank_Within_Segment
    FROM Segment_Type_Performance
)

SELECT
    Customer_Segment,
    Transaction_Type,
    Total_Transactions,
    Total_Value_NGN,
    Average_Value_NGN,
    Value_Rank_Within_Segment
FROM Ranked_Performance
ORDER BY
    Customer_Segment,
    Value_Rank_Within_Segment;
    /*
BUSINESS INTERPRETATION:

Transaction-type rankings are remarkably consistent across all four
customer segments.

Transfers generated the highest total transaction value within every
customer segment, ranking first for Everyday, Premium, SME and Student
customers. Deposits ranked second across all four segments, followed by
Card Purchases, Cash Withdrawals, Bill Payments and Airtime/Data.

For Everyday customers, Transfers generated approximately NGN 114.07
million, followed by Deposits at NGN 57.75 million. The same ordering
was observed for Premium, SME and Student customers.

Although Deposits ranked second by total value, they recorded the
highest average transaction value within every customer segment.
Average Deposit values ranged from approximately NGN 96,250.51 for
Everyday customers to NGN 105,341.70 for SME customers.

SME customers recorded particularly high average transaction values
for Transfers (NGN 70,164.01) and Deposits (NGN 105,341.70), despite
the SME segment having fewer customers and transactions overall.

The consistency of transaction-type rankings across all four segments
suggests that the broad pattern of transaction value is similar across
customer segments. Segment differences are therefore more visible in
transaction amounts and overall activity levels than in the ordering
of transaction types by total value.
*/
