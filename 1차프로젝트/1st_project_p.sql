-- �б⺰ ��ո��ⵥ���� Ž��(������)
select
(select avg(���űݾ�) pur14Q1 from pur14Q1
where ����ȣ in (select * from custorigin)),
(select avg(���űݾ�) pur14Q2 from pur14Q2
where ����ȣ in (select * from custorigin)),
(select avg(���űݾ�) pur14Q3 from pur14Q3
where ����ȣ in (select * from custorigin)),
(select avg(���űݾ�) pur14Q4 from pur14Q4
where ����ȣ in (select * from custorigin)),
(select avg(���űݾ�) pur15Q1 from pur15Q1
where ����ȣ in (select * from custorigin)),
(select avg(���űݾ�) pur15Q2 from pur15Q2
where ����ȣ in (select * from custorigin)),
(select avg(���űݾ�) pur15Q3 from pur15Q3
where ����ȣ in (select * from custorigin)),
(select avg(���űݾ�) pur15Q4 from pur15Q4
where ����ȣ in (select * from custorigin))
from dual;

-- �б⺰ ��ո��ⵥ���� Ž��(���Ұ�)
select
(select avg(���űݾ�) pur14Q1 from pur14Q1
where ����ȣ in (select ����ȣ from purbydiv
where ����� < 1.062483356)),
(select avg(���űݾ�) pur14Q2 from pur14Q2
where ����ȣ in (select ����ȣ from purbydiv
where ����� < 1.062483356)),
(select avg(���űݾ�) pur14Q3 from pur14Q3
where ����ȣ in (select ����ȣ from purbydiv
where ����� < 1.062483356)),
(select avg(���űݾ�) pur14Q4 from pur14Q4
where ����ȣ in (select ����ȣ from purbydiv
where ����� < 1.062483356)),
(select avg(���űݾ�) pur15Q1 from pur15Q1
where ����ȣ in (select ����ȣ from purbydiv
where ����� < 1.062483356)),
(select avg(���űݾ�) pur15Q2 from pur15Q2
where ����ȣ in (select ����ȣ from purbydiv
where ����� < 1.062483356)),
(select avg(���űݾ�) pur15Q3 from pur15Q3
where ����ȣ in (select ����ȣ from purbydiv
where ����� < 1.062483356)),
(select avg(���űݾ�) pur15Q4 from pur15Q4
where ����ȣ in(select ����ȣ from purbydiv
where ����� < 1.062483356))
from dual;

-- ������ �б⺰ ��� �湮�󵵼� 

select �б�, round(avg (��),2) from(
select �б�,������, count(*) �� from(
select ������,��������,�б�,count(*) "�湮" from custorigin c
join purprod2 p on c.������ = p.����ȣ
group by ������,��������,�б�)
group by �б�,������)
group by �б�
order by �б�;

-- ���� �� �б⺰ ��� �湮�󵵼� 

select �б�, round(avg (��),2) from(
select �б�,����ȣ, count(*) �� from(
select p.����ȣ,��������,�б�,count(*) "�湮" from purbydiv c
join purprod2 p on c.����ȣ = p.����ȣ
where ����� < 1.062483356
group by p.����ȣ,��������,�б�)
group by �б�,����ȣ)
group by �б�
order by �б�;

-- ���޻纰 �б⺰ �������� ��ո���

select ���޻�, �б�, avg(���űݾ�) from purprod2 p
join custorigin c on c.����ȣ=p.����ȣ
group by ���޻�, �б�
order by ���޻�, �б�;

-- ���޻纰 �б⺰ ���Ұ��� ��ո���

select ���޻�, �б�, avg(���űݾ�) from purprod2 p
join purbydiv c on c.����ȣ=p.����ȣ
where ����� < 1.062483356
group by ���޻�, �б�
order by ���޻�, �б�;