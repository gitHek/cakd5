-- �󺧺� ���պз�,���޻�,�Һ���з� ����
-- 0
select a.���պз� , round(H4-H1) from
(select ���պз� , sum(���űݾ�)*1.045 H1 from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 0 and �ݱ� = 'H1'
group by ���պз�) a
join (select ���պз� , sum(���űݾ�)*0.983 H4 from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 0 and �ݱ� = 'H4'
group by ���պз�) b on a.���պз� = b.���պз�
order by H4-H1;

select a.���޻� , round(H4-H1) from
(select ���޻� , sum(���űݾ�)*1.045 H1 from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 0 and �ݱ� = 'H1'
group by ���޻�) a
join (select ���޻� , sum(���űݾ�)*0.983 H4 from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 0 and �ݱ� = 'H4'
group by ���޻�) b on a.���޻� = b.���޻�
order by H4-H1;

select a.�Һ���з� , round(H4-H1) from
(select �Һ���з� , sum(���űݾ�)*1.045 H1 from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 0 and �ݱ� = 'H1'
group by �Һ���з�) a
join (select �Һ���з� , sum(���űݾ�)*0.983 H4 from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 0 and �ݱ� = 'H4'
group by �Һ���з�) b on a.�Һ���з� = b.�Һ���з�
order by H4-H1;

-- 1
select a.���պз� , round(H4-H1) from
(select ���պз� , sum(���űݾ�)*1.045 H1 from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 1 and �ݱ� = 'H1'
group by ���պз�) a
join (select ���պз� , sum(���űݾ�)*0.983 H4 from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 1 and �ݱ� = 'H4'
group by ���պз�) b on a.���պз� = b.���պз�
order by H4-H1;

select a.���޻� , round(H4-H1) from
(select ���޻� , sum(���űݾ�)*1.045 H1 from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 1 and �ݱ� = 'H1'
group by ���޻�) a
join (select ���޻� , sum(���űݾ�)*0.983 H4 from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 1 and �ݱ� = 'H4'
group by ���޻�) b on a.���޻� = b.���޻�
order by H4-H1;

select a.�Һ���з� , round(H4-H1) from
(select �Һ���з� , sum(���űݾ�)*1.045 H1 from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 1 and �ݱ� = 'H1'
group by �Һ���з�) a
join (select �Һ���з� , sum(���űݾ�)*0.983 H4 from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 1 and �ݱ� = 'H4'
group by �Һ���з�) b on a.�Һ���з� = b.�Һ���з�
order by H4-H1;

-- 2
select a.���պз� , round(H4-H1) from
(select ���պз� , sum(���űݾ�)*1.045 H1 from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 2 and �ݱ� = 'H1'
group by ���պз�) a
join (select ���պз� , sum(���űݾ�)*0.983 H4 from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 2 and �ݱ� = 'H4'
group by ���պз�) b on a.���պз� = b.���պз�
order by H4-H1;

select a.���޻� , round(H4-H1) from
(select ���޻� , sum(���űݾ�)*1.045 H1 from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 2 and �ݱ� = 'H1'
group by ���޻�) a
join (select ���޻� , sum(���űݾ�)*0.983 H4 from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 2 and �ݱ� = 'H4'
group by ���޻�) b on a.���޻� = b.���޻�
order by H4-H1;

select a.�Һ���з� , round(H4-H1) from
(select �Һ���з� , sum(���űݾ�)*1.045 H1 from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 2 and �ݱ� = 'H1'
group by �Һ���з�) a
join (select �Һ���з� , sum(���űݾ�)*0.983 H4 from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 2 and �ݱ� = 'H4'
group by �Һ���з�) b on a.�Һ���з� = b.�Һ���з�
order by H4-H1;

-- ���޻纰 �̿�Ƚ��
select ���޻�, round(avg(Ƚ��)) Ƚ�� from(
select ���޻� ,b.����ȣ, count(��������ȣ)Ƚ�� from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 0
group by ���޻�, b.����ȣ)
group by ���޻�
order by Ƚ��;

select ���޻�, round(avg(Ƚ��)) Ƚ�� from(
select ���޻� ,b.����ȣ, count(��������ȣ)Ƚ�� from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 1
group by ���޻�, b.����ȣ)
group by ���޻�
order by Ƚ��;

select ���޻�, round(avg(Ƚ��)) Ƚ�� from(
select ���޻� ,b.����ȣ, count(��������ȣ)Ƚ�� from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 2
group by ���޻�, b.����ȣ)
group by ���޻�
order by Ƚ��;

