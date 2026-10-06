# FinTrust Banking Analytics
## Week 4 Final Analytics Report

### Project
FinTrust Financial Intelligence & Digital Banking Support Solution

### Track
Data Analytics

### Week 4 Focus
Final Testing, Validation, Refinement and Presentation
---

## 1. Final Data & Analysis Review

### 1.1 Data Quality Validation

The final cleaned transaction dataset was reviewed using Python/Pandas before finalizing the analytical outputs.

| Validation Check | Result | Status |
|---|---:|---|
| Transaction records | 12,000 | Pass |
| Number of columns | 11 | Pass |
| Missing values in cleaned dataset | 0 | Pass |
| Duplicate transaction rows | 0 | Pass |
| Duplicate Transaction IDs | 0 | Pass |
| Zero or negative transaction amounts | 0 | Pass |
| Minimum transaction amount | NGN 100.17 | Pass |
| Maximum transaction amount | NGN 693,454.45 | Pass |
| Transaction date range | 1 Jan 2026 – 31 Mar 2026 | Pass |
| Active transaction days | 90 | Pass |
| Unique Customer IDs | 1,500 | Pass |

The validation confirmed that the cleaned transaction dataset was suitable for the final analysis.

### 1.2 KPI Accuracy Validation

The dashboard KPIs were independently recalculated using Python/Pandas and compared with the Power BI dashboard.

| KPI | Validated Result | Power BI Result | Status |
|---|---:|---:|---|
| Total Customers | 1,500 | 1,500 | Pass |
| Total Transactions | 12,000 | 12K | Pass |
| Total Transaction Value | NGN 560,477,354.85 | NGN 560.5M | Pass |
| Average Transaction Value | NGN 46,706.45 | NGN 46.71K | Pass |
| Transaction Success Rate | 90.47% | 90.47% | Pass |
| Risk Review Rate | 19.60% | 19.60% | Pass |

All six dashboard KPI calculations were validated successfully. No calculation correction was required.

### 1.3 Python Reproducibility

The Week 3 Python analysis notebook was executed from beginning to end using the Run All function in VS Code/Jupyter.

Result:

- All notebook cells executed successfully.
- No execution errors were encountered.
- Analytical outputs and visualizations were reproduced successfully.

The Python analysis was therefore considered reproducible for the final project version.
---

## 2. Final SQL Analysis & Validation

Five important SQL analyses were selected for final validation. Each query was re-run in MySQL and compared with the results documented during Week 3.

### 2.1 Customer Transaction Behaviour by Segment

**Finding:** Everyday customers generate the highest overall transaction volume and value.

**Validation Method:** The customer-segment SQL query was re-run using a JOIN between the customer and transaction tables, with grouped transaction counts and values.

**Result:** Everyday customers recorded 711 customers, 5,644 transactions and NGN 261.46 million in transaction value. The results matched the previously documented Week 3 analysis exactly.

**Conclusion:** The finding is supported. No correction was required.

### 2.2 Transaction Performance by Channel

**Finding:** The Mobile App is the dominant transaction channel but recorded the lowest transaction success rate.

**Validation Method:** The channel-performance SQL query was re-run using transaction counts, transaction values and conditional success-rate calculations.

**Result:** The Mobile App recorded 5,102 transactions worth NGN 240.10 million and a success rate of 89.75%, the lowest among the five channels.

**Conclusion:** The finding is supported. No correction was required.

### 2.3 Monthly Transaction Trend

**Finding:** February recorded lower total transaction volume than January and March.

**Validation Method:** The monthly trend SQL query was re-run using a CTE and the LAG window function to calculate month-over-month changes.

**Result:** February recorded 3,734 transactions, representing a 9.65% decrease from January.

**Conclusion:** The monthly count result is supported, but the interpretation required refinement because February contains fewer calendar days.

### 2.4 High-Value Transaction Patterns

**Finding:** Transfers dominate high-value transaction activity, while Deposits have the highest average high-value transaction amount.

**Validation Method:** High-value transactions were identified using the overall dataset average transaction value as the analytical benchmark and then grouped by transaction type.

