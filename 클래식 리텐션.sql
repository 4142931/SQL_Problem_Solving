-- 쿼리를 작성하는 목표, 확인할 지표 : 클래식 리텐션
  -- 클래식 리텐션은 최초 방문일로부터 N일(또는 주, 월, 년) 후에 재방문한 고객의 비율을 집계
  -- 문제 기준 1년간 추이 확인 및 첫 주문으로부터 n개월 마다 주문하는 고객 수를 계산
-- 쿼리 계산 방법 : 
  -- 리텐션 파악하기 위한 WITH절 작성 기준이 될 order_month, first_order_month를 추출 후 
  -- CASE 문을 활용하여 첫달 구매자 + N MONTH를 할 경우 ORDER_MONTH에 주문이 있다면 사용자 이용 중.
-- 데이터의 기간 : 2020년
-- 사용할 테이블 : records, customer_stats
-- JOIN KEY : customer_id
-- 데이터 특징 : 

WITH retention AS 
    (
      SELECT R.order_id 
          ,R.customer_id # 고객 수를 세기 위해서 출력
          ,R.order_date # order_month를 추출하기 위해 출력
          ,C.first_order_date # first_order_month를 추출 위해 출력
          ,DATE_FORMAT(R.order_date, '%Y-%m-01') AS order_month # case문에서 조건으로 사용
          ,DATE_FORMAT(C.first_order_date, '%Y-%m-01') AS first_order_month # 그룹화 하기 위해서 출력
      FROM records AS R 
      JOIN customer_stats AS C ON R.customer_id = C.customer_id
    )

SELECT first_order_month
      ,count(DISTINCT customer_id) as month0 
      ,count(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 1 MONTH) = order_month THEN customer_id ELSE NULL END) AS month1
      ,count(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 2 MONTH) = order_month THEN customer_id ELSE NULL END) AS month2
      ,count(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 3 MONTH) = order_month THEN customer_id ELSE NULL END) AS month3
      ,count(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 4 MONTH) = order_month THEN customer_id ELSE NULL END) AS month4
      ,count(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 5 MONTH) = order_month THEN customer_id ELSE NULL END) AS month5
      ,count(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 6 MONTH) = order_month THEN customer_id ELSE NULL END) AS month6
      ,count(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 7 MONTH) = order_month THEN customer_id ELSE NULL END) AS month7
      ,count(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 8 MONTH) = order_month THEN customer_id ELSE NULL END) AS month8
      ,count(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 9 MONTH) = order_month THEN customer_id ELSE NULL END) AS month9
      ,count(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 10 MONTH) = order_month THEN customer_id ELSE NULL END) AS month10
      ,count(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 11 MONTH) = order_month THEN customer_id ELSE NULL END) AS month11
FROM retention
group by first_order_month