-- ESCAPE
SELECT * FROM employees WHERE job_id LIKE '%\_A%' ESCAPE '\';
SELECT * FROM employees WHERE job_id LIKE '%#_A%' ESCAPE '#';

-- IN : OR ��� ���
SELECT * FROM employees WHERE manager_id = 101 or manager_id =  102 or manager_id = 103;
SELECT * FROM employees WHERE manager_id IN (101,102,103);

-- BETWEEN AND : �� �� ������ ��(�� �� ����)
SELECT * FROM employees WHERE manager_id BETWEEN 101 AND 103;

-- IS NULL / IS NOT NULL
SELECT * FROM employees WHERE commission_pct IS NULL;
SELECT * FROM employees WHERE commission_pct IS NOT NULL;

--[�ֿ� �Լ�]
-- MOD : ������
SELECT * FROM employees WHERE MOD (employee_id,2)=1;
SELECT MOD(10,3) FROM DUAL;

--ROUND()
SELECT ROUND(355.95555) FROM DUAL;
SELECT ROUND(355.95555,0) FROM DUAL;
SELECT ROUND(355.95555,2) FROM DUAL;
SELECT ROUND(355.95555,-1) FROM DUAL;

--TRUNC()
SELECT TRUNC(45.5555,1) FROM DUAL;
SELECT last_name, TRUNC(salary/12,2) FROM employees;

-- ��¥ ���� �Լ�
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE +1 FROM DUAL;
SELECT last_name, TRUNC((SYSDATE - hire_date)/365) �ټӳ�� FROM employees;
SELECT last_name,hire_date, ADD_MONTHS(hire_date, 6) FROM employees;
SELECT LAST_DAY(SYSDATE)-SYSDATE FROM DUAL;
SELECT hire_date, NEXT_DAY(hire_date,'��') FROM employees;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'��') FROM DUAL;

-- MONTHS_BETWEEN()
SELECT last_name, SYSDATE, hire_date, TRUNC(MONTHS_BETWEEN(sysdate, hire_date)) �ټӰ��� FROM employees;

-- ����ȯ �Լ�
-- number character date
-- TO_DATE() ���ڿ��� ��¥��
-- TO_NUMBER , TO_CHAR , TO_DATE
SELECT last_name, months_between('2012/12/31',hire_date) FROM employees;
SELECT TRUNC(sysdate - to_date('2014/01/01')) FROM dual;

-- Q. employees ���̺� �ִ� �����鿡 ���Ͽ� ���� �������� �ټӿ����� ���ϼ���.
SELECT employee_id, last_name , TRUNC((sysdate-hire_date)/365) �ټӿ��� 
FROM employees;

SELECT TO_DATE('20210101') ,
TO_CHAR(TO_DATE('20210101'),'MonthDD YYYY','NLS_DATE_LANGUAGE=ENGLISH') format1 FROM dual;

SELECT TO_CHAR(SYSDATE, 'yy/mm/dd hh24:mi:ss') FROM dual;
SELECT TO_CHAR(SYSDATE, 'yy/mm/dd') FROM dual;
SELECT TO_CHAR(SYSDATE, 'hh24:mi:ss') FROM dual;
SELECT TO_CHAR(SYSDATE, 'day') FROM dual;
SELECT TO_CHAR(SYSDATE, 'month') FROM dual;

-- TO_CHAR
--9 ���ڸ��� ����ǥ��
--0 �պκ��� 0���� ǥ��
--$ �޷���ȣ�� �տ� ǥ��
--. �Ҽ����� ǥ��
--, Ư�� ��ġ�� ǥ��
--MI �����ʿ� ? ��ȣ ǥ��
--PR  �������� <>�� ǥ��
--EEEE ������ ǥ��
--B ������ 0���� ǥ��
--L ������ȭ
SELECT salary, TO_CHAR(salary, '099999') FROM employees;
SELECT TO_CHAR(-salary, '999999PR') FROM employees;
SELECT TO_CHAR(1111, '99.99EEEE') FROM dual;
SELECT TO_CHAR(1111, 'B9999.99') FROM dual;
SELECT TO_CHAR(1111, 'L99999') FROM dual;

--WIDTH_BUCKET() ������, �ּҰ�, �ִ밪, BUCKET ����
SELECT WIDTH_BUCKET(92,0,100,10) FROM dual;
SELECT department_id, last_name, salary, WIDTH_BUCKET(salary,0,20000,5) FROM employees WHERE department_id = 50;

