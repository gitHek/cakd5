-- 분기별 매출데이터 탐색(기존고객)
select
(select sum(구매금액) pur14Q1 from pur14Q1
where 고객번호 in (select * from custorigin)),
(select sum(구매금액) pur14Q2 from pur14Q2
where 고객번호 in (select * from custorigin)),
(select sum(구매금액) pur14Q3 from pur14Q3
where 고객번호 in (select * from custorigin)),
(select sum(구매금액) pur14Q4 from pur14Q4
where 고객번호 in (select * from custorigin)),
(select sum(구매금액) pur15Q1 from pur15Q1
where 고객번호 in (select * from custorigin)),
(select sum(구매금액) pur15Q2 from pur15Q2
where 고객번호 in (select * from custorigin)),
(select sum(구매금액) pur15Q3 from pur15Q3
where 고객번호 in (select * from custorigin)),
(select sum(구매금액) pur15Q4 from pur15Q4
where 고객번호 in (select * from custorigin))
from dual;

-- 분기별 매출데이터 탐색(감소고객)
select
(select sum(구매금액) pur14Q1 from pur14Q1
where 고객번호 in (select 고객번호 from purbydiv
where 성장률 < 1.062483356)),
(select sum(구매금액) pur14Q2 from pur14Q2
where 고객번호 in (select 고객번호 from purbydiv
where 성장률 < 1.062483356)),
(select sum(구매금액) pur14Q3 from pur14Q3
where 고객번호 in (select 고객번호 from purbydiv
where 성장률 < 1.062483356)),
(select sum(구매금액) pur14Q4 from pur14Q4
where 고객번호 in (select 고객번호 from purbydiv
where 성장률 < 1.062483356)),
(select sum(구매금액) pur15Q1 from pur15Q1
where 고객번호 in (select 고객번호 from purbydiv
where 성장률 < 1.062483356)),
(select sum(구매금액) pur15Q2 from pur15Q2
where 고객번호 in (select 고객번호 from purbydiv
where 성장률 < 1.062483356)),
(select sum(구매금액) pur15Q3 from pur15Q3
where 고객번호 in (select 고객번호 from purbydiv
where 성장률 < 1.062483356)),
(select sum(구매금액) pur15Q4 from pur15Q4
where 고객번호 in(select 고객번호 from purbydiv
where 성장률 < 1.062483356))
from dual;

-- 방문빈도수를 구간별로 나눈 최대값
select 구간,max(빈도) from(
select ntile(100) over (order by 빈도 desc) as 구간, 고객번호, 빈도 from(
select 고객번호, count(*) 빈도 from(
select c.고객번호,구매일자,count(*) "빈도" from custdemo c
join purprod p on c.고객번호 = p.고객번호
group by c.고객번호,구매일자
order by c.고객번호)
group by 고객번호
order by 고객번호))
group by 구간
order by max(빈도);