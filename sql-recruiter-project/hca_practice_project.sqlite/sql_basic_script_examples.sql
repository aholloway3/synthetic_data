CREATE TABLE patients (
patient_id INTEGER PRIMARY KEY,
patient_name TEXT,
diagnosis_code TEXT,
age INTEGER,
last_admission_date TEXT,
is_active INTEGER
);

CREATE TABLE eligibility_rules (
rule_id INTEGER PRIMARY KEY,
diagnosis_code TEXT,
min_age INTEGER,
max_age INTEGER,
requires_recent_admission INTEGER
);

-- Insert sample patients
INSERT INTO patients VALUES
(1, 'John Doe', 'I10', 72, '2023-10-15', 1),
(2, 'Jane Smith', 'E11', 45, '2024-01-20', 1),
(3, 'Bob Johnson', 'I10', 68, '2022-12-01', 1),
(4, 'Alice Brown', 'M54', 55, NULL, 1),
(5, 'Charlie Wilson','I10', 80, '2024-02-01', 1);

-- Insert sample business rules
INSERT INTO eligibility_rules VALUES
(1, 'I10', 65, 75, 1);


-- Find eligible patients
SELECT
p.patient_id,
p.patient_name,
p.diagnosis_code,
p.age,
p.last_admission_date
FROM patients p
INNER JOIN eligibility_rules r ON p.diagnosis_code = r.diagnosis_code
WHERE p.age BETWEEN r.min_age AND r.max_age
	AND (r.requires_recent_admission = 0 OR
	(r. requires_recent_admission = 1 AND 
	p.last_admission_date >= date('now', '-3months')))
	AND p.is_active =1;
	
	
-- "Why are my volumes low?" - Check diagnosis code distribution
SELECT diagnosis_code, COUNT(*) as patient_count
FROM patients
WHERE is_active = 1
GROUP BY diagnosis_code;

-- "Is my data complete?" - Data quality check 
SELECT COUNT(*) as total_patients,
		COUNT(last_admission_date) as patients_with_admission_data,
		COUNT(*) - COUNT(last_admission_date) as missing_admission_dates
FROM patients;

-- "Let me test the rules individually" - Break down of the logic
SELECT patient_id, diagnosis_code, age,
	(age BETWEEN 65 AND 75) as meets_age_criteria,
	(last_admission_date >= date('now', '-3 months')) as
has_recent_admission
FROM patients
WHERE diagnosis_code = 'I10';

-- See all business rules
SELECT * FROM eligibility_rules;

-- See all patient data 
SELECt * FROM patients;

-- Find patients who almost qualify (for analysis)
SELECT * FROM patients 
WHERE diagnosis_code = 'I10'
	AND age BETWEEN 60 and 80
	AND is_active = 1;
	
-- === DEBUGGING QUERIES ===
--First, check basic data quality
SELECT COUNT(*) as total_patients,
		COUNT(DISTINCT diagnosis_code) as unique_diagnoses
FROM patients;

-- TEST the JOIN separately from the WHERE conditions 
SELECT COUNT(*) as patients_with_matching_rules
FROM patients p
INNER JOIN eligibility_rules r ON p.diagnosis_code = r.diagnosis_code;

-- === MAIN ANALYSIS QUERY ===
-- This is the final, production-ready version
SELECT p.patient_id, p.patient_name, p.diagnosis_code, p.age
FROM patients p
INNER JOIN eligibility_rules r ON p.diagnosis_code = r.diagnosis_code
WHERE p.age BETWEEN r.min_age AND r.max_age
	AND (r.requires_recent_admission = 0 OR p.last_admission_date >= date('now','-3 months'))
	AND p.is_active =1;

	