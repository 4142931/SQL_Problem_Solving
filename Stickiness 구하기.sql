
-- 쿼리를 작성하는 목표 : Stickiness 구하기 
-- 확인할 지표 : dt, dau, wau, Stickiness
-- 쿼리 계산 방법 : wau는 2020년 11월 1일부터 11월 7일 사이에 한 번이라도 주문한 고객의 수 이기 때문에 
               -- 테이블을 결합해야한다, dau 테이블과, wau 테이블을 order_date를 기준으로 결합하는게 핵심
               -- BETWEEN DATE_ADD(D.order_date, INTERVAL -6 DAY) AND D.order_date
-- 데이터의 기간 :  2020년 11월 한 달 
-- 사용할 테이블 : records 
-- JOIN KEY : -  
-- 데이터 특징 : -

SELECT D.order_date AS dt
      ,COUNT(DISTINCT D.customer_id) AS dau
      ,COUNT(DISTINCT W.customer_id) AS wau
      ,ROUND(COUNT(DISTINCT D.customer_id) / COUNT(DISTINCT W.customer_id), 2) AS stickiness
FROM records AS D
LEFT JOIN records AS W ON W.order_date BETWEEN DATE_ADD(D.order_date, INTERVAL -6 DAY) AND D.order_date
WHERE D.order_date BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY D.order_date
ORDER BY dt ASC;