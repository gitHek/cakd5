-- ���̺� 2�� ����(���� ���� ����)
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


-- ������ ���� 5���� ����
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

-- �Ӽ� Ÿ�� ����, ������ �� ����, �Ӽ� �̸� ����, �������� �߰�, savepoint 2�� ����
-- �������� ����
ALTER TABLE testcust ADD CONSTRAINT CUST_PK PRIMARY KEY (CUSTID);
-- �Ӽ� Ÿ�� ����
DESC testcust;
ALTER TABLE testcust MODIFY(AGE VARCHAR2(10));
DESC testcust;
-- �Ӽ� �̸� ����
SELECT * FROM testpur;
ALTER TABLE testpur RENAME COLUMN PRICE TO PRODPRICE;
-- ������ �� ����
SELECT * FROM testpur;
SAVEPOINT SV1;
UPDATE testpur SET prodprice = '25000' WHERE prod = 'B0002';
SELECT * FROM testpur;
SAVEPOINT SV2;
UPDATE testpur SET prodprice = '35000' WHERE prod = 'A0004';
UPDATE testpur SET custid = '0006' WHERE prod = 'B0001';

-- savepoint 1������ rollback �� �����۾� ����

ROLLBACK TO SV1;
SELECT * FROM testpur;
UPDATE testpur SET prodprice = '25000' WHERE prod = 'B0002';
SELECT * FROM testpur;
SAVEPOINT SV2;
UPDATE testpur SET prodprice = '35000' WHERE prod = 'A0004';
UPDATE testpur SET custid = '0006' WHERE prod = 'B0001';
-- savepoint 2������ rollback �� �����۾� ����
ROLLBACK TO SV2;
SELECT * FROM testpur;
UPDATE testpur SET prodprice = '35000' WHERE prod = 'A0004';
UPDATE testpur SET custid = '0006' WHERE prod = 'B0001';
SELECT * FROM testpur;
-- �۾����� Ȯ��
COMMIT;
-- 2�� ���̺� Join (inner join, left outer join, right outer join, full outer join)�� ����
SELECT * FROM testcust
JOIN testpur ON testpur.custid = testcust.custid;

SELECT * FROM testcust
JOIN testpur ON testpur.custid(+) = testcust.custid;

SELECT * FROM testcust
JOIN testpur ON testpur.custid = testcust.custid(+);

SELECT * FROM testcust
full outer JOIN testpur ON testpur.custid = testcust.custid;
-- 2�� ���̺� ���Ͽ� �� ���Ǻ��� ������� ��ȸ�ϰ� �� ������� ���Ͽ� ������(�ߺ����� �� ������), ������, �������� ����ϼ���.
-- ������(�ߺ�������)
SELECT custid FROM testcust
WHERE gender = 'M'
UNION
SELECT custid FROM testpur
WHERE purdate < '20/12/01';
-- ������(�ߺ�����)
SELECT custid FROM testcust
WHERE gender = 'M'
UNION ALL
SELECT custid FROM testpur
WHERE purdate < '20/12/01';
-- ������
SELECT custid FROM testcust
WHERE gender = 'M'
INTERSECT
SELECT custid FROM testpur
WHERE purdate < '20/12/01';
-- ������
SELECT custid FROM testcust
WHERE gender = 'M'
MINUS
SELECT custid FROM testpur
WHERE purdate < '20/12/01';

-- [����] HR EMPLOYEES ���̺��� escape �ɼ��� ����Ͽ� �Ʒ��� ���� ��µǴ� SQL���� �ۼ��ϼ���.
-- job_id Į������  _�� ���ϵ�ī�尡 �ƴ� ���ڷ� ����Ͽ� '_A'�� �����ϴ�  ��� ���� ���


-- [����] employees ���̺��� �̸��� first_name�� last_name�� �ٿ��� 'name' Į�������� ����ϼ���.
-- ��) steven King

-- [����] Seo��� ����� �μ����� ����ϼ���.

-- [����] HR ���̺���� �м��ؼ� ��ü ��Ȳ�� ������ �� �ִ� ��� ���̺� 3���� �ۼ��ϼ���.
-- ��) �μ��� salary ����