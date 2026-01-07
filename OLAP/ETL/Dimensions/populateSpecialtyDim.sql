INSERT INTO dim_specialty (specialty_id, specialty_code, specialty_name)
SELECT DISTINCT
    specialty_id,
    specialty_code,
    specialty_name
FROM specialties
