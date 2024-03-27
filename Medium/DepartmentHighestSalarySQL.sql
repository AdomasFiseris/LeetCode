# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        Department.name AS Department,
        Employee.name AS Employee,
        Employee.salary AS Salary,
        DENSE_RANK() OVER (PARTITION BY Department.name ORDER BY salary DESC) as ranking
    FROM
        Employee
    JOIN
        Department ON Employee.departmentId = Department.id
)
SELECT
    CTE.Department,
    CTE.Employee,
    CTE.Salary
FROM
    CTE
WHERE
    ranking = 1