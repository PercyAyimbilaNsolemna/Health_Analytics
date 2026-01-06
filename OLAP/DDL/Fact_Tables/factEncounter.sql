CREATE TABLE IF NOT EXISTS fact_encounter (
    encounter_key BIGINT AUTO_INCREMENT PRIMARY KEY,

    /* Natural key   */
    encounter_id INT NOT NULL,

    /* Foreign keys to dimensions  */
    date_key INT NOT NULL,
    discharge_date_key INT,

    patient_key INT NOT NULL,
    provider_key INT NOT NULL,
    specialty_key INT NOT NULL,
    department_key INT NOT NULL,
    encounter_type_key INT NOT NULL,

    /* Pre-aggregated metrics   */
    diagnosis_count INT DEFAULT 0,
    procedure_count INT DEFAULT 0,
    total_allowed_amount DECIMAL(12,2) DEFAULT 0.00,
    length_of_stay INT,                -- days
    is_readmission_flag BOOLEAN DEFAULT 0,

    /* Audit fields  */
    record_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    UNIQUE (encounter_id),

    /* Time-based analytics  */
    INDEX idx_fact_date (date_key),
    INDEX idx_fact_discharge_date (discharge_date_key),

    /* Core slicing dimensions   */
    INDEX idx_fact_specialty (specialty_key),
    INDEX idx_fact_encounter_type (encounter_type_key),
    INDEX idx_fact_patient (patient_key),

    /* Performance-heavy queries  */
    INDEX idx_fact_readmission (patient_key, discharge_date_key, is_readmission_flag)

)
