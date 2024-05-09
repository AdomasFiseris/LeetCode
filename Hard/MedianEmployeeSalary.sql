# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        id,
        company,
        salary,
        RANK() OVER (PARTITION BY company ORDER BY salary ASC, id ASC) AS rank_id
    FROM
        Employee
), CTE_2 AS (
    SELECT
        id,
        company,
        salary,
        rank_id,
        COUNT(rank_id) OVER (PARTITION BY company) as total
    FROM
        CTE
)
SELECT
    id,
    company,
    salary
FROM
    CTE_2
WHERE
    rank_id IN (total / 2, total / 2 + 1, ROUND(total / 2, 0));
