SELECT
    s.specialty_name,
    SUM(f.is_readmission_flag) AS readmissions,
    COUNT(*) AS total_discharges,
    ROUND(
        SUM(f.is_readmission_flag) / COUNT(*) * 100, 2
    ) AS readmission_rate
FROM fact_encounter f
JOIN dim_specialty s
    ON f.specialty_key = s.specialty_key
JOIN dim_encounter_type et
    ON f.encounter_type_key = et.encounter_type_key
WHERE et.encounter_type_name = 'Inpatient'
GROUP BY s.specialty_name
ORDER BY readmission_rate DESC
