-- 쿼리를 작성하는 목표, 확인할 지표 
  -- 지역별 자전거 대여 후 같은 지역과 다른 지역의 반납된 횟수를 집계
-- 쿼리 계산 방법 : rental_history에 station의 대여와 반납 지역 아이디를 각각 조인하여
  -- LOCAL을 비교해 그 수를 카운트한다. 이때 COUNT는 bike_id로 한다. 
-- 데이터의 기간 : 2021년 1월
-- 사용할 테이블 : station, rental_history 
-- JOIN KEY : station_id, rent_station_id
-- 데이터 특징 : 

SELECT S1.local
      ,COUNT(bike_id) AS all_rent 
      ,COUNT(CASE WHEN S1.local = S2.local THEN bike_id ELSE NULL END) AS same_local  
      ,COUNT(CASE WHEN S1.local <> S2.local THEN bike_id ELSE NULL END) AS diff_local   
FROM rental_history AS R 
		INNER JOIN station AS S1 ON S1.station_id = R.rent_station_id  
		INNER JOIN station AS S2 ON S2.station_id = R.return_station_id 
WHERE R.rent_at BETWEEN '2021-01-01 00:00:00' AND '2021-01-31 23:59:59'
  AND R.return_at BETWEEN '2021-01-01 00:00:00' AND '2021-01-31 23:59:59'
GROUP BY S1.local
ORDER BY all_rent DESC


        