# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        Project.project_id,
        Project.employee_id,
        Employee.experience_years
    FROM
        Project
    JOIN
        Employee ON Project.employee_id = Employee.employee_id
), CTE_2 AS (
    SELECT
        CTE.project_id,
        CTE.employee_id,
        CTE.experience_years,
        RANK() OVER (PARTITION BY CTE.project_id ORDER BY CTE.experience_years DESC) AS ranked
    FROM
        CTE
)
SELECT
    CTE_2.project_id,
    CTE_2.employee_id
FROM
    CTE_2
WHERE
    ranked = 1;
