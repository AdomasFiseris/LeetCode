# Write your MySQL query statement below
WITH CTE AS(
    SELECT
        DISTINCT Wimbledon AS player_id,
        COUNT(Wimbledon) AS wins
    FROM
        Championships
    GROUP BY
        player_id

    UNION ALL

    SELECT
        DISTINCT Fr_open AS player_id,
        COUNT(Fr_open) AS wins
    FROM
        Championships
    GROUP BY
        player_id
    
    UNION ALL

    SELECT
        DISTINCT US_open AS player_id,
        COUNT(US_open) AS wins
    FROM
        Championships
    GROUP BY
        player_id
    
    UNION ALL

    SELECT
        DISTINCT Au_open AS player_id,
        COUNT(Au_open) AS wins
    FROM
        Championships
    GROUP BY
        player_id
)
SELECT
    CTE.player_id,
    Players.player_name,
    SUM(CTE.wins) AS grand_slams_count
FROM
    CTE
LEFT JOIN
    Players ON CTE.player_id = Players.player_id
GROUP BY
    CTE.player_id
ORDER BY
    CTE.player_id;
