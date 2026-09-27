-- Day06 窗口函数 row_number() rank() 用于用户行为、复购分析
-- 业务场景：标记用户每次下单时间，找用户首次下单、末次下单

-- 1. 给每个用户订单按下单时间排序，标记用户第N次下单
SELECT user_id,order_id,create_time,order_amount,
ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY create_time ASC) AS order_seq
FROM orders
WHERE order_status='paid';

--2. 获取每个用户第一次下单时间和最近一次下单时间
SELECT DISTINCT user_id,
FIRST_VALUE(create_time) OVER(PARTITION BY user_id ORDER BY create_time) AS first_order_time,
LAST_VALUE(create_time) OVER(PARTITION BY user_id ORDER BY create_time ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_order_time
FROM orders;

--3. 按日期，计算GMV以及累计GMV
SELECT order_date,gmv,
SUM(gmv) OVER(ORDER BY order_date) AS accumulate_gmv
FROM (
    SELECT DATE(create_time) AS order_date, SUM(order_amount) gmv
    FROM orders WHERE order_status='paid'
    GROUP BY order_date
) t;
