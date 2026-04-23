# Synthetic Claims Data Generator

## What
Python script that generates realistic healthcare claims data for analysis, denial trend identification, and fraud risk scoring.

## Why
Real claims data cannot be shared due to PHI restrictions. Synthetic data allows demonstration of healthcare analytics techniques without privacy concerns.

## Features
- Generates 100+ claims with realistic fields (payor, amount, denial reason, provider, patient)
- Includes denial rate analysis by payor
- Calculates fraud risk scores based on amount and reason
- Produces visualization of top denial reasons

## How to Run

```bash
pip install pandas numpy matplotlib faker
python generate_claims.py
```
## Sample Output

- Console output: Summary stats, denial rates, fraud risk claims
- Plot: Bar chart of denial reasons (saves or displays)

## Files
- `generate_claims.py` — Main script
- `requirements.txt` — Dependencies

## Real-World Application
This mimics real claims denial analysis workflows used in revenue cycle management and healthcare analytics.
