INSERT INTO dim_patient (
    patient_id,
    gender,
    date_of_birth,
    age_group,
    mrn
)
SELECT
    patient_id,
    gender,
    date_of_birth,
    CASE
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) < 18 THEN '0-17'
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 18 AND 34 THEN '18-34'
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 35 AND 49 THEN '35-49'
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 50 AND 64 THEN '50-64'
        ELSE '65+'
    END AS age_group,
    mrn
FROM patients