--[����] employees ���̺��� employee_id, last_name, salary, hire_date �� �Ի��� �������� �ټӳ���� ����ؼ� �Ʒ������� �߰��� ��
-- ����ϼ���. 2001�� 1�� 1�� â���Ͽ� ����(2020�� 12�� 31��)���� 20�Ⱓ ��Ǿ�� ȸ��� ������ �ټӿ����� ���� 30������� ������ ��޿�
-- ���� 1000���� bonus�� ����(bonus ���� �������� ����)
SELECT employee_id, last_name, salary, hire_date, 
TRUNC((TO_DATE('20/12/31')-hire_date)/365) �ټӿ���,
WIDTH_BUCKET(TRUNC((TO_DATE('20/12/31')-hire_date)/365),0,20,30)*1000 bonus 
FROM employees
ORDER BY bonus DESC;


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

--[HR tables]
SELECT * FROM employees;

--[����} EMPLOYEES ���̺��� commission_pct�� Null �� ������ ����ϼ���.
SELECT COUNT(*)
FROM employees
WHERE commission_pct is Null;

--[����} EMPLOYEES ���̺��� employee_id�� Ȧ���� �͸� ����ϼ���.
SELECT * FROM employees WHERE MOD(employee_id,2) = 1;

--[����} job_id�� ���� ���̸� ���ϼ���.
SELECT job_id,LENGTH(job_id) ���ڱ��� FROM employees ;

--[����} job_id ���� �����հ�, �������, �ְ���, �������� ���
SELECT job_id, SUM(salary) �����հ�, AVG(salary) �������, MAX(salary) �ְ���, MIN(salary) ��������
FROM employees
GROUP BY job_id;


-- ��¥ ���� �Լ�
SELECT SYSDATE FROM DUAL;
SELECT * FROM employees;
SELECT last_name, hire_date,TRUNC((SYSDATE - hire_date)/365,0) �ټӿ��� FROM employees;

-- Ư�� ���� ���� ���� ��¥�� ���ϱ�
SELECT last_name,hire_date, ADD_MONTHS(hire_date,6) FROM employees;

-- �ش� ��¥�� ���� ���� ������ ��ȯ�ϴ� �Լ�
SELECT LAST_DAY(SYSDATE) FROM DUAL;

--Q. ���� �� ����(hire_date ����)
SELECT hire_date, LAST_DAY(LAST_DAY(hire_date)+1) �����޸���
FROM employees;
SELECT hire_date, LAST_DAY(ADD_MONTHS(hire_date,1)) �����޸���
FROM employees;

-- �ش� ��¥�� �������� ��õ� ���Ͽ� �ش��ϴ� ������ ��¥�� ��ȯ
SELECT hire_date,next_day(hire_date,'��')
FROM employees;

-- months_between() ��¥�� ��¥ ������ ���� �� ���ϱ�
SELECT last_name, TRUNC(MONTHS_BETWEEN(SYSDATE,hire_date),0) �ټӿ���,ROUND(MONTHS_BETWEEN(SYSDATE,hire_date),0) �ټӿ���2
FROM employees;

--Q. �Ի��� 6���� �� ù ��° �������� �����̸����� ����ϼ���.
SELECT * FROM employees;
SELECT first_name, last_name, hire_date, next_day(ADD_MONTHS(hire_date,6),'��') "6���� �� ù��° ������"
FROM employees;

--Q. job_id ���� �����հ�, �������, �ְ���, �������� ���, �� ��տ����� 5000�̻��� ��츸 ����
SELECT job_id, SUM(salary) �����հ�, AVG(salary) �������, MAX(salary) �ְ���, MIN(salary) ��������
FROM employees
GROUP BY job_id
HAVING AVG(salary)>=5000;

--Q. job_id ���� �����հ�, �������, �ְ���, �������� ���, �� ��տ����� 5000�̻��� ��츸 �������� ����
SELECT job_id, SUM(salary) �����հ�, AVG(salary) �������, MAX(salary) �ְ���, MIN(salary) ��������
FROM employees
GROUP BY job_id
HAVING AVG(salary)>=5000
ORDER BY AVG(salary) DESC;

--Q. last_name�� L�� ���Ե� ������ ������ ���ϼ���.
SELECT last_name, salary
FROM employees
WHERE last_name LIKE '%L%';

SELECT last_name, salary
FROM employees
WHERE last_name LIKE '%L%' OR last_name LIKE '%l%';

-- Q. job_id�� PROG�� ���Ե� ������ �Ի����� ���ϼ���.
SELECT job_id ,last_name, hire_date
FROM employees
WHERE job_id LIKE '%PROG%';

--Q. ������ 10000$ �̻��� manager_id�� 100�� ������ �����͸� ����ϼ���.
SELECT last_name, salary, manager_id
FROM employees
WHERE salary>=10000 AND manager_id=100;

