-- dml

DESC BOOK;
SELECT * FROM BOOK;
SELECT BOOKNAME,PRICE FROM BOOK;
SELECT PUBLISHER FROM BOOK;
-- 고유한 값만 추출(중복제거) : DISTINCT
SELECT DISTINCT PUBLISHER FROM BOOK;
-- 불린 인덱싱
SELECT *
FROM BOOK
WHERE PRICE <10000;
-- Q. 가격이 10000원 이상 20000원 이하인 도서를 검색하세요.
SELECT *
FROM BOOK
WHERE PRICE <= 20000 AND PRICE >= 10000;

-- Q. 출판사가 굿스포츠, 혹은 대한미디어인 도서를 검색하세요.
SELECT * FROM BOOK WHERE publisher = '굿스포츠' OR publisher = '대한미디어';
SELECT * FROM BOOK WHERE PUBLISHER IN ('굿스포츠' , '대한미디어');

-- Q. 출판사가 굿스포츠, 혹은 대한미디어가 아닌 도서를 검색하세요.
SELECT * FROM BOOK WHERE PUBLISHER NOT IN ('굿스포츠' , '대한미디어');

-- Q. 도서이름에 축구가 포함된 출판사를 검색하세요.
select * 
from book 
where BOOKNAME like '%축구%';

-- [과제] 도서이름의 왼쪽 두 번쨰 위치에 구라는 문자열을  갖는 도서를 검색하세요.
-- _은 특정 위치의 한개의 문자와 일치
-- %은 0개 이상의 문자와 일치
SELECT *
FROM BOOK
WHERE BOOKNAME LIKE '_구%';
-- [과제] 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하세요.
SELECT *
FROM BOOK
WHERE BOOKNAME LIKE '%축구%' AND PRICE >= 20000;

-- 정렬
SELECT * FROM BOOK ORDER BY BOOKNAME;
-- 내림차순 정렬
SELECT * FROM BOOK ORDER BY BOOKNAME DESC;

--Q. 도서를 가격순으로 검색하고 가격이 같으면 이름순으로 검색하세요.
SELECT * FROM BOOK ORDER BY PRICE,BOOKNAME;

--Q. 도서를 가격의 내림차순으로 검색하고 만약 가격이 같다면 출판사의 올림차순으로 정령하세요
SELECT * FROM BOOK ORDER BY PRICE DESC,PUBLISHER;

SELECT * FROM ORDERS;
SELECT SUM(SALEPRICE) FROM ORDERS;

SELECT SUM(SALEPRICE) AS "총매출" FROM ORDERS;

-- Q. CUSTID 가 2번인 고객이 주문한 도서의 총 판매액을 구하세요.
SELECT SUM(SALEPRICE) AS "총판매액" FROM ORDERS WHERE CUSTID = 2;

SELECT SUM(SALEPRICE) AS "총 판매액",
MIN(SALEPRICE) AS 최소금액,
MAX(SALEPRICE) AS 최대금액, 
AVG(SALEPRICE) AS 평균금액
FROM ORDERS;

SELECT COUNT(*) FROM ORDERS;

-- Q. 도서 수량과 총 판매액을 출력하세요.
SELECT CUSTID,COUNT(*) AS "도서수량",
SUM(SALEPRICE) AS "총 판매액"
FROM ORDERS GROUP BY CUSTID;

--Q. 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문도서의 총 수량을 구하세요.
-- 단 두권 이상 구매한 고객에 한정함
SELECT CUSTID, COUNT(*) AS 총수량
FROM ORDERS
WHERE SALEPRICE >= 8000
GROUP BY CUSTID
HAVING COUNT(*) >=2;

SELECT * FROM CUSTOMER;

SELECT * 
FROM CUSTOMER, ORDERS
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID
ORDER BY CUSTOMER.CUSTID;

--Q. 고객별로 주문한 모든 도서의 총 판매액을 구하고 고객별로 정렬하세요.
SELECT CUSTID,
SUM(SALEPRICE) AS 총판매액
FROM ORDERS
GROUP BY CUSTID
ORDER BY CUSTID;

SELECT * FROM CUSTOMER;
SELECT * FROM BOOK;
SELECT * FROM ORDERS;
-- Q. 고객의 이름과 고객이 주문한 도서의 이름을 구하세요.
SELECT NAME ,BOOKNAME 
FROM CUSTOMER, BOOK , ORDERS 
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID AND ORDERS.BOOKID = BOOK.BOOKID;

SELECT C.NAME ,B.BOOKNAME 
FROM CUSTOMER C, BOOK B, ORDERS O
WHERE C.CUSTID = O.CUSTID AND O.BOOKID = B.BOOKID;

