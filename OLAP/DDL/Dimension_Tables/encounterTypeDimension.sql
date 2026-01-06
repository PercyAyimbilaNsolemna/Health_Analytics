CREATE TABLE IF NOT EXISTS dim_encounter_type (
    encounter_type_key INT AUTO_INCREMENT PRIMARY KEY,
    encounter_type_name VARCHAR(50) UNIQUE
)
