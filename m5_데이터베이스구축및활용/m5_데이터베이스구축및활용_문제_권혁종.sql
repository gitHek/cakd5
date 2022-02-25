������ ��� AI ���� �ַ�� ������ ��������

������� : �����ͺ��̽� ���� �� Ȱ��

- ���� : 22.02.25
- ���� : ������
- ���� : 90


�� HR TABLES(EMPLOYEES, DEPARTMENTS, COUNTRIES, JOB_HISSTORY, JOBS, LOCATIONS, REGIONS)�� Ȱ���Ͽ� ���� �������� �����ϼ���.
select * from employees;
--Q1. HR EMPLOYEES ���̺��� �̸�, ����, 10% �λ�� ������ ����ϼ���.
--A.

select last_name �̸�, salary ����, round(salary*1.1) "10% �λ�� ����"
from employees;
    
--Q2.  2005�� ��ݱ⿡ �Ի��� ����鸸 ���	
--A.        
select last_name, hire_date
from employees
where hire_date >= '2005/01/01' and hire_date <= '2005/06/30';

--Q3. ���� SA_MAN, IT_PROG, ST_MAN �� ����� ���
--A.
select last_name, job_id
from employees
where job_id in ('SA_MAN', 'IT_PROG', 'ST_MAN');
   
--Q4. manager_id �� 101���� 103�� ����� ���
--A.   	
SELECT last_name, manager_id
FROM employees
WHERE manager_id BETWEEN 101 AND 103;

--Q5. EMPLOYEES ���̺��� LAST_NAME, HIRE_DATE �� �Ի����� 6���� �� ù ��° �������� ����ϼ���.
--A.
SELECT last_name, hire_date, NEXT_DAY(ADD_MONTHS(hire_date,6),'��') "6���� �� ù ������"
from employees;

--Q6. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� �����ϱ����� W_MONTH(�ټӿ���)�� ������ ����ؼ� ����ϼ���.(�ټӿ��� ���� ��������)
--A.
SELECT employee_id, last_name, salary, hire_date, TRUNC(MONTHS_BETWEEN(sysdate,hire_date)) �ټӿ���
FROM employees
ORDER BY �ټӿ��� DESC;

--Q7. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� W_YEAR(�ټӳ��)�� ����ؼ� ����ϼ���.(�ټӳ�� ���� ��������)
--A.
SELECT employee_id, last_name, salary, hire_date, TRUNC((to_date(sysdate)-hire_date)/365) �ټӳ��
FROM employees
ORDER BY �ټӳ�� DESC;

--Q8. EMPLOYEE_ID�� Ȧ���� ������ EMPLPYEE_ID�� LAST_NAME�� ����ϼ���.
--A. 
SELECT employee_id, last_name
FROM employees
WHERE MOD(employee_id,2)=1;

--Q9. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME �� M_SALARY(����)�� ����ϼ���. �� ������ �Ҽ��� ��°�ڸ������� ǥ���ϼ���.
--A
SELECT employee_id, last_name, round(salary/12,2) M_SALARY
FROM employees;

--Q10. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� �ټӳ���� ����ؼ� �Ʒ������� �߰��� �Ŀ� ����ϼ���.
--2001�� 1�� 1�� â���Ͽ� 2020�� 12�� 31�ϱ��� 20�Ⱓ ��ǿ� ȸ��� ������  �ټӳ���� ���� 30 ������� ������  ��޿� ���� 1000���� BONUS�� ����.
--�������� ����.    
--A.
SELECT employee_id, last_name, salary, hire_date, TRUNC((to_date('2020/12/31')-hire_date)/365) �ټӳ��,
WIDTH_BUCKET(TRUNC((to_date('2020/12/31')-hire_date)/365),0,20,30) BONUS���,
WIDTH_BUCKET(TRUNC((to_date('2020/12/31')-hire_date)/365),0,20,30)*1000 BONUS
FROM employees
ORDER BY BONUS DESC;

--Q11. EMPLOYEES ���̺��� commission_pct ��  Null�� ������  ����ϼ���.
--A.
SELECT COUNT(*)
FROM employees
WHERE commission_pct IS NULL;

--Q12. EMPLOYEES ���̺��� deparment_id �� ���� ������ �����Ͽ�  POSITION�� '����'���� ����ϼ���.
--A. Ʋ��
SELECT last_name, NVL(department_id,'����') POSITION
FROM employees
WHERE department_id IS NULL;

--Q13. ����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���(join~on, where �� �����ϴ� �� ���� ��� ���)
--A. Ʋ��
SELECT employee_id ���, last_name �̸�, e.job_id ����, job_title  ������
FROM employees e
join jobs j on j.job_id = e.job_id
where employee_id = 120;

SELECT employee_id ���, last_name �̸�, e.job_id ����, job_title  ������
from employees e,jobs j
where j.job_id = e.job_id and employee_id = 120;

