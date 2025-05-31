#programmers_LEVEL 3

# 대장균의 크기에 따라 분류하기 
-- 쿼리를 작성하는 목표 : 대장균 개체의 ID와 분류된 이름(COLONY_NAME)을 출력하는 SQL 문을 작성
-- 확인할 지표 : SIZE_OF_COLONY
-- 쿼리 계산 방법 : PERCENT_RANK()를 이용해 SIZE_OF_COLONY의 %범위 값을 구한 후 CASE 문을 통해 각 COLONY_NAME 설정
-- 데이터의 기간 : -
-- 사용할 테이블 : ECOLI_DATA 
-- JOIN KEY : -
-- 데이터 특징 : -
SELECT ID
      ,CASE 
            WHEN PERCENT_RANK() OVER(ORDER BY SIZE_OF_COLONY DESC) <= 0.25 THEN 'CRITICAL'
            WHEN PERCENT_RANK() OVER(ORDER BY SIZE_OF_COLONY DESC) <= 0.50 THEN 'HIGH'
            WHEN PERCENT_RANK() OVER(ORDER BY SIZE_OF_COLONY DESC) <= 0.75 THEN 'MEDIUM'
            ELSE 'LOW'
       END AS COLONY_NAME
FROM ECOLI_DATA 
ORDER BY ID ASC;



# 대장균들의 자식의 수 구하기
-- 쿼리를 작성하는 목표 : 대장균 개체의 ID(ID)와 자식의 수(CHILD_COUNT)를 출력하는 SQL 문을 작성
-- 확인할 지표 : ID, PARENT_ID
-- 쿼리 계산 방법 : SELF JOIN을 이용해 ID, PARENT_ID를 LEFT JOIN하여 GROUP BY와 COUNT를 이용해 계산
-- 데이터의 기간 : - 
-- 사용할 테이블 : ECOLI_DATA
-- JOIN KEY : E1.ID = E2.PARENT_ID
-- 데이터 특징 : PARENT_ID 컬럼에 NULL 값이 존재, COUNT(PARENT_ID) 명시할 것
SELECT E1.ID AS ID
      ,COUNT(E2.PARENT_ID) AS CHILD_COUNT
FROM ECOLI_DATA AS E1
LEFT JOIN ECOLI_DATA AS E2 ON E1.ID = E2.PARENT_ID
GROUP BY E1.ID
ORDER BY ID ASC;

# 헤비 유저가 소유한 장소
-- 쿼리를 작성하는 목표 : 헤비 유저가 등록한 공간의 정보를 아이디 순으로 조회하는 SQL문을 작성
-- 확인할 지표 : HOST_ID
-- 쿼리 계산 방법 : 유저 공간을 1개 등록했을 경우 헤비 유저가 아니기 때문에 서브쿼리를 이용해 
--               HOST_ID 별로 그룹화 한 다음 HVING에서 필터링해 다중행 서브쿼리  
-- 데이터의 기간 : -
-- 사용할 테이블 : PLACES
-- JOIN KEY : -
-- 데이터 특징 : -
SELECT ID, NAME, HOST_ID 
FROM PLACES 
WHERE HOST_ID IN (
                    SELECT HOST_ID
                    FROM PLACES 
                    GROUP BY HOST_ID 
                    HAVING COUNT(*) >= 2
                 )
ORDER BY ID ASC;


# 조회수가 가장 많은 중고거래 게시판의 첨부파일 조회하기
-- 쿼리를 작성하는 목표 : 두 테이블에서 조회수가 가장 높은 중고거래 게시물에 대한 첨부파일 경로를 조회
-- 확인할 지표 : FILE_PATH, FILE_ID,	FILE_EXT,	FILE_NAME,	BOARD_ID
-- 쿼리 계산 방법 : CONCAT을 이용해 출력 값을 붙여주고, WHERE 조건 절에 가장 높은 뷰를 가진 게시물을 필터링
-- 데이터의 기간 : -
-- 사용할 테이블 : USED_GOODS_BOARD, USED_GOODS_FILE 
-- JOIN KEY : BOARD_ID
-- 데이터 특징 : -
SELECT CONCAT('/home/grep/src/',B.BOARD_ID,'/',FILE_ID,FILE_NAME,FILE_EXT) AS FILE_PATH
FROM USED_GOODS_BOARD AS B
JOIN USED_GOODS_FILE AS F ON B.BOARD_ID = F.BOARD_ID
WHERE B.BOARD_ID IN  (SELECT FIRST_VALUE(BOARD_ID) OVER(ORDER BY VIEWS DESC) 
                      FROM USED_GOODS_BOARD                                )
