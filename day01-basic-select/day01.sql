-- Day01 基础SELECT练习 电商订单场景
-- 知识点：SELECT FROM WHERE AND OR LIMIT 比较运算符
-- 场景：电商订单表 orders

-- 1. 查询所有订单的前10条数据
SELECT * FROM orders LIMIT 10;

-- 2. 查询订单号、用户ID、订单金额
SELECT order_id,user_id,order_amount FROM orders;

-- 3. 筛选订单金额大于100元的订单
SELECT order_id,user_id,order_amount 
FROM orders 
WHERE order_amount > 100;

-- 4. 筛选2025-01-01之后，并且订单状态为已支付的订单
SELECT order_id,user_id,create_time,order_status
FROM orders
WHERE create_time >= '2025-01-01' AND order_status = 'paid';

-- 5. 订单金额小于20 或者 订单来源为小程序的订单
SELECT order_id,user_id,order_amount,source
FROM orders
WHERE order_amount <20 OR source = 'mini_program';
