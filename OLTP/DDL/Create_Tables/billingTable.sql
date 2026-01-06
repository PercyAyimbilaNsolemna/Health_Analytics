CREATE TABLE IF NOT EXISTS billing (
  billing_id INT PRIMARY KEY,
  encounter_id INT,
  claim_amount DECIMAL (12, 2),
  allowed_amount DECIMAL (12, 2),
  claim_date DATE,
  claim_status VARCHAR (50),
  FOREIGN KEY (encounter_id) REFERENCES encounters (encounter_id),
  INDEX idx_claim_date (claim_date)
)