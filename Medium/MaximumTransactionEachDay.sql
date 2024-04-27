# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        transaction_id,
        day,
        amount,
        RANK() OVER (PARTITION BY day ORDER BY amount DESC) AS ranked
    FROM
        Transactions
)
SELECT
    transaction_id
FROM
    CTE
WHERE
    ranked = 1
ORDER BY
    transaction_id ASC;
