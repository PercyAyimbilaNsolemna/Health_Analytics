/* Example: Load dates 2023–2026  */

INSERT INTO dim_date
SELECT
    CAST(DATE_FORMAT(d, '%Y%m%d') AS UNSIGNED) AS date_key,
    d AS full_date,
    DAY(d),
    DAYOFWEEK(d),
    DAYNAME(d),
    WEEK(d),
    MONTH(d),
    MONTHNAME(d),
    QUARTER(d),
    YEAR(d),
    CASE WHEN DAYOFWEEK(d) IN (1,7) THEN 1 ELSE 0 END
FROM (
    SELECT DATE_ADD('2023-01-01', INTERVAL seq DAY) d
    FROM (
        SELECT @row := @row + 1 AS seq
        FROM information_schema.columns, (SELECT @row := -1) r
        LIMIT 1461
    ) x
) dates
