CREATE TABLE IF NOT EXISTS dim_specialty (
    specialty_key INT AUTO_INCREMENT PRIMARY KEY,
    specialty_id INT NOT NULL,
    specialty_code VARCHAR(10),
    specialty_name VARCHAR(100),
    UNIQUE (specialty_id)
)
