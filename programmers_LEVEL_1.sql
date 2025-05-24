
#programmers_LEVEL 1

# 조건에 부합하는 중고거래 댓글 조회하기
-- USED_GOODS_BOARD와 USED_GOODS_REPLY 테이블에서 2022년 10월에 작성된 게시글 제목, 게시글 ID, 댓글 ID, 댓글 작성자 ID, 댓글 내용, 댓글 작성일을 조회하는 SQL문을 작성해주세요. 
-- 결과는 댓글 작성일을 기준으로 오름차순 정렬해주시고, 댓글 작성일이 같다면 게시글 제목을 기준으로 오름차순 정렬해주세요.
SELECT  B.TITLE,
        B.BOARD_ID,	
        R.REPLY_ID,
        R.WRITER_ID,
        R.CONTENTS,
        DATE_FORMAT(R.CREATED_DATE, '%Y-%m-%d') AS CREATED_DATE
FROM USED_GOODS_BOARD AS B
JOIN USED_GOODS_REPLY AS R ON B.BOARD_ID = R.BOARD_ID
WHERE B.CREATED_DATE BETWEEN '2022-10-01 00:00:00' AND '2022-10-31 23:59:59'
ORDER BY CREATED_DATE ASC, B.TITLE ASC;

# 가장 큰 물고기 10마리 구하기
-- FISH_INFO 테이블에서 가장 큰 물고기 10마리의 ID와 길이를 출력하는 SQL 문을 작성해주세요. 
-- 결과는 길이를 기준으로 내림차순 정렬하고, 길이가 같다면 물고기의 ID에 대해 오름차순 정렬해주세요. 
-- 단, 가장 큰 물고기 10마리 중 길이가 10cm 이하인 경우는 없습니다.
-- ID 컬럼명은 ID, 길이 컬럼명은 LENGTH로 해주세요.
SELECT ID
        ,LENGTH 
FROM FISH_INFO 
WHERE LENGTH IS NOT NULL
ORDER BY LENGTH DESC, ID ASC
LIMIT 10;

# 최댓값 구하기
-- 가장 최근에 들어온 동물은 언제 들어왔는지 조회하는 SQL 문을 작성해주세요.
SELECT MAX(DATETIME) AS 시간
FROM ANIMAL_INS;


# 잡은 물고기의 평균 길이 구하기
-- 잡은 물고기의 평균 길이를 출력하는 SQL문을 작성해주세요.
-- 평균 길이를 나타내는 컬럼 명은 AVERAGE_LENGTH로 해주세요.
-- 평균 길이는 소수점 3째자리에서 반올림하며, 10cm 이하의 물고기들은 10cm 로 취급하여 평균 길이를 구해주세요.
SELECT ROUND(AVG(CASE WHEN LENGTH = LENGTH THEN LENGTH
            WHEN LENGTH IS NULL THEN 10
       END), 2) AS AVERAGE_LENGTH
FROM FISH_INFO;

# 모든 레코드 조회하기
-- 동물 보호소에 들어온 모든 동물의 정보를 ANIMAL_ID순으로 조회하는 SQL문을 작성해주세요. 
-- SQL을 실행하면 다음과 같이 출력되어야 합니다.
SELECT *
FROM ANIMAL_INS 
ORDER BY ANIMAL_ID ASC;

# Python 개발자 찾기
-- DEVELOPER_INFOS 테이블에서 Python 스킬을 가진 개발자의 정보를 조회하려 합니다. 
-- Python 스킬을 가진 개발자의 ID, 이메일, 이름, 성을 조회하는 SQL 문을 작성해 주세요.
-- 결과는 ID를 기준으로 오름차순 정렬해 주세요.
SELECT ID
        ,EMAIL
        ,FIRST_NAME
        ,LAST_NAME
FROM DEVELOPER_INFOS 
WHERE SKILL_1 = 'Python'
   OR SKILL_2 = 'Python'
   OR SKILL_3 = 'Python'
ORDER BY ID ASC;

# 과일로 만든 아이스크림 고르기
-- 상반기 아이스크림 총주문량이 3,000보다 높으면서 아이스크림의 주 성분이 과일인 아이스크림의 맛을 총주문량이 큰 순서대로 조회하는 SQL 문을 작성해주세요.
SELECT F.FLAVOR
FROM FIRST_HALF AS F 
LEFT JOIN ICECREAM_INFO AS I ON F.FLAVOR = I.FLAVOR
WHERE F.TOTAL_ORDER > 3000
  AND I.INGREDIENT_TYPE = 'fruit_based'
ORDER BY F.TOTAL_ORDER DESC;

#잔챙이 잡은 수 구하기
-- 잡은 물고기 중 길이가 10cm 이하인 물고기의 수를 출력하는 SQL 문을 작성해주세요.
-- 물고기의 수를 나타내는 컬럼 명은 FISH_COUNT로 해주세요.
SELECT COUNT(*) AS FISH_COUNT
FROM FISH_INFO 
WHERE LENGTH IS NULL;

