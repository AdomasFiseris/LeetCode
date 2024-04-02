# Write your MySQL query statement below
WITH Buy AS (
    SELECT
        stock_name,
        SUM(price) AS BuyPrice
    FROM
        Stocks
    WHERE
        operation = 'Buy'
    GROUP BY
        stock_name
), Sell AS (
    SELECT
        stock_name,
        SUM(price) AS SellPrice
    FROM
        Stocks
    WHERE
        operation = 'Sell'
    GROUP BY
        stock_name
)
SELECT
    Buy.stock_name,
    (Sell.SellPrice - Buy.BuyPrice) AS capital_gain_loss
FROM
    Buy
JOIN
    Sell ON Buy.stock_name = Sell.stock_name