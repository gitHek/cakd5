빅데이터 기반 AI 응용 솔루션 개발자 전문과정

교과목명 : 데이터베이스 구축 및 활용

- 평가일 : 22.02.25
- 성명 : 권혁종
- 점수 : 90


※ HR TABLES(EMPLOYEES, DEPARTMENTS, COUNTRIES, JOB_HISSTORY, JOBS, LOCATIONS, REGIONS)를 활용하여 다음 질문들을 수행하세요.
select * from employees;
--Q1. HR EMPLOYEES 테이블에서 이름, 연봉, 10% 인상된 연봉을 출력하세요.
--A.

select last_name 이름, salary 연봉, round(salary*1.1) "10% 인상된 연봉"
from employees;
    
--Q2.  2005년 상반기에 입사한 사람들만 출력	
--A.        
select last_name, hire_date
from employees
where hire_date >= '2005/01/01' and hire_date <= '2005/06/30';

--Q3. 업무 SA_MAN, IT_PROG, ST_MAN 인 사람만 출력
--A.
select last_name, job_id
from employees
where job_id in ('SA_MAN', 'IT_PROG', 'ST_MAN');
   
--Q4. manager_id 가 101에서 103인 사람만 출력
--A.   	
SELECT last_name, manager_id
FROM employees
WHERE manager_id BETWEEN 101 AND 103;

--Q5. EMPLOYEES 테이블에서 LAST_NAME, HIRE_DATE 및 입사일의 6개월 후 첫 번째 월요일을 출력하세요.
--A.
SELECT last_name, hire_date, NEXT_DAY(ADD_MONTHS(hire_date,6),'월') "6개월 후 첫 월요일"
from employees;

--Q6. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 현재일까지의 W_MONTH(근속월수)를 정수로 계산해서 출력하세요.(근속월수 기준 내림차순)
--A.
SELECT employee_id, last_name, salary, hire_date, TRUNC(MONTHS_BETWEEN(sysdate,hire_date)) 근속월수
FROM employees
ORDER BY 근속월수 DESC;

--Q7. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 W_YEAR(근속년수)를 계산해서 출력하세요.(근속년수 기준 내림차순)
--A.
SELECT employee_id, last_name, salary, hire_date, TRUNC((to_date(sysdate)-hire_date)/365) 근속년수
FROM employees
ORDER BY 근속년수 DESC;

--Q8. EMPLOYEE_ID가 홀수인 직원의 EMPLPYEE_ID와 LAST_NAME을 출력하세요.
--A. 
SELECT employee_id, last_name
FROM employees
WHERE MOD(employee_id,2)=1;

--Q9. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME 및 M_SALARY(월급)을 출력하세요. 단 월급은 소수점 둘째자리까지만 표현하세요.
--A
SELECT employee_id, last_name, round(salary/12,2) M_SALARY
FROM employees;

--Q10. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 근속년수를 계산해서 아래사항을 추가한 후에 출력하세요.
--2001년 1월 1일 창업하여 2020년 12월 31일까지 20년간 운영되온 회사는 직원의  근속년수에 따라 30 등급으로 나누어  등급에 따라 1000원의 BONUS를 지급.
--내림차순 정렬.    
--A.
SELECT employee_id, last_name, salary, hire_date, TRUNC((to_date('2020/12/31')-hire_date)/365) 근속년수,
WIDTH_BUCKET(TRUNC((to_date('2020/12/31')-hire_date)/365),0,20,30) BONUS등급,
WIDTH_BUCKET(TRUNC((to_date('2020/12/31')-hire_date)/365),0,20,30)*1000 BONUS
FROM employees
ORDER BY BONUS DESC;

--Q11. EMPLOYEES 테이블에서 commission_pct 의  Null값 갯수를  출력하세요.
--A.
SELECT COUNT(*)
FROM employees
WHERE commission_pct IS NULL;

--Q12. EMPLOYEES 테이블에서 deparment_id 가 없는 직원을 추출하여  POSITION을 '신입'으로 출력하세요.
--A. 틀림
SELECT last_name, NVL(department_id,'신입') POSITION
FROM employees
WHERE department_id IS NULL;

--Q13. 사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력(join~on, where 로 조인하는 두 가지 방법 모두)
--A. 틀림
SELECT employee_id 사번, last_name 이름, e.job_id 업무, job_title  업무명
FROM employees e
join jobs j on j.job_id = e.job_id
where employee_id = 120;

