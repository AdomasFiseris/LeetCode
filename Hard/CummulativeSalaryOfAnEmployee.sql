# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        id,
        month,
        Salary,
        RANK() OVER (PARTITION BY id ORDER BY month DESC) AS ranked
    FROM
        Employee
), CTE_2 AS (
    SELECT
        id,
        month,
        Salary,
        ranked
    FROM
        CTE
    WHERE
        ranked > 1
)
SELECT
    id,
    month,
    SUM(Salary) OVER (
        PARTITION BY id 
        ORDER BY STR_TO_DATE(CONCAT('2020-', month, '-01'), '%Y-%m-%d') 
        RANGE BETWEEN INTERVAL 2 MONTH PRECEDING AND CURRENT ROW
    ) AS Salary
FROM
    CTE_2
ORDER BY
    id ASC,
    month DESC;
