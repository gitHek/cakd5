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

