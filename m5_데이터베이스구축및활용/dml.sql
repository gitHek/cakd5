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