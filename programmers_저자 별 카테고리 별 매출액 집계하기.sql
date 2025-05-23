#programmers : 저자 별 카테고리 별 매출액 집계하기

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
ORDER BY B.author_id ASC, B.category DESC