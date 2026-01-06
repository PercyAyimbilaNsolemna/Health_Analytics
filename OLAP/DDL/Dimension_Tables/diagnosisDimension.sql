CREATE TABLE IF NOT EXISTS dim_diagnosis (
    diagnosis_key INT AUTO_INCREMENT PRIMARY KEY,
    diagnosis_id INT NOT NULL,
    icd10_code VARCHAR(10),
    icd10_description VARCHAR(200),
    UNIQUE (diagnosis_id)
)
