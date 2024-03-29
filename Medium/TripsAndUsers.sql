WITH BannedClient AS (
    SELECT
        Users.users_id AS BannedUser_id
    FROM
        Trips
    JOIN
        Users ON Trips.client_id = Users.users_id
    WHERE
        Users.banned = 'Yes'
),
BannedDriver AS (
    SELECT
        Users.users_id AS BannedUser_id
    FROM
        Trips
    JOIN
        Users ON Trips.driver_id = Users.users_id
    WHERE
        Users.banned = 'Yes'
),
BannedUsers AS (
    SELECT BannedUser_id FROM BannedClient
    UNION
    SELECT BannedUser_id FROM BannedDriver
)
SELECT 
    Trips.request_at AS `Day`,
    ROUND(
            SUM(CASE WHEN Trips.status != 'completed' AND Trips.client_id NOT IN (SELECT BannedUser_id FROM BannedUsers) AND Trips.driver_id NOT IN (SELECT BannedUser_id FROM BannedUsers) THEN 1 ELSE 0 END) /
            NULLIF(SUM(CASE WHEN Trips.client_id NOT IN (SELECT BannedUser_id FROM BannedUsers) AND Trips.driver_id NOT IN (SELECT BannedUser_id FROM BannedUsers) THEN 1 ELSE 0 END), 0)
    , 2) AS `Cancellation Rate`
FROM 
    Trips
WHERE 
    Trips.request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY 
    Trips.request_at
HAVING
    ROUND(
            SUM(CASE WHEN Trips.status != 'completed' AND Trips.client_id NOT IN (SELECT BannedUser_id FROM BannedUsers) AND Trips.driver_id NOT IN (SELECT BannedUser_id FROM BannedUsers) THEN 1 ELSE 0 END) /
            NULLIF(SUM(CASE WHEN Trips.client_id NOT IN (SELECT BannedUser_id FROM BannedUsers) AND Trips.driver_id NOT IN (SELECT BannedUser_id FROM BannedUsers) THEN 1 ELSE 0 END), 0)
    , 2) IS NOT NULL;