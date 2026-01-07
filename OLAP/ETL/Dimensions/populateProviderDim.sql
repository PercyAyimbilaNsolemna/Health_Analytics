INSERT INTO dim_provider (
    provider_id,
    provider_name,
    credential,
    specialty_key,
    department_key
)
SELECT
    p.provider_id,
    CONCAT(p.first_name, ' ', p.last_name),
    p.credential,
    ds.specialty_key,
    dd.department_key
FROM providers p
JOIN dim_specialty ds
    ON ds.specialty_id = p.specialty_id
JOIN dim_department dd
    ON dd.department_id = p.department_id
