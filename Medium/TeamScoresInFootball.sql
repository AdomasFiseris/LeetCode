# Write your MySQL query statement below
WITH CTE AS(
    SELECT
        host_team AS team,
        SUM(CASE
                WHEN host_goals > guest_goals THEN 3
                WHEN host_goals < guest_goals THEN 0
                ELSE 1
            END) AS num_points
    FROM
        Matches
    GROUP BY
        host_team

    UNION ALL

    SELECT
        guest_team AS team,
        SUM(CASE
                WHEN guest_goals > host_goals THEN 3
                WHEN guest_goals < host_goals THEN 0
                ELSE 1
            END) AS num_points
    FROM
        Matches
    GROUP BY
        guest_team
)
SELECT
    Teams.team_id,
    Teams.team_name,
    COALESCE(SUM(CTE.num_points), 0) AS num_points
FROM
    Teams
LEFT JOIN
    CTE ON Teams.team_id = CTE.team
GROUP BY
    Teams.team_id
ORDER BY
    num_points DESC,
    Teams.team_id ASC;
