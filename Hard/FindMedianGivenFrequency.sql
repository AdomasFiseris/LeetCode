# Write your MySQL query statement below
WITH RECURSIVE expanded AS (
    SELECT
        num,
        frequency
    FROM
        Numbers
    WHERE
        frequency > 0
    UNION ALL
    SELECT
        num,
        frequency - 1
    FROM
        expanded
    WHERE
        frequency > 1
), CTE AS (
    SELECT
        num,
        ROW_NUMBER() OVER (ORDER BY num ASC) AS row_num
    FROM
        expanded
), CTE_2 AS (
    SELECT
        MAX(row_num) AS max_num
    FROM
        CTE
)
SELECT
    CASE
        WHEN MOD((SELECT max_num FROM CTE_2), 2) = 0 THEN
            ROUND((
                (SELECT num FROM CTE WHERE row_num = (SELECT max_num FROM CTE_2) / 2) +
                (SELECT num FROM CTE WHERE row_num = ((SELECT max_num FROM CTE_2) / 2) + 1)
            ) / 2, 1)
        ELSE
            (SELECT num FROM CTE WHERE row_num = ROUND((SELECT max_num FROM CTE_2) / 2, 0))
    END AS median;
