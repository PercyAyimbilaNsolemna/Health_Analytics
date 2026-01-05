CREATE TABLE IF NOT EXISTS encounter_procedures (
  encounter_procedure_id INT PRIMARY KEY,
  encounter_id INT,
  procedure_id INT,
  procedure_date DATE,
  FOREIGN KEY (encounter_id) REFERENCES encounters (encounter_id),
  FOREIGN KEY (procedure_id) REFERENCES procedures (procedure_id)
);