WITH CTE AS (
    SELECT
        book_id
    FROM
        Books
    WHERE
        available_from BETWEEN '2019-05-23' AND '2019-06-23'
),
CTE_2 AS (
    SELECT
        book_id,
        SUM(quantity) AS total_sold
    FROM
        Orders
    WHERE
        dispatch_date BETWEEN '2018-06-23' AND '2019-06-23'
    GROUP BY
        book_id
)
SELECT
    Books.book_id,
    Books.name
FROM
    Books
LEFT JOIN CTE_2 ON Books.book_id = CTE_2.book_id
WHERE
    Books.book_id NOT IN (SELECT book_id FROM CTE)
    AND (CTE_2.total_sold < 10 OR CTE_2.total_sold IS NULL)
    AND Books.available_from <= '2019-05-23';
