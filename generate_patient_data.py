import pandas as pd
import numpy as np
import random
from faker import Faker

# Initialize fake data generator
fake = Faker()

# Generate 100 random claims
np.random.seed(42)  # For reproducibility
n_claims = 100

data = {
    "Claim_ID": np.arange(1000, 1000 + n_claims),
    "Denied": np.random.choice(["Y", "N"], n_claims, p=[0.3, 0.7]),
    "Amount": np.round(np.random.uniform(50, 5000, n_claims), 2),
    "Payor": np.random.choice(["Blue Cross", "Aetna", "Cigna", "Medicare", "United"], n_claims),
    "Provider": [fake.name() for _ in range(n_claims)],
    "Patient": [fake.name() for _ in range(n_claims)],
    "Date": pd.date_range(start="2023-01-01", periods=n_claims).strftime("%Y-%m-%d"),
    "Reason": np.random.choice(["No Coverage", "Fraud", "Duplicate", "Coding Error", "Missing Auth"], n_claims),
    "Status": np.random.choice(["Denied", "Approved", "Pending", "Appealed"], n_claims),
    "Claim_Type": np.random.choice(["Medical", "Dental", "Vision", "Pharmacy"], n_claims)
}

df = pd.DataFrame(data)
print(df)
# 1. Summary stats
print("\nBasic Stats:")
print(df.describe())

# 2. Denial rate by payor
print("\nDenial Rates by Payor:")
print(df.groupby("Payor")["Denied"].value_counts(normalize=True).unstack() * 100)

# 3. Average claim amount by denial status
print("\nAvg Claim Amount by Denial Status:")
print(df.groupby("Denied")["Amount"].mean())

import matplotlib.pyplot as plt

# Plot denial reasons
df["Reason"].value_counts().plot(kind="bar")
plt.title("Top Denial Reasons")
plt.show()

# Add a "Fraud Risk" score
df["Fraud_Risk"] = np.where(
    (df["Amount"] > 3000) & (df["Reason"] == "Fraud"),
    "High",
    np.where(df["Amount"] > 1500, "Medium", "Low")
)

# Show high-risk claims
print("\nHigh Fraud Risk Claims:")
print(df[df["Fraud_Risk"] == "High"])
