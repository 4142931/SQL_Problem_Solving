-- 쿼리를 작성하는 목표 : 당일 미세먼지 농도가 다음날의 미세먼지 농도가 더 안좋은 날 찾기
-- 확인할 지표 : 식별지표 measured_at, pm10
-- 쿼리 계산 방법 : JOIN을 활용한 방법 / lead를 이용한 계산
-- 데이터의 기간 : 2022년
-- 사용할 테이블 : measurements 
-- JOIN KEY : - 
-- 데이터 특징 : 

-- 1. Join을 활용해서 테이블 붙이기 
SELECT m1.measured_at AS today
      ,m1.pm10 
      ,m2.measured_at as next_day
      ,m2.pm10 as next_pm10
FROM measurements as m1
JOIN measurements as m2 on date_add(m1.measured_at, INTERVAL 1 day) = m2.measured_at
WHERE m1.pm10 < m2.pm10

-- 2. lead를 이용한 계산
WITH TEST AS
    (
      SELECT measured_at AS today
          ,pm10 
          ,LEAD(measured_at, 1) OVER() AS next_day
          ,LEAD(pm10, 1) OVER() AS next_pm10
      FROM measurements
    )

SELECT *
FROM TEST
WHERE pm10 < next_pm10
