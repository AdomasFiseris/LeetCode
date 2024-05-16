# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        SUM(amount) / COUNT(id) AS average_company_per_month,
        DATE_FORMAT(Salary.pay_date, '%Y-%m') AS month
    FROM
        Salary
    GROUP BY
        month
), CTE_2 AS (
    SELECT
        Employee.department_id,
        SUM(Salary.amount) / COUNT(Salary.employee_id) AS average_department_per_month,
        DATE_FORMAT(Salary.pay_date, '%Y-%m') AS pay_month
    FROM
        Employee
    JOIN
        Salary ON Employee.employee_id = Salary.employee_id
    GROUP BY
        Employee.department_id,
        pay_month
)
SELECT
    CTE_2.pay_month,
    CTE_2.department_id,
    CASE
        WHEN CTE_2.average_department_per_month > CTE.average_company_per_month THEN 'higher'
        WHEN CTE_2.average_department_per_month = CTE.average_company_per_month THEN 'same'
        ELSE 'lower'
    END AS comparison
FROM
    CTE_2
JOIN
    CTE ON CTE_2.pay_month = CTE.month;
