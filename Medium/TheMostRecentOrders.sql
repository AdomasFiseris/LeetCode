# Write your MySQL query statement below
WITH CTE AS (
SELECT
    product_id,
    order_id,
    order_date,
    RANK() OVER (PARTITION BY product_id ORDER BY order_date DESC) as ranked
FROM
    Orders
)
SELECT
    Products.product_name,
    CTE.product_id,
    CTE.order_id,
    CTE.order_date
FROM
    CTE
JOIN
    Products ON CTE.product_id = Products.product_id
WHERE
    ranked = 1
ORDER BY
    Products.product_name ASC,
    product_id ASC,
    order_id ASC;
