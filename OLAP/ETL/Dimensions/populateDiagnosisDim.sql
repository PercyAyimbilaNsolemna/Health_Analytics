INSERT INTO dim_diagnosis (
    diagnosis_id,
    icd10_code,
    icd10_description
)
SELECT DISTINCT
    diagnosis_id,
    icd10_code,
    icd10_description
FROM diagnoses
