INSERT INTO bridge_encounter_procedure (encounter_key, procedure_key)
SELECT
    f.encounter_key,
    dp.procedure_key
FROM encounter_procedures ep
JOIN fact_encounter f
    ON f.encounter_id = ep.encounter_id
JOIN dim_procedure dp
    ON dp.procedure_id = ep.procedure_id
