# Synthetic Data Generation Workflow

## Steps:
1. Create Python script with pandas/numpy
2. Generate realistic patient data with:
    - Demographic (age, gender)
    - Clinical measurement (BP, cholesterol)
    - Treatment groups and outcomes
3. Saved to local folder
4. Verified data quality in LibraOffice Calc

## Commands used:
```bash
python3 -m venv venv
source venv/bin/activate
pip install pandas numpy
python scripts/data_generation/generate_patient_data.py
```

## Idea for Next Steps:
- Write SQL queries to analyze this data
- Create more complex synthetic datasets
- Build a complete analytics pipeline
