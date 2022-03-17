-- 분기별 평균매출데이터 탐색(기존고객)
select
(select avg(구매금액) pur14Q1 from pur14Q1
where 고객번호 in (select * from custorigin)),
(select avg(구매금액) pur14Q2 from pur14Q2
where 고객번호 in (select * from custorigin)),
(select avg(구매금액) pur14Q3 from pur14Q3
where 고객번호 in (select * from custorigin)),
(select avg(구매금액) pur14Q4 from pur14Q4
where 고객번호 in (select * from custorigin)),
(select avg(구매금액) pur15Q1 from pur15Q1
where 고객번호 in (select * from custorigin)),
(select avg(구매금액) pur15Q2 from pur15Q2
where 고객번호 in (select * from custorigin)),
(select avg(구매금액) pur15Q3 from pur15Q3
where 고객번호 in (select * from custorigin)),
(select avg(구매금액) pur15Q4 from pur15Q4
where 고객번호 in (select * from custorigin))
from dual;

-- 분기별 평균매출데이터 탐색(감소고객)
select
(select avg(구매금액) pur14Q1 from pur14Q1
where 고객번호 in (select 고객번호 from purbydiv
where 성장률 < 1.062483356)),
(select avg(구매금액) pur14Q2 from pur14Q2
where 고객번호 in (select 고객번호 from purbydiv
where 성장률 < 1.062483356)),
(select avg(구매금액) pur14Q3 from pur14Q3
where 고객번호 in (select 고객번호 from purbydiv
where 성장률 < 1.062483356)),
(select avg(구매금액) pur14Q4 from pur14Q4
where 고객번호 in (select 고객번호 from purbydiv
where 성장률 < 1.062483356)),
(select avg(구매금액) pur15Q1 from pur15Q1
where 고객번호 in (select 고객번호 from purbydiv
where 성장률 < 1.062483356)),
(select avg(구매금액) pur15Q2 from pur15Q2
where 고객번호 in (select 고객번호 from purbydiv
where 성장률 < 1.062483356)),
(select avg(구매금액) pur15Q3 from pur15Q3
where 고객번호 in (select 고객번호 from purbydiv
where 성장률 < 1.062483356)),
(select avg(구매금액) pur15Q4 from pur15Q4
where 고객번호 in(select 고객번호 from purbydiv
where 성장률 < 1.062483356))
from dual;

-- 기존고객 분기별 평균 방문빈도수 

select 분기, round(avg (빈도),2) from(
select 분기,기존고객, count(*) 빈도 from(
select 기존고객,구매일자,분기,count(*) "방문" from custorigin c
join purprod2 p on c.기존고객 = p.고객번호
group by 기존고객,구매일자,분기)
group by 분기,기존고객)
group by 분기
order by 분기;

-- 감소 고객 분기별 평균 방문빈도수 

select 분기, round(avg (빈도),2) from(
select 분기,고객번호, count(*) 빈도 from(
select p.고객번호,구매일자,분기,count(*) "방문" from purbydiv c
join purprod2 p on c.고객번호 = p.고객번호
where 성장률 < 1.062483356
group by p.고객번호,구매일자,분기)
group by 분기,고객번호)
group by 분기
order by 분기;

-- 제휴사별 분기별 기존고객의 평균매출

select 제휴사, 분기, avg(구매금액) from purprod2 p
join custorigin c on c.고객번호=p.고객번호
group by 제휴사, 분기
order by 제휴사, 분기;

-- 제휴사별 분기별 감소고객의 평균매출

select 제휴사, 분기, avg(구매금액) from purprod2 p
join purbydiv c on c.고객번호=p.고객번호
where 성장률 < 1.062483356
group by 제휴사, 분기
order by 제휴사, 분기;