# Write your MySQL query statement below
WITH CTE AS(
    SELECT
        user2_id AS friend_1
    FROM
        Friendship
    WHERE
        user1_id = '1'
    
    UNION ALL

    SELECT
        user1_id AS friend_1
    FROM
        Friendship
    WHERE
        user2_id = '1'
)
SELECT
    DISTINCT page_id AS recommended_page
FROM
    Likes
RIGHT JOIN
    CTE ON Likes.user_id = CTE.friend_1
WHERE
    page_id NOT IN (SELECT page_id FROM Likes WHERE user_id = '1') AND page_id IS NOT NULL;