**Result:** Transfers recorded 1,207 high-value transactions worth NGN 214.54 million. Deposits recorded the highest average high-value transaction amount at NGN 233,124.49.

**Conclusion:** The finding is supported. No correction was required.

### 2.5 International versus Domestic Transactions

**Finding:** International transactions have a substantially higher risk-review rate than domestic transactions.

**Validation Method:** The international-versus-domestic SQL query was re-run using conditional aggregation to calculate transaction success and risk-review rates.

**Result:** International transactions had a risk-review rate of 36.88%, compared with 18.88% for domestic transactions.

**Conclusion:** The finding is supported. The analysis demonstrates an association but does not establish why international transactions are reviewed more frequently.

### 2.6 SQL Validation Summary

| Analysis | Validation Result |
|---|---|
| Customer behaviour by segment | Supported |
| Channel performance | Supported |
| Monthly transaction trend | Supported, interpretation refined |
| High-value transaction patterns | Supported |
| International versus domestic activity | Supported |
---

## 3. Validation & Refinement Evidence

### 3.1 February Transaction Trend Refinement

**Initial Finding:**  
February recorded a 9.65% decline in transaction count compared with January.

**Initial Interpretation:**  
The lower monthly transaction count appeared to indicate a decline in transaction activity.

**Validation Method:**  
The monthly transaction results were re-tested by calculating average daily transactions, using the number of active calendar days in each month.

**Validation Result:**

| Month | Total Transactions | Active Days | Average Daily Transactions |
|---|---:|---:|---:|
| January 2026 | 4,133 | 31 | 133.32 |
| February 2026 | 3,734 | 28 | 133.36 |
| March 2026 | 4,133 | 31 | 133.32 |

**Refinement:**  
The February decline in total monthly transactions was largely explained by February having 28 calendar days compared with 31 days in January and March.

**Re-test Result:**  
Average daily transaction activity was effectively stable across all three months.

**Final Conclusion:**  
The original interpretation was refined. February had lower total monthly transaction volume, but the evidence does not support a meaningful decline in underlying daily transaction activity.

**Business Implication:**  
Monthly transaction counts should be interpreted alongside daily-normalized metrics when comparing months with different numbers of calendar days.
---

## 4. Final Business Insights & Recommendations

### Insight 1 — Everyday Customers Drive Overall Transaction Activity

**Finding:**  
The Everyday customer segment is the largest contributor to overall transaction activity.

**Evidence:**  
Everyday customers recorded 711 customers, 5,644 transactions and approximately NGN 261.46 million in transaction value.

**Business Meaning:**  
The Everyday segment contributes the largest overall transaction volume and value primarily because it has the largest customer population. However, customer activity differs across segments, with Students recording the highest transactions per customer and SMEs recording the highest average transaction value.

**Recommended Action:**  
Maintain broad engagement and service quality for the Everyday segment while developing segment-specific engagement strategies for Premium, Student and SME customers.

### Insight 2 — Mobile App Dominates Activity but Has the Lowest Success Rate

**Finding:**  
The Mobile App is FinTrust's dominant transaction channel but has the lowest success rate among the five channels.

**Evidence:**  
The Mobile App processed 5,102 transactions worth approximately NGN 240.10 million and recorded an 89.75% success rate, compared with 90.33%–91.70% across the other channels.

**Business Meaning:**  
The Mobile App is a critical customer-facing channel because it handles the highest volume and value of transactions. Its relatively lower success rate means transaction failures on this channel could affect a large number of customers.

**Recommended Action:**  
Investigate the causes of Mobile App transaction failures and prioritize reliability monitoring and improvement for this high-volume channel.

### Insight 3 — Daily Transaction Activity Was Stable Across the Three Months

**Finding:**  
February recorded lower total monthly transaction volume, but underlying daily transaction activity remained stable.

**Evidence:**  
Average daily transactions were 133.32 in January, 133.36 in February and 133.32 in March.

