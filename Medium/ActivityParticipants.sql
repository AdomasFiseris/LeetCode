# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        Activities.id,
        COUNT(Friends.activity) AS count_of_activity
    FROM
        Friends
    JOIN
        Activities ON Friends.activity = Activities.name
    GROUP BY
        Activities.id
)
SELECT
    Activities.name AS activity
FROM
    Activities
JOIN
    CTE ON Activities.id = CTE.id
WHERE
    CTE.count_of_activity NOT IN (
        (SELECT MAX(count_of_activity) FROM CTE),
        (SELECT MIN(count_of_activity) FROM CTE)
    )
