import pandas as pd

# Load the raw FinTrust datasets
customers = pd.read_csv("data/raw/FinTrust_Customer_Data.csv")
transactions = pd.read_csv("data/raw/FinTrust_Transaction_Data.csv")
data_dictionary = pd.read_csv("data/raw/FinTrust_Data_Dictionary.csv")

print("FinTrust datasets loaded successfully!")

# Check the dimensions of each main dataset
print("\nCUSTOMER DATASET")
print("Number of records:", customers.shape[0])
print("Number of columns:", customers.shape[1])

print("\nTRANSACTION DATASET")
print("Number of records:", transactions.shape[0])
print("Number of columns:", transactions.shape[1])
# Display field names and data types
print("\nCUSTOMER DATASET - FIELD NAMES AND DATA TYPES")
print(customers.dtypes)

print("\nTRANSACTION DATASET - FIELD NAMES AND DATA TYPES")
print(transactions.dtypes)
# Check missing values
print("\nCUSTOMER DATASET - MISSING VALUES")
print(customers.isnull().sum())

print("\nTRANSACTION DATASET - MISSING VALUES")
print(transactions.isnull().sum())

# Calculate missing-value percentages
print("\nCUSTOMER DATASET - MISSING VALUE PERCENTAGES")
print((customers.isnull().sum() / len(customers) * 100).round(2))

print("\nTRANSACTION DATASET - MISSING VALUE PERCENTAGES")
print((transactions.isnull().sum() / len(transactions) * 100).round(2))

# Check for duplicate rows
print("\nDUPLICATE ROW CHECK")
print("Customer duplicate rows:", customers.duplicated().sum())
print("Transaction duplicate rows:", transactions.duplicated().sum())

# Check duplicate primary identifiers
print("\nDUPLICATE ID CHECK")
print("Duplicate Customer_IDs:", customers["Customer_ID"].duplicated().sum())
print("Duplicate Transaction_IDs:", transactions["Transaction_ID"].duplicated().sum())

# Classify variables based on the FinTrust data dictionary

customer_numerical = [
    "Age",
    "Tenure_Months",
    "Digital_Engagement_Score"
]

customer_categorical = [
    "Gender",
    "City",
    "Customer_Segment",
    "Account_Type",
    "Monthly_Income_Band",
    "Preferred_Channel",
    "Account_Status"
]

transaction_numerical = [
    "Amount_NGN"
]

transaction_categorical = [
    "Transaction_Type",
    "Channel",
    "Device_Type",
    "Location",
    "International_Transaction",
    "Transaction_Status",
    "Risk_Review_Flag"
]

transaction_datetime = [
    "Transaction_DateTime"
]

print("\nVARIABLE CLASSIFICATION")

print("\nCustomer numerical variables:")
print(customer_numerical)

print("\nCustomer categorical variables:")
print(customer_categorical)

print("\nTransaction numerical variables:")
print(transaction_numerical)

print("\nTransaction categorical variables:")
print(transaction_categorical)

print("\nTransaction date/time variables:")
print(transaction_datetime)

# Inspect unique values in customer categorical variables
print("\nCUSTOMER CATEGORICAL VALUES")

for column in customer_categorical:
    print(f"\n{column}:")
    print(customers[column].value_counts(dropna=False))


# Inspect unique values in transaction categorical variables
print("\nTRANSACTION CATEGORICAL VALUES")

for column in transaction_categorical:
    print(f"\n{column}:")
    print(transactions[column].value_counts(dropna=False))

    # Inspect numerical variable ranges
print("\nCUSTOMER NUMERICAL SUMMARY")
print(customers[customer_numerical].describe())

print("\nTRANSACTION NUMERICAL SUMMARY")
print(transactions[transaction_numerical].describe())

# Check relationship between customer and transaction datasets
print("\nDATASET RELATIONSHIP CHECK")

unique_transaction_customers = transactions["Customer_ID"].nunique()

unmatched_customers = transactions[
    ~transactions["Customer_ID"].isin(customers["Customer_ID"])
]["Customer_ID"].nunique()

print("Unique customers in customer dataset:", customers["Customer_ID"].nunique())
print("Unique customers appearing in transactions:", unique_transaction_customers)
print("Transaction Customer_IDs not found in customer dataset:", unmatched_customers)

# Detailed descriptive statistics
print("\nCUSTOMER DESCRIPTIVE STATISTICS")
print(
    customers[
        ["Age", "Tenure_Months", "Digital_Engagement_Score"]
    ].describe().round(2)
)

print("\nTRANSACTION DESCRIPTIVE STATISTICS")
print(
    transactions[
        ["Amount_NGN"]
    ].describe().round(2)
)

# Compare mean and median
print("\nMEAN AND MEDIAN COMPARISON")

for column in ["Age", "Tenure_Months", "Digital_Engagement_Score"]:
    print(
        f"{column}: "
        f"Mean = {customers[column].mean():.2f}, "
        f"Median = {customers[column].median():.2f}"
    )

print(
    f"Amount_NGN: "
    f"Mean = {transactions['Amount_NGN'].mean():.2f}, "
    f"Median = {transactions['Amount_NGN'].median():.2f}"
)

# Outlier assessment using the IQR method
print("\nOUTLIER ASSESSMENT - IQR METHOD")

numerical_data = {
    "Age": customers["Age"],
    "Tenure_Months": customers["Tenure_Months"],
    "Digital_Engagement_Score": customers["Digital_Engagement_Score"],
    "Amount_NGN": transactions["Amount_NGN"]
}

for name, series in numerical_data.items():
    q1 = series.quantile(0.25)
    q3 = series.quantile(0.75)
    iqr = q3 - q1

    lower_bound = q1 - (1.5 * iqr)
    upper_bound = q3 + (1.5 * iqr)

    outliers = series[
        (series < lower_bound) | (series > upper_bound)
    ]

    outlier_percentage = (len(outliers) / len(series)) * 100

    print(f"\n{name}")
    print(f"Q1: {q1:.2f}")
    print(f"Q3: {q3:.2f}")
    print(f"IQR: {iqr:.2f}")
    print(f"Lower Bound: {lower_bound:.2f}")
    print(f"Upper Bound: {upper_bound:.2f}")
    print(f"Potential Outliers: {len(outliers)}")
    print(f"Outlier Percentage: {outlier_percentage:.2f}%")