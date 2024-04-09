# Write your MySQL query statement below
WITH A AS (
    SELECT
        customer_id
    FROM
        Orders
    WHERE
        product_name = 'A'
), B AS (
    SELECT
        customer_id
    FROM
        Orders
    WHERE
        product_name = 'B'
), NotC AS (
    SELECT
        customer_id
    FROM
        Orders
    WHERE
        product_name = 'C'
), Merged AS (
    SELECT
        A.customer_id
    FROM
        A
    JOIN
        B ON A.customer_id = B.customer_id
    WHERE
        A.customer_id NOT IN (SELECT * FROM NotC)
)
SELECT
    Merged.customer_id,
    Customers.customer_name
FROM
    Merged
JOIN
    Customers ON Merged.customer_id = Customers.customer_id
GROUP BY
    Merged.customer_id
ORDER BY
    Merged.customer_id
