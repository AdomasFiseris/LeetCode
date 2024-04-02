WITH CTE AS (
    SELECT
        buyer_id,
        SUM(CASE WHEN EXTRACT(YEAR FROM order_date) = 2019 THEN 1 ELSE 0 END) AS orders_in_2019
    FROM
        Orders
    GROUP BY
        buyer_id
)
SELECT
    Users.user_id AS buyer_id,
    Users.join_date,
    COALESCE(CTE.orders_in_2019, 0) AS orders_in_2019
FROM
    Users
LEFT JOIN
    CTE ON Users.user_id = CTE.buyer_id;