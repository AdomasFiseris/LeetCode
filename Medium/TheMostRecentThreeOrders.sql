# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        customer_id,
        order_id,
        order_date,
        RANK() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS ranked
    FROM
        Orders
)
SELECT
    Customers.name AS customer_name,
    CTE.customer_id,
    CTE.order_id,
    CTE.order_date
FROM
    Customers
JOIN
    CTE ON Customers.customer_id = CTE.customer_id
WHERE
    CTE.ranked = 1 OR CTE.ranked = 2 OR CTE.ranked = 3
ORDER BY
    Customers.name ASC,
    CTE.customer_id ASC,
    CTE.order_date DESC;
