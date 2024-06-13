# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        first_player AS player,
        SUM(first_score) AS score
    FROM
        Matches
    GROUP BY
        first_player

    UNION ALL

    SELECT
        second_player AS player,
        SUM(second_score) AS score
    FROM
        Matches
    GROUP BY
        second_player
), CTE_2 AS (
    SELECT
        player,
        SUM(score) AS score
    FROM
        CTE
    GROUP BY
        player
), CTE_3 AS (
    SELECT
        Players.group_id,
        CTE_2.player AS player_id,
        CTE_2.score,
        RANK() OVER (PARTITION BY Players.group_id ORDER BY CTE_2.score DESC, player ASC) AS ranked
    FROM
        Players
    LEFT JOIN
        CTE_2 ON Players.player_id = CTE_2.player
)
SELECT
    group_id AS GROUP_ID,
    player_id AS PLAYER_ID
FROM
    CTE_3
WHERE
    ranked = 1;
