-- dml

DESC BOOK;
SELECT * FROM BOOK;
SELECT BOOKNAME,PRICE FROM BOOK;
SELECT PUBLISHER FROM BOOK;
-- ������ ���� ����(�ߺ�����) : DISTINCT
SELECT DISTINCT PUBLISHER FROM BOOK;
-- �Ҹ� �ε���
SELECT *
FROM BOOK
WHERE PRICE <10000;
-- Q. ������ 10000�� �̻� 20000�� ������ ������ �˻��ϼ���.
SELECT *
FROM BOOK
WHERE PRICE <= 20000 AND PRICE >= 10000;

-- Q. ���ǻ簡 �½�����, Ȥ�� ���ѹ̵���� ������ �˻��ϼ���.
SELECT * FROM BOOK WHERE publisher = '�½�����' OR publisher = '���ѹ̵��';
SELECT * FROM BOOK WHERE PUBLISHER IN ('�½�����' , '���ѹ̵��');

-- Q. ���ǻ簡 �½�����, Ȥ�� ���ѹ̵� �ƴ� ������ �˻��ϼ���.
SELECT * FROM BOOK WHERE PUBLISHER NOT IN ('�½�����' , '���ѹ̵��');

-- Q. �����̸��� �౸�� ���Ե� ���ǻ縦 �˻��ϼ���.
select * 
from book 
where BOOKNAME like '%�౸%';

-- [����] �����̸��� ���� �� ���� ��ġ�� ����� ���ڿ���  ���� ������ �˻��ϼ���.
-- _�� Ư�� ��ġ�� �Ѱ��� ���ڿ� ��ġ
-- %�� 0�� �̻��� ���ڿ� ��ġ
SELECT *
FROM BOOK
WHERE BOOKNAME LIKE '_��%';
-- [����] �౸�� ���� ���� �� ������ 20,000�� �̻��� ������ �˻��ϼ���.
SELECT *
FROM BOOK
WHERE BOOKNAME LIKE '%�౸%' AND PRICE >= 20000;

-- ����
SELECT * FROM BOOK ORDER BY BOOKNAME;
-- �������� ����
SELECT * FROM BOOK ORDER BY BOOKNAME DESC;

--Q. ������ ���ݼ����� �˻��ϰ� ������ ������ �̸������� �˻��ϼ���.
SELECT * FROM BOOK ORDER BY PRICE,BOOKNAME;

--Q. ������ ������ ������������ �˻��ϰ� ���� ������ ���ٸ� ���ǻ��� �ø��������� �����ϼ���
SELECT * FROM BOOK ORDER BY PRICE DESC,PUBLISHER;

SELECT * FROM ORDERS;
SELECT SUM(SALEPRICE) FROM ORDERS;

SELECT SUM(SALEPRICE) AS "�Ѹ���" FROM ORDERS;

-- Q. CUSTID �� 2���� ���� �ֹ��� ������ �� �Ǹž��� ���ϼ���.
SELECT SUM(SALEPRICE) AS "���Ǹž�" FROM ORDERS WHERE CUSTID = 2;

SELECT SUM(SALEPRICE) AS "�� �Ǹž�",
MIN(SALEPRICE) AS �ּұݾ�,
MAX(SALEPRICE) AS �ִ�ݾ�, 
AVG(SALEPRICE) AS ��ձݾ�
FROM ORDERS;

SELECT COUNT(*) FROM ORDERS;

-- Q. ���� ������ �� �Ǹž��� ����ϼ���.
SELECT CUSTID,COUNT(*) AS "��������",
SUM(SALEPRICE) AS "�� �Ǹž�"
FROM ORDERS GROUP BY CUSTID;

--Q. ������ 8000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ������� �� ������ ���ϼ���.
-- �� �α� �̻� ������ ���� ������
SELECT CUSTID, COUNT(*) AS �Ѽ���
FROM ORDERS
WHERE SALEPRICE >= 8000
GROUP BY CUSTID
HAVING COUNT(*) >=2;

SELECT * FROM CUSTOMER;

SELECT * 
FROM CUSTOMER, ORDERS
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID
ORDER BY CUSTOMER.CUSTID;

--Q. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ� ������ �����ϼ���.
SELECT CUSTID,
SUM(SALEPRICE) AS ���Ǹž�
FROM ORDERS
GROUP BY CUSTID
ORDER BY CUSTID;

SELECT * FROM CUSTOMER;
SELECT * FROM BOOK;
SELECT * FROM ORDERS;
-- Q. ���� �̸��� ���� �ֹ��� ������ �̸��� ���ϼ���.
SELECT NAME ,BOOKNAME 
FROM CUSTOMER, BOOK , ORDERS 
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID AND ORDERS.BOOKID = BOOK.BOOKID;

SELECT C.NAME ,B.BOOKNAME 
FROM CUSTOMER C, BOOK B, ORDERS O
WHERE C.CUSTID = O.CUSTID AND O.BOOKID = B.BOOKID;

