-- 数据处理
-- 看一下数据
SELECT
    *
FROM shopping_trends
LIMIT 10;

-- 缺失值检测
SELECT
    *
FROM shopping_trends
WHERE `Customer ID` IS NULL OR `Age` IS NULL
    OR `Gender` IS NULL
    OR `Item Purchased` IS NULL
    OR Category IS NULL
    OR `Purchase Amount (USD)` IS NULL
    OR Location IS NULL
    OR Size IS NULL
    OR Color IS NULL
    OR Season IS NULL
    OR `Review Rating` IS NULL
    OR `Subscription Status` IS NULL
    OR `Shipping Type` IS NULL
    OR `Discount Applied` IS NULL
    OR `Promo Code Used` IS NULL
    OR `Previous Purchases` IS NULL
    OR `Payment Method` IS NULL
    OR `Frequency of Purchases` IS NULL;

-- 筛选重复值
SELECT
     COUNT(*)
FROM shopping_trends
GROUP BY `Customer ID`,
         `Age`,
         `Gender`,
         `Item Purchased`,
         `Category`,
         `Purchase Amount (USD)`,
         `Location`,
         Size, Color,
         Season,
         `Review Rating`,
         `Subscription Status`,
         `Shipping Type`,
         `Discount Applied`, `Promo Code Used`, `Previous Purchases`, `Payment Method`, `Frequency of Purchases`
HAVING COUNT(*) > 1;

-- 四、数据分析
-- 4.1 用户特征分析(年龄、性别、地域集中度)

-- 先查看年龄范围
SELECT
    MIN(`Age`),
    MAX(`Age`)
FROM shopping_trends;

-- 4.1.1 用户年龄分布
SELECT
    CASE
        WHEN `Age` <= 20 THEN '20岁以下'
        WHEN `Age` > 20 AND `Age` <= 30 THEN '21-30岁'
        WHEN `Age` > 30 AND `Age` <= 40 THEN '31-40岁'
        WHEN `Age` > 40 AND `Age` <= 50 THEN '41-50岁'
        WHEN `Age` > 50 AND `Age` <= 60 THEN '51-60岁'
        WHEN `Age` > 60 THEN '60岁以上'
    END AS `年龄段`,
    COUNT(*) AS `用户数量`
FROM shopping_trends
GROUP BY `年龄段`
ORDER BY `年龄段`;

-- 4.1.2 用户性别分布
SELECT
    `Gender`,
    COUNT(*) AS `用户数量`,
    CONCAT(ROUND(COUNT(*) / (SELECT COUNT(*) FROM shopping_trends) * 100, 2),'%') AS `性别占比`
FROM shopping_trends
GROUP BY `Gender`
ORDER BY `性别占比` DESC;

-- 4.1.3 用户地域分布
SELECT
    Location,
    COUNT(*) AS `用户数量`,
    SUM(`Purchase Amount (USD)`) AS `总消费金额`,
    AVG(`Purchase Amount (USD)`) AS `平均消费金额`
FROM shopping_trends
GROUP BY Location
ORDER BY `总消费金额` DESC
LIMIT 10;


-- 4.2 商品销售分析
-- 4.2.1 畅销商品类别分析
SELECT
    Category,
    COUNT(*) AS `销售数量`,
    SUM(`Purchase Amount (USD)`) AS `总销售额`,
    AVG(`Purchase Amount (USD)`) AS `平均销售额`
FROM shopping_trends
GROUP BY Category
ORDER BY `总销售额` DESC
LIMIT 10;

-- 4.2.2 商品颜色偏好分析
SELECT
    Color,
    COUNT(*) AS `销售数量`,
    SUM(`Purchase Amount (USD)`) AS `总销售额`,
    AVG(`Purchase Amount (USD)`) AS `平均销售额`
FROM shopping_trends
GROUP BY Color
ORDER BY `总销售额` DESC
LIMIT 10;

