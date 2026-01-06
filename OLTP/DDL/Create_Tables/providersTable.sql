CREATE TABLE IF NOT EXISTS providers (
  provider_id INT PRIMARY KEY,
  first_name VARCHAR (100),
  last_name VARCHAR (100),
  credential VARCHAR(20),
  specialty_id INT,
  department_id INT,
  FOREIGN KEY (specialty_id) REFERENCES specialties (specialty_id),
  FOREIGN KEY (department_id) REFERENCES departments (department_id)
)