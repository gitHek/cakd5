-- �б⺰ �� ���̱�
create table purprod3 as
(SELECT ���޻�,��������ȣ,�Һз��ڵ�,�Һз���,���պз�,�Һ���з�,����ȣ,�����ڵ�,��������,���Žð�,���űݾ�,year,��,
CASE WHEN �������� > 20150931 then 'Q8'
WHEN �������� > 20150631 then 'Q7'
WHEN �������� > 20150331 then 'Q6'
WHEN �������� > 20141231 then 'Q5'
WHEN �������� > 20140931 then 'Q4'
WHEN �������� > 20140631 then 'Q3'
WHEN �������� > 20140331 then 'Q2' 
ELSE 'Q1' END AS �б�
FROM purprod2);

-- �б⺰ ��ո��ⵥ���� Ž��(������)
select �б�, avg(���űݾ�) ��ո��� from purprod2 a
join custorigin b on a.����ȣ = b.����ȣ
group by �б�
order by �б�;

-- �б⺰ ��ո��ⵥ���� Ž��(���Ұ�)

select �б�, avg(���űݾ�) ��ո��� from purprod2 a
join purbydiv b on a.����ȣ = b.����ȣ
where ����� < 1.062483356
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