SELECT COUNT(*) FROM PURPROD;
SELECT * FROM PURPROD;
-- 2014�� 2015�� ������ 4�� ȸ�� ���� ������


CREATE TABLE pur_amt AS
SELECT ����ȣ cusno, sum(���űݾ�) as puramt 
FROM purprod
GROUP BY ����ȣ
ORDER BY ����ȣ;

ALTER TABLE PURPROD ADD YEAR NUMBER;
UPDATE purprod SET
YEAR = substr(��������,1,4);
COMMIT;

CREATE TABLE purbyyear AS
SELECT ����ȣ, YEAR, SUM(���űݾ�) ���ž�
FROM purprod
GROUP BY ����ȣ, YEAR
ORDER BY ����ȣ;

SELECT * FROM purbyyear;