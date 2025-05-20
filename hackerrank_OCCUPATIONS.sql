
#hackerrank : OCCUPATIONS 
 
-- 쿼리를 작성하는 목표 : 테이블 열 피벗하기 
-- 확인할 지표 : -
-- 쿼리 계산 방법 : GROUP BY하기 위한 ROW_NUMBER를 활용해 번호 생성 후 CASE 문으로 각 열 생성
-- 데이터의 기간 : -
-- 사용할 테이블 : OCCUPATIONS 
-- JOIN KEY : -
-- 데이터 특징 : 

WITH OCCUPATIONS_RN AS 
(
SELECT NAME
      ,OCCUPATION
      ,ROW_NUMBER() OVER(PARTITION BY OCCUPATION ORDER BY NAME ASC) AS RN
FROM OCCUPATIONS 

)

SELECT MAX(CASE WHEN Occupation = 'Doctor' THEN NAME ELSE NULL END) AS Doctor
      ,MAX(CASE WHEN Occupation = 'Professor' THEN NAME ELSE NULL END) AS Professor
      ,MAX(CASE WHEN Occupation = 'Singer' THEN NAME ELSE NULL END) AS Singer
      ,MAX(CASE WHEN Occupation = 'Actor' THEN NAME ELSE NULL END) AS Actor
FROM OCCUPATIONS_RN
GROUP BY RN

