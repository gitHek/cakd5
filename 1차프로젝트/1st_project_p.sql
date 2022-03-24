-- ������ == ��� �ݱ⸶�� �����̷��� �ִ� ��
create table custorigin as
select a.����ȣ ����ȣ from
(select distinct ����ȣ from purprod2
where (��������>=20140101 and �������� <=20140631)) a
join (select distinct ����ȣ from purprod2
where (��������>=20140701 and �������� <=20141231)) b on a.����ȣ = b.����ȣ 
join (select distinct ����ȣ from purprod2
where (��������>=20150101 and �������� <=20150631)) c on a.����ȣ = c.����ȣ
join (select distinct ����ȣ from purprod2
where (��������>=20150701 and �������� <=20151231)) d on a.����ȣ = d.����ȣ
order by a.����ȣ;

-- ���Ұ� ���� : ���� ��������� ���� ������ �� or ���⵵���� ���� ������ ��(����θ�Ƽ ����)
create table purbydiv as
select a.����ȣ, "15H1"/"14H1" ����� from custorigin a 
join (select ����ȣ, sum(���űݾ�)*1.045 "14H1" from (select * from purprod2 where �б� = 'Q1' or �б� = 'Q2') group by ����ȣ) b on a.����ȣ = b.����ȣ
join (select ����ȣ, sum(���űݾ�)*1.017 "15H1" from (select * from purprod2 where �б� = 'Q5' or �б� = 'Q6') group by ����ȣ) c on a.����ȣ = c.����ȣ
join custorigin d on a.����ȣ = d.����ȣ;

create table purbydiv2 as
select a.����ȣ, "15H1"/"14H1" ����� from custorigin a 
join (select ����ȣ, sum(���űݾ�)*1.045 "14H1" from (select * from purprod2 where �б� = 'Q1' or �б� = 'Q2') group by ����ȣ) b on a.����ȣ = b.����ȣ
join (select ����ȣ, sum(���űݾ�)*0.983 "15H1" from (select * from purprod2 where �б� = 'Q7' or �б� = 'Q8') group by ����ȣ) c on a.����ȣ = c.����ȣ
join custorigin d on a.����ȣ = d.����ȣ;

(select * from purbydiv
where ����� < 0.8);

-- �б�,�ݱ⺰ �� ���̱�
create table purprod3 as
(SELECT ���޻�,��������ȣ,�Һз��ڵ�,�Һз���,���պз�,�Һ���з�,����ȣ,�����ڵ�,��������,���Žð�,���űݾ�,year,��,
CASE WHEN �������� > 20150931 then 'Q8'
WHEN �������� > 20150631 then 'Q7'
WHEN �������� > 20150331 then 'Q6'
WHEN �������� > 20141231 then 'Q5'
WHEN �������� > 20140931 then 'Q4'
WHEN �������� > 20140631 then 'Q3'
WHEN �������� > 20140331 then 'Q2' 
ELSE 'Q1' END AS �б�,
CASE WHEN �������� > 20150631 then 'H4'
WHEN �������� > 20141231 then 'H3'
WHEN �������� > 20140631 then 'H2' 
ELSE 'H1' END AS �ݱ�
FROM purprod2);

-- �б⺰ ������ �� ����
select �б� , sum(���űݾ�) �Ѹ��� from purprod2 a
join custorigin b on a.����ȣ= b.����ȣ
group by �б�
order by �б�;

-- �б⺰ �������� �� ����
select �б� , sum(���űݾ�) �Ѹ��� from purprod2 a
join purbydiv b on a.����ȣ= b.����ȣ
where ����� < 0.8
group by �б�
order by �б�;

-- �б⺰ ���� ��ո��ⵥ���� Ž��(������)
select �б�, avg(��ո���) ��ո��� from (
select �б�,����ȣ,avg(���űݾ�) ��ո��� from purprod2
group by �б�, ����ȣ)a
join custorigin b on a.����ȣ = b.����ȣ
group by �б�
order by �б�;

-- �б⺰ ���� ��ո��ⵥ���� Ž��(��������)
select �б�, avg(��ո���) ��ո��� from (
select �б�,����ȣ,avg(���űݾ�) ��ո��� from purprod2
group by �б�, ����ȣ)a
join purbydiv b on a.����ȣ = b.����ȣ
where ����� < 0.8
group by �б�
order by �б�;

