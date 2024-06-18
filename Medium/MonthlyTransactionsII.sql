# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        DATE_FORMAT(trans_date, '%Y-%m') AS month,
        country,
        (CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
        (CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_amount,
        0 AS chargeback_count,
        0 AS chargeback_amount
    FROM
        Transactions

    UNION ALL

    SELECT
        DATE_FORMAT(Chargebacks.trans_date, '%Y-%m') AS month,
        Transactions.country,
        0 AS approved_count,
        0 AS approved_amount,
        1 AS chargeback_count,
        Transactions.amount AS chargeback_amount
    FROM
        Transactions
    JOIN
        Chargebacks ON Transactions.id = Chargebacks.trans_id
)
SELECT
    month,
    country,
    SUM(approved_count) AS approved_count,
    SUM(approved_amount) AS approved_amount,
    SUM(chargeback_count) AS chargeback_count,
    SUM(chargeback_amount) AS chargeback_amount
FROM
    CTE
WHERE
    approved_count > 1 OR 
    approved_amount > 1 OR 
    chargeback_count > 1 OR 
    chargeback_amount > 1
GROUP BY
    month,
    country;
