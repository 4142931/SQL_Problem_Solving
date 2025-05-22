# programmers : 5월 식품들의 총매출 조회하기

/*
문제 FOOD_PRODUCT와 FOOD_ORDER 테이블에서 생산일자가 2022년 5월인 식품들의 식품 ID, 식품 이름, 총매출을 조회하는 SQL문을 작성해주세요. 
	이때 결과는 총매출을 기준으로 내림차순 정렬해주시고 총매출이 같다면 식품 ID를 기준으로 오름차순 정렬해주세요. 
*/

-- 쿼리를 작성하는 목표 : 2022년 5월인 식품들의 식품 ID, 식품 이름, 총매출을 조회하는 쿼리 작성
-- 확인할 지표 : TOTAL_SALES
-- 쿼리 계산 방법 : 각 테이블 INNER JOIN 후 2022년 5월 필터링, SUM(PRICE * AMOUNT) 집계함수로 TOTAL_SALES 구하기 
-- 데이터의 기간 : 2022년 5월
-- 사용할 테이블 : FOOD_PRODUCT, FOOD_ORDER
-- JOIN KEY : PRODUCT_ID
-- 데이터 특징 : -

SELECT P.PRODUCT_ID 
      ,P.PRODUCT_NAME
      ,SUM(PRICE * AMOUNT) AS TOTAL_SALES 
FROM FOOD_PRODUCT AS P
JOIN FOOD_ORDER AS O ON P.PRODUCT_ID = O.PRODUCT_ID
WHERE PRODUCE_DATE BETWEEN '2022-05-01 00:00:00' AND '2022-05-31 23:59:59'
GROUP BY P.PRODUCT_ID, P.PRODUCT_NAME
ORDER BY TOTAL_SALES DESC, P.PRODUCT_ID ASC