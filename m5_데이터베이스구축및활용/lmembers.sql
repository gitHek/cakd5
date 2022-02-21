SELECT COUNT(*) FROM PURPROD;
SELECT * FROM PURPROD;
-- 2014년 2015년 사이의 4개 회사 구매 데이터


CREATE TABLE pur_amt AS
SELECT 고객번호 cusno, sum(구매금액) as puramt 
FROM purprod
GROUP BY 고객번호
ORDER BY 고객번호;

ALTER TABLE PURPROD ADD YEAR NUMBER;
UPDATE purprod SET
YEAR = substr(구매일자,1,4);
COMMIT;

CREATE TABLE purbyyear AS
SELECT 고객번호, YEAR, SUM(구매금액) 구매액
FROM purprod
GROUP BY 고객번호, YEAR
ORDER BY 고객번호;

SELECT * FROM purbyyear;