-- ������ �б⺰ ��� �湮�󵵼� 

select �б�, round(avg (��),2) from(
select �б�,������, count(*) �� from(
select ������,��������,�б�,count(*) "�湮" from custorigin c
join purprod2 p on c.������ = p.����ȣ
group by ������,��������,�б�)
group by �б�,������)
group by �б�
order by �б�;

--�������� �б⺰ ��� �湮�󵵼� 

select �б�, round(avg (��),2) from(
select �б�,����ȣ, count(*) �� from(
select p.����ȣ,��������,�б�,count(*) "�湮" from purbydiv c
join purprod2 p on c.����ȣ = p.����ȣ
where ����� < 0.8
group by p.����ȣ,��������,�б�)
group by �б�,����ȣ)
group by �б�
order by �б�;



-- ���޻纰 �б⺰ �������� ��ո���

select ���޻�, �б�, avg(���űݾ�) from purprod2 p
join custorigin c on c.����ȣ=p.����ȣ
group by ���޻�, �б�
order by ���޻�, �б�;

-- ���޻纰 �б⺰ ���������� ��ո���

select ���޻�, �б�, avg(���űݾ�) from purprod2 p
join purbydiv c on c.����ȣ=p.����ȣ
where ����� < 0.8
group by ���޻�, �б�
order by ���޻�, �б�;

-- �������� 1�ݱ� ���� : 150705606508 ��

select sum(���űݾ�) from purprod2 a
join custorigin b on a.����ȣ = b.����ȣ
where �ݱ� = 'H1';

-- �������� 3�ݱ� ���� : 164494835833 ��

select sum(���űݾ�) from purprod2 a
join custorigin b on a.����ȣ = b.����ȣ
where  �ݱ� = 'H3';


-- ���������� 1�ݱ� ���� : 59310081176 ��

select sum(���űݾ�) from purprod2 a
join purbydiv b on a.����ȣ = b.����ȣ
where ����� < 1.0915 and �ݱ� = 'H1';

-- ���������� 3�ݱ� ���� : 32818370138 ��

select sum(���űݾ�) from purprod2 a
join purbydiv b on a.����ȣ = b.����ȣ
where ����� < 1.0915 and �ݱ� = 'H3';

-- ��ü ���� 15�� 1�ݱ� ���� : 165231857377 ��
select sum(���űݾ�) from purprod2 a
where  �б� = 'Q5' or �б� = 'Q6';


-- ������ �� : 19147
select count(*) from custorigin;

-- �������� �� : 4551
select count(*) from custorigin a
join purbydiv b on a.����ȣ=b.����ȣ
where ����� < 1.0915;

select count(*) from custorigin a
join purbydiv b on a.����ȣ=b.����ȣ
where ����� < 1;
select count(*) from custorigin a
join purbydiv b on a.����ȣ=b.����ȣ
where ����� < 0.9;
select count(*) from custorigin a
join purbydiv b on a.����ȣ=b.����ȣ
where ����� < 0.8;
select count(*) from custorigin a
join purbydiv b on a.����ȣ=b.����ȣ
where ����� < 0.7;
select count(*) from custorigin a
join purbydiv b on a.����ȣ=b.����ȣ
where ����� < 0.6;

-- ���պз��� �б⺰ ���� ��ո��ⵥ���� Ž��(������)
select ���պз�,�б�, avg(��ո���) ��ո��� from (
select ���պз�,�б�,����ȣ,avg(���űݾ�) ��ո��� from purprod2
group by ���պз�,�б�, ����ȣ)a
join custorigin b on a.����ȣ = b.����ȣ
group by ���պз�,�б�
order by ���պз�,�б�;

-- ���պз��� �б⺰ ��ո��ⵥ���� Ž��(���Ұ�)
select ���պз�,�б�, avg(��ո���) ��ո��� from (
select ���պз�,�б�,����ȣ,avg(���űݾ�) ��ո��� from purprod2
group by ���պз�,�б�, ����ȣ)a
join purbydiv b on a.����ȣ = b.����ȣ
where ����� < 0.8
group by ���պз�,�б�
order by ���պз�,�б�;

