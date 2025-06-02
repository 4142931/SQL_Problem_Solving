# 상품을 구매한 회원 비율 구하기
# https://school.programmers.co.kr/learn/courses/30/lessons/131534
-- 쿼리를 작성하는 목표 : 상품을 구매한 회원의 비율 구하 기
-- 확인할 지표 : PUCHASED_RATIO
-- 쿼리 계산 방법 : 조인을 통해 기간 조건 필터링 후 ONLINE_SALE의 주문한 고객의 수와 서브쿼리를 이용한 USER_INFO의 2021년에 가입한 전체 회원수를 구하는 것이 핵심 
-- 데이터의 기간 : 2021
-- 사용할 테이블 : USER_INFO, ONLINE_SALE
-- JOIN KEY : user_id
-- 데이터 특징 : user_id이 있으므로 DISTINCT 필요

SELECT
       YEAR(O.SALES_DATE) AS 'YEAR'
      ,MONTH(O.SALES_DATE) AS 'MONTH'
      ,COUNT(DISTINCT O.user_id) AS PURCHASED_USERS
      ,ROUND(COUNT(DISTINCT O.user_id) / (SELECT COUNT(DISTINCT user_id) FROM USER_INFO WHERE YEAR(joined) = 2021), 1) AS PUCHASED_RATIO
FROM USER_INFO AS U 
JOIN ONLINE_SALE AS O ON U.user_id = O.user_id
WHERE YEAR(U.joined) = 2021
GROUP BY YEAR, MONTH
ORDER BY YEAR ASC, MONTH ASC;