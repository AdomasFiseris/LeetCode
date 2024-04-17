WITH CTE AS (
    SELECT
        Orders.customer_id,
        SUM(Orders.quantity * Product.price) AS order_amount
    FROM
        Orders
    JOIN
        Product ON Orders.product_id = Product.product_id
    WHERE
        (EXTRACT(YEAR FROM order_date) = 2020 AND EXTRACT(MONTH FROM order_date) = 6)
    GROUP BY
        Orders.customer_id
    HAVING
        order_amount >= 100
), CTE_2 AS (
    SELECT
        Orders.customer_id,
        SUM(Orders.quantity * Product.price) AS order_amount
    FROM
        Orders
    JOIN
        Product ON Orders.product_id = Product.product_id
    WHERE
        EXTRACT(YEAR FROM order_date) = 2020 AND EXTRACT(MONTH FROM order_date) = 7
    GROUP BY
        Orders.customer_id
    HAVING
        order_amount >= 100
)
SELECT
    CTE.customer_id,
    Customers.name
FROM
    Customers
JOIN
    CTE ON Customers.customer_id = CTE.customer_id
JOIN
    CTE_2 ON Customers.customer_id = CTE_2.customer_id
GROUP BY
    CTE.customer_id,
    Customers.name;
