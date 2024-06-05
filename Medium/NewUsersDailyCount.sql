# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        DISTINCT user_id,
        MIN(activity_date) AS first_login
    FROM
        Traffic
    WHERE
        activity = 'login'
    GROUP BY
        user_id
)
SELECT
    Traffic.activity_date AS login_date,
    COUNT(DISTINCT CTE.user_id) AS user_count
FROM
    Traffic
RIGHT JOIN
    CTE ON Traffic.user_id = CTE.user_id AND Traffic.activity_date = CTE.first_login
GROUP BY
    Traffic.activity_date
HAVING
    Traffic.activity_date BETWEEN DATE_SUB('2019-06-30', INTERVAL 90 DAY) AND '2019-06-30';
