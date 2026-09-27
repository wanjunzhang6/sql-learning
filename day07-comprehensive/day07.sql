-- Day07 综合业务题：电商用户复购分析【衔接你后面的电商复购项目！】
/*需求说明
复购用户定义：完成2次及以上支付订单的用户
计算指标：
1.总付费用户数
2.复购用户数量
3.复购率 = 复购用户 / 总付费用户
*/

WITH user_pay_order AS (
    SELECT user_id, COUNT(order_id) AS pay_cnt
    FROM orders
    WHERE order_status = 'paid'
    GROUP BY user_id
)
SELECT
    COUNT(DISTINCT user_id) AS total_pay_user,
    SUM(IF(pay_cnt >=2,1,0)) AS repurchase_user,
    ROUND(SUM(IF(pay_cnt >=2,1,0)) / COUNT(DISTINCT user_id),4) AS repurchase_rate
FROM user_pay_order;

-- 拓展题：统计每个月的复购率
WITH user_month_order AS (
    SELECT user_id,DATE_FORMAT(create_time,'%Y-%m') AS order_month,
    COUNT(order_id) pay_cnt
    FROM orders WHERE order_status='paid'
    GROUP BY user_id,order_month
)
SELECT order_month,
COUNT(DISTINCT user_id) AS month_pay_user,
SUM(IF(pay_cnt>=2,1,0)) month_repurchase_user,
ROUND(SUM(IF(pay_cnt>=2,1,0))/COUNT(DISTINCT user_id),4) AS month_repurchase_rate
FROM user_month_order
GROUP BY order_month;
