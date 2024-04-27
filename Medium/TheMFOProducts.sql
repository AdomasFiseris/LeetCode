# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        Orders.customer_id,
        Orders.product_id,
        Products.product_name,
        COUNT(*) AS product_count
    FROM
        Orders
    JOIN
        Products ON Orders.product_id = Products.product_id
    GROUP BY
        Orders.customer_id,
        Orders.product_id,
        Products.product_name
), CTE_2 AS (
    SELECT
        customer_id,
        MAX(product_count) AS max_count
    FROM
        CTE
    GROUP BY
        customer_id
)
SELECT
    CTE.product_id,
    CTE.product_name,
    CTE.customer_id
FROM
    CTE
JOIN
    CTE_2 ON CTE.customer_id = CTE_2.customer_id
    AND CTE.product_count = CTE_2.max_count;