ORDER BY FILE_ID DESC;


# 대여 기록이 존재하는 자동차 리스트 구하기 
-- 쿼리를 작성하는 목표 : 테이블에서 자동차 종류가 '세단'인 자동차들 중 10월에 대여를 시작한 기록이 있는 자동차 ID 리스트를 출력
-- 확인할 지표 : car_type, start_date, car_id
-- 쿼리 계산 방법 :  조인을 통해 22년 10월, 세단인 조건으로 필터링 한 후 중복을 제외한 CAR_ID 값을 출력
-- 데이터의 기간 : 2022-10
-- 사용할 테이블 : CAR_RENTAL_COMPANY_CAR, CAR_RENTAL_COMPANY_RENTAL_HISTORY 
-- JOIN KEY : CAR_ID
-- 데이터 특징 : -
SELECT DISTINCT C1.car_id AS CAR_ID
FROM CAR_RENTAL_COMPANY_CAR AS C1
JOIN CAR_RENTAL_COMPANY_RENTAL_HISTORY AS C2 ON C1.CAR_ID = C2.CAR_ID
WHERE C2.start_date LIKE '2022-10%'
  AND C1.car_type = '세단'
ORDER BY CAR_ID DESC;

# 조건별로 분류하여 주문상태 출력하기
-- 쿼리를 작성하는 목표 : FOOD_ORDER 테이블에서 2022년 5월 1일을 기준으로 주문 ID, 제품 ID, 출고일자, 출고여부를 조회하는 SQL문을 작성
-- 확인할 지표 : ORDER_ID, PRODUCT_ID, OUT_DATE
-- 쿼리 계산 방법 : CASE문을 사용해 출고여부는 2022년 5월 1일까지 출고완료로 이 후 날짜는 출고 대기로 미정이면 출고미정으로 출력
-- 데이터의 기간 : 2022
-- 사용할 테이블 : FOOD_ORDER 
-- JOIN KEY : -
-- 데이터 특징 : 날짜 데이터 00:00:00 형식으로 DATE_FORMAT 사용해 형식 바꿀 것 
SELECT ORDER_ID
     , PRODUCT_ID
     , DATE_FORMAT(OUT_DATE, '%Y-%m-%d') AS OUT_DATE
     ,CASE 
            WHEN OUT_DATE <= '2022-05-01 23:59:59' THEN '출고완료'
            WHEN OUT_DATE >= '2022-05-01 23:59:59' THEN '출고대기'
            ELSE '출고미정'
      END AS 출고여부
FROM FOOD_ORDER 
ORDER BY ORDER_ID ASC;

# 오랜 기간 보호한 동물(2)
-- 쿼리를 작성하는 목표 : 입양을 간 동물 중, 보호 기간이 가장 길었던 동물 두 마리의 아이디와 이름을 조회하는 SQL문을 작성
-- 확인할 지표 : ANIMAL_ID, NAME
-- 쿼리 계산 방법 : 각 테이블을 조인해서 들어온 날짜와 나간 날짜의 차이로 보호 기간을 설정하고 가장 긴 시간 보호된 동물 출력 
-- 데이터의 기간 : -
-- 사용할 테이블 : ANIMAL_INS, ANIMAL_OUTS 
-- JOIN KEY : ANIMAL_ID
-- 데이터 특징 : ORDER BY DATEDIFF(O.DATETIME, I.DATETIME)에서 나간 날에서 들어온 날을 뺀 순으로 정렬
SELECT I.ANIMAL_ID
      ,I.NAME
