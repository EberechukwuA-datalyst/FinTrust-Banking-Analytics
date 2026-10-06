# FinTrust Banking Analytics

## Project Overview

FinTrust Banking Analytics is a portfolio project completed as part of the AnalystLab Africa Internship Programme.

The project analyses synthetic customer and transaction data for FinTrust Digital Bank to understand customer behaviour, transaction activity, channel usage, transaction outcomes, and risk-review patterns.

I am completing this project through the **Data Analytics track**, using Python, SQL, and Power BI to progress from business and data understanding to exploratory analysis, advanced analytics, validation, and management reporting.

---

# Week 1 — Business and Data Understanding

## Objective

The focus of Week 1 was to understand the business problem, review the available datasets, profile the data, define analytical questions and KPIs, and establish the analytical foundation for subsequent project stages.

## Work Completed

- Business understanding and problem definition
- Review of customer, transaction, and data dictionary resources
- Initial data profiling using Python and Pandas
- Data type and variable classification
- Missing-value assessment
- Duplicate and identifier checks
- Dataset relationship validation
- Descriptive statistical analysis
- IQR-based potential outlier assessment
- Analytical question development
- KPI planning
- Dashboard wireframe and planning

## Dataset Overview

The project uses two main datasets:

- **Customer Data:** 1,500 records and 12 fields
- **Transaction Data:** 12,000 records and 11 fields

The datasets are connected using `Customer_ID`.

## Key Week 1 Data Quality Findings

- No missing values were identified in the customer dataset.
- `Device_Type` contains 96 missing values (0.80%).
- `Location` contains 96 missing values (0.80%).
- No duplicate customer or transaction records were identified.
- No duplicate primary identifiers were identified.
- All transaction customer IDs matched records in the customer dataset.
- `Transaction_DateTime` required conversion before time-based analysis.
- The IQR method identified 1,474 transaction amounts (12.28%) as potential statistical outliers requiring further investigation.

Potential outliers were not automatically treated as data errors because high-value transactions may represent legitimate banking activity.

---

# Week 2 — Data Cleaning, Exploratory Analysis and Dashboard Development

## Objective

Week 2 focused on preparing the transaction data for analysis and performing exploratory analysis across Python, SQL, and Power BI.

The objective was to transform the initial data understanding from Week 1 into measurable insights about transaction activity, customer segments, channels, transaction outcomes, and risk-review patterns.

## Work Completed

- Cleaned and prepared transaction data for analysis
- Converted transaction date/time fields into appropriate analytical formats
- Performed exploratory data analysis using Python
- Conducted SQL-based business analysis
- Analysed transaction volume and value
- Compared customer segments
- Examined transaction channel usage
- Analysed transaction types and transaction outcomes
- Investigated risk-review patterns
- Developed the first Power BI analytics dashboard
- Documented key business findings and analytical observations

## Week 2 Analytical Focus

Week 2 analysis explored:

- Overall transaction activity
- Transaction value and volume
- Customer-segment distribution
- Transaction-channel usage
- Transaction-type patterns
- Transaction-status distribution
- Monthly transaction trends
- Risk-reviewed transactions
- International and domestic transaction behaviour

## Week 2 Power BI Dashboard

The first Power BI dashboard was developed to provide an interactive summary of FinTrust's transaction activity.

The dashboard included KPI cards and visuals covering:

- Total customers
- Total transactions
- Total transaction value
- Average transaction value
- Transaction success rate
- Risk-review rate
- Transaction channels
- Customer segments
- Transaction types
- Transaction status
- Monthly transaction trends
- Risk-review activity

This dashboard established the visual reporting foundation that was substantially enhanced during Week 3.

---

# Week 3 — Advanced Analysis, Validation and Management Dashboard

## Objective

Week 3 extended the exploratory work completed during Week 2 through deeper SQL analysis, additional Python analysis, cross-tool validation, and substantial improvements to the Power BI dashboard.

The focus shifted from primarily descriptive reporting toward comparative analysis, validation, interpretation, and management-oriented decision support.

## Advanced SQL Analysis

Eight additional business-focused SQL analyses were completed using techniques including:

- `JOIN`
- `GROUP BY`
- Aggregate functions
- `CASE`
- Common Table Expressions (CTEs)
- `LAG()`
- `DENSE_RANK()`
- Window functions
- Conditional aggregation

The analyses covered:

- Customer-segment transaction behaviour
- Channel performance
- Month-over-month transaction trends
- High-value transaction patterns
- High-value customer activity
- Risk-review rates by customer segment
- Domestic versus international transaction behaviour
- Transaction-type patterns across customer segments

## Advanced Python Analysis

Five additional Python analyses and visualizations were completed:

1. **Channel Performance Comparison**
2. **Daily-Normalized Transaction Trend**
3. **High-Value Transaction Patterns**
4. **Customer Segment Behaviour Comparison**
5. **International vs Domestic Transaction Analysis**

Python was also used to independently validate several SQL findings.

## Key Week 3 Findings

