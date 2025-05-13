-- 쿼리를 작성하는 목표, 확인할 지표 : 롤링리텐션
  -- 롤링 리텐션은 최초 활성화 시점부터 특정 시점까지 아직 이탈하지 않은 고객의 비율을 계산
  -- 주문이 지속적으로 잘 일어나고 있는지 확인, 고객의 첫 주문일을 기준으로 이후에 주문을 하는지 확인
-- 쿼리 계산 방법 : 
  -- first_order_date, last_order_date를 기준으로 first_order_month, last_order_month를 만들어
  -- first_order_month가 last_order_month 보다 작거나 같으면 구매하고 있는 것으로 판단 COUNT해 파악
-- 데이터의 기간 : 2020년
-- 사용할 테이블 : customer_stats 
-- JOIN KEY : -
-- 데이터 특징 : first_order_date, last_order_date 데이터가 없다면 만들어야한다. 
with retention AS
      (
      SELECT customer_id
            ,first_order_date
            ,last_order_date
            ,DATE_FORMAT(first_order_date, '%Y-%m-01') AS first_order_month
            ,DATE_FORMAT(last_order_date, '%Y-%m-01') AS last_order_month
      FROM customer_stats 
      )

SELECT first_order_month
      ,COUNT(DISTINCT customer_id) AS month0 
      ,COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 1 MONTH) <= last_order_month THEN customer_id ELSE NULL END) AS month1
      ,COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 2 MONTH) <= last_order_month THEN customer_id ELSE NULL END) AS month2 
      ,COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 3 MONTH) <= last_order_month THEN customer_id ELSE NULL END) AS month3 
      ,COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 4 MONTH) <= last_order_month THEN customer_id ELSE NULL END) AS month4 
      ,COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 5 MONTH) <= last_order_month THEN customer_id ELSE NULL END) AS month5 
      ,COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 6 MONTH) <= last_order_month THEN customer_id ELSE NULL END) AS month6 
      ,COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 7 MONTH) <= last_order_month THEN customer_id ELSE NULL END) AS month7 
      ,COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 8 MONTH) <= last_order_month THEN customer_id ELSE NULL END) AS month8 
      ,COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 9 MONTH) <= last_order_month THEN customer_id ELSE NULL END) AS month9 
      ,COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 10 MONTH) <= last_order_month THEN customer_id ELSE NULL END) AS month10 
      ,COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 11 MONTH) <= last_order_month THEN customer_id ELSE NULL END) AS month11 
FROM retention
GROUP BY first_order_month