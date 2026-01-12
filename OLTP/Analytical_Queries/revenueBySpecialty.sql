/*

    Total allowed amounts by specialty and month (Revenue analysis)

    Requirement

    Aggregate allowed_amount

    Group by specialty and month

    Identify revenue-generating specialties

*/


SELECT
    YEAR(b.claim_date) AS year,
    MONTH(b.claim_date) AS month,
    s.specialty_name,
    SUM(b.allowed_amount) AS total_allowed_amount
FROM billing b
JOIN encounters e
    ON b.encounter_id = e.encounter_id
JOIN providers p
    ON e.provider_id = p.provider_id
JOIN specialties s
    ON p.specialty_id = s.specialty_id
GROUP BY
    year,
    month,
    s.specialty_name
ORDER BY
    total_allowed_amount DESC
