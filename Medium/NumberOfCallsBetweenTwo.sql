# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        CASE WHEN from_id < to_id THEN from_id ELSE to_id END AS person1,
        CASE
            WHEN (CASE WHEN from_id > to_id THEN to_id ELSE from_id END) = to_id 
            THEN from_id ELSE to_id END AS person2,
        duration
    FROM
        Calls
)
SELECT
    person1,
    person2,
    COUNT(*) AS call_count,
    SUM(duration) AS total_duration
FROM
    CTE
GROUP BY
    person1,
    person2;
