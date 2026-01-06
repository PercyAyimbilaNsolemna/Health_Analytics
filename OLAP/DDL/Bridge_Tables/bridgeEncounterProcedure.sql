CREATE TABLE IF NOT EXISTS bridge_encounter_procedure (
    encounter_key INT NOT NULL,
    procedure_key INT NOT NULL,
    PRIMARY KEY (encounter_key, procedure_key)
)
