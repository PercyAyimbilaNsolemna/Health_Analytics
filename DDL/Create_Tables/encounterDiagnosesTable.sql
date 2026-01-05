CREATE TABLE IF NOT EXISTS encounter_diagnoses (
  encounter_diagnosis_id INT PRIMARY KEY,
  encounter_id INT,
  diagnosis_id INT,
  diagnosis_sequence INT,
  FOREIGN KEY (encounter_id) REFERENCES encounters (encounter_id),
  FOREIGN KEY (diagnosis_id) REFERENCES diagnoses (diagnosis_id)
);