### Channel Performance

The **Mobile App** was the dominant transaction channel:

- **5,102 transactions**
- Approximately **NGN 240.10 million** in transaction value
- **89.75% transaction success rate**

Although it generated the highest transaction volume and value, its success rate was the lowest among the five channels.

### Daily Transaction Trend

Monthly totals initially suggested a decline in February:

- January: **4,133 transactions**
- February: **3,734 transactions**
- March: **4,133 transactions**

After normalizing for the number of calendar days, average daily activity was:

- January: **133.32 transactions/day**
- February: **133.36 transactions/day**
- March: **133.32 transactions/day**

This refined the original interpretation: February's lower monthly total was primarily consistent with the shorter month rather than a meaningful reduction in daily transaction activity.

### Customer Segment Behaviour

Transaction frequency per customer was:

- Student: **8.23**
- Premium: **8.00**
- Everyday: **7.94**
- SME: **7.90**

SME customers recorded the highest average transaction value at approximately **NGN 49,115.69**, while Everyday customers generated the highest overall transaction volume and value.

### High-Value Transaction Analysis

The overall average transaction value of **NGN 46,706.45** was used as an analytical benchmark for above-average/high-value transactions.

A total of **3,071 transactions** exceeded this benchmark.

Transfers accounted for:

- **1,207 high-value transactions**
- Approximately **NGN 214.54 million** in total high-value transaction value
- **32.64% risk-review rate** within the high-value Transfer group

Deposits recorded the highest average high-value transaction amount at approximately **NGN 233,124.49**.

The mean-based high-value definition is an analytical benchmark and does not represent an official FinTrust transaction threshold.

### International vs Domestic Transactions

International transactions recorded a **36.88% risk-review rate**, compared with **18.88% for domestic transactions**.

International transactions also recorded an approximately **93.12% success rate**, compared with **90.36% for domestic transactions**.

The higher risk-review rate therefore did not correspond to a lower transaction success rate in this dataset.

`Risk_Review_Flag` is a synthetic educational indicator and should not be interpreted as confirmation of fraud or suspicious customer behaviour.

---

# Week 3 Finding Validation

Important Week 2 findings were revisited using multiple analytical tools.

| Finding | Validation Result |
|---|---|
| February had lower monthly transaction volume | **Refined** — daily-normalized activity remained essentially stable |
| International transactions had a higher risk-review rate | **Confirmed** across SQL, Python, and Power BI |
| Mobile App was the dominant transaction channel | **Confirmed and extended** — highest usage and value, but lowest channel success rate |

Cross-tool validation strengthened confidence in the findings while also demonstrating the importance of deeper analysis before drawing business conclusions.

---

# Enhanced Power BI Management Dashboard

The Week 2 dashboard was substantially upgraded during Week 3.

The enhanced dashboard includes:

### Executive KPIs

- Total Customers — **1,500**
- Total Transactions — **12,000**
- Total Transaction Value — approximately **NGN 560 million**
- Average Transaction Value — **NGN 46.71K**
- Transaction Success Rate — **90.47%**
- Risk Review Rate — **19.60%**

### Analytical Visuals

- Transactions by Channel
- Average Daily Transactions by Month
- Transactions per Customer by Segment
- Transaction Status Distribution
- Risk-Reviewed Transactions by Type
- Domestic vs International Risk-Review Rate
- High-Value Transactions by Type

### Interactive Filters

- Channel
- Customer Segment
- Transaction Type

The dashboard was redesigned to provide a clearer management story while allowing users to dynamically explore transaction and customer behaviour.

---

# Management Recommendations

The Week 3 analysis produced several evidence-based recommendations:

1. Investigate unsuccessful **Mobile App transactions**, given the channel's high usage but comparatively lower success rate.
2. Maintain proportionate monitoring and further analysis of **international transactions**.
3. Include **daily-normalized metrics** alongside monthly totals in performance reporting.
4. Consider differences in **customer-segment behaviour** when developing engagement and service strategies.
5. Conduct deeper analysis of **high-value Transfer activity**.
6. Investigate risk-review drivers using multiple transaction characteristics rather than customer segment alone.
7. Use the interactive Power BI dashboard as a recurring management performance-monitoring tool.

---

# Tools and Technologies

- **Python**
- **Pandas**
- **Matplotlib**
- **Jupyter Notebook**
- **SQL / MySQL**
- **Power BI**
- **DAX**
- **Visual Studio Code**
- **Git**
- **GitHub**

---

## Repository Structure

```text
FinTrust-Banking-Analytics/
|
|-- data/
|   |-- raw/
|   `-- processed/
|
|-- notebooks/
|   |-- 01_data_profiling.py
|   |-- FinTrust_Week2_Data_Analysis.ipynb
|   |-- FinTrust_Week3_Advanced_Analysis.ipynb
|   `-- FinTrust_Week4_Final_Data_Analysis.ipynb
|
|-- sql/
|   |-- FinTrust_Week2_SQL_Analysis.sql
|   `-- FinTrust_Week3_Advanced_SQL_Analysis.sql
|
|-- dashboard/
|   |-- FinTrust_Week2_Analytics_Dashboard.pbix
|   |-- FinTrust_Week3_Analytics_Dashboard.pbix
|   `-- FinTrust_Week4_Final_Analytics_Dashboard.pbix
|
|-- reports/
|   `-- FinTrust_Week4_Final_Analytics_Report.md
|
|-- .gitignore
`-- README.md
```