-- 4.2.3 季节性销售趋势分析
SELECT
    Season,
    COUNT(*) AS `销售数量`,
    SUM(`Purchase Amount (USD)`) AS `总销售额`,
    AVG(`Purchase Amount (USD)`) AS `平均销售额`
FROM shopping_trends
GROUP BY Season
ORDER BY `总销售额` DESC;

-- 4.3 用户购买行为特征分析
-- 4.3.1 支付方式偏好分析
SELECT
    `Payment Method`,
    COUNT(*) AS `数量`,
    CONCAT(ROUND(COUNT(*) / (SELECT COUNT(*) FROM shopping_trends) * 100, 2),'%') AS `支付方式占比`
FROM shopping_trends
GROUP BY `Payment Method`
ORDER BY `支付方式占比` DESC;

-- 4.3.2 配送方式偏好分析
SELECT
    `Shipping Type`,
    COUNT(*) AS `数量`,
    CONCAT(ROUND(COUNT(*) / (SELECT COUNT(*) FROM shopping_trends) * 100, 2),'%') AS `配送方式占比`,
    ROUND(AVG(`Purchase Amount (USD)`), 2) AS `平均消费金额`
FROM shopping_trends
GROUP BY `Shipping Type`;

-- 4.4 高复购客户分析
-- 4.4.1 历史购买次数分析
SELECT
    CASE
        WHEN `Previous Purchases` = 1 THEN '1次购买'
        WHEN `Previous Purchases` BETWEEN 2 AND 5 THEN '2-5次购买'
        WHEN `Previous Purchases` BETWEEN 6 AND 10 THEN '6-10次购买'
        WHEN `Previous Purchases` > 10 THEN '10次以上购买'
    END AS `购买次数`,
    COUNT(*) AS `客户数量`,
    CONCAT(ROUND(COUNT(*) / (SELECT COUNT(*) FROM shopping_trends) * 100, 2),'%') AS `购买次数占比`
FROM shopping_trends
GROUP BY `购买次数`
ORDER BY `客户数量` DESC;

-- 4.4.2 购买频率分析
WITH STEP1 AS(
    SELECT
        `Frequency of Purchases`,
        CASE
            WHEN `Previous Purchases` = 1 THEN '1次购买'
            WHEN `Previous Purchases` BETWEEN 2 AND 5 THEN '2-5次购买'
            WHEN `Previous Purchases` BETWEEN 6 AND 10 THEN '6-10次购买'
            WHEN `Previous Purchases` > 10 THEN '10次以上购买'
        END AS `购买次数`,
    COUNT(*) AS `客户数量`
    FROM shopping_trends
    GROUP BY `Frequency of Purchases`, `购买次数`
)
SELECT
    `Frequency of Purchases` AS `购买频率`,
    SUM(CASE WHEN `购买次数` = '1次购买' THEN `客户数量` ELSE 0 END) AS `1次购买客户数量`,
    SUM(CASE WHEN `购买次数` = '2-5次购买' THEN `客户数量` ELSE 0 END) AS `2-5次购买客户数量`,
    SUM(CASE WHEN `购买次数` = '6-10次购买' THEN `客户数量` ELSE 0 END) AS `6-10次购买客户数量`,
    SUM(CASE WHEN `购买次数` = '10次以上购买' THEN `客户数量` ELSE 0 END) AS `10次以上购买客户数量`
FROM STEP1
GROUP BY `Frequency of Purchases`;

-- 4.4.3 高复购用户的特征
SELECT
    COUNT(CASE
                WHEN `Previous Purchases` > 5 AND `Frequency of Purchases` IN ('Bi-Weekly','Weekly','Fortnightly')
        THEN `Customer ID`
        ELSE NULL
        END) AS `高复购用户数量`,
    CONCAT(ROUND(COUNT(CASE
                            WHEN `Previous Purchases` > 5 AND `Frequency of Purchases` IN ('Bi-Weekly','Weekly','Fortnightly')
                        THEN `Customer ID`
                        ELSE NULL
                        END) / (SELECT COUNT(*) FROM shopping_trends) * 100, 2),'%') AS `高复购用户占比`