FROM ANIMAL_INS AS I
JOIN ANIMAL_OUTS AS O ON I.ANIMAL_ID = O.ANIMAL_ID
ORDER BY DATEDIFF(O.DATETIME, I.DATETIME) DESC
LIMIT 2;

# 대장균의 크기에 따라 분류하기 1
-- 쿼리를 작성하는 목표 : 대장균 개체의 크기가 100 이하라면 'LOW', 100 초과 1000 이하라면 'MEDIUM', 1000 초과라면 'HIGH' 라고 분류
-- 확인할 지표 : ID, SIZE
-- 쿼리 계산 방법 : CASE문을 이용해 각 조건에 맞게 설정 한 뒤 출력 (단순한 문제) 
-- 데이터의 기간 : - 
-- 사용할 테이블 : ECOLI_DATA 
-- JOIN KEY : -
-- 데이터 특징 : -
SELECT ID
       ,CASE
            WHEN SIZE_OF_COLONY <= 100 THEN 'LOW'
            WHEN SIZE_OF_COLONY > 100 AND SIZE_OF_COLONY <= 1000  THEN 'MEDIUM'
            WHEN SIZE_OF_COLONY > 1000 THEN 'HIGH'
            ELSE NULL
       END AS SIZE
FROM ECOLI_DATA 
ORDER BY ID ASC;

# 조건에 맞는 사용자 정보 조회하기
-- 쿼리를 작성하는 목표 : 중고 거래 게시물을 3건 이상 등록한 사용자의 사용자 ID, 닉네임, 전체주소, 전화번호를 조회
-- 확인할 지표 : USER_ID, NICKNAME, 전체주소, 전화번호
-- 쿼리 계산 방법 : 조건 절에 서브쿼리를 이용해서 게시판에 3번 이상 작성한 ID로 필터링, CONCAT, SUBSTR을 이용한 전화전호 출력
-- 데이터의 기간 : - 
-- 사용할 테이블 : USED_GOODS_BOARD, USED_GOODS_USER
-- JOIN KEY : B.WRITER_ID = U.USER_ID
-- 데이터 특징 : 전화번호 상에 SUBSTR로 진행하게 될 경우 자리수가 안맞으면 오류가 날 수 있음, 이 점 확인해야함
-- 			  전체 주소에도 띄어쓰기 확인해야함.
SELECT DISTINCT U.USER_ID
      ,U.NICKNAME
      ,CONCAT(U.CITY, ' ', U.STREET_ADDRESS1, ' ', U.STREET_ADDRESS2) AS 전체주소
      ,CONCAT(LEFT(TLNO, 3), '-' ,SUBSTR(TLNO, 4, 4), '-' ,RIGHT(TLNO, 4)) AS 전화번호
FROM USED_GOODS_BOARD AS B
JOIN USED_GOODS_USER  AS U ON B.WRITER_ID = U.USER_ID
WHERE B.WRITER_ID IN 
                     (SELECT WRITER_ID
                     FROM USED_GOODS_BOARD 
                     GROUP BY WRITER_ID
                     HAVING COUNT(*) >= 3)
ORDER BY USER_ID DESC;


-- 물고기 종류 별 대어 찾기
SELECT F.ID
       ,FN.FISH_NAME
       ,F.LENGTH
FROM FISH_INFO AS F
     JOIN FISH_NAME_INFO AS FN ON F.FISH_TYPE = FN.FISH_TYPE
WHERE (FISH_NAME, LENGTH) IN 
    (SELECT FN.FISH_NAME, MAX(LENGTH)
     FROM FISH_INFO AS F
     JOIN FISH_NAME_INFO AS FN ON F.FISH_TYPE = FN.FISH_TYPE
     GROUP BY FN.FISH_NAME)
ORDER BY F.ID ASC;


-- 업그레이드 할 수 없는 아이템 구하기
SELECT I.ITEM_ID
        ,I.ITEM_NAME
        ,I.RARITY
FROM ITEM_INFO AS I 
LEFT JOIN ITEM_TREE AS T ON I.ITEM_ID = T.PARENT_ITEM_ID 
WHERE T.PARENT_ITEM_ID IS NULL
ORDER BY I.ITEM_ID DESC;

