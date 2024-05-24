# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        event_type,
        AVG(occurrences) AS avg_all
    FROM
        Events
    GROUP BY
        event_type
), CTE_2 AS (
    SELECT
        Events.business_id,
        Events.event_type,
        Events.occurrences,
        CTE.avg_all
    FROM
        Events
    JOIN
        CTE ON Events.event_type = CTE.event_type
), CTE_3 AS (
    SELECT
        business_id,
        COUNT(event_type) AS business_cnt
    FROM
        CTE_2
    WHERE
        occurrences > avg_all
    GROUP BY
        business_id
)
SELECT
    business_id
FROM
    CTE_3
WHERE
    business_cnt > 1;
