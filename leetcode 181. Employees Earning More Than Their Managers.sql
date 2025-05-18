-- leetcode 181. Employees Earning More Than Their Managers
-- 쿼리를 작성하는 목표 : 그들의 매니저 보다 더 많이 버는 직원찾기 
-- 확인할 지표 : id, name, managerId 
-- 쿼리 계산 방법 : 셀프조인을 통해 필터링
-- 데이터의 기간 : - 
-- 사용할 테이블 : Employee
-- JOIN KEY : id, salary, managerId 
-- 데이터 특징 : - 

SELECT E1.name AS Employee
FROM Employee AS E1
JOIN Employee AS E2 ON E1.managerId = E2.ID
WHERE E1.salary > E2.salary 