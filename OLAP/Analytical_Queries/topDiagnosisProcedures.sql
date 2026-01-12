SELECT
    diag.icd10_code,
    proc.cpt_code,
    COUNT(*) AS encounter_count
FROM bridge_encounter_diagnosis bd
JOIN bridge_encounter_procedure bp
    ON bd.encounter_key = bp.encounter_key
JOIN dim_diagnosis diag
    ON bd.diagnosis_key = diag.diagnosis_key
JOIN dim_procedure proc
    ON bp.procedure_key = proc.procedure_key
GROUP BY
    diag.icd10_code,
    proc.cpt_code
ORDER BY encounter_count DESC
