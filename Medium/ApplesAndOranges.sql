# Write your MySQL query statement below
SELECT
    Apples.sale_date,
    Apples.sold_num - Oranges.sold_num AS diff
FROM
    (SELECT * FROM Sales WHERE fruit = 'apples') AS Apples
JOIN
    (SELECT * FROM Sales WHERE fruit = 'oranges') AS Oranges ON Apples.sale_date = Oranges.sale_date
GROUP BY
    sale_date
ORDER BY
    sale_date;
