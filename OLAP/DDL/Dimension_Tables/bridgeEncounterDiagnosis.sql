CREATE TABLE IF NOT EXISTS bridge_encounter_diagnosis (
    encounter_key INT NOT NULL,
    diagnosis_key INT NOT NULL,
    diagnosis_sequence INT,
    PRIMARY KEY (encounter_key, diagnosis_key)
)
