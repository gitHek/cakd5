-- �б⺰ ���ⵥ���� Ž��(������)
select
(select sum(���űݾ�) pur14Q1 from pur14Q1
where ����ȣ in (select * from custorigin)),
(select sum(���űݾ�) pur14Q2 from pur14Q2
where ����ȣ in (select * from custorigin)),
(select sum(���űݾ�) pur14Q3 from pur14Q3
where ����ȣ in (select * from custorigin)),
(select sum(���űݾ�) pur14Q4 from pur14Q4
where ����ȣ in (select * from custorigin)),
(select sum(���űݾ�) pur15Q1 from pur15Q1
where ����ȣ in (select * from custorigin)),
(select sum(���űݾ�) pur15Q2 from pur15Q2
where ����ȣ in (select * from custorigin)),
(select sum(���űݾ�) pur15Q3 from pur15Q3
where ����ȣ in (select * from custorigin)),
(select sum(���űݾ�) pur15Q4 from pur15Q4
where ����ȣ in (select * from custorigin))
from dual;

-- �б⺰ ���ⵥ���� Ž��(���Ұ�)
select
(select sum(���űݾ�) pur14Q1 from pur14Q1
where ����ȣ in (select ����ȣ from purbydiv
where ����� < 1.062483356)),
(select sum(���űݾ�) pur14Q2 from pur14Q2
where ����ȣ in (select ����ȣ from purbydiv
where ����� < 1.062483356)),
(select sum(���űݾ�) pur14Q3 from pur14Q3
where ����ȣ in (select ����ȣ from purbydiv
where ����� < 1.062483356)),
(select sum(���űݾ�) pur14Q4 from pur14Q4
where ����ȣ in (select ����ȣ from purbydiv
where ����� < 1.062483356)),
(select sum(���űݾ�) pur15Q1 from pur15Q1
where ����ȣ in (select ����ȣ from purbydiv
where ����� < 1.062483356)),
(select sum(���űݾ�) pur15Q2 from pur15Q2
where ����ȣ in (select ����ȣ from purbydiv
where ����� < 1.062483356)),
(select sum(���űݾ�) pur15Q3 from pur15Q3
where ����ȣ in (select ����ȣ from purbydiv
where ����� < 1.062483356)),
(select sum(���űݾ�) pur15Q4 from pur15Q4
where ����ȣ in(select ����ȣ from purbydiv
where ����� < 1.062483356))
from dual;

-- �湮�󵵼��� �������� ���� �ִ밪
select ����,max(��) from(
select ntile(100) over (order by �� desc) as ����, ����ȣ, �� from(
select ����ȣ, count(*) �� from(
select c.����ȣ,��������,count(*) "��" from custdemo c
join purprod p on c.����ȣ = p.����ȣ
group by c.����ȣ,��������
order by c.����ȣ)
group by ����ȣ
order by ����ȣ))
group by ����
order by max(��);