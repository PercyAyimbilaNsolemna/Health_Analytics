CREATE TABLE IF NOT EXISTS dim_provider (
    provider_key INT AUTO_INCREMENT PRIMARY KEY,
    provider_id INT NOT NULL,
    provider_name VARCHAR(200),
    credential VARCHAR(20),
    specialty_key INT,
    department_key INT,
    UNIQUE (provider_id)
)
