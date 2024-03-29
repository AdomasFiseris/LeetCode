# Write your MySQL query statement below
WITH ConsecutiveVisits AS (
    SELECT
        id,
        visit_date,
        people,
        LAG(people, 1) OVER (ORDER BY id) AS prev_people,
        LAG(people, 2) OVER (ORDER BY id) AS prev_people2,
        LEAD(people, 1) OVER (ORDER BY id) AS next_people,
        LEAD(people, 2) OVER (ORDER BY id) AS next_people2
    FROM
        Stadium
),
Marked AS (
    SELECT
        id,
        visit_date,
        people
    FROM
        ConsecutiveVisits
    WHERE
        (people >= 100 AND prev_people >= 100 AND prev_people2 >= 100)
        OR (people >= 100 AND prev_people >= 100 AND next_people >= 100)
        OR (people >= 100 AND next_people >= 100 AND next_people2 >= 100)
)
SELECT
    id,
    visit_date,
    people
FROM
    Marked
ORDER BY
    visit_date ASC;