-- [과제] 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하세요.
SELECT C.NAME ,B.BOOKNAME,B.PRICE
FROM CUSTOMER C, BOOK B, ORDERS O
WHERE C.CUSTID = O.CUSTID AND O.BOOKID = B.BOOKID AND B.PRICE =20000;

-- [과제] 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하세요.
-- OURTER JOIN 조인조건을 만족하지 못하더라도 해당행을 나타냄
SELECT C.NAME ,O.SALEPRICE
FROM CUSTOMER C, ORDERS O 
WHERE C.CUSTID = O.CUSTID(+);
-- [과제] 가장 비싼 도서의 이름을 출력하세요.
SELECT BOOKNAME, PRICE
FROM BOOK
WHERE PRICE = (SELECT MAX(PRICE) FROM BOOK);

-- [과제] 도서를 구매한 적이 있는 고객의 이름을 검색하세요.
SELECT DISTINCT C.NAME
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID;

SELECT NAME
FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS);
-- [과제] 대한미디어에서 출판한 도서를 구매한 고객의 이름을 출력하세요.

SELECT C.NAME , B.BOOKNAME, B.PUBLISHER
FROM CUSTOMER C, ORDERS O, BOOK B
WHERE C.CUSTID = O.CUSTID AND B.BOOKID = O.BOOKID AND B.PUBLISHER = '대한미디어';

SELECT NAME
FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS
WHERE BOOKID IN (SELECT BOOKID FROM BOOK
WHERE PUBLISHER = '대한미디어'));

-- Q. 출판사별로 출판사의 평균 도서가격보다 비싼 도서를 구하시오.
SELECT * FROM BOOK;
SELECT B1.BOOKNAME FROM BOOK B1
WHERE B1.PRICE > (SELECT AVG(B2.PRICE)
FROM BOOK B2 WHERE B2.PUBLISHER = B1.PUBLISHER);

--Q. 도서를 주문하지 않은 고객의 이름을 보이시오.
SELECT NAME
FROM CUSTOMER
MINUS
SELECT NAME
FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS);

SELECT NAME
FROM CUSTOMER
WHERE CUSTID NOT IN (SELECT CUSTID FROM ORDERS);

-- Q. 주문이 있는 고객의 이름과 주소를 보이시오.
SELECT * FROM CUSTOMER;
SELECT NAME, ADDRESS
FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS);

--Q. CUSTOMER 테이블에서 고객벊노가 5인 고객의 주소를 '대한민국 부산'으로 변경하시오
SELECT * FROM CUSTOMER;

UPDATE CUSTOMER
SET ADDRESS = '대한민국 부산'
WHERE CUSTID = 5;
SELECT * FROM CUSTOMER;

-- Q. customer 테이블에서 박세리의 주소를 김연아의 주소 바꾸세요.

UPDATE customer
SET address = (SELECT address FROM customer
WHERE name = '김연아')
WHERE name = '박세리';
SELECT * FROM CUSTOMER;

-- Q. customer 테이블에서 고객번호가 5인 고객을 삭제하 후 결과를 확인하세요.
DELETE customer
WHERE custid = 5;
SELECT * FROM customer;

SELECT ABS(-78), ABS(+78) FROM DUAL;
SELECT ROUND(4.875,1) FROM DUAL;
select * from orders;
-- Q. 고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하시오.
SELECT custid 고객번호 ,ROUND(AVG(saleprice),-2) 평균주문금액
FROM orders
GROUP BY custid;

-- Q. 도서 제목에 '야구'가 포함된 도서를 '농구'로 변경한 후 도서목록, 가격을 보이시오.
SELECT * FROM book;
SELECT bookid, REPLACE(bookname,'야구','농구') bookname, price
FROM book;

-- Q. '굿스포츠'에서 출판한 도서의 제목과 제목의 글자 수, 바이트 수를 보이시오.
SELECT bookname 제목, LENGTH(bookname) 글자수, LENGTHB(bookname) 바이트수
FROM book
WHERE publisher = '굿스포츠';

SELECT * FROM customer;
INSERT INTO customer(custid,name,adress) VALUES (5,'박세리','대한민국 대전');
INSERT INTO customer VALUES (5,'박세리','대한민국 대전',NULL);
INSERT INTO customer VALUES (6,'박세리','대한민국 대전','010-9000-0001');
DELETE customer WHERE custid = 6;

-- Q. 마당서점의 고객 중세어 같은 성(姓) 을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.
SELECT SUBSTR(name,1,1) 성, COUNT(*) 인원수
FROM customer
GROUP BY SUBSTR(name,1,1);

--Q. 마당서점은 주문일로 부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하세요.
SELECT orderid, custid, bookid, saleprice, orderdate , orderdate + 10 주문확정일자 
FROM orders;

SELECT orderdate, orderdate + 10 주문확정일자 
FROM orders;

