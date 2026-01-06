/*

    Most common diagnosis–procedure combinations

    Requirement
    Show:

    ICD-10 code

    CPT code

    Number of encounters where they co-occur

*/


SELECT
    d.icd10_code,
    pr.cpt_code,
    COUNT(DISTINCT e.encounter_id) AS encounter_count
FROM encounter_diagnoses ed
JOIN diagnoses d
    ON ed.diagnosis_id = d.diagnosis_id
JOIN encounter_procedures ep
    ON ed.encounter_id = ep.encounter_id
JOIN procedures pr
    ON ep.procedure_id = pr.procedure_id
JOIN encounters e
    ON e.encounter_id = ed.encounter_id
GROUP BY
    d.icd10_code,
    pr.cpt_code
ORDER BY
    encounter_count DESC
