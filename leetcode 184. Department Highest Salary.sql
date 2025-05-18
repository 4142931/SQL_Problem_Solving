-- leetcode 184. Department Highest Salary
-- 쿼리를 작성하는 목표 : 각 부서에서 가장 높은 금액의 봉급을 맞는 직원 찾기
-- 확인할 지표 :  
-- 쿼리 계산 방법 : WINDOW 함수 사용해 각 부서별 봉급 순위를 중복 가능하게 해 WITH으로 조건 주어 출력
-- 데이터의 기간 : - 
-- 사용할 테이블 : Employee, Department
-- JOIN KEY : E.departmentId,  D.id 
-- 데이터 특징 : -

WITH E_RANK AS
        (
        SELECT D.NAME AS Department 
            ,E.NAME AS Employee 
            ,E.salary 
            ,DENSE_RANK() OVER(PARTITION BY D.NAME ORDER BY E.salary DESC) AS RK
        FROM Employee AS E
        JOIN Department AS D ON E.departmentId = D.ID
        )

SELECT Department
      ,Employee
      ,salary
FROM E_RANK
WHERE RK = 1