# 잡은 물고기 중 가장 큰 물고기의 길이 구하기
-- FISH_INFO 테이블에서 잡은 물고기 중 가장 큰 물고기의 길이를 'cm' 를 붙여 출력하는 SQL 문을 작성해주세요.
-- 이 때 컬럼명은 'MAX_LEN GTH' 로 지정해주세요.
SELECT CONCAT(MAX(LENGTH), 'cm') AS MAX_LENGTH
FROM FISH_INFO;

#평균 일일 대여 요금 구하기
-- CAR_RENTAL_COMPANY_CAR 테이블에서 자동차 종류가 'SUV'인 자동차들의 평균 일일 대여 요금을 출력하는 SQL문을 작성해주세요. 
-- 이때 평균 일일 대여 요금은 소수 첫 번째 자리에서 반올림하고, 컬럼명은 AVERAGE_FEE 로 지정해주세요.
SELECT ROUND(AVG(daily_fee), 0) AS AVERAGE_FEE
FROM CAR_RENTAL_COMPANY_CAR 
WHERE car_type = 'SUV';

# 조건에 맞는 도서 리스트 출력하기
-- BOOK 테이블에서 2021년에 출판된 '인문' 카테고리에 속하는 도서 리스트를 찾아서 도서 ID(BOOK_ID), 출판일 (PUBLISHED_DATE)을 출력하는 SQL문을 작성해주세요.
-- 결과는 출판일을 기준으로 오름차순 정렬해주세요.
SELECT BOOK_ID
	   ,DATE_FORMAT(published_date, '%Y-%m-%d') AS PUBLISHED_DATE
FROM BOOK
WHERE YEAR(PUBLISHED_DATE) = 2021
  AND CATEGORY = '인문'
ORDER BY PUBLISHED_DATE ASC;

# 12세 이하인 여자 환자 목록 출력하기
-- PATIENT 테이블에서 12세 이하인 여자환자의 환자이름, 환자번호, 성별코드, 나이, 전화번호를 조회하는 SQL문을 작성해주세요. 
-- 이때 전화번호가 없는 경우, 'NONE'으로 출력시켜 주시고 결과는 나이를 기준으로 내림차순 정렬하고, 나이 같다면 환자이름을 기준으로 오름차순 정렬해주세요.
SELECT PT_NAME
        ,PT_NO
        ,GEND_CD
        ,AGE
        ,CASE WHEN TLNO = TLNO THEN TLNO ELSE 'NONE' END AS TLNO
FROM PATIENT 
WHERE AGE <= 12
  AND GEND_CD = 'W'
ORDER BY AGE DESC, PT_NAME ASC;

# 인기있는 아이스크림
-- 상반기에 판매된 아이스크림의 맛을 총주문량을 기준으로 내림차순 정렬하고 총주문량이 같다면 출하 번호를 기준으로 오름차순 정렬하여 조회하는 SQL 문을 작성해주세요.
SELECT FLAVOR
FROM FIRST_HALF
ORDER BY TOTAL_ORDER DESC, SHIPMENT_ID ASC;

# 아픈 동물 찾기
-- 동물 보호소에 들어온 동물 중 아픈 동물1의 아이디와 이름을 조회하는 SQL 문을 작성해주세요. 이때 결과는 아이디 순으로 조회해주세요. 
SELECT ANIMAL_ID	,NAME
FROM ANIMAL_INS 
WHERE INTAKE_CONDITION = 'Sick'
ORDER BY ANIMAL_ID ASC;

# 이름이 없는 동물의 아이디
-- 동물 보호소에 들어온 동물 중, 이름이 없는 채로 들어온 동물의 ID를 조회하는 SQL 문을 작성해주세요. 단, ID는 오름차순 정렬되어야 합니다.
SELECT ANIMAL_ID
FROM ANIMAL_INS 
WHERE NAME IS NULL
ORDER BY ANIMAL_ID ASC;

# 경기도에 위치한 식품창고 목록 출력하기
-- FOOD_WAREHOUSE 테이블에서 경기도에 위치한 창고의 ID, 이름, 주소, 냉동시설 여부를 조회하는 SQL문을 작성해주세요. 
-- 이때 냉동시설 여부가 NULL인 경우, 'N'으로 출력시켜 주시고 결과는 창고 ID를 기준으로 오름차순 정렬해주세요.
SELECT WAREHOUSE_ID
        ,WAREHOUSE_NAME
        ,ADDRESS
        ,CASE WHEN FREEZER_YN = FREEZER_YN THEN FREEZER_YN 
              WHEN FREEZER_YN IS NULL THEN 'N'
         END AS FREEZER_YN
FROM FOOD_WAREHOUSE 
WHERE ADDRESS LIKE '%경기도%'
ORDER BY WAREHOUSE_ID ASC;

