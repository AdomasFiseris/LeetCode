# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        caller_id AS person_id,
        duration
    FROM
        Calls

    UNION ALL

    SELECT
        callee_id AS person_id,
        duration
    FROM
        Calls
), CTE_2 AS(
    SELECT
        SUBSTRING(Person.phone_number, 1, 3) AS country_code_phone,
        SUM(CTE.duration) AS total_country_duration,
        COUNT(CTE.person_id) AS number_of_people,
        SUM(CTE.duration) / COUNT(CTE.person_id) AS average_country_duration
    FROM
        Person
    JOIN
        CTE ON Person.id = CTE.person_id
    GROUP BY
        country_code_phone
)
SELECT
    Country.name AS country
FROM
    Country
JOIN
    CTE_2 ON Country.country_code = CTE_2.country_code_phone
WHERE
    CTE_2.average_country_duration > (SELECT
                                            SUM(total_country_duration) / SUM(number_of_people) AS global_average
                                        FROM
                                            CTE_2);
