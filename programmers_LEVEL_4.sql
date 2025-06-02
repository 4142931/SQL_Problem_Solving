#programmers_LEVEL 4

# 보호소에서 중성화한 동물
-- 쿼리를 작성하는 목표 : 보호소에 들어올 당시에는 중성화되지 않았지만, 보호소를 나갈 당시에는 
--                   중성화된 동물의 아이디와 생물 종, 이름을 조회하는 아이디 순으로 조회하는 SQL 문을 작성
-- 확인할 지표 : ANIMAL_ID, ANIMAL_TYPE, SEX_UPON_OUTCOME
-- 쿼리 계산 방법 : ANIMAL_ID로 두 테이블 조인한다. 중성화는 비가역적이기 때문에 
--              만약 중성화를 했다면 입양시도 같은 값이다. 따라서 보호 시작시와 입양의 데이터 값이 다르면
--              들어올 당시에 중성화 X BUT 입양 시 중성화O 
-- 데이터의 기간 : -
-- 사용할 테이블 :ANIMAL_INS, ANIMAL_OUTS 
-- JOIN KEY : ANIMAL_ID
-- 데이터 특징 : 중성화를 거치지 않은 동물은 성별 및 중성화 여부에 Intact, 중성화를 거친 동물은 Spayed 또는 Neutered라고 표시
SELECT AO.ANIMAL_ID
      ,AO.ANIMAL_TYPE
      ,AO.NAME
FROM ANIMAL_INS AS AI
JOIN ANIMAL_OUTS AS AO ON AI.ANIMAL_ID = AO.ANIMAL_ID
WHERE SEX_UPON_INTAKE <> SEX_UPON_OUTCOME
ORDER BY AO.ANIMAL_ID ASC;

# 서울에 위치한 식당 목록 출력하기
-- 쿼리를 작성하는 목표 : 서울에 위치한 식당들의 식당 ID, 식당 이름, 음식 종류, 즐겨찾기수, 주소, 리뷰 평균 점수를 조회
-- 확인할 지표 : REST_ID,	REST_NAME,	FOOD_TYPE,	FAVORITES,	ADDRESS	SCORE
-- 쿼리 계산 방법 : GROUP BY와 AVG()로 그룹하고 HAVING을 통해 필터링
-- 데이터의 기간 : -
-- 사용할 테이블 : REST_INFO, REST_REVIEW 
-- JOIN KEY : REST_ID
-- 데이터 특징 : ADDRESS 서울 외 다른 지역이 존재, 
-- REST_ID, REST_NAME, FOOD_TYPE,	FAVORITES, ADDRESS 같은 값으로
-- GROUP BY해도 결과에 지장을 주지 않음 
SELECT RI.REST_ID
    ,	RI.REST_NAME
    ,	RI.FOOD_TYPE
    ,	RI.FAVORITES
    ,	RI.ADDRESS
    ,   ROUND(AVG(RR.REVIEW_SCORE), 2) AS SCORE
FROM REST_INFO AS RI
LEFT JOIN REST_REVIEW  AS RR ON RI.REST_ID = RR.REST_ID
WHERE ADDRESS LIKE '서울%'
GROUP BY REST_ID, REST_NAME, FOOD_TYPE,	FAVORITES, ADDRESS
HAVING AVG(RR.REVIEW_SCORE) IS NOT NULL
ORDER BY SCORE DESC, FAVORITES DESC;

#년, 월, 성별 별 상품 구매 회원 수 구하기
# https://school.programmers.co.kr/learn/courses/30/lessons/131532
/*
USER_INFO 테이블과 ONLINE_SALE 테이블에서 년, 월, 성별 별로 상품을 구매한 회원수를 집계하는 SQL문을 작성해주세요. 
결과는 년, 월, 성별을 기준으로 오름차순 정렬해주세요. 이때, 성별 정보가 없는 경우 결과에서 제외해주세요.
*/
-- 쿼리를 작성하는 목표 : 년, 월, 성별 별 상품 구매 회원 수 구하기
-- 확인할 지표 : USERS
-- 쿼리 계산 방법 : 년, 월, gender별로 그룹화 및 고객 수 카운트
-- 데이터의 기간 : 2022년
-- 사용할 테이블 : USER_INFO, ONLINE_SALE 
-- JOIN KEY : USER_ID
-- 데이터 특징 : gender 컬럼에 NULL 값 있어서 NULL일 경우 제외하고 출력
SELECT YEAR(O.sales_date) AS YEAR
      ,MONTH(O.sales_date) AS MOMTH 
      ,U.gender 
      ,COUNT(DISTINCT U.USER_ID) AS USERS
FROM USER_INFO AS U
JOIN ONLINE_SALE AS O ON U.USER_ID = O.USER_ID
WHERE gender IS NOT NULL
GROUP BY YEAR, MOMTH, U.gender 
ORDER BY YEAR ASC, MOMTH ASC, U.gender ASC;

# 식품분류별 가장 비싼 식품의 정보 조회하기
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
ORDER BY MAX_PRICE DESC;

# 식품분류별 가장 비싼 식품의 정보 조회하기
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
ORDER BY MAX_PRICE DESC;

# 저자 별 카테고리 별 매출액 집계하기
#https://school.programmers.co.kr/learn/courses/30/lessons/144856
/*
2022년 1월의 도서 판매 데이터를 기준으로 저자 별, 카테고리 별 매출액(TOTAL_SALES = 판매량 * 판매가) 을 구하여, 
저자 ID(AUTHOR_ID), 저자명(AUTHOR_NAME), 카테고리(CATEGORY), 매출액(SALES) 리스트를 출력하는 SQL문을 작성해주세요.
결과는 저자 ID를 오름차순으로, 저자 ID가 같다면 카테고리를 내림차순 정렬해주세요.
*/
-- 쿼리를 작성하는 목표 : 2022년 1월 저자 별, 카테고리 별 매출액 구하기
-- 확인할 지표 : TOTAL_SALES
-- 쿼리 계산 방법 : 각 테이블 조인 후 SUM() 함수 사용하여 그룹화
-- 데이터의 기간 : 2022년 1월
-- 사용할 테이블 : BOOK, AUTHOR, BOOK_SALES 
-- JOIN KEY : AUTHOR_ID, BOOK_ID
-- 데이터 특징 : -
SELECT B.author_id
      ,A.AUTHOR_NAME
      ,B.category
      ,SUM(B.price * BS.sales) AS TOTAL_SALES
FROM BOOK AS B 
JOIN AUTHOR AS A ON B.AUTHOR_ID = A.AUTHOR_ID
JOIN BOOK_SALES AS BS ON B.BOOK_ID = BS.BOOK_ID
WHERE BS.SALES_DATE BETWEEN '2022-01-01 00:00:00' AND '2022-01-31 23:59:59'
GROUP BY B.author_id,A.AUTHOR_NAME, B.category
ORDER BY B.author_id ASC, B.category DESC;

# 5월 식품들의 총매출 조회하기
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
ORDER BY TOTAL_SALES DESC, P.PRODUCT_ID ASC;
