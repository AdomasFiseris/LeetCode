# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        COUNT(delivery_id) AS same_day
    FROM
        Delivery
    WHERE
        order_date = customer_pref_delivery_date
), CTE_2 AS (
    SELECT
        COUNT(delivery_id) AS any_time
    FROM
        Delivery
)
SELECT
    ROUND((CTE.same_day / CTE_2.any_time * 100), 2) AS immediate_percentage
FROM
    CTE
CROSS JOIN
    CTE_2;
