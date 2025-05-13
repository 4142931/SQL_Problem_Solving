-- 쿼리를 작성하는 목표, 확인할 지표 : 일 별로 전체 상품 판매 개수, 80% 이상 할인 상품의 판매 개수를 계산해주세요.
-- 쿼리 계산 방법 : 전체 개수는 바로 COUNT 진행하고,80% 할인 상품은 CASE로 조건을 준 뒤 
--                 ,COUNT,DISTINCT 이용해서 개수 파악 따라서 WHERE 조건을 주지 않고 진행
-- 데이터의 기간 : 2020
-- 사용할 테이블 : records 
-- JOIN KEY : - 
-- 데이터 특징 DISCOUNT가 0.8이상 -> 재고 처리 상품

SELECT order_date
      ,SUM(quantity) AS all_items
      ,SUM(CASE WHEN discount >= 0.8 THEN quantity ELSE NULL END) AS big_discount_items
FROM records
GROUP BY order_date
HAVING all_items >= 10
   AND big_discount_items >= 1
ORDER BY big_discount_items DESC