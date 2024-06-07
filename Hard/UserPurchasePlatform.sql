WITH CTE AS (
    SELECT
        spend_date,
        user_id
    FROM
        Spending
    WHERE
        platform = 'mobile'
    GROUP BY
        spend_date, user_id
), CTE_2 AS (
    SELECT
        spend_date,
        user_id
    FROM
        Spending
    WHERE
        platform = 'desktop'
    GROUP BY
        spend_date, user_id
), CTE_3 AS (
    SELECT
        CTE.spend_date,
        'both' AS platform,
        CTE.user_id
    FROM
        CTE
    JOIN
        CTE_2 ON CTE.user_id = CTE_2.user_id AND CTE.spend_date = CTE_2.spend_date
    GROUP BY
        CTE.spend_date, CTE.user_id
), DatePlatform AS (
    SELECT DISTINCT spend_date FROM Spending
), Platforms AS (
    SELECT 'mobile' AS platform UNION ALL
    SELECT 'desktop' UNION ALL
    SELECT 'both'
), DatePlatformCross AS (
    SELECT spend_date, platform FROM DatePlatform CROSS JOIN Platforms
)
SELECT
    DatePlatformCross.spend_date,
    DatePlatformCross.platform,
    COALESCE(SUM(CASE 
                    WHEN Spending.platform = 'mobile' AND DatePlatformCross.platform = 'mobile' AND Spending.user_id NOT IN (SELECT user_id FROM CTE_3 WHERE CTE_3.spend_date = Spending.spend_date) THEN Spending.amount
                    WHEN Spending.platform = 'desktop' AND DatePlatformCross.platform = 'desktop' AND Spending.user_id NOT IN (SELECT user_id FROM CTE_3 WHERE CTE_3.spend_date = Spending.spend_date) THEN Spending.amount
                    WHEN DatePlatformCross.platform = 'both' AND CTE_3.user_id IS NOT NULL THEN Spending.amount
                    ELSE 0 
                 END), 0) AS total_amount,
    COALESCE(COUNT(DISTINCT CASE 
                                WHEN DatePlatformCross.platform = 'mobile' AND Spending.platform = 'mobile' AND Spending.user_id NOT IN (SELECT user_id FROM CTE_3 WHERE CTE_3.spend_date = Spending.spend_date) THEN Spending.user_id
                                WHEN DatePlatformCross.platform = 'desktop' AND Spending.platform = 'desktop' AND Spending.user_id NOT IN (SELECT user_id FROM CTE_3 WHERE CTE_3.spend_date = Spending.spend_date) THEN Spending.user_id
                                WHEN DatePlatformCross.platform = 'both' AND CTE_3.user_id IS NOT NULL THEN CTE_3.user_id
                                ELSE NULL 
                            END), 0) AS total_users
FROM
    DatePlatformCross
LEFT JOIN
    Spending ON DatePlatformCross.spend_date = Spending.spend_date
LEFT JOIN
    CTE_3 ON DatePlatformCross.spend_date = CTE_3.spend_date AND DatePlatformCross.platform = 'both' AND Spending.user_id = CTE_3.user_id
GROUP BY
    DatePlatformCross.spend_date, DatePlatformCross.platform
ORDER BY
    DatePlatformCross.spend_date, DatePlatformCross.platform;
