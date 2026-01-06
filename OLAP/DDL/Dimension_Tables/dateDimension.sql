CREATE TABLE IF NOT EXISTS dim_date (
    date_key INT PRIMARY KEY,            /* YYYYMMDD   */
    full_date DATE NOT NULL,
    day_of_month TINYINT,
    day_of_week TINYINT,
    day_name VARCHAR(10),
    week_of_year TINYINT,
    month TINYINT,
    month_name VARCHAR(10),
    quarter TINYINT,
    year SMALLINT,
    is_weekend BOOLEAN
)