-- [����] ������ 20,000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���ϼ���.
SELECT C.NAME ,B.BOOKNAME,B.PRICE
FROM CUSTOMER C, BOOK B, ORDERS O
WHERE C.CUSTID = O.CUSTID AND O.BOOKID = B.BOOKID AND B.PRICE =20000;

-- [����] ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���ϼ���.
-- OURTER JOIN ���������� �������� ���ϴ��� �ش����� ��Ÿ��
SELECT C.NAME ,O.SALEPRICE
FROM CUSTOMER C, ORDERS O 
WHERE C.CUSTID = O.CUSTID(+);
-- [����] ���� ��� ������ �̸��� ����ϼ���.
SELECT BOOKNAME, PRICE
FROM BOOK
WHERE PRICE = (SELECT MAX(PRICE) FROM BOOK);

-- [����] ������ ������ ���� �ִ� ���� �̸��� �˻��ϼ���.
SELECT DISTINCT C.NAME
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID;

SELECT NAME
FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS);
-- [����] ���ѹ̵��� ������ ������ ������ ���� �̸��� ����ϼ���.

SELECT C.NAME , B.BOOKNAME, B.PUBLISHER
FROM CUSTOMER C, ORDERS O, BOOK B
WHERE C.CUSTID = O.CUSTID AND B.BOOKID = O.BOOKID AND B.PUBLISHER = '���ѹ̵��';

SELECT NAME
FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS
WHERE BOOKID IN (SELECT BOOKID FROM BOOK
WHERE PUBLISHER = '���ѹ̵��'));

-- Q. ���ǻ纰�� ���ǻ��� ��� �������ݺ��� ��� ������ ���Ͻÿ�.
SELECT * FROM BOOK;
SELECT B1.BOOKNAME FROM BOOK B1
WHERE B1.PRICE > (SELECT AVG(B2.PRICE)
FROM BOOK B2 WHERE B2.PUBLISHER = B1.PUBLISHER);

--Q. ������ �ֹ����� ���� ���� �̸��� ���̽ÿ�.
SELECT NAME
FROM CUSTOMER
MINUS
SELECT NAME
FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS);

SELECT NAME
FROM CUSTOMER
WHERE CUSTID NOT IN (SELECT CUSTID FROM ORDERS);

-- Q. �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�.
SELECT * FROM CUSTOMER;
SELECT NAME, ADDRESS
FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS);

--Q. CUSTOMER ���̺��� �����밡 5�� ���� �ּҸ� '���ѹα� �λ�'���� �����Ͻÿ�
SELECT * FROM CUSTOMER;

UPDATE CUSTOMER
SET ADDRESS = '���ѹα� �λ�'
WHERE CUSTID = 5;
SELECT * FROM CUSTOMER;

-- Q. customer ���̺��� �ڼ����� �ּҸ� �迬���� �ּ� �ٲټ���.

UPDATE customer
SET address = (SELECT address FROM customer
WHERE name = '�迬��')
WHERE name = '�ڼ���';
SELECT * FROM CUSTOMER;

-- Q. customer ���̺��� ����ȣ�� 5�� ���� ������ �� ����� Ȯ���ϼ���.
DELETE customer
WHERE custid = 5;
SELECT * FROM customer;

SELECT ABS(-78), ABS(+78) FROM DUAL;
SELECT ROUND(4.875,1) FROM DUAL;
select * from orders;
-- Q. ���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���Ͻÿ�.
SELECT custid ����ȣ ,ROUND(AVG(saleprice),-2) ����ֹ��ݾ�
FROM orders
GROUP BY custid;

-- Q. ���� ���� '�߱�'�� ���Ե� ������ '��'�� ������ �� �������, ������ ���̽ÿ�.
SELECT * FROM book;
SELECT bookid, REPLACE(bookname,'�߱�','��') bookname, price
FROM book;

-- Q. '�½�����'���� ������ ������ ����� ������ ���� ��, ����Ʈ ���� ���̽ÿ�.
SELECT bookname ����, LENGTH(bookname) ���ڼ�, LENGTHB(bookname) ����Ʈ��
FROM book
WHERE publisher = '�½�����';

SELECT * FROM customer;
INSERT INTO customer(custid,name,adress) VALUES (5,'�ڼ���','���ѹα� ����');
INSERT INTO customer VALUES (5,'�ڼ���','���ѹα� ����',NULL);
INSERT INTO customer VALUES (6,'�ڼ���','���ѹα� ����','010-9000-0001');
DELETE customer WHERE custid = 6;

-- Q. ���缭���� �� �߼��� ���� ��(��) �� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.
SELECT SUBSTR(name,1,1) ��, COUNT(*) �ο���
FROM customer
GROUP BY SUBSTR(name,1,1);

--Q. ���缭���� �ֹ��Ϸ� ���� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���ϼ���.
SELECT orderid, custid, bookid, saleprice, orderdate , orderdate + 10 �ֹ�Ȯ������ 
FROM orders;

SELECT orderdate, orderdate + 10 �ֹ�Ȯ������ 
FROM orders;

--Q. DBMS ������ ������ ���� ��¥�� �ð�, ������ Ȯ���ϼ���.
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE,'yyyy/mm/dd dy hh24:mi:ss') SYSDATE1 FROM DUAL;

