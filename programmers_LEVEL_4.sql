#programmers_LEVEL 4

# 보호소에서 중성화한 동물
-- 쿼리를 작성하는 목표 : 보호소에 들어올 당시에는 중성화되지 않았지만, 보호소를 나갈 당시에는 
--                   중성화된 동물의 아이디와 생물 종, 이름을 조회하는 아이디 순으로 조회하는 SQL 문을 작성
-- 확인할 지표 : ANIMAL_ID, ANIMAL_TYPE, SEX_UPON_OUTCOME
-- 쿼리 계산 방법 : ANIMAL_ID로 두 테이블 조인한다. 중성화는 비가역적이기 때문에 
--              만약 중성화를 했다면 입양시도 같은 값이다. 따라서 보호 시작시와 입양의 데이터 값이 다르면
--              들어올 당시에 중성화 X BUT 입양 시 중성화O 
-- 데이터의 기간 : -
-- 사용할 테이블 :ANIMAL_INS, ANIMAL_OUTS 
-- JOIN KEY : ANIMAL_ID
-- 데이터 특징 : 중성화를 거치지 않은 동물은 성별 및 중성화 여부에 Intact, 중성화를 거친 동물은 Spayed 또는 Neutered라고 표시
SELECT AO.ANIMAL_ID
      ,AO.ANIMAL_TYPE
      ,AO.NAME
FROM ANIMAL_INS AS AI
JOIN ANIMAL_OUTS AS AO ON AI.ANIMAL_ID = AO.ANIMAL_ID
WHERE SEX_UPON_INTAKE <> SEX_UPON_OUTCOME
ORDER BY AO.ANIMAL_ID ASC