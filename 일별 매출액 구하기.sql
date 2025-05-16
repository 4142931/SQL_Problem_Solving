-- 쿼리를 작성하는 목표 : 매출 분석 : 일별 매출액 구하기
-- 확인할 지표 : order_date, price, quantity
-- 쿼리 계산 방법 : 각 테이블 조인 후 GROUP BY와 SUM 집계함수를 이용해 일별 매출액 계산
-- 데이터의 기간 : 2018-12-01 ~ 2019-12-09
-- 사용할 테이블 : customers, orders, order_items
-- JOIN KEY : customer_id, order_id
-- 데이터 특징 : OI.order_id 데이터 안에 C로 시작하는 ID는 환불 아이디(제외)

SELECT O.order_date 
      ,SUM(OI.price * OI.quantity) AS total_sales
FROM customers AS C
JOIN orders AS O ON C.customer_id = O.customer_id
JOIN order_items AS OI ON O.order_id = OI.order_id 
WHERE order_date BETWEEN '2018-12-01' AND '2019-12-09'
  AND OI.order_id NOT LIKE 'C%'
GROUP BY O.order_date 
ORDER BY order_date ASC