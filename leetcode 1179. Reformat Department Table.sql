-- 1179. Reformat Department Table
-- 쿼리를 작성하는 목표 : 형식 바꾸기,  id, revenue, month의 형식을 바꾸기 위함
-- 확인할 지표 :  id, revenue, month 
-- 쿼리 계산 방법 : CASE, GROUP BY, 집계함수 
-- 데이터의 기간 : - 
-- 사용할 테이블 : Department
-- JOIN KEY : - 
-- 데이터 특징 : - 

SELECT ID,
        MAX(CASE WHEN month = 'Jan' THEN revenue ELSE NULL END) AS Jan_Revenue,
        MAX(CASE WHEN month = 'Feb' THEN revenue ELSE NULL END) AS Feb_Revenue,
        MAX(CASE WHEN month = 'Mar' THEN revenue ELSE NULL END) AS Mar_Revenue,
        MAX(CASE WHEN month = 'Apr' THEN revenue ELSE NULL END) AS Apr_Revenue,
        MAX(CASE WHEN month = 'May' THEN revenue ELSE NULL END) AS May_Revenue,
        MAX(CASE WHEN month = 'Jun' THEN revenue ELSE NULL END) AS Jun_Revenue,
        MAX(CASE WHEN month = 'Jul' THEN revenue ELSE NULL END) AS Jul_Revenue,
        MAX(CASE WHEN month = 'Aug' THEN revenue ELSE NULL END) AS Aug_Revenue,
        MAX(CASE WHEN month = 'Sep' THEN revenue ELSE NULL END) AS Sep_Revenue,
        MAX(CASE WHEN month = 'Oct' THEN revenue ELSE NULL END) AS Oct_Revenue,
        MAX(CASE WHEN month = 'Nov' THEN revenue ELSE NULL END) AS Nov_Revenue,
        MAX(CASE WHEN month = 'Dec' THEN revenue ELSE NULL END) AS Dec_Revenue
FROM Department
GROUP BY ID