create table purprod3 as
(SELECT a.���޻�,��������ȣ,a.�Һз��ڵ�,b.�Һз���,b.���պз�,b.�Һ���з�,����ȣ,�����ڵ�,��������,���Žð�,���űݾ�,year,��
FROM purprod2 a
join prodcl2 b on a.�Һз��ڵ� = b.�Һз��ڵ�);

-- ������ ���� ���������� �� �� ������ ���ذ� ��� ����
-- ���� 7034��, ���� 1583��
-- ���� 44.2% , ���� 45.4%

select a.����,���� ���Ұ���,��ü,round(����/��ü,3) ����
from (select ����, count(a.����ȣ) ��ü from custdemo a
join custorigin b on a.����ȣ = b.����ȣ
group by ����
order by ����) a
join 
(select ����,count(a.����ȣ) ���� from custdemo a
join purbydiv b on a.����ȣ= b.����ȣ
where ����� <0.8
group by ����
order by ����) b on a.���� = b.����;

-- ���ɴ뿡 ���� ���������� �� �� ������ ���ذ� ��� ����

select a.���ɴ�,���� ���Ұ���,��ü,round(����/��ü,3) ����
from (select ���ɴ�, count(a.����ȣ) ��ü from custdemo a
join custorigin b on a.����ȣ = b.����ȣ
group by ���ɴ�
order by ���ɴ�) a
join 
(select ���ɴ�,count(a.����ȣ) ���� from custdemo a
join purbydiv b on a.����ȣ= b.����ȣ
where ����� <0.8
group by ���ɴ�
order by ���ɴ�) b on a.���ɴ� = b.���ɴ�;

-- ���������� ���� �������� ��
select a.��������,���� ���Ұ���,��ü,round(����/��ü,3) ����
from (select ��������, count(a.����ȣ) ��ü from custdemo a
join custorigin b on a.����ȣ = b.����ȣ
group by ��������
order by ��������) a
join 
(select ��������,count(a.����ȣ) ���� from custdemo a
join purbydiv b on a.����ȣ= b.����ȣ
where ����� <0.8
group by ��������
order by ��������) b on a.�������� = b.��������;

-- ������̿�Ƚ���� �б�, �ݱ�� ���̱�
create table compet2 as
(SELECT ����ȣ,���޻�,�����,�̿���,
CASE WHEN �̿��� > 201509 then 'Q8'
WHEN �̿��� > 201506 then 'Q7'
WHEN �̿��� > 201503 then 'Q6'
WHEN �̿��� > 201412 then 'Q5'
WHEN �̿��� > 201409 then 'Q4'
WHEN �̿��� > 201406 then 'Q3'
WHEN �̿��� > 201403 then 'Q2' 
ELSE 'Q1' END AS �б�,
CASE WHEN �̿��� > 201506 then 'H4'
WHEN �̿��� > 201412 then 'H3'
WHEN �̿��� > 201406 then 'H2' 
ELSE 'H1' END AS �ݱ�
FROM compet);

-- ���������� �б⺰ ����� �̿�� : 2015���� �����͸� �ֱ⿡ Ȱ���� �����.

select �б�, count(*) from compet2 group by �б�;
select �б�, count(*) from compet2 a
join custorigin b on a.����ȣ = b.����ȣ 
group by �б�;

-- ���������� ��� ä���̿�Ƚ�� : 5.61ȸ
select round(avg(nvl("�̿�Ƚ��",0)),2) ����̿�Ƚ�� from channel a
join custorigin b on a.����ȣ(+) = b.����ȣ
order by �̿�Ƚ�� ;

-- ������������ ��� ä�� �̿�Ƚ�� : 4.8ȸ
select round(avg(nvl("�̿�Ƚ��",0)),2) ����̿�Ƚ�� from channel a
join purbydiv b on a.����ȣ(+) = b.����ȣ
where ����� <0.8
order by �̿�Ƚ�� ;

-- ä���� �̿����� ���� ����߿� ���������� ����?

-- ������ �б⺰ �� �湮�󵵼� 

