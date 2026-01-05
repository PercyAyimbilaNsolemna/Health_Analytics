CREATE TABLE IF NOT EXISTS patients (
  patient_id INT PRIMARY KEY,
  first_name VARCHAR (100),
  last_name VARCHAR (100),
  date_of_birth DATE,
  gender CHAR(1),
  mrn VARCHAR (20) UNIQUE
);