--Q. department_id�� 100���� ���� ��� ������ ������ ���ϼ���.
SELECT last_name,salary,department_id
FROM employees
WHERE department_id < 100;

--Q. department_id�� 101, 103�� ������ job_id�� ���ϼ���.
SELECT job_id,last_name, manager_id
FROM employees
WHERE manager_id = 101 OR manager_id = 103;

-- join
SELECT * FROM employees;
SELECT * FROM departments;

--Q. �����ȣ�� 110�� ����� �μ���
SELECT employee_id, department_name
FROM employees e,departments d
WHERE e.department_id = d.department_id AND e.employee_id=110;

SELECT employee_id, department_name
FROM employees e
JOIN departments d on e.department_id = d.department_id
WHERE e.employee_id = 110;

--Q. ����� 120���� ����� ���, �̸� ����(job_id), ������(job_title)�� ���
SELECT e.employee_id ���,e.first_name �̸�,e.last_name ��,e.job_id ����,j.job_title ������
FROM employees e
JOIN jobs j on e.job_id = j.job_id
WHERE e.employee_id = 120;

SELECT e.employee_id ���,e.first_name �̸�,e.last_name ��,e.job_id ����,j.job_title ������
FROM employees e ,jobs j
WHERE e.employee_id = 120 and e.job_id = j.job_id;

-- ���, �̸�, department_name, job_title(employees, departments, jobs)

SELECT e.employee_id ��� ,e.first_name �̸�,e.last_name ��,d.department_name �μ���,j.job_title �����̸�
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id AND e.job_id = j.job_id;

SELECT e.employee_id ��� ,e.first_name �̸�,e.last_name ��,d.department_name �μ���,j.job_title �����̸�
FROM employees e
JOIN departments d on e.department_id = d.department_id
JOIN jobs j on e.job_id = j.job_id
ORDER BY e.employee_id;

-- self join �ϳ��� ���̺��� �ΰ��� ���̺��� ��ó�� ����
SELECT e.employee_id ���, e.last_name �μ���, m.last_name ���,m.employee_id ���
FROM employees e, employees m  
WHERE e.employee_id = m.manager_id
ORDER BY e.employee_id;

-- outer join: �������ǿ� �������� ���ϴ��� �ش� ���� ��Ÿ���� ������ ���
SELECT e.employee_id ���, e.last_name �μ���, m.last_name ���,m.employee_id ���
FROM employees e, employees m  
WHERE e.employee_id = m.manager_id(+);

--Q. 100�� �μ��� ������ ����� �޿����� �� ���� �ݿ��� �޴� ����� ���
SELECT last_name, salary
FROM employees
WHERE salary >
ALL(SELECT salary FROM employees
WHERE department_id = 100);

--[����] 2005�� ���Ŀ� �Ի��� ������ ���, �̸�, �Ի���, �μ���(department_name), ������(job_title)�� ���
SELECT e.employee_id ���, e.last_name �̸�, e.hire_date �Ի���, d.department_name �μ���, j.job_title ������
FROM employees e
JOIN departments d ON d.department_id = e.department_id
JOIN jobs j ON j.job_id = e.job_id
WHERE hire_date > '2005/06/17';

--[����] job_title, department_name ���� ��� ������ ���� �� ����ϼ���.
SELECT job_title, department_name, ROUND(AVG(salary)) ��տ���
FROM employees e
JOIN departments d ON d.department_id = e.department_id
JOIN jobs j ON j.job_id = e.job_id
GROUP BY job_title, department_name;

--[����] ��պ��� ���� �޿��� �޴� ���� �˻� �� ����ϼ���.
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

--[����] last_name�� King�� ������ last_name, hire_date, department_id�� ����ϼ���
SELECT last_name, hire_date, department_id
FROM employees
WHERE LOWER(last_name) = 'king';
-- ��ҹ��� ������� ã��������� �̷���

--[����] ���, �̸�, ���� ����ϼ���. ��, ������ �Ʒ� ���ؿ� ����
--salary > 20000 then '��ǥ�̻�'
--salary > 15000 then '�̻�'
--salary > 10000 then '����'
--salary > 5000 then '����'
--salary > 3000 then '�븮'
--else '���'

SELECT employee_id ���, last_name �̸�,
CASE WHEN salary > 20000 then '��ǥ�̻�'
WHEN salary > 15000 then '�̻�'
WHEN salary > 10000 then '����'
WHEN salary > 5000 then '����'
WHEN salary > 3000 then '�븮'
ELSE '���' END AS ����
FROM employees;

SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM jobs;










