# Write your MySQL query statement below
WITH RankedLogs AS (
    SELECT
        log_id,
        log_id - ROW_NUMBER() OVER (ORDER BY log_id) AS gap
    FROM
        Logs
), GroupedLogs AS (
    SELECT
        log_id,
        MIN(log_id) OVER (PARTITION BY gap) AS start_id
    FROM
        RankedLogs
)
SELECT
    start_id,
    MAX(log_id) AS end_id
FROM
    GroupedLogs
GROUP BY
    start_id
ORDER BY
    start_id;
