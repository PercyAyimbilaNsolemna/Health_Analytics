/*

    Monthly encounters & unique patients by specialty and encounter type

    Requirement
    For each month + specialty + encounter type, show:

    Total encounters

    Unique patients

*/

SELECT
    DATE_FORMAT(e.encounter_date, '%Y-%m') AS encounter_month,
    s.specialty_name,
    e.encounter_type,
    COUNT(e.encounter_id) AS total_encounters,
    COUNT(DISTINCT e.patient_id) AS unique_patients
FROM encounters e
JOIN providers p
    ON e.provider_id = p.provider_id
JOIN specialties s
    ON p.specialty_id = s.specialty_id
GROUP BY
    encounter_month,
    s.specialty_name,
    e.encounter_type
ORDER BY
    encounter_month,
    s.specialty_name,
    e.encounter_type