select �б�, sum(��) from(
select �б�,����ȣ, count(*) �� from(
select c.����ȣ,��������,�б�,count(*) "�湮" from custorigin c
join purprod2 p on c.����ȣ = p.����ȣ
group by c.����ȣ,��������,�б�)
group by �б�,����ȣ)
group by �б�
order by �б�;

-- ������ �ݱ⺰ �� �湮�󵵼� 

select �ݱ�, sum(��) from(
select �ݱ�,����ȣ, count(*) �� from(
select c.����ȣ,��������,�ݱ�,count(*) "�湮" from custorigin c
join purprod2 p on c.����ȣ = p.����ȣ
group by c.����ȣ,��������,�ݱ�)
group by �ݱ�,����ȣ)
group by �ݱ�
order by �ݱ�;


-- ������ �ݱ⺰ ���� �� �湮 �󵵼� 

select �ݱ�,����ȣ, count(*) �� from(
select c.����ȣ,�ݱ�,��������,count(*) "�湮" from custorigin c
join purprod2 p on c.����ȣ = p.����ȣ
group by c.����ȣ,�ݱ�,��������)
group by �ݱ�,����ȣ
order by �ݱ�,����ȣ;

-- ���� �ݱ⺰ �� �湮�� ���ϱ�
select a.����ȣ,H1,H2,H3,H4 from
(select ����ȣ, count(*) H1 from(
select c.����ȣ,��������,count(*) "�湮" from custorigin c
join purprod2 p on c.����ȣ = p.����ȣ
where �ݱ� = 'H1'
group by c.����ȣ,��������)
group by ����ȣ
order by ����ȣ) a
join (select ����ȣ, count(*) H2 from(
select c.����ȣ,��������,count(*) "�湮" from custorigin c
join purprod2 p on c.����ȣ = p.����ȣ
where �ݱ� = 'H2'
group by c.����ȣ,��������)
group by ����ȣ
order by ����ȣ) b on a.����ȣ = b.����ȣ
join (select ����ȣ, count(*) H3 from(
select c.����ȣ,��������,count(*) "�湮" from custorigin c
join purprod2 p on c.����ȣ = p.����ȣ
where �ݱ� = 'H3'
group by c.����ȣ,��������)
group by ����ȣ
order by ����ȣ) c on a.����ȣ = c.����ȣ
join (select ����ȣ, count(*) H4 from(
select c.����ȣ,��������,count(*) "�湮" from custorigin c
join purprod2 p on c.����ȣ = p.����ȣ
where �ݱ� = 'H4'
group by c.����ȣ,��������)
group by ����ȣ
order by ����ȣ) d on a.����ȣ = d.����ȣ;

-- ���� �ݱ⺰ �� ���űݾ� ���ϱ� 

select a.����ȣ,H1�ݱ�,H2�ݱ�,H3�ݱ�,H4�ݱ� from
(select b.����ȣ, nvl(���űݾ�,0) H1�ݱ� from (
SELECT ����ȣ, SUM(���űݾ�) ���űݾ� FROM PURPROD2
where �ݱ� = 'H1'-- ���⿡ �߰��� ���� ��������
GROUP BY ����ȣ) a
join custorigin b on a.����ȣ(+) = b.����ȣ
order by ����ȣ) a
join (select b.����ȣ, nvl(���űݾ�,0) H2�ݱ� from (
SELECT ����ȣ, SUM(���űݾ�) ���űݾ� FROM PURPROD2
where �ݱ� = 'H2' -- ���⿡ �߰��� ���� ��������
GROUP BY ����ȣ) a
join custorigin b on a.����ȣ(+) = b.����ȣ) b on a.����ȣ = b.����ȣ
join (select b.����ȣ, nvl(���űݾ�,0) H3�ݱ� from (
SELECT ����ȣ, SUM(���űݾ�) ���űݾ� FROM PURPROD2
where �ݱ� = 'H3' -- ���⿡ �߰��� ���� ��������
GROUP BY ����ȣ) a
join custorigin b on a.����ȣ(+) = b.����ȣ) c on a.����ȣ = c.����ȣ
join (select b.����ȣ, nvl(���űݾ�,0) H4�ݱ� from (
SELECT ����ȣ, SUM(���űݾ�) ���űݾ� FROM PURPROD2
where �ݱ� = 'H4'  -- ���⿡ �߰��� ���� ��������
GROUP BY ����ȣ) a
join custorigin b on a.����ȣ(+) = b.����ȣ) d on a.����ȣ = d.����ȣ;

