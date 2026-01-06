CREATE TABLE IF NOT EXISTS dim_patient (
    patient_key INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    gender CHAR(1),
    date_of_birth DATE,
    age_group VARCHAR(20),
    mrn VARCHAR(20),
    UNIQUE (patient_id)
)