**Business Meaning:**  
The lower February total was largely associated with February having 28 calendar days rather than 31. The evidence does not support a meaningful underlying decline in daily transaction activity.

**Recommended Action:**  
Use daily-normalized transaction metrics when comparing monthly performance, particularly when months have different numbers of calendar days.

### Insight 4 — High-Value Activity Is Concentrated in Transfers and Deposits

**Finding:**  
Transfers dominate high-value transaction activity, while Deposits have the highest average high-value transaction amount.

**Evidence:**  
Transfers accounted for 1,207 high-value transactions worth approximately NGN 214.54 million. Deposits recorded the highest average high-value transaction amount at approximately NGN 233,124.49.

**Business Meaning:**  
High-value activity is concentrated in transaction types with different operational characteristics. Transfers contribute the greatest high-value volume and total value, while Deposits involve the largest average amounts.

**Recommended Action:**  
Monitor high-value Transfer activity and maintain appropriate review of large Deposit transactions using the available transaction and risk-review indicators.

### Insight 5 — International Transactions Have a Higher Risk-Review Rate

**Finding:**  
International transactions have a substantially higher risk-review rate than domestic transactions.

**Evidence:**  
International transactions recorded a 36.88% risk-review rate compared with 18.88% for domestic transactions.

**Business Meaning:**  
International transaction status is associated with more frequent risk review within this dataset. However, the analysis does not establish the reason for the difference, and the synthetic Risk_Review_Flag must not be interpreted as a real fraud determination.

**Recommended Action:**  
Maintain enhanced monitoring of international transaction activity and investigate the underlying factors associated with the higher review rate.

### 4.1 Summary of Final Recommendations

1. Prioritize reliability monitoring and investigation of Mobile App transaction failures.
2. Use daily-normalized metrics when comparing monthly transaction performance.
3. Maintain segment-specific customer engagement strategies.
4. Monitor high-value Transfer and Deposit activity using appropriate analytical indicators.
5. Maintain enhanced monitoring of international transaction activity while investigating the drivers of the higher risk-review rate.
---

## 5. Final Validation Summary

The following table summarizes the major analytical findings selected for final validation.

| Finding | Validation Method | Result | Conclusion |
|---|---|---|---|
| Everyday customers drive overall transaction activity. | Re-ran the customer-segment SQL analysis using customer and transaction table joins and grouped metrics. | Everyday customers recorded 711 customers, 5,644 transactions and NGN 261.46M in transaction value. | Supported. |
| Mobile App is the dominant channel but has the lowest success rate. | Re-ran the channel-performance SQL analysis using transaction counts, values and conditional success-rate calculations. | Mobile App recorded 5,102 transactions and an 89.75% success rate, the lowest among the five channels. | Supported. |
| February transaction activity declined. | Re-ran monthly SQL analysis and then calculated average daily transactions by month. | February recorded 3,734 transactions, but average daily transactions were 133.36 versus 133.32 in January and March. | Refined. Lower monthly volume was largely explained by February having fewer days. |
| Transfers dominate high-value activity and Deposits have the highest average high-value amount. | Re-ran the high-value transaction SQL analysis using the overall average transaction value as the analytical benchmark. | Transfers recorded 1,207 high-value transactions worth NGN 214.54M. Deposits had the highest average high-value transaction amount at NGN 233,124.49. | Supported. |
| International transactions have a higher risk-review rate than domestic transactions. | Re-ran the international-versus-domestic SQL analysis using conditional aggregation. | International transactions recorded a 36.88% risk-review rate compared with 18.88% for domestic transactions. | Supported. |

### 5.1 Overall Validation Outcome

Four of the five selected findings were directly supported by re-testing. One finding, concerning February transaction activity, was refined after daily normalization demonstrated that the lower monthly count did not represent a meaningful decline in underlying daily activity.

The final analytical conclusions therefore reflect both the original evidence and the additional validation performed during Week 4.
---

## 6. Assumptions, Limitations & Responsible Use

### 6.1 Assumptions

