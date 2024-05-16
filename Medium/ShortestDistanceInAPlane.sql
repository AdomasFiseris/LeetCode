# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        x,
        y,
        ROW_NUMBER() OVER () AS row_num
    FROM
        Point2D
), CTE_2 AS (
    SELECT
        a.x AS x1,
        a.y AS y1,
        b.x AS x2,
        b.y AS y2,
        ROUND(SQRT(POW(b.x - a.x, 2) + POW(b.y - a.y, 2)), 2) AS shortest
    FROM
        CTE a, CTE b
    WHERE
        a.row_num <> b.row_num
    ORDER BY
        shortest ASC
)
SELECT
    CTE_2.shortest AS shortest
FROM
    CTE_2
LIMIT 1;