FROM shopping_trends;

-- 4.5 忠诚度分析
WITH STEP1 AS(
    SELECT
        `Previous Purchases` AS `购买次数`,
        CASE
            WHEN `Frequency of Purchases` = 'Bi-Weekly' THEN 7
            WHEN `Frequency of Purchases` = 'Weekly' THEN 6
            WHEN `Frequency of Purchases` = 'Fortnightly' THEN 5
            WHEN `Frequency of Purchases` = 'Monthly' THEN 4
            WHEN `Frequency of Purchases` = 'Every 3 Months' THEN 3
            WHEN `Frequency of Purchases` = 'Quarterly' THEN 2
            WHEN `Frequency of Purchases` = 'Annually' THEN 1
        END AS `购买频率打分`,
        CASE
            WHEN `Purchase Amount (USD)` < AVG(`Purchase Amount (USD)`) OVER(PARTITION BY Category) * 0.8 THEN 1
            WHEN `Purchase Amount (USD)` BETWEEN AVG(`Purchase Amount (USD)`) OVER(PARTITION BY Category) * 0.8
                AND AVG(`Purchase Amount (USD)`) OVER(PARTITION BY Category) * 1.2 THEN 2
            WHEN `Purchase Amount (USD)` > AVG(`Purchase Amount (USD)`) OVER(PARTITION BY Category) * 1.2 THEN 3
        END AS `消费金额打分`,
        IF(`Discount Applied` = 'Yes', 1, 0) AS `折扣使用打分`,
        `Review Rating` AS `评价打分`,
        IF(`Subscription Status` = 'Yes', 1, 0) AS `订阅使用打分`
    FROM shopping_trends
),
    STEP2 AS(
        SELECT
            (购买次数 - MIN(购买次数)OVER()) / (MAX(购买次数)OVER() - MIN(购买次数)OVER()) * 100 AS X1,
            (购买频率打分 - MIN(购买频率打分)OVER()) / (MAX(购买频率打分)OVER() - MIN(购买频率打分)OVER()) * 100 AS X2,
            (消费金额打分 - MIN(消费金额打分)OVER()) / (MAX(消费金额打分)OVER() - MIN(消费金额打分)OVER()) * 100 AS X3,
            (折扣使用打分 - MIN(折扣使用打分)OVER()) / (MAX(折扣使用打分)OVER() - MIN(折扣使用打分)OVER()) * 100 AS X4,
            (评价打分 - MIN(评价打分)OVER()) / (MAX(评价打分)OVER() - MIN(评价打分)OVER()) * 100 AS X5,
            (订阅使用打分 - MIN(订阅使用打分)OVER()) / (MAX(订阅使用打分)OVER() - MIN(订阅使用打分)OVER()) * 100 AS X6
        FROM STEP1
    )
SELECT
    CASE WHEN 忠诚度得分 < 20 THEN '忠诚度极低'
        WHEN 忠诚度得分 >= 20 AND 忠诚度得分 < 40 THEN '忠诚度低'
        WHEN 忠诚度得分 >= 40 AND 忠诚度得分 < 60 THEN '忠诚度中'
        WHEN 忠诚度得分 >= 60 AND 忠诚度得分 < 80 THEN '忠诚度高'
        WHEN 忠诚度得分 >= 80 THEN '忠诚度极高'
    END AS `忠诚度`,
    COUNT(*) AS `客户数量`
FROM (SELECT
          X1 * 0.25 + X2 * 0.2 + X3 * 0.2 + X4 * 0.05 + X5 * 0.15 + X6 * 0.15 AS `忠诚度得分`
      FROM STEP2
          ) AS t
GROUP BY `忠诚度`
ORDER BY FIELD(`忠诚度`, '忠诚度极低', '忠诚度低', '忠诚度中', '忠诚度高', '忠诚度极高');
