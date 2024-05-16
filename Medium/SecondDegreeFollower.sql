# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        follower,
        COUNT(followee) AS count_followee
    FROM
        Follow
    GROUP BY
        follower
    HAVING
        count_followee >= 1
), CTE_2 AS (
    SELECT
        CTE.follower,
        Follow.followee AS followee
    FROM
        CTE
    JOIN
        Follow ON CTE.follower = Follow.followee
)
SELECT
    CTE_2.Followee AS follower,
    COUNT(CTE_2.follower) AS num
FROM
    CTE_2
GROUP BY
    CTE_2.Followee
ORDER BY
    CTE_2.Followee ASC;
