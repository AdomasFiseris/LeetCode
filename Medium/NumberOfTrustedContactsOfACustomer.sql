# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        Customers.customer_id,
        COUNT(Contacts.contact_name) AS contacts_cnt,
        SUM(Contacts.contact_name IN (SELECT customer_name FROM Customers)) AS trusted_contacts_cnt
    FROM
        Customers
    LEFT JOIN
        Contacts ON Customers.customer_id = Contacts.user_id
    GROUP BY
        Customers.customer_id
)
SELECT
    Invoices.invoice_id,
    Customers.customer_name,
    Invoices.price,
    COALESCE(CTE.contacts_cnt, 0) AS contacts_cnt,
    COALESCE(CTE.trusted_contacts_cnt, 0) AS trusted_contacts_cnt
FROM
    Invoices
LEFT JOIN
    Customers ON Invoices.user_id = Customers.customer_id
LEFT JOIN
    CTE ON Invoices.user_id = CTE.customer_id
ORDER BY
    Invoices.invoice_id;
