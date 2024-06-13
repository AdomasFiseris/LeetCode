# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        Users.user_id,
        Orders.order_id,
        Orders.item_id,
        Orders.order_date,
        RANK() OVER (PARTITION BY Users.user_id ORDER BY Orders.order_date ASC) AS ranked
    FROM
        Users
    JOIN
        Orders ON Users.user_id = Orders.seller_id
), CTE_2 AS (
    SELECT
        Users.user_id,
        COALESCE(CTE.item_id, 'no_second_item') AS second_item,
        Users.favorite_brand
    FROM
        Users
    LEFT JOIN
        CTE ON Users.user_id = CTE.user_id AND CTE.ranked = 2
), CTE_3 AS (
    SELECT
        CTE_2.user_id,
        CTE_2.second_item,
        CTE_2.favorite_brand,
        Items.item_brand
    FROM
        CTE_2
    LEFT JOIN
        Items ON CTE_2.second_item = Items.item_id
)
SELECT
    user_id AS seller_id,
    CASE
        WHEN favorite_brand = item_brand THEN 'yes'
        ELSE 'no'
    END AS 2nd_item_fav_brand
FROM
    CTE_3;