SELECT employee_id 사번, last_name 이름, e.job_id 업무, job_title  업무명
from employees e,jobs j
where j.job_id = e.job_id and employee_id = 120;

--Q14.  employees 테이블에서 이름에 FIRST_NAME에 LAST_NAME을 붙여서 'NAME' 컬럼명으로 출력하세요.
--예) Steven King
--A. 
select employee_id , first_name||' '||last_name name
from employees;

--Q15. lmembers purprod 테이블로 부터 총구매액, 2014 구매액, 2015 구매액을 한번에 출력하세요.
--A. 틀림
select (select sum(p1.구매금액) from purprod p1) as amt,
(select sum(p2.구매금액) from purprod p2 where p2.구매일자<20150101) as amt_2014,
(select sum(p3.구매금액) from purprod p3 where p3.구매일자>20141231) as amt_2015
from dual;

--Q16. HR EMPLOYEES 테이블에서 escape 옵션을 사용하여 아래와 같이 출력되는 SQL문을 작성하세요.
--job_id 칼럼에서  _을 와일드카드가 아닌 문자로 취급하여 '_A'를 포함하는  모든 행을 출력
--A.

SELECT * FROM employees
WHERE job_id like '%/_A%' ESCAPE '/';

--Q17. HR EMPLOYEES 테이블에서 SALARY, LAST_NAME 순으로 올림차순 정렬하여 출력하세요.
--A. 
SELECT * FROM employees
ORDER BY salary , last_name;
   
--Q18. Seo라는 사람의 부서명을 출력하세요.
--A.
SELECT last_name, department_name 부서명
from employees e
join departments d on d.department_id = e.department_id
where last_name = 'Seo';

--Q19. LMEMBERS 데이터에서 고객별 구매금액의 합계를 구한 CUSPUR 테이블을 생성한 후 CUSTDEMO 테이블과 
--고객번호를 기준으로 결합하여 출력하세요.
--A.
CREATE TABLE CUSPUR AS 
select 고객번호, sum(구매금액) 구매금액합
from purprod
group by 고객번호;

SELECT * from custdemo d
join cuspur p on d.고객번호 = p.고객번호;

--Q20.PURPROD 테이블로 부터 아래 사항을 수행하세요.
-- 2년간 구매금액을 연간 단위로 분리하여 고객별, 제휴사별로 구매액을 표시하는 AMT_14, AMT_15 테이블 2개를 생성 (출력내용 : 고객번호, 제휴사, SUM(구매금액) 구매금액)
--AMT14와 AMT15 2개 테이블을 고객번호와 제휴사를 기준으로 FULL OUTER JOIN 적용하여 결합한 AMT_YEAR_FOJ 테이블 생성
--14년과 15년의 구매금액 차이를 표시하는 증감 컬럼을 추가하여 출력(단, 고객번호, 제휴사별로 구매금액 및 증감이 구분되어야 함)
--A.

create table AMT_14 as
select 고객번호, 제휴사, sum(구매금액) 구매금액 from purprod
where 구매일자 <= 20141231
group by 고객번호, 제휴사
order by 고객번호;

create table AMT_15 as
select 고객번호, 제휴사, sum(구매금액) 구매금액 from purprod
where 구매일자 >= 20150101
group by 고객번호, 제휴사
order by 고객번호;

create table AMT_YEAR_FOJ as
select a.고객번호 "14년고객번호",a.제휴사 "14년제휴사",a.구매금액 "14년구매금액",
b.고객번호 "15년고객번호",b.제휴사 "15년제휴사",b.구매금액 "15년구매금액"
from amt_14 a
full outer join amt_15 b on a.고객번호 = b.고객번호 and a.제휴사 = b.제휴사;

select "14년고객번호","14년제휴사","15년고객번호","15년제휴사",NVL("15년구매금액",0)-NVL("14년구매금액",0) 증감 from AMT_YEAR_FOJ
order by "14년고객번호";

select * from AMT_YEAR_FOJ
where "15년고객번호" is null;
--Q(BONUS). HR 테이블들을 분석해서 전체 현황을 설명할 수 있는 요약 테이블을 작성하세요. (예 : 부서별 평균 SALARY 순위)
--A.
select e.job_id,j.job_title, round(avg(salary)) "업무별 평균연봉",
rank() over(order by round(avg(salary)) DESC) 연봉순위,
count(e.employee_id) 인원수
from employees e
join departments d on d.department_id = e.department_id
join jobs j on j.job_id = e.job_id
group by e.job_id,j.job_title;