-- 특정 조건을 만족하는 물고기별 수와 최대 길이 구하기
SELECT 
      COUNT(*) AS FISH_COUNT
      ,MAX(LENGTH) AS MAX_LENGTH
      ,FISH_TYPE 
FROM FISH_INFO
GROUP BY FISH_TYPE
HAVING AVG (CASE 
            WHEN LENGTH = LENGTH THEN LENGTH
            WHEN LENGTH IS NULL THEN 10
       END) >= 33     
ORDER BY FISH_TYPE ASC;

-- 자동차 대여 기록에서 대여중 / 대여 가능 여부 구분하기
SELECT CAR_ID,
       MAX(CASE
            WHEN '2022-10-16' BETWEEN START_DATE AND END_DATE THEN '대여중'
            ELSE '대여 가능'
       END) AS AVAILABILITY
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
GROUP BY CAR_ID
ORDER BY CAR_ID DESC;

-- 없어진 기록 찾기
SELECT O.ANIMAL_ID
        ,O.NAME
FROM ANIMAL_OUTS AS O
LEFT JOIN ANIMAL_INS AS I ON O.ANIMAL_ID = I.ANIMAL_ID
WHERE I.ANIMAL_ID IS NULL
ORDER BY O.ANIMAL_ID ASC
        ,O.NAME  ASC;
        
-- 부서별 평균 연봉 조회하기
SELECT  D.DEPT_ID
        ,D.DEPT_NAME_EN
        ,ROUND(AVG(E.SAL), 0) AS AVG_SAL
FROM HR_DEPARTMENT AS D
INNER JOIN HR_EMPLOYEES AS E ON D.DEPT_ID = E.DEPT_ID
GROUP BY D.DEPT_ID, D.DEPT_NAME_EN
ORDER BY AVG_SAL DESC;

-- 즐겨찾기가 가장 많은 식당 정보 출력하기
 SELECT FOOD_TYPE
        ,REST_ID
        ,REST_NAME
        ,FAVORITES
FROM REST_INFO
WHERE (FOOD_TYPE, FAVORITES) IN
            (SELECT FOOD_TYPE
                    ,MAX(FAVORITES) 
            FROM REST_INFO 
            GROUP BY FOOD_TYPE)
ORDER BY FOOD_TYPE DESC;

-- 있었는데요 없었습니다
SELECT I.ANIMAL_ID
        ,I.NAME
FROM ANIMAL_INS AS I
JOIN ANIMAL_OUTS AS O ON I.ANIMAL_ID = O.ANIMAL_ID
WHERE I.DATETIME >= O.DATETIME
ORDER BY I.DATETIME;

-- 조건에 맞는 사용자와 총 거래금액 조회하기
SELECT WRITER_ID
       ,NICKNAME
       ,SUM(PRICE) AS TOTAL_SALES
FROM USED_GOODS_BOARD AS B 
JOIN USED_GOODS_USER AS U ON B.WRITER_ID = U.USER_ID
WHERE B.STATUS = 'DONE'
GROUP BY WRITER_ID, NICKNAME
HAVING TOTAL_SALES >= 700000
ORDER BY TOTAL_SALES ASC;

-- 오랜 기간 보호한 동물(1)
SELECT I.NAME
        ,I.DATETIME
FROM ANIMAL_INS AS I
LEFT JOIN ANIMAL_OUTS AS O ON I.ANIMAL_ID = O.ANIMAL_ID
WHERE O.ANIMAL_ID IS NULL
ORDER BY I.DATETIME ASC
LIMIT 3;

-- 카테고리 별 도서 판매량 집계하기
SELECT CATEGORY
        ,SUM(SALES) AS TOTAL_SALES
FROM BOOK AS B
JOIN BOOK_SALES AS S ON B.BOOK_ID = S.BOOK_ID
WHERE sales_date BETWEEN '2022-01-01 00:00:00' AND '2022-01-31 23:59:59'
GROUP BY CATEGORY 
ORDER BY CATEGORY ASC

