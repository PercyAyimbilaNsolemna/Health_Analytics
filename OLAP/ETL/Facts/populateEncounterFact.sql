

INSERT INTO fact_encounter (
    encounter_id,
    date_key,
    discharge_date_key,
    patient_key,
    provider_key,
    specialty_key,
    department_key,
    encounter_type_key,
    diagnosis_count,
    procedure_count,
    total_allowed_amount,
    length_of_stay,
    is_readmission_flag
)
SELECT
    e.encounter_id,

    /* Encounter date */
    CAST(DATE_FORMAT(e.encounter_date, '%Y%m%d') AS UNSIGNED) AS date_key,

    /* Discharge date (nullable) */
    CASE
        WHEN e.discharge_date IS NOT NULL
        THEN CAST(DATE_FORMAT(e.discharge_date, '%Y%m%d') AS UNSIGNED)
        ELSE NULL
    END AS discharge_date_key,

    dp.patient_key,
    dprov.provider_key,
    ds.specialty_key,
    dd.department_key,
    det.encounter_type_key,

    /* Diagnosis count  */
    COUNT(DISTINCT ed.diagnosis_id) AS diagnosis_count,

    /* Procedure count  */
    COUNT(DISTINCT ep.procedure_id) AS procedure_count,

    /* Revenue  */
    COALESCE(SUM(b.allowed_amount), 0.00) AS total_allowed_amount,

    /* Length of stay  */
    CASE
        WHEN e.discharge_date IS NOT NULL
        THEN DATEDIFF(e.discharge_date, e.encounter_date)
        ELSE NULL
    END AS length_of_stay,

    /* Placeholder for readmission (computed later)  */
    0 AS is_readmission_flag

FROM encounters e

/* Dimension joins */
JOIN dim_patient dp
    ON dp.patient_id = e.patient_id

JOIN dim_provider dprov
    ON dprov.provider_id = e.provider_id

JOIN dim_specialty ds
    ON ds.specialty_key = dprov.specialty_key

JOIN dim_department dd
    ON dd.department_key = dprov.department_key

JOIN dim_encounter_type det
    ON det.encounter_type_name = e.encounter_type

/* Aggregation sources  */
LEFT JOIN encounter_diagnoses ed
    ON ed.encounter_id = e.encounter_id

LEFT JOIN encounter_procedures ep
    ON ep.encounter_id = e.encounter_id

LEFT JOIN billing b
    ON b.encounter_id = e.encounter_id

GROUP BY
    e.encounter_id,
    date_key,
    discharge_date_key,
    dp.patient_key,
    dprov.provider_key,
    ds.specialty_key,
    dd.department_key,
    det.encounter_type_key