--Q. DBMS 서버에 설정된 현재 날짜와 시간, 요일을 확인하세요.
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE,'yyyy/mm/dd dy hh24:mi:ss') SYSDATE1 FROM DUAL;

--Q. 마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오.
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE,'yyyy/mm/dd dy hh24:mi:ss') SYSDATE1 FROM DUAL;

SELECT * FROM orders;
SELECT orderid 주문번호, TO_CHAR(orderdate,'yyyy-mm-dd day') 주문일, custid 고객번호, bookid 도서번호
FROM orders
WHERE orderdate = '20-07-07';

--Q. 고객목록에서 고객번호, 이름, 전화번호를 앞의 2명만 보이시오.
SELECT * FROM customer;
SELECT ROWNUM 순번, custid 고객번호, name 이름, phone 전화번호
FROM customer
WHERE ROWNUM<=2;

--Q. 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
SELECT * FROM orders;
SELECT orderid 주문번호, saleprice 금액
FROM orders
WHERE saleprice <= (SELECT AVG(saleprice) FROM orders);

--Q. 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 보이시오.
SELECT orderid 주문번호, custid 고객번호, saleprice 금액
FROM orders o1
WHERE o1.saleprice > (SELECT avg(o2.saleprice) FROM orders o2 WHERE o1.custid = o2.custid);

-- Q. '대한민국'에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice)
FROM orders
WHERE custid in (SELECT custid FROM customer WHERE address LIKE '%대한민국%');

-- Q. 3번고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 보이시오.
SELECT orderid 주문번호, saleprice 금액
FROM orders
WHERE saleprice > (SELECT MAX(saleprice) FROM orders WHERE custid = 3);

select * from customer;
select * from orders;
select * from book;

--[과제] EXISTS 연산자를 사용하여 '대한민국'에 거주하는 고객에게 판매한 도서의 총 판매액을 수하시오.
SELECT SUM(saleprice) total
FROM orders o 
WHERE EXISTS (SELECT * FROM customer c 
WHERE address LIKE '%대한민국%' AND o.custid = c.custid);

--[과제] 마당서점의 고객별 판매액을 보이시오(고객이름과 고객별 판매액 출력).
SELECT (SELECT name FROM customer c WHERE c.custid = o.custid) name,
SUM(saleprice) total FROM orders o
GROUP BY o.custid;

--[과제] 고객번호가 2 이하인 고객의 판매액을 보이시오(고객이름과 고객별 판매액 출력)
SELECT	c.name, SUM(o.saleprice) "total"
FROM (SELECT custid, name FROM Customer WHERE custid <= 2) c,Orders	o
WHERE c.custid=o.custid
GROUP BY c.name;

--Q. 주소에 '대한민국'을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오. 뷰의 이름은 vw_Customer로 설정하시오.
CREATE VIEW vw_Customer
AS SELECT *
FROM customer
WHERE address LIKE '%대한민국%';

SELECT * FROM vw_Customer;

SELECT * FROM orders;
--Q. Orders 테이블에서 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성하세요.
CREATE VIEW v_1
AS SELECT o.orderid,c.name,b.bookname,o.saleprice,o.orderdate FROM orders o,book b,customer c
WHERE o.bookid=b.bookid and o.custid = c.custid;
SELECT * FROM v_1;
-- ‘김연아’ 고객이 구입한 도서의 주문번호, 도서이름, 주문액을 보이시오.
SELECT orderid 주문번호, bookname 도서이름, saleprice 주문액
FROM v_1
WHERE name = '김연아';

--[과제] vw_Customer를 미국을 주소로 가진 고객으로 변경하세요.

CREATE OR REPLACE VIEW vw_Customer
AS SELECT * FROM customer
WHERE address LIKE '%미국%';
SELECT * FROM vw_Customer;

--[과제] 앞서 생성한 뷰 vw_Customer를 삭제하시오.
DROP VIEW vw_Customer;

SELECT * FROM employees;

--[과제} EMPLOYEES 테이블에서 commission_pct의 Null 값 개수를 출력하세요.
SELECT 
--[과제} EMPLOYEES 테이블에서 employee_id가 홀수인 것만 출력하세요.
--[과제} job_id의 문자 길이를 구하세요.
--[과제} job_id 별로 연봉합계, 연봉평균, 최고연봉, 최저연봉 출력
--Q. 입사일 6개월 후 첫 번째 월요일을 직원이름별로 출력하세요.
--Q. job_id 별로 연봉합계, 연봉평균, 최고연봉, 최저연봉 출력, 단 평균연봉이 5000이상인 경우만 포함
--Q. job_id 별로 연봉합계, 연봉평균, 최고연봉, 최저연봉 출력, 단 평균연봉이 5000이하인 경우만 포함




