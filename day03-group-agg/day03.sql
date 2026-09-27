-- Day03 分组聚合函数：COUNT SUM AVG MAX MIN GROUP BY HAVING
-- 运营指标：每日订单量、GMV、客单价

--1. 按日期分组，统计每日订单数、总GMV、平均订单金额
SELECT DATE(create_time) AS order_date,
       COUNT(order_id) AS order_cnt,
       SUM(order_amount) AS gmv,
       AVG(order_amount) AS avg_amount
FROM orders
WHERE order_status = 'paid'
GROUP BY order_date;

--2. 按用户分组，统计每个用户下单次数和消费总额，只保留消费总额大于300的用户
SELECT user_id,
       COUNT(order_id) AS user_order_count,
       SUM(order_amount) AS total_consume
FROM orders
WHERE order_status = 'paid'
GROUP BY user_id
HAVING total_consume > 300;

--3. 按渠道source分组，查看每个渠道最大单笔订单金额、最小金额
SELECT source,
       MAX(order_amount) AS max_single_amount,
       MIN(order_amount) AS min_single_amount
FROM orders
GROUP BY source;

-- 面试重点：WHERE过滤原始数据，HAVING过滤分组后的结果
