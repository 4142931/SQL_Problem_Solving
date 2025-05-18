-- leetcode 183. Customers Who Never Order
-- 쿼리를 작성하는 목표 : 한 번도 주문하지 않은 고객 구하기
-- 확인할 지표 : name
-- 쿼리 계산 방법 : LEFT JOIN을 통해 주문되지 않은 고객 ID를 WHERE 조건으로 필터링
-- 데이터의 기간 : - 
-- 사용할 테이블 : Customers, Orders
-- JOIN KEY : C.ID, O.customerId 
-- 데이터 특징 : -

SELECT name AS Customers 
FROM Customers AS C
LEFT JOIN Orders AS O ON C.ID = O.customerId 
WHERE O.ID IS NULL 
