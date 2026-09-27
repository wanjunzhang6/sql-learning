-- Day04 多表联查 LEFT JOIN / INNER JOIN
-- 表：orders订单表、users用户表
-- users(user_id,user_name,register_time,city)

--1. INNER JOIN 查询已支付订单，带出用户所在城市（只匹配存在用户信息的记录）
SELECT o.order_id, o.user_id, o.order_amount, u.city
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id
WHERE o.order_status = 'paid';

--2. LEFT JOIN：查询所有订单，关联用户信息，保留全部订单（即使用户信息缺失）
SELECT o.order_id, o.user_id, o.order_amount, IFNULL(u.city,'未知城市') as city
FROM orders o
LEFT JOIN users u ON o.user_id = u.user_id;

--3. 业务需求：统计每个城市的订单GMV和订单数量
SELECT u.city,
       COUNT(o.order_id) AS order_count,
       SUM(o.order_amount) AS city_gmv
FROM orders o
LEFT JOIN users u ON o.user_id = u.user_id
WHERE o.order_status = 'paid'
GROUP BY u.city;
