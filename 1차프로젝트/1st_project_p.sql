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

-- ���������� 14�⵵ 1�ݱ� ���� : 56401500984 ��

select sum(���űݾ�) from purprod2 a
join purbydiv b on a.����ȣ = b.����ȣ
where ����� < 0.8 and (�б� = 'Q1' or �б� = 'Q2');

-- ���������� 15�⵵ 1�ݱ� ���� : 30458845532 ��

select sum(���űݾ�) from purprod2 a
join purbydiv b on a.����ȣ = b.����ȣ
where ����� < 0.8 and (�б� = 'Q5' or �б� = 'Q6');

-- ��ü ���� 15�� 1�ݱ� ���� : 165231857377 ��
select sum(���űݾ�) from purprod2 a
where  �б� = 'Q5' or �б� = 'Q6';


-- ������ �� : 19147
select count(*) from custorigin;

-- �������� �� : 4551
select count(*) from custorigin a
join purbydiv b on a.����ȣ=b.����ȣ
where ����� < 0.8;

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

