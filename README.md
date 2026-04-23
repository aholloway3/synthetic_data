# Synthetic Patient Data Generator

## What
Python script that generates realistic-but-fake patient data for SQL testing and pipeline development.

## Why
Real patient data can't be shared. This lets me demonstrate healthcare data work without PHI.

## How
## Steps:
1. Create Python script with pandas/numpy
2. Generate realistic patient data with:
    - Demographic (age, gender)
    - Clinical measurement (BP, cholesterol)
    - Treatment groups and outcomes
3. Saved to local folder
4. Verified data quality in LibreOffice Calc

## Commands used:
```bash
python3 -m venv venv
source venv/bin/activate
pip install pandas numpy
python generate_patient_data.py
```
## Output
Creates `patient_data.csv` with: patient_id, age, gender, diagnosis_code, admission_date, discharge_date.

## Schema
- patient_id: unique integer
- age: 18-95
- gender: M/F/other
- diagnosis_code: ICD-10 format (I10, E11, etc.)
- admission_date: random date in 2023-2024
- discharge_date: admission_date + random length of stay

## Idea for Next Steps:
- Write SQL queries to analyze this data
- Create more complex synthetic datasets
- Build a complete analytics pipeline
