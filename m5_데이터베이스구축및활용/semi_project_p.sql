-- ����� �̿�� ���� n�� �̱�

select * from (select ����ȣ,count(*) from compet
group by ����ȣ
order by count(*) desc)
where rownum <=3500;

-- ����� �̿�� ���� 1000���� ���� ����

select round(avg(����)) from purbygap
where ����ȣ in (select * from (select ����ȣ from compet
group by ����ȣ
order by count(*) desc)
where rownum <=1000);

-- '079' ���������� B���޻��� ������ ��û���� ���� 

select ���޻�,year, sum(���űݾ�) from purprod p
join custdemo d on p.����ȣ = d.����ȣ
where �������� = '079'
group by ���޻�,year
order by ���޻�,year;

-- ���� ���Ұ����� �������� ī��Ʈ

select ��������, count(����ȣ) from custdemo
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%')
group by ��������
order by count(����ȣ) desc;

-- ���� ���Ұ����� ���������� ���Ҿ� ��

select ��������, sum(����) from custdemo c
join purbygap p on p.����ȣ = c.����ȣ
where c.����ȣ in (select ����ȣ from purbygap where ���� like '-%')
group by ��������
order by sum(����);

-- ���� ���Ҿ��� ���� ����

select ��������, sum(����) from custdemo c
join purbygap p on p.����ȣ = c.����ȣ
group by ��������
order by sum(����);

-- ���� ���Ұ��� ���޻纰 �⵵�� ���űݾ�

select ���޻�,year, sum(���űݾ�) from purprod p
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%')
group by ���޻�,year
order by ���޻�,year;

-- ������ ���� ���� ���Ұ� ��
-- ���� 7034��, ���� 1583��

select ����,count(����ȣ) from custdemo
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%')
group by ����
order by ����;

-- ������ ���Ű��� �� ����
-- ���� 44.2% , ���� 45.4%

select a.����,round(����/��ü,3) 
from (select ����, count(����ȣ) ��ü from custdemo
group by ����
order by ����) a
join 
(select ����,count(����ȣ) ���� from custdemo
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%')
group by ����
order by ����) b on a.���� = b.����;

-- ���ɴ뺰 ���� ���� �� ��

select ���ɴ�,count(����ȣ) from custdemo
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%')
group by ���ɴ�
order by ���ɴ�;


-- ���ɴ뺰 ���� ���� ������

select a.���ɴ�, round(����/��ü,3) 
from (select ���ɴ�, count(����ȣ) ��ü from custdemo
group by ���ɴ�
order by ���ɴ�) a
join 
(select ���ɴ�,count(����ȣ) ���� from custdemo
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%')
group by ���ɴ�
order by ���ɴ�) b on a.���ɴ� = b.���ɴ�;

-- '079' ���������� ������ 2014�� 2015�� ���� 

select ���޻�,year, sum(���űݾ�) from purprod p
join custdemo d on p.����ȣ = d.����ȣ
where �������� = '079'
group by ���޻�,year
order by ���޻�,year;

-- �� ����������, ������, �⵵�� �����
select �����ڵ�,��������,year,sum(���űݾ�) from purprod p
join custdemo c on p.����ȣ = c.����ȣ
group by �����ڵ�,��������,year
order by �����ڵ�,��������,year;

-- ������ ������ ���Ұ��� ������
create table jumpo_year_2014 as
select �����ڵ�,YEAR,SUM(���űݾ�) ���ž� from PURBYGAP G
join custdemo c on G.����ȣ = c.����ȣ
join purprod p on P.����ȣ = c.����ȣ
where c.����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2014
group by �����ڵ�,YEAR
order by �����ڵ�,YEAR;

create table jumpo_year_2015 as
select �����ڵ�,YEAR,SUM(���űݾ�) ���ž� from PURBYGAP G
join custdemo c on G.����ȣ = c.����ȣ
join purprod p on P.����ȣ = c.����ȣ
where c.����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2015
group by �����ڵ�,YEAR
order by �����ڵ�,YEAR;

select j4.�����ڵ�, j5.���ž�-j4.���ž� ���������� from jumpo_year_2014 j4
join jumpo_year_2015 j5 on j4.�����ڵ� = j5.�����ڵ�
order by ����������;

-- ���պз��� ���Ű��Ұ��� ������ �� ����� ������

create table gapbytong14 as 
select ���պз�, sum(���űݾ�) �ѱ��űݾ� from purprod p
join prodcl_new c on c.�Һз��ڵ� = p.�Һз��ڵ�
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2014
group by ���պз�
order by �ѱ��űݾ� desc;

select * from gapbytong14

create table gapbytong15 as 
select ���պз�, sum(���űݾ�) �ѱ��űݾ� from purprod p
join prodcl_new c on c.�Һз��ڵ� = p.�Һз��ڵ�
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2015
group by ���պз�
order by �ѱ��űݾ� desc;

select * from gapbytong15;

select g4.���պз�, g5."�ѱ��űݾ�"-g4."�ѱ��űݾ�" ���� from gapbytong14 g4
join gapbytong15 g5 on g4.���պз� = g5.���պз�
order by ����;

-- ���պз��� ������ 2014���� 2015�⵵ ���Ű��Ұ����� ������

select ���պз�, sum(���űݾ�) �ѱ��űݾ� from purprod p
join prodcl_new c on c.�Һз��ڵ� = p.�Һз��ڵ�
join custdemo d on d.����ȣ = p.����ȣ
where p.����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2015 and ���� = 'F'
group by ���պз�
order by �ѱ��űݾ� desc;

select g4.���պз�,nvl(g5."�ѱ��űݾ�",0)-nvl(g4."�ѱ��űݾ�",0) ���� from
(select ���պз�, sum(���űݾ�) �ѱ��űݾ� from purprod p
join prodcl_new c on c.�Һз��ڵ� = p.�Һз��ڵ�
join custdemo d on d.����ȣ = p.����ȣ
where p.����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2014 and ���� = 'M'
group by ���պз�
order by �ѱ��űݾ� desc) g4
join (select ���պз�, sum(���űݾ�) �ѱ��űݾ� from purprod p
join prodcl_new c on c.�Һз��ڵ� = p.�Һз��ڵ�
join custdemo d on d.����ȣ = p.����ȣ
where p.����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2015 and ���� = 'M'
group by ���պз�
order by �ѱ��űݾ� desc) g5 on g4.���պз� = g5.���պз�
order by ����;

-- �ο� ��ü�� ���̰� �������� ������ ���Ű��Ұ� �е������� ����
-- ������ �ֿ� ���� ǰ���� �м�,��ǰ,��󸮿� ���õ� �͵鿡�� ���� ���Ұ� ����
-- �̸� ���� �İ�� ����� ������??

-- ���� ���� ������ ��ȭ�ϴ� �׸��� ã�ƺ���?

-- ���Ű��Ұ��� ��� ����� �̿�Ƚ�� : 1.53ȸ
select round(avg(nvl(Ƚ��,0)),2) from(
select c.����ȣ,Ƚ�� from custdemo c
join (select ����ȣ , count(����ȣ) Ƚ�� from compet
group by ����ȣ
order by ����ȣ) d on c.����ȣ = d.����ȣ(+))
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%');

-- ��ü ������ ��� ����� �̿�Ƚ�� : 1.45ȸ
select round(avg(nvl(Ƚ��,0)),2) from(
select c.����ȣ,Ƚ�� from custdemo c
join (select ����ȣ , count(����ȣ) Ƚ�� from compet
group by ����ȣ
order by ����ȣ) d on c.����ȣ = d.����ȣ(+));