---

# Project Progress

- [x] Week 1 — Business and Data Understanding
- [x] Week 2 — Data Cleaning, Exploratory Analysis and Initial Dashboard
- [x] Week 3 — Advanced Analysis, Validation and Management Dashboard
- [ ] Week 4 — Final Refinement, Reporting and Presentation

---

## Week 4 — Final Validation & Refinement

Week 4 focused on final testing, validation, refinement and preparation of the FinTrust Banking Analytics solution for final presentation.

## Week 4 Objective

Finalize the Data Analytics solution by:

- validating data quality and KPI calculations;
- re-testing important SQL analyses;
- validating Python reproducibility;
- refining the Power BI dashboard;
- validating major business findings;
- refining findings where evidence required a change in interpretation;
- documenting assumptions, limitations and responsible use.

## Final Data & KPI Validation

The cleaned transaction dataset was independently validated using Python/Pandas.

Key validation results:

- 12,000 transaction records
- 11 transaction fields
- 0 missing values in the cleaned dataset
- 0 duplicate transaction rows
- 0 duplicate Transaction IDs
- 0 zero or negative transaction amounts
- Transaction period: January–March 2026
- 90 active transaction days
- 1,500 unique Customer IDs

The six Power BI KPI calculations were independently recalculated and validated:

| KPI | Final Result |
|---|---:|
| Total Customers | 1,500 |
| Total Transactions | 12,000 |
| Total Transaction Value | ₦560,477,354.85 |
| Average Transaction Value | ₦46,706.45 |
| Transaction Success Rate | 90.47% |
| Risk Review Rate | 19.60% |

## Final SQL Validation

Five major SQL analyses were re-tested in MySQL:

1. Customer transaction behaviour by segment
2. Transaction performance by channel
3. Monthly transaction trends
4. High-value transaction patterns
5. International versus domestic transaction performance

The SQL validation confirmed that the major Week 3 analytical results were reproducible and supported by the underlying data.

## Key Validation & Refinement

One important finding was refined during Week 4.

The original monthly analysis showed that February transaction volume decreased by 9.65% compared with January.

A daily-normalized validation showed:

- January: 133.32 transactions/day
- February: 133.36 transactions/day
- March: 133.32 transactions/day

The final conclusion was therefore refined: February had lower total monthly transaction volume because it contained fewer calendar days, but underlying daily transaction activity remained stable.

## Final Business Insights

### 1. Everyday customers drive overall transaction activity

711 Everyday customers generated 5,644 transactions worth approximately ₦261.46M.

### 2. Mobile App dominates activity but has the lowest success rate

The Mobile App processed 5,102 transactions worth approximately ₦240.10M and recorded an 89.75% success rate.

### 3. Daily transaction activity remained stable across January–March

Daily-normalized transaction activity remained approximately 133 transactions per day across all three months.

### 4. High-value activity is concentrated in Transfers and Deposits

Transfers generated 1,207 high-value transactions worth approximately ₦214.54M, while Deposits recorded the highest average high-value transaction amount at approximately ₦233,124.49.

### 5. International transactions have a higher risk-review rate

International transactions recorded a 36.88% risk-review rate compared with 18.88% for domestic transactions.

## Final Dashboard Refinements

The Week 4 Power BI dashboard was refined to improve:

- monetary KPI formatting;
- transaction-status readability;
- slicer readability and usability;
- overall visual clarity and management usability.

The final dashboard provides a consolidated view of customer activity, transaction performance, trends, transaction outcomes, risk-review patterns and high-value activity.

## Week 4 Deliverables

- Final Power BI dashboard
- Final Python analysis notebook
- Advanced SQL analysis
- KPI validation evidence
- Final business insights
- Business recommendations
- Validation and refinement evidence
- Data-quality documentation
- Final analytics report

## Limitations

The FinTrust organisation and datasets are fictional and synthetic.

The `Risk_Review_Flag` is a synthetic educational indicator and must not be interpreted as evidence of actual fraud or financial crime.

The analysis covers January–March 2026 and is limited to the variables available in the supplied datasets.

High-value transactions are defined using the dataset's overall average transaction value and should not be interpreted as an official banking threshold.

## Project Progress

- [x] Week 1 — Business Understanding & Data Profiling
- [x] Week 2 — Data Preparation, SQL Analysis, Python EDA & Power BI Dashboard
- [x] Week 3 — Advanced SQL, Advanced Python, Dashboard Enhancement & Validation
- [x] Week 4 — Final Testing, Validation, Refinement & Final Analytics Solution