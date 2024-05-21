# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        DISTINCT Sales.buyer_id
    FROM
        Sales
    LEFT JOIN
        Product ON Sales.product_id = Product.product_id
    WHERE
        Product.product_name = 'iPhone'
)
SELECT
    DISTINCT Sales.buyer_id
FROM
    Sales
LEFT JOIN
    Product ON Sales.product_id = Product.product_id
WHERE
    Product.product_name = 'S8' AND Sales.buyer_id NOT IN (SELECT buyer_id FROM CTE);