--Q. ���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���̽ÿ�.
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE,'yyyy/mm/dd dy hh24:mi:ss') SYSDATE1 FROM DUAL;

SELECT * FROM orders;
SELECT orderid �ֹ���ȣ, TO_CHAR(orderdate,'yyyy-mm-dd day') �ֹ���, custid ����ȣ, bookid ������ȣ
FROM orders
WHERE orderdate = '20-07-07';

--Q. ����Ͽ��� ����ȣ, �̸�, ��ȭ��ȣ�� ���� 2�� ���̽ÿ�.
SELECT * FROM customer;
SELECT ROWNUM ����, custid ����ȣ, name �̸�, phone ��ȭ��ȣ
FROM customer
WHERE ROWNUM<=2;

--Q. ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
SELECT * FROM orders;
SELECT orderid �ֹ���ȣ, saleprice �ݾ�
FROM orders
WHERE saleprice <= (SELECT AVG(saleprice) FROM orders);

--Q. �� ���� ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ� ������ ���ؼ� �ֹ���ȣ, ����ȣ, �ݾ��� ���̽ÿ�.
SELECT orderid �ֹ���ȣ, custid ����ȣ, saleprice �ݾ�
FROM orders o1
WHERE o1.saleprice > (SELECT avg(o2.saleprice) FROM orders o2 WHERE o1.custid = o2.custid);

-- Q. '���ѹα�'�� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT SUM(saleprice)
FROM orders
WHERE custid in (SELECT custid FROM customer WHERE address LIKE '%���ѹα�%');

-- Q. 3������ �ֹ��� ������ �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
SELECT orderid �ֹ���ȣ, saleprice �ݾ�
FROM orders
WHERE saleprice > (SELECT MAX(saleprice) FROM orders WHERE custid = 3);

select * from customer;
select * from orders;
select * from book;

--[����] EXISTS �����ڸ� ����Ͽ� '���ѹα�'�� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT SUM(saleprice) total
FROM orders o 
WHERE EXISTS (SELECT * FROM customer c 
WHERE address LIKE '%���ѹα�%' AND o.custid = c.custid);

--[����] ���缭���� ���� �Ǹž��� ���̽ÿ�(���̸��� ���� �Ǹž� ���).
SELECT (SELECT name FROM customer c WHERE c.custid = o.custid) name,
SUM(saleprice) total FROM orders o
GROUP BY o.custid;

--[����] ����ȣ�� 2 ������ ���� �Ǹž��� ���̽ÿ�(���̸��� ���� �Ǹž� ���)
SELECT	c.name, SUM(o.saleprice) "total"
FROM (SELECT custid, name FROM Customer WHERE custid <= 2) c,Orders	o
WHERE c.custid=o.custid
GROUP BY c.name;

--Q. �ּҿ� '���ѹα�'�� �����ϴ� ����� ������ �並 ����� ��ȸ�Ͻÿ�. ���� �̸��� vw_Customer�� �����Ͻÿ�.
CREATE VIEW vw_Customer
AS SELECT *
FROM customer
WHERE address LIKE '%���ѹα�%';

SELECT * FROM vw_Customer;

SELECT * FROM orders;
--Q. Orders ���̺��� ���̸��� �����̸��� �ٷ� Ȯ���� �� �ִ� �並 �����ϼ���.
CREATE VIEW v_1
AS SELECT o.orderid,c.name,b.bookname,o.saleprice,o.orderdate FROM orders o,book b,customer c
WHERE o.bookid=b.bookid and o.custid = c.custid;
SELECT * FROM v_1;
-- ���迬�ơ� ���� ������ ������ �ֹ���ȣ, �����̸�, �ֹ����� ���̽ÿ�.
SELECT orderid �ֹ���ȣ, bookname �����̸�, saleprice �ֹ���
FROM v_1
WHERE name = '�迬��';

--[����] vw_Customer�� �̱��� �ּҷ� ���� ������ �����ϼ���.

CREATE OR REPLACE VIEW vw_Customer
AS SELECT * FROM customer
WHERE address LIKE '%�̱�%';
SELECT * FROM vw_Customer;

--[����] �ռ� ������ �� vw_Customer�� �����Ͻÿ�.
DROP VIEW vw_Customer;

SELECT * FROM employees;

--[����} EMPLOYEES ���̺��� commission_pct�� Null �� ������ ����ϼ���.
SELECT 
--[����} EMPLOYEES ���̺��� employee_id�� Ȧ���� �͸� ����ϼ���.
--[����} job_id�� ���� ���̸� ���ϼ���.
--[����} job_id ���� �����հ�, �������, �ְ���, �������� ���
--Q. �Ի��� 6���� �� ù ��° �������� �����̸����� ����ϼ���.
--Q. job_id ���� �����հ�, �������, �ְ���, �������� ���, �� ��տ����� 5000�̻��� ��츸 ����
--Q. job_id ���� �����հ�, �������, �ְ���, �������� ���, �� ��տ����� 5000������ ��츸 ����




