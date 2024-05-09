# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        'failed' AS period_state,
        fail_date AS date
    FROM
        Failed
    UNION ALL
    SELECT
        'succeeded' AS period_state,
        success_date AS date
    FROM
        Succeeded
), CTE_2 AS (
    SELECT
        period_state,
        date
    FROM
        CTE
    WHERE
        date BETWEEN '2019-01-01' AND '2019-12-31'
    ORDER BY
        date ASC
)
SELECT 
    period_state, 
    MIN(date) AS start_date, 
    MAX(date) AS end_date
FROM (
    SELECT
        period_state,
        date,
        @group_number := IF(@previous_state = period_state AND @previous_date = DATE_SUB(date, INTERVAL 1 DAY), @group_number, @group_number + 1) AS group_number,
        @previous_state := period_state,
        @previous_date := date
    FROM
        CTE_2,
        (SELECT @previous_state := NULL, @previous_date := NULL, @group_number := 0) AS vars
    ORDER BY
        date
) AS grouped
GROUP BY
    group_number, period_state
ORDER BY
    MIN(date);
