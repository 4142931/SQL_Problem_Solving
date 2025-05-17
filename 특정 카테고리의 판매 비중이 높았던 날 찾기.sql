-- 쿼리를 작성하는 목표 : 가구 판매 비중이 높았던 날 찾기, 
  -- 일별 주문 수가 10개 이상인 날 중에서, ‘Furniture’ 카테고리 주문의 비율이 40% 이상 이었던 날만 출력
-- 확인할 지표 : furniture_pct : 해당일의 전체 주문 대비 Furniture 카테고리 주문 비율 
-- 쿼리 계산 방법 : 
  -- order_date별로 group by, 
  -- category = 'Furniture' 조건으로 case 문 작성해 해당 일의 furniture 주문 수 구하기
  -- COUNT(DISTINCT order_id)로 furniture_pct 구하기 및 having 조건에 추가 
-- 데이터의 기간 : 2020
-- 사용할 테이블 : records 
-- JOIN KEY : - 
-- 데이터 특징 : 


SELECT order_date 
      ,COUNT(DISTINCT CASE WHEN category = 'Furniture' THEN order_id ELSE NULL END) AS furniture 
      ,ROUND(COUNT(DISTINCT CASE WHEN category = 'Furniture' THEN order_id ELSE NULL END) * 100 / COUNT(DISTINCT order_id), 2) AS furniture_pct
FROM records
GROUP BY order_date 
HAVING COUNT(DISTINCT order_id) >= 10 
   AND furniture_pct >= 40
ORDER BY furniture_pct DESC, order_date ASC