#programmers : 년, 월, 성별 별 상품 구매 회원 수 구하기

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
ORDER BY YEAR ASC, MOMTH ASC, U.gender ASC