-- 테이블 2개 생성(제약 조건 포함)
CREATE TABLE TESTCUST(
CUSTID NVARCHAR2(5) NOT NULL,
BIRTHDAY DATE,
GENDER NCHAR(1),
AGE NUMBER);

CREATE TABLE TESTPUR(
PROD NVARCHAR2(10) NOT NULL,
CUSTID NCHAR(4),
PRICE NUMBER,
PURDATE DATE);


-- 데이터 각각 5개씩 삽입
INSERT INTO testcust(CUSTID, BIRTHDAY, GENDER) VALUES('0001','1994/08/20','M');
INSERT INTO testcust(CUSTID, BIRTHDAY, GENDER) VALUES('0002','1997/04/12','F');
INSERT INTO testcust(CUSTID, BIRTHDAY, GENDER) VALUES('0003','1992/03/02','F');
INSERT INTO testcust(CUSTID, BIRTHDAY, GENDER) VALUES('0004','1999/06/13','M');
INSERT INTO testcust(CUSTID, BIRTHDAY, GENDER) VALUES('0005','1991/01/19','F');
INSERT INTO testpur VALUES('A0001','0001','10000','20/10/15');
INSERT INTO testpur VALUES('A0003','0002','20000','20/11/05');
INSERT INTO testpur VALUES('A0004','0004','30000','20/12/10');
INSERT INTO testpur VALUES('B0001','0001','15000','20/12/20');
INSERT INTO testpur VALUES('B0002','0003','20000','20/12/20');

SELECT * FROM testcust;
SELECT * FROM testpur;

-- 속성 타입 수정, 데이터 값 변경, 속성 이름 변경, 제약조건 추가, savepoint 2개 포함
-- 제약조건 설정
ALTER TABLE testcust ADD CONSTRAINT CUST_PK PRIMARY KEY (CUSTID);
-- 속성 타입 수정
DESC testcust;
ALTER TABLE testcust MODIFY(AGE VARCHAR2(10));
DESC testcust;
-- 속성 이름 변경
SELECT * FROM testpur;
ALTER TABLE testpur RENAME COLUMN PRICE TO PRODPRICE;
-- 데이터 값 변경
SELECT * FROM testpur;
SAVEPOINT SV1;
UPDATE testpur SET prodprice = '25000' WHERE prod = 'B0002';
SELECT * FROM testpur;
SAVEPOINT SV2;
UPDATE testpur SET prodprice = '35000' WHERE prod = 'A0004';
UPDATE testpur SET custid = '0006' WHERE prod = 'B0001';

-- savepoint 1번으로 rollback 후 동일작업 수행

ROLLBACK TO SV1;
SELECT * FROM testpur;
UPDATE testpur SET prodprice = '25000' WHERE prod = 'B0002';
SELECT * FROM testpur;
SAVEPOINT SV2;
UPDATE testpur SET prodprice = '35000' WHERE prod = 'A0004';
UPDATE testpur SET custid = '0006' WHERE prod = 'B0001';
-- savepoint 2번으로 rollback 후 동일작업 수행
ROLLBACK TO SV2;
SELECT * FROM testpur;
UPDATE testpur SET prodprice = '35000' WHERE prod = 'A0004';
UPDATE testpur SET custid = '0006' WHERE prod = 'B0001';
SELECT * FROM testpur;
-- 작업내용 확정
COMMIT;
-- 2개 테이블 Join (inner join, left outer join, right outer join, full outer join)을 수행
SELECT * FROM testcust
JOIN testpur ON testpur.custid = testcust.custid;

SELECT * FROM testcust
JOIN testpur ON testpur.custid(+) = testcust.custid;

SELECT * FROM testcust
JOIN testpur ON testpur.custid = testcust.custid(+);

SELECT * FROM testcust
full outer JOIN testpur ON testpur.custid = testcust.custid;
-- 2개 테이블에 대하여 각 조건별로 결과물을 조회하고 그 결과물에 대하여 합집합(중복포함 및 미포함), 교집합, 차집합을 출력하세요.
-- 합집합(중복미포함)
SELECT custid FROM testcust
WHERE gender = 'M'
UNION
SELECT custid FROM testpur
WHERE purdate < '20/12/01';
-- 합집합(중복포함)
SELECT custid FROM testcust
WHERE gender = 'M'
UNION ALL
SELECT custid FROM testpur
WHERE purdate < '20/12/01';
-- 교집합
SELECT custid FROM testcust
WHERE gender = 'M'
INTERSECT
SELECT custid FROM testpur
WHERE purdate < '20/12/01';
-- 차집합
SELECT custid FROM testcust
WHERE gender = 'M'
MINUS
SELECT custid FROM testpur
WHERE purdate < '20/12/01';

-- [과제] HR EMPLOYEES 테이블에서 escape 옵션을 사용하여 아래와 같이 출력되는 SQL문을 작성하세요.
-- job_id 칼럼에서  _을 와일드카드가 아닌 문자로 취급하여 '_A'를 포함하는  모든 행을 출력


-- [과제] employees 테이블에서 이름에 first_name에 last_name을 붙여서 'name' 칼럼명으로 출력하세요.
-- 예) steven King

-- [과제] Seo라는 사람의 부서명을 출력하세요.

-- [과제] HR 테이블들을 분석해서 전체 현황을 설명할 수 있는 요약 테이블 3개를 작성하세요.
-- 예) 부서별 salary 순위