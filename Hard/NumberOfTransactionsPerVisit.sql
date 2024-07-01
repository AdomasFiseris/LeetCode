# Write your MySQL query statement below
WITH RECURSIVE transaction_counts AS (
    SELECT
        Visits.user_id,
        Visits.visit_date,
        COUNT(Transactions.user_id) AS transactions_count
    FROM
        Visits
    LEFT JOIN
        Transactions ON Visits.user_id = Transactions.user_id AND Visits.visit_date = Transactions.transaction_date
    GROUP BY
        Visits.user_id, Visits.visit_date
),
max_transactions AS (
    SELECT MAX(transactions_count) AS max_value FROM transaction_counts
),
numbers AS (
    SELECT 0 AS num
    UNION ALL
    SELECT num + 1
    FROM numbers, max_transactions
    WHERE num < max_transactions.max_value
)
SELECT
    numbers.num AS transactions_count,
    COUNT(transaction_counts.transactions_count) AS visits_count
FROM
    numbers
LEFT JOIN
    transaction_counts ON numbers.num = transaction_counts.transactions_count
GROUP BY
    numbers.num
ORDER BY
    numbers.num;
