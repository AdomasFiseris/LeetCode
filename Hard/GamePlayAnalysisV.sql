# Write your MySQL query statement below
WITH Install_Days AS (
    SELECT
        player_id,
        MIN(event_date) AS install_dates
    FROM
        Activity
    GROUP BY
        player_id
), Consecutive_days AS (
    SELECT
        Activity.player_id,
        Activity.event_date,
        Install_Days.install_dates,
        LEAD(Activity.event_date, 1) OVER (PARTITION BY Activity.player_id ORDER BY Activity.event_date ASC) AS consecutive_day
    FROM
        Activity
    JOIN
        Install_Days ON Activity.player_id = Install_Days.player_id
), Retained AS (
    SELECT
        player_id,
        install_dates,
        CASE
            WHEN DATEDIFF(consecutive_day, install_dates) = 1 THEN 'YES'
            ELSE 'NO'
        END AS retention_enum
    FROM
        Consecutive_days
)
SELECT
    DISTINCT install_dates AS install_dt,
    COUNT(DISTINCT player_id) AS installs,
    ROUND(
        SUM(CASE WHEN retention_enum = 'YES' THEN 1 ELSE 0 END) /
        COUNT(DISTINCT player_id),
        2) AS Day1_retention
FROM
    Retained
GROUP BY
    install_dates;
