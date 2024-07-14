# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        username,
        activity,
        startDate,
        endDate,
        RANK() OVER (PARTITION BY username ORDER BY endDate DESC) AS ranked
    FROM
        UserActivity
), CTE_2 AS (
    SELECT
        username,
        activity,
        startDate,
        endDate
    FROM
        CTE
    WHERE
        ranked = 2
)
SELECT
    CTE.username,
    CTE.activity,
    CTE.startDate,
    CTE.endDate
FROM
    CTE
LEFT JOIN
    CTE_2 ON CTE.username = CTE_2.username
WHERE
    CTE.ranked = 2 OR
    (CTE.ranked = 1 AND CTE_2.username IS NULL);
