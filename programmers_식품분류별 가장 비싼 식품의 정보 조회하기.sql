

# programmers : 식품분류별 가장 비싼 식품의 정보 조회하기

-- FOOD_PRODUCT 테이블에서 식품분류별로 가격이 제일 비싼 식품의 분류, 가격, 이름을 조회하는 SQL문을 작성해주세요. 
-- 이때 식품분류가 '과자', '국', '김치', '식용유'인 경우만 출력시켜 주시고 결과는 식품 가격을 기준으로 내림차순 정렬해주세요.

/*
문제의 핵심은 다중컬럼 서브쿼리와, GROUP BY의 개념을 이해하는 것이 중요하다.
WHERE절에 '과자', '국', '김치', '식용유' 해당 조건을 넣고 GROUP BY할 경우
CATEGORY, PRICE AS MAX_PRICE는 그룹별 가장 높은 가격이 출력되지만 
PRODUCT_NAME의 경우에는 해당되지 않기에 어떤 값이 나올지는 DB에 따라 다르다.
따라서 서브쿼리를 통해 CATEGORY, MAX_PRICE 값을 출력한 후 조건으로 필터링해 
찾는 방법이 정확하다. 
*/

SELECT CATEGORY
      ,PRICE AS MAX_PRICE
      ,PRODUCT_NAME
FROM FOOD_PRODUCT
WHERE (CATEGORY,PRICE) IN 
                            (SELECT CATEGORY
                                  ,MAX(PRICE) AS MAX_PRICE 
                            FROM FOOD_PRODUCT 
                            WHERE CATEGORY IN ('과자', '국', '김치', '식용유')
                            GROUP BY CATEGORY)
ORDER BY MAX_PRICE DESC
