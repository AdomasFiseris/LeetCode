# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        (CASE WHEN continent = 'America' THEN name ELSE null END) AS America,
        (CASE WHEN continent = 'Asia' THEN name ELSE null END) AS Asia,
        (CASE WHEN continent = 'Europe' THEN name ELSE null END) AS Europe,
        ROW_NUMBER() OVER (PARTITION BY continent ORDER BY name) AS ranked
    FROM
        Student
)
SELECT
    MIN(America) AS America,
    MIN(Asia) AS Asia,
    MIN(Europe) AS Europe
FROM
    CTE
GROUP BY
    ranked;