The final analysis assumes that the cleaned transaction dataset accurately represents the approved FinTrust project data and that the customer and transaction tables can be appropriately linked using Customer_ID.

Monthly comparisons were interpreted using both total transaction counts and daily-normalized transaction metrics where the number of calendar days could affect the comparison.

The high-value transaction analysis defines "high-value" as transactions above the overall average transaction value in the dataset. This is an analytical benchmark and not an official FinTrust threshold.

### 6.2 Limitations

The analysis covers synthetic FinTrust data for the January–March 2026 period and therefore does not represent actual banking activity.

The dataset is limited to the variables provided in the approved project resources. Important operational factors that may influence transaction outcomes are not available in the dataset.

The analysis identifies associations and patterns but does not establish causation. For example, the higher risk-review rate observed for international transactions does not explain why those transactions are reviewed more frequently.

Customer transaction activity should not be interpreted as customer profitability or lifetime value because the available data does not contain the required profitability measures.

The high-value transaction benchmark is analytical and should not be interpreted as a formal banking risk or transaction threshold.

### 6.3 Responsible Use

FinTrust is a fictional organisation and the datasets are synthetic.

Risk_Review_Flag is a synthetic educational indicator and must not be represented as evidence of actual fraud, suspicious activity or financial crime.

The dashboard and analytical outputs are intended for educational and portfolio purposes and should not be presented as a production banking system.

Business recommendations are based only on the available analytical evidence and should be subject to further investigation before operational implementation.

### 6.4 Data and Methodological Considerations

The cleaned transaction dataset contained no missing values or duplicate transaction records during final validation.

The original raw-data profiling identified missing Device_Type and Location values, which were addressed during data preparation before the final analysis.

The final analysis therefore focuses on the cleaned dataset while retaining awareness of the limitations identified during the original data-quality assessment.
---

## 7. Week 4 Final Conclusion

Week 4 focused on final testing, validation, refinement and finalization of the FinTrust Data Analytics solution.

The final transaction dataset was validated for record completeness, missing values, duplicates, transaction amounts, date coverage and customer identifiers. All six major Power BI KPI calculations were independently recalculated and confirmed to be accurate.

The most important SQL analyses were re-run in MySQL and their results were compared with the Week 3 outputs. The major customer-segment, channel, high-value transaction and international transaction findings were supported by the validation tests.

The February transaction trend provided an important refinement. Although February recorded fewer total transactions than January and March, daily-normalized analysis showed that average daily transaction activity remained stable. The final interpretation was therefore revised to avoid overstating a decline in customer activity.

The Power BI dashboard was refined to improve monetary KPI formatting, transaction-status readability and slicer usability. The final dashboard provides a concise management view of customer activity, transaction performance, transaction status, risk-review patterns and high-value transaction activity.

The final business recommendations are based on validated analytical evidence and focus on Mobile App reliability, daily-normalized performance measurement, customer-segment engagement, high-value transaction monitoring and international transaction monitoring.

Overall, the Week 4 work transformed the Week 1–3 analysis into a validated and presentation-ready business intelligence solution while clearly documenting its assumptions, limitations and responsible-use considerations.

## 8. Final Deliverables Checklist

### Data Analytics Outputs

- [x] Final Power BI dashboard
- [x] Final SQL analysis
- [x] Final Python analysis notebook
- [x] KPI validation
- [x] Final business insights
- [x] Business recommendations
- [x] Final validation evidence
- [x] Data-quality validation
- [x] Final Week 4 documentation

### Key Week 4 Improvements

- [x] Independently validated six major dashboard KPIs
- [x] Re-tested five important SQL analyses
- [x] Validated Python notebook reproducibility
- [x] Refined the February monthly trend interpretation
- [x] Improved Power BI KPI formatting
- [x] Improved transaction-status visual readability
- [x] Improved slicer readability and usability
- [x] Documented assumptions and limitations

## 9. Final Project Status

**Week 1:** Completed  
**Week 2:** Completed  
**Week 3:** Completed  
**Week 4:** Final analytics solution completed and validated

The project is now ready for final repository organization, presentation preparation and submission.