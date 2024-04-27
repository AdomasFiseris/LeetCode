# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        user_id,
        visit_date,
        CASE
            WHEN LEAD(visit_date) OVER (PARTITION BY user_id ORDER BY visit_date ASC) IS NULL
            THEN DATEDIFF('2021-1-1', visit_date)
            ELSE DATEDIFF(LEAD(visit_date) OVER (PARTITION BY user_id ORDER BY visit_date ASC), visit_date)
        END AS day_gap
    FROM
        UserVisits
)
SELECT
    user_id,
    MAX(day_gap) AS biggest_window
FROM
    CTE
GROUP BY
    user_id
ORDER BY
    user_id;
