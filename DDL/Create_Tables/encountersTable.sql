CREATE TABLE IF NOT EXISTS encounters (
  encounter_id INT PRIMARY KEY,
  patient_id INT,
  provider_id INT,
  encounter_type VARCHAR (50), -- 'Outpatient', 'Inpatient', 'ER'
  encounter_date DATETIME,
  discharge_date DATETIME,
  department_id INT,
  FOREIGN KEY (patient_id) REFERENCES patients (patient_id),
  FOREIGN KEY (provider_id) REFERENCES providers (provider_id),
  FOREIGN KEY (department_id) REFERENCES departments (department_id),
  INDEX idx_encounter_date (encounter_date)
);