-- �󺧺� ����� �̿� �� ä���̿�
select ���޻�, round(avg(�̿�Ƚ��),2) �̿�Ƚ�� from (select b.����ȣ,nvl(���޻�,'C_ONLINEMALL') ���޻� ,nvl(�̿�Ƚ��,0) �̿�Ƚ�� from channel a
join gunzip b on a.����ȣ(+) = b.����ȣ
where �� = 0
order by b.����ȣ)
group by ���޻�
order by ���޻�;
select ���޻�, round(avg(�̿�Ƚ��),2) �̿�Ƚ�� from (select b.����ȣ,nvl(���޻�,'C_ONLINEMALL') ���޻� ,nvl(�̿�Ƚ��,0) �̿�Ƚ�� from channel a
join gunzip b on a.����ȣ(+) = b.����ȣ
where �� = 1
order by b.����ȣ)
group by ���޻�
order by ���޻�;
select ���޻�, round(avg(�̿�Ƚ��),2) �̿�Ƚ�� from (select b.����ȣ,nvl(���޻�,'C_ONLINEMALL') ���޻� ,nvl(�̿�Ƚ��,0) �̿�Ƚ�� from channel a
join gunzip b on a.����ȣ(+) = b.����ȣ
where �� = 2
order by b.����ȣ)
group by ���޻�
order by ���޻�;

-- �󺧺� ���޻縦 �̿��� �� ��
select ���޻�, count(*) from channel a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 2
group by ���޻�
order by ���޻�;




select ���޻� ,round(avg(�̿�Ƚ��),2) �̿�Ƚ�� from channel a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 2
group by ���޻�
order by ���޻�;

select count(*) from (
select distinct a.����ȣ from compet a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 2
order by ����ȣ);


select distinct ���޻� from channel
order by ���޻�;

select * from channel
order by ����ȣ;

select ���޻� , round(avg(�̿�Ƚ��),2) from(
select a.����ȣ, ���޻�, count(*) �̿�Ƚ�� from compet a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 0
group by a.����ȣ ,���޻�)
group by ���޻�
order by ���޻�;
select ���޻� , round(avg(�̿�Ƚ��),2) from(
select a.����ȣ, ���޻�, count(*) �̿�Ƚ�� from compet a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 1
group by a.����ȣ ,���޻�)
group by ���޻�
order by ���޻�;
select ���޻� , round(avg(�̿�Ƚ��),2) from(
select a.����ȣ, ���޻�, count(*) �̿�Ƚ�� from compet a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 2
group by a.����ȣ ,���޻�)
group by ���޻�
order by ���޻�;

-- �󺧺� ��� ����� ��� �̿�Ƚ��
select round(avg(nvl(�̿�Ƚ��,0)),2) from(
select a.����ȣ, ���޻�, count(*) �̿�Ƚ�� from compet a
join gunzip b on a.����ȣ= b.����ȣ
where �� = 0
group by a.����ȣ ,���޻�) a
join gunzip b on a.����ȣ(+) = b.����ȣ;
select round(avg(nvl(�̿�Ƚ��,0)),2) from(
select a.����ȣ, ���޻�, count(*) �̿�Ƚ�� from compet a
join gunzip b on a.����ȣ= b.����ȣ
where �� = 1
group by a.����ȣ ,���޻�) a
join gunzip b on a.����ȣ(+) = b.����ȣ;select round(avg(nvl(�̿�Ƚ��,0)),2) from(
select a.����ȣ, ���޻�, count(*) �̿�Ƚ�� from compet a
join gunzip b on a.����ȣ= b.����ȣ
where �� = 2
group by a.����ȣ ,���޻�) a
join gunzip b on a.����ȣ(+) = b.����ȣ;





select distinct ���޻� from channel;





select * from compet;


select ����ȣ from purbydiv2
where ����� <0.8 
order by ����ȣ;

select ����ȣ from gunzip
order by ����ȣ;

select sum(���űݾ�) from purprod2 a
join purbydiv2 b on a.����ȣ = b.����ȣ
where �����<0.8 and �ݱ� = 'H4';

select sum(���űݾ�) from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �ݱ� = 'H4';

select round(avg(����Ƚ��)) from (
select b.����ȣ, sum(���űݾ�) ����Ƚ�� from purprod2 a
join gunzip b on a.����ȣ = b.����ȣ
where �� = 2
group by b.����ȣ);