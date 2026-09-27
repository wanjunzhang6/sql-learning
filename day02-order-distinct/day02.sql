-- Day02 ORDER BY DISTINCT 电商业务练习
-- 知识点：去重、升序降序排序

-- 1. 查询所有已支付订单，按下单时间从新到旧排序
SELECT order_id, user_id, create_time, order_amount
FROM orders
WHERE order_status = 'paid'
ORDER BY create_time DESC;

-- 2. 查询所有订单，按金额降序，金额相同则按用户id升序
SELECT order_id, user_id, order_amount
FROM orders
ORDER BY order_amount DESC, user_id ASC;

-- 3. 统计一共有多少独立下单用户（去重统计）
SELECT COUNT(DISTINCT user_id) AS total_unique_user
FROM orders;

-- 4. 查询订单来源有哪几种（去重查看渠道）
SELECT DISTINCT source
FROM orders;

-- 5. 筛选金额>50的订单，按金额升序，只取前20条
SELECT order_id,user_id,order_amount
FROM orders
WHERE order_amount >50
ORDER BY order_amount ASC
LIMIT 20;
