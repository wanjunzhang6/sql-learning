-- Day05 CASE WHEN 用户分层、订单标签、业务指标划分
-- 数据运营高频考点：用户价值分层、订单金额分级

--1. 给订单打金额标签：高客单>200，中客单50~200，低客单<50
SELECT order_id,user_id,order_amount,
CASE
    WHEN order_amount >=200 THEN '高客单'
    WHEN order_amount >=50 THEN '中客单'
    ELSE '低客单'
END AS amount_level
FROM orders;

--2. 用户消费分层：累计消费>=1000高价值，300~1000普通，<300低价值
SELECT user_id,
       SUM(order_amount) AS total_spend,
CASE
    WHEN SUM(order_amount)>=1000 THEN '高价值用户'
    WHEN SUM(order_amount)>=300 THEN '普通用户'
    ELSE '低价值用户'
END AS user_level
FROM orders
WHERE order_status='paid'
GROUP BY user_id;

--3. 统计不同订单状态的订单数量，一行展示
SELECT
SUM(CASE WHEN order_status='paid' THEN 1 ELSE 0 END) AS paid_order_cnt,
SUM(CASE WHEN order_status='cancel' THEN 1 ELSE 0 END) AS cancel_order_cnt,
SUM(CASE WHEN order_status='refund' THEN 1 ELSE 0 END) AS refund_order_cnt
FROM orders;
