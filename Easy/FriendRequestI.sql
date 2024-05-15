# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        requester_id,
        accepter_id
    FROM
        RequestAccepted
    GROUP BY
        requester_id,
        accepter_id
), CTE_2 AS (
    SELECT
        COUNT(requester_id) AS accepted_count
    FROM
        CTE
), CTE_3 AS (
    SELECT
        sender_id,
        send_to_id
    FROM
        FriendRequest
    GROUP BY
        sender_id,
        send_to_id
), CTE_4 AS (
    SELECT
        COUNT(sender_id) AS all_requests
    FROM
        CTE_3
)
SELECT
    ROUND(COALESCE((CTE_2.accepted_count / CTE_4.all_requests), 0.00), 2) AS accept_rate
FROM
    CTE_2,
    CTE_4;
