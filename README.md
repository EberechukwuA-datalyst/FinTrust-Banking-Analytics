# FinTrust Banking Analytics

## Project Overview

FinTrust Banking Analytics is a portfolio project completed as part of the AnalystLab Africa Internship Programme.

The project focuses on analysing synthetic customer and transaction data for FinTrust Digital Bank to understand customer behaviour, transaction activity, channel usage, transaction outcomes, and risk-review patterns.

I am completing this project through the Data Analytics track.

## Week 1 — Business and Data Understanding

The focus of Week 1 was to understand the business problem, review the available datasets, profile the data, define analytical questions and KPIs, and plan the structure of the future dashboard.

### Work Completed

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

- Customer Data: 1,500 records and 12 fields
- Transaction Data: 12,000 records and 11 fields

The datasets are connected using `Customer_ID`.

## Key Week 1 Data Quality Findings

- No missing values were identified in the customer dataset.
- `Device_Type` contains 96 missing values (0.80%).
- `Location` contains 96 missing values (0.80%).
- No duplicate customer or transaction records were identified.
- No duplicate primary identifiers were identified.
- All transaction customer IDs matched records in the customer dataset.
- `Transaction_DateTime` currently loads as a string and will require conversion before time-based analysis.
- The IQR method identified 1,474 transaction amounts (12.28%) as potential statistical outliers requiring further investigation.

Potential outliers are not automatically treated as data errors, as high-value transactions may represent valid banking activity.

## Tools

- Python
- Pandas
- Visual Studio Code
- Git and GitHub
- Google Docs

## Repository Structure

```text
FinTrust-Banking-Analytics/
├── data/
├── notebooks/
│   └── 01_data_profiling.py
├── reports/
├── dashboard/
├── .gitignore
└── README.md