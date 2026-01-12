/*

    STAR SCHEMA

    Monthly encounters & unique patients by specialty and encounter type

    Requirement
    For each month + specialty + encounter type, show:

    Total encounters

    Unique patients

*/

SELECT
    d.year,
    d.month,
    s.specialty_name,
    et.encounter_type_name,
    COUNT(f.encounter_key) AS total_encounters,
    COUNT(DISTINCT f.patient_key) AS unique_patients
FROM fact_encounter f
JOIN dim_date d
    ON f.date_key = d.date_key
JOIN dim_specialty s
    ON f.specialty_key = s.specialty_key
JOIN dim_encounter_type et
    ON f.encounter_type_key = et.encounter_type_key
GROUP BY
    d.year,
    d.month,
    s.specialty_name,
    et.encounter_type_name
ORDER BY
    d.year,
    d.month
