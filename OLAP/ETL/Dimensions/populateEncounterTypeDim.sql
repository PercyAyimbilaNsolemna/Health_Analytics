INSERT INTO dim_encounter_type (encounter_type_name)
SELECT DISTINCT
    encounter_type
FROM encounters
