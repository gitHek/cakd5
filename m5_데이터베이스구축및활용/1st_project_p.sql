drop table purbyyear;
drop table pur14r;
drop table pur15;
drop table purbygap;


CREATE TABLE purbyyear AS
SELECT 고객번호, YEAR, SUM(구매금액) 구매액
FROM purprod2
GROUP BY 고객번호, YEAR
ORDER BY 고객번호;

create table pur14 as
select 고객번호, year ,구매액
from purbyyear
where year = 2014
order by 고객번호;

create table pur15 as
select 고객번호, year ,구매액
from purbyyear
where year = 2015
order by 고객번호;

create table purbygap as
select pur14.고객번호,nvl(pur15.구매액,0)-nvl(pur14.구매액,0) 차이
from pur14
join pur15 on pur14.고객번호 = pur15.고객번호;

-- 성별에 따른 구매 감소고객 수 및 성별전체대비 비율
-- 여성 7083명, 남성 1602명
-- 여성 44.55% , 남성 45.97%

select a.성별,감소 감소고객수,round(감소/전체*100,2) 비율
from (select 성별, count(고객번호) 전체 from custdemo
group by 성별
order by 성별) a
join 
(select 성별,count(고객번호) 감소 from custdemo
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%')
group by 성별
order by 성별) b on a.성별 = b.성별;

-- 30대 이상 여성의 전체구매감소고객증감 대비 구매감소량 : 약 77.57% 전체 대비 비율 : 10.77%
select "30대이상여성감고고객",전체구매감소고객,round("30대이상여성감고고객"/전체구매감소고객,4)*100 비율 ,
(select sum(구매금액) from purprod2 where year = 2015) "2015전체매출",
round(abs("30대이상여성감고고객")/(select sum(구매금액) from purprod2 where year = 2015)*100,2) "매출대비비율"
from
(select
((select sum(구매금액) from purprod2 p
join custdemo c on p.고객번호 = c.고객번호
where p.고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2015 
and 성별 = 'F' and 연령대 not in ('19세이하','20세~24세','25세~29세'))
-
(select sum(구매금액) from purprod2 p
join custdemo c on p.고객번호 = c.고객번호
where p.고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2014 
and 성별 = 'F' and 연령대 not in ('19세이하','20세~24세','25세~29세'))) "30대이상여성감고고객"
,
((select sum(구매금액) from purprod2 
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2015)
-
(select sum(구매금액) from purprod2
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2014)) "전체구매감소고객"
from dual);

-- 30대 ~ 40대 여성의 전체구매감소고객증감 대비 구매감소량 : 약 46.24% , 전체 매출대비 비율 : 7.1%
select "30대~40대여성감고고객",전체구매감소고객,round("30대~40대여성감고고객"/전체구매감소고객,4)*100 비율,
(select sum(구매금액) from purprod where year = 2015) "2015전체매출",
round(abs("30대~40대여성감고고객")/(select sum(구매금액) from purprod where year = 2015)*100,2) "매출대비비율"
from
(select
((select sum(구매금액) from purprod p
join custdemo c on p.고객번호 = c.고객번호
where p.고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2015 
and 성별 = 'F' and 연령대 in ('30세~34세','35세~39세','40세~44세','45세~49세'))
-
(select sum(구매금액) from purprod p
join custdemo c on p.고객번호 = c.고객번호
where p.고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2014 
and 성별 = 'F' and 연령대 in ('30세~34세','35세~39세','40세~44세','45세~49세'))) "30대~40대여성감고고객"
,
((select sum(구매금액) from purprod 
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2015)
-
(select sum(구매금액) from purprod 
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2014)) "전체구매감소고객"
from dual);


-- 전체구매감소고객의 구매감소량의 전체 매출대비 비율 : 15.35%

select 전체구매감소고객,
(select sum(구매금액) from purprod where year = 2015) "2015전체매출",
round(abs("전체구매감소고객")/(select sum(구매금액) from purprod where year = 2015)*100,2) "매출대비비율"
from
(select
((select sum(구매금액) from purprod 
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2015)
-
(select sum(구매금액) from purprod 
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2014)) "전체구매감소고객"
from dual);