--Q14.  employees ���̺��� �̸��� FIRST_NAME�� LAST_NAME�� �ٿ��� 'NAME' �÷������� ����ϼ���.
--��) Steven King
--A. 
select employee_id , first_name||' '||last_name name
from employees;

--Q15. lmembers purprod ���̺�� ���� �ѱ��ž�, 2014 ���ž�, 2015 ���ž��� �ѹ��� ����ϼ���.
--A. Ʋ��
select (select sum(p1.���űݾ�) from purprod p1) as amt,
(select sum(p2.���űݾ�) from purprod p2 where p2.��������<20150101) as amt_2014,
(select sum(p3.���űݾ�) from purprod p3 where p3.��������>20141231) as amt_2015
from dual;

--Q16. HR EMPLOYEES ���̺��� escape �ɼ��� ����Ͽ� �Ʒ��� ���� ��µǴ� SQL���� �ۼ��ϼ���.
--job_id Į������  _�� ���ϵ�ī�尡 �ƴ� ���ڷ� ����Ͽ� '_A'�� �����ϴ�  ��� ���� ���
--A.

SELECT * FROM employees
WHERE job_id like '%/_A%' ESCAPE '/';

--Q17. HR EMPLOYEES ���̺��� SALARY, LAST_NAME ������ �ø����� �����Ͽ� ����ϼ���.
--A. 
SELECT * FROM employees
ORDER BY salary , last_name;
   
--Q18. Seo��� ����� �μ����� ����ϼ���.
--A.
SELECT last_name, department_name �μ���
from employees e
join departments d on d.department_id = e.department_id
where last_name = 'Seo';

--Q19. LMEMBERS �����Ϳ��� ���� ���űݾ��� �հ踦 ���� CUSPUR ���̺��� ������ �� CUSTDEMO ���̺�� 
--����ȣ�� �������� �����Ͽ� ����ϼ���.
--A.
CREATE TABLE CUSPUR AS 
select ����ȣ, sum(���űݾ�) ���űݾ���
from purprod
group by ����ȣ;

SELECT * from custdemo d
join cuspur p on d.����ȣ = p.����ȣ;

--Q20.PURPROD ���̺�� ���� �Ʒ� ������ �����ϼ���.
-- 2�Ⱓ ���űݾ��� ���� ������ �и��Ͽ� ����, ���޻纰�� ���ž��� ǥ���ϴ� AMT_14, AMT_15 ���̺� 2���� ���� (��³��� : ����ȣ, ���޻�, SUM(���űݾ�) ���űݾ�)
--AMT14�� AMT15 2�� ���̺��� ����ȣ�� ���޻縦 �������� FULL OUTER JOIN �����Ͽ� ������ AMT_YEAR_FOJ ���̺� ����
--14��� 15���� ���űݾ� ���̸� ǥ���ϴ� ���� �÷��� �߰��Ͽ� ���(��, ����ȣ, ���޻纰�� ���űݾ� �� ������ ���еǾ�� ��)
--A.

create table AMT_14 as
select ����ȣ, ���޻�, sum(���űݾ�) ���űݾ� from purprod
where �������� <= 20141231
group by ����ȣ, ���޻�
order by ����ȣ;

create table AMT_15 as
select ����ȣ, ���޻�, sum(���űݾ�) ���űݾ� from purprod
where �������� >= 20150101
group by ����ȣ, ���޻�
order by ����ȣ;

create table AMT_YEAR_FOJ as
select a.����ȣ "14�����ȣ",a.���޻� "14�����޻�",a.���űݾ� "14�ⱸ�űݾ�",
b.����ȣ "15�����ȣ",b.���޻� "15�����޻�",b.���űݾ� "15�ⱸ�űݾ�"
from amt_14 a
full outer join amt_15 b on a.����ȣ = b.����ȣ and a.���޻� = b.���޻�;

select "14�����ȣ","14�����޻�","15�����ȣ","15�����޻�",NVL("15�ⱸ�űݾ�",0)-NVL("14�ⱸ�űݾ�",0) ���� from AMT_YEAR_FOJ
order by "14�����ȣ";

select * from AMT_YEAR_FOJ
where "15�����ȣ" is null;
--Q(BONUS). HR ���̺���� �м��ؼ� ��ü ��Ȳ�� ������ �� �ִ� ��� ���̺��� �ۼ��ϼ���. (�� : �μ��� ��� SALARY ����)
--A.
select e.job_id,j.job_title, round(avg(salary)) "������ ��տ���",
rank() over(order by round(avg(salary)) DESC) ��������,
count(e.employee_id) �ο���
from employees e
join departments d on d.department_id = e.department_id
join jobs j on j.job_id = e.job_id
group by e.job_id,j.job_title;

