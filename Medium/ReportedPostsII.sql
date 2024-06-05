# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        action_date,
        COUNT(DISTINCT post_id) AS daily_post_count
    FROM
        Actions
    WHERE
        action = 'report' AND extra = 'spam'
    GROUP BY
        action_date
), CTE_2 AS (
    SELECT
        Actions.action_date,
        COUNT(DISTINCT Removals.post_id) AS daily_removal_count
    FROM
        Actions
    RIGHT JOIN
        Removals ON Actions.post_id = Removals.post_id
    WHERE
        Actions.action = 'report' AND Actions.extra = 'spam'
    GROUP BY
        action_date
), CTE_3 AS (

    SELECT
        CTE.action_date,
        CTE.daily_post_count,
        COALESCE(CTE_2.daily_removal_count, 0),
        COALESCE(CTE_2.daily_removal_count, 0) / CTE.daily_post_count AS daily_removal_percentage
    FROM
        CTE
    LEFT JOIN
        CTE_2 ON CTE.action_date = CTE_2.action_date
)
SELECT
    ROUND(AVG(CTE_3.daily_removal_percentage) * 100, 2) AS average_daily_percent
FROM
    CTE_3;