# 조건에 맞는 회원수 구하기
-- USER_INFO 테이블에서 2021년에 가입한 회원 중 나이가 20세 이상 29세 이하인 회원이 몇 명인지 출력하는 SQL문을 작성해주세요.
SELECT COUNT(*) AS USERS
FROM USER_INFO 
WHERE joined BETWEEN '2021-01-01 00:00:00' AND '2021-12-31 23:59:59'
  AND age BETWEEN 20 AND 29;
  
# 흉부외과 또는 일반외과 의사 목록 출력하기
-- DOCTOR 테이블에서 진료과가 흉부외과(CS)이거나 일반외과(GS)인 의사의 이름, 의사ID, 진료과, 고용일자를 조회하는 SQL문을 작성해주세요. 
-- 이때 결과는 고용일자를 기준으로 내림차순 정렬하고, 고용일자가 같다면 이름을 기준으로 오름차순 정렬해주세요.
SELECT DR_NAME 
        ,DR_ID
        ,MCDP_CD
        ,DATE_FORMAT(HIRE_YMD, '%Y-%m-%d') AS HIRE_YMD
FROM DOCTOR
WHERE MCDP_CD IN ('CS', 'GS')
ORDER BY HIRE_YMD DESC, DR_NAME ASC;

#인기있는 아이스크림
-- 상반기에 판매된 아이스크림의 맛을 총주문량을 기준으로 내림차순 정렬하고 총주문량이 같다면 출하 번호를 기준으로 오름차순 정렬하여 조회하는 SQL 문을 작성해주세요.
SELECT FLAVOR
FROM FIRST_HALF
ORDER BY TOTAL_ORDER DESC, SHIPMENT_ID ASC;

#어린 동물 찾기
-- 동물 보호소에 들어온 동물 중 젊은 동물1의 아이디와 이름을 조회하는 SQL 문을 작성해주세요. 이때 결과는 아이디 순으로 조회해주세요.
SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS 
WHERE INTAKE_CONDITION != 'Aged'
ORDER BY ANIMAL_ID ASC;

#역순 정렬하기
-- 동물 보호소에 들어온 모든 동물의 이름과 보호 시작일을 조회하는 SQL문을 작성해주세요. 
-- 이때 결과는 ANIMAL_ID 역순으로 보여주세요. SQL을 실행하면 다음과 같이 출력되어야 합니다.
SELECT NAME
        ,DATETIME
FROM ANIMAL_INS  
ORDER BY ANIMAL_ID DESC;

#나이 정보가 없는 회원 수 구하기
-- USER_INFO 테이블에서 나이 정보가 없는 회원이 몇 명인지 출력하는 SQL문을 작성해주세요. 이때 컬럼명은 USERS로 지정해주세요.
SELECT COUNT(*) AS USERS
FROM USER_INFO 
WHERE AGE IS NULL;

#동물의 아이디와 이름
-- 동물 보호소에 들어온 모든 동물의 아이디와 이름을 ANIMAL_ID순으로 조회하는 SQL문을 작성해주세요. SQL을 실행하면 다음과 같이 출력되어야 합니다.
SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS 
ORDER BY ANIMAL_ID ASC;

#이름이 있는 동물의 아이디
-- 동물 보호소에 들어온 동물 중, 이름이 있는 동물의 ID를 조회하는 SQL 문을 작성해주세요. 
-- 단, ID는 오름차순 정렬되어야 합니다.
SELECT ANIMAL_ID
FROM ANIMAL_INS 
WHERE NAME IS NOT NULL
ORDER BY ANIMAL_ID ASC;

#가장 비싼 상품 구하기
-- PRODUCT 테이블에서 판매 중인 상품 중 가장 높은 판매가를 출력하는 SQL문을 작성해주세요. 
-- 이때 컬럼명은 MAX_PRICE로 지정해주세요.
SELECT MAX(PRICE) AS MAX_PRICE
FROM PRODUCT ;

#여러 기준으로 정렬하기
-- 동물 보호소에 들어온 모든 동물의 아이디와 이름, 보호 시작일을 이름 순으로 조회하는 SQL문을 작성해주세요. 
-- 단, 이름이 같은 동물 중에서는 보호를 나중에 시작한 동물을 먼저 보여줘야 합니다.
SELECT ANIMAL_ID, NAME , DATETIME
FROM ANIMAL_INS 
ORDER BY NAME ASC, DATETIME DESC;

#상위 n개 레코드
-- 동물 보호소에 가장 먼저 들어온 동물의 이름을 조회하는 SQL 문을 작성해주세요.
SELECT NAME 
FROM ANIMAL_INS 
ORDER BY DATETIME ASC
LIMIT 1;

#강원도에 위치한 생산공장 목록 출력하기
-- FOOD_FACTORY 테이블에서 강원도에 위치한 식품공장의 공장 ID, 공장 이름, 주소를 조회하는 SQL문을 작성해주세요. 
-- 이때 결과는 공장 ID를 기준으로 오름차순 정렬해주세요.
SELECT FACTORY_ID, FACTORY_NAME, ADDRESS
FROM FOOD_FACTORY 
WHERE ADDRESS LIKE '%강원도%'
ORDER BY FACTORY_ID ASC;