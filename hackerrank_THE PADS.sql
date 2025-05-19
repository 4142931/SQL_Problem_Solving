
#hackerrank : THE PADS
 
-- 쿼리를 작성하는 목표 : NAME에 (직업)문자를 출력하고, 그 아래 전체 직업의 개수를 그룹별로 출력
-- 확인할 지표 : -
-- 쿼리 계산 방법 : CONCAT을 활용한 출력
-- 데이터의 기간 : -
-- 사용할 테이블 : OCCUPATIONS 
-- JOIN KEY : -
-- 데이터 특징 : OCCUPATION의 열을 LEFT, LOWER 함수로 적절히 활용할 것 

SELECT CONCAT(NAME, '(', LEFT(OCCUPATION, 1), ')')
FROM OCCUPATIONS
ORDER BY NAME ASC;

SELECT CONCAT('There are a total of ', COUNT(*), ' ', LOWER(OCCUPATION),'s.')
FROM OCCUPATIONS
GROUP BY OCCUPATION
ORDER BY COUNT(*), LOWER(OCCUPATION);