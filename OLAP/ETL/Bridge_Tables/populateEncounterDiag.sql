INSERT INTO bridge_encounter_diagnosis (encounter_key, diagnosis_key, diagnosis_sequence)
SELECT
    f.encounter_key,
    dd.diagnosis_key,
    ed.diagnosis_sequence
FROM encounter_diagnoses ed
JOIN fact_encounter f
    ON f.encounter_id = ed.encounter_id
JOIN dim_diagnosis dd
    ON dd.diagnosis_id = ed.diagnosis_id