-- �ݱ⺰ ���� Ƚ�� ���ϱ�

select a.����ȣ,H1�ݱ�,H2�ݱ�,H3�ݱ�,H4�ݱ� from
(select b.����ȣ, nvl(����Ƚ��,0) H1�ݱ� from (
SELECT ����ȣ, count(*) ����Ƚ�� FROM PURPROD2
where �ݱ� = 'H1' and �Һ���з� = '��Ÿ'-- ���⿡ �߰��� ���� ��������
GROUP BY ����ȣ) a
join custorigin b on a.����ȣ(+) = b.����ȣ
order by ����ȣ) a
join (select b.����ȣ, nvl(����Ƚ��,0) H2�ݱ� from (
SELECT ����ȣ, count(*) ����Ƚ�� FROM PURPROD2
where �ݱ� = 'H2' and �Һ���з� = '��Ÿ'-- ���⿡ �߰��� ���� ��������
GROUP BY ����ȣ) a
join custorigin b on a.����ȣ(+) = b.����ȣ) b on a.����ȣ = b.����ȣ
join (select b.����ȣ, nvl(����Ƚ��,0) H3�ݱ� from (
SELECT ����ȣ, count(*) ����Ƚ�� FROM PURPROD2
where �ݱ� = 'H3' and �Һ���з� = '��Ÿ'-- ���⿡ �߰��� ���� ��������
GROUP BY ����ȣ) a
join custorigin b on a.����ȣ(+) = b.����ȣ) c on a.����ȣ = c.����ȣ
join (select b.����ȣ, nvl(����Ƚ��,0) H4�ݱ� from (
SELECT ����ȣ, count(*) ����Ƚ�� FROM PURPROD2
where �ݱ� = 'H4' and �Һ���з� = '��Ÿ'-- ���⿡ �߰��� ���� ��������
GROUP BY ����ȣ) a
join custorigin b on a.����ȣ(+) = b.����ȣ) d on a.����ȣ = d.����ȣ;

select * from purprod2 where ���պз� = '�Ǳ�';

-- ���������� 1�� �� ���̱�
select a.����ȣ,ceil(nvl(�����,0)) from custorigin a
join (select * from purbydiv2
where ����� < 0.8
order by ����ȣ) b on a.����ȣ= b.����ȣ(+)
order by ����ȣ;

-- ���� �ݱ⺰ �ֱٱ�����?
select a.����ȣ,H1�ݱ�,H2�ݱ�,H3�ݱ�,H4�ݱ� from
(select b.����ȣ, to_date(20140701)-max(to_date(��������)) H1�ݱ� from purprod2 a
join custorigin b on a.����ȣ(+) = b.����ȣ
where �ݱ� = 'H1'
group by b.����ȣ
order by b.����ȣ) a
join (select b.����ȣ, to_date(20150101)-max(to_date(��������)) H2�ݱ� from purprod2 a
join custorigin b on a.����ȣ(+) = b.����ȣ
where �ݱ� = 'H2'
group by b.����ȣ) b on a.����ȣ = b.����ȣ
join (select b.����ȣ, to_date(20150701)-max(to_date(��������)) H3�ݱ� from purprod2 a
join custorigin b on a.����ȣ(+) = b.����ȣ
where �ݱ� = 'H3'
group by b.����ȣ) c on a.����ȣ = c.����ȣ
join (select b.����ȣ, to_date(20160101)-max(to_date(��������)) H4�ݱ� from purprod2 a
join custorigin b on a.����ȣ(+) = b.����ȣ
where �ݱ� = 'H4'
group by b.����ȣ) d on a.����ȣ = d.����ȣ;

-- ���� ä�� �̿� Ƚ��
select a.����ȣ, ���� from custorigin a
join custdemo b on a.����ȣ = b.����ȣ
order by ����ȣ;