-- 쿼리를 작성하는 목표 : 핵심 고객 판별하기
-- 확인할 지표 : 파생지표 RFM / last_order_date, cnt_orders, sum_sales
-- 쿼리 계산 방법 : CASE문을 이용해 각 조건에 맞는 고객 선별 및 COUNT를 이용한 고객 수 계산 
-- 데이터의 기간 : 2020 
-- 사용할 테이블 : customer_stats 
-- JOIN KEY : - 
-- 데이터 특징 : 

SELECT
      CASE WHEN last_order_date BETWEEN '2020-12-01' AND '2020-12-31' THEN 'recent' ELSE 'past' END AS recency  
      ,CASE WHEN cnt_orders >= 3 THEN 'high' ELSE 'low' END AS frequency 
      ,CASE WHEN sum_sales >= 500 THEN 'high' ELSE 'low' END AS monetary 
      ,COUNT(customer_id) AS customers 
FROM customer_stats 
GROUP BY recency, frequency, monetary
HAVING recency = 'recent' AND frequency = 'high' AND monetary = 'high'
    OR recency = 'past' AND frequency = 'high' AND monetary = 'high'
ORDER BY recency DESC