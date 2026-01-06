CREATE TABLE IF NOT EXISTS dim_procedure (
    procedure_key INT AUTO_INCREMENT PRIMARY KEY,
    procedure_id INT NOT NULL,
    cpt_code VARCHAR(10),
    cpt_description VARCHAR(200),
    UNIQUE (procedure_id)
)
