INSERT INTO dim_procedure (
    procedure_id,
    cpt_code,
    cpt_description
)
SELECT DISTINCT
    procedure_id,
    cpt_code,
    cpt_description
FROM procedures
