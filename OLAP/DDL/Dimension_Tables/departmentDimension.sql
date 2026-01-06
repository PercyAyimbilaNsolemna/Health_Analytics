CREATE TABLE IF NOT EXISTS dim_department (
    department_key INT AUTO_INCREMENT PRIMARY KEY,
    department_id INT NOT NULL,
    department_name VARCHAR(100),
    floor INT,
    capacity INT,
    UNIQUE (department_id)
)
