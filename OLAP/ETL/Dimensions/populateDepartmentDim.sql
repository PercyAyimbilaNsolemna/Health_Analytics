/*

    Extract, Transform and Load Department data from the OLTP Department table into the dim deapartment OLAP table

*/

INSERT INTO dim_department (`department_id`, `department_name`, `floor`, `capacity`)

SELECT DISTINCT 
            `department_id`,
            `department_name`,
            `floor`,
            `capacity`
FROM `departments`