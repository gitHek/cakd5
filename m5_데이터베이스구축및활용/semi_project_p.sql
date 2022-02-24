-- 경쟁사 이용률 상위 n명 뽑기

select * from (select 고객번호,count(*) from compet
group by 고객번호
order by count(*) desc)
where rownum <=3500;

-- 경쟁사 이용률 상위 1000명의 매출 감소

select round(avg(차이)) from purbygap
where 고객번호 in (select * from (select 고객번호 from compet
group by 고객번호
order by count(*) desc)
where rownum <=1000);

-- '079' 거주지역의 B제휴사의 매출이 엄청나게 감소 

select 제휴사,year, sum(구매금액) from purprod p
join custdemo d on p.고객번호 = d.고객번호
where 거주지역 = '079'
group by 제휴사,year
order by 제휴사,year;

-- 구매 감소고객들의 거주지역 카운트

select 거주지역, count(고객번호) from custdemo
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%')
group by 거주지역
order by count(고객번호) desc;

-- 구매 감소고객들의 거주지역별 감소액 합

select 거주지역, sum(차이) from custdemo c
join purbygap p on p.고객번호 = c.고객번호
where c.고객번호 in (select 고객번호 from purbygap where 차이 like '-%')
group by 거주지역
order by sum(차이);

-- 구매 감소액이 높은 지역

select 거주지역, sum(차이) from custdemo c
join purbygap p on p.고객번호 = c.고객번호
group by 거주지역
order by sum(차이);

-- 구매 감소고객의 제휴사별 년도별 구매금액

select 제휴사,year, sum(구매금액) from purprod p
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%')
group by 제휴사,year
order by 제휴사,year;

-- 성별에 따른 구매 감소고객 수
-- 여성 7034명, 남성 1583명

select 성별,count(고객번호) from custdemo
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%')
group by 성별
order by 성별;

-- 성별별 구매감소 고객 비율

select a.성별,round(감소/전체,3) 
from (select 성별, count(고객번호) 전체 from custdemo
group by 성별
order by 성별) a
join 
(select 성별,count(고객번호) 감소 from custdemo
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%')
group by 성별
order by 성별) b on a.성별 = b.성별;

-- 연령대별 구매 감소 고객 수

select 연령대,count(고객번호) from custdemo
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%')
group by 연령대
order by 연령대;


-- 연령대별 구매 감소 고객비율

select a.연령대, round(감소/전체,3) 
from (select 연령대, count(고객번호) 전체 from custdemo
group by 연령대
order by 연령대) a
join 
(select 연령대,count(고객번호) 감소 from custdemo
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%')
group by 연령대
order by 연령대) b on a.연령대 = b.연령대;

-- '079' 거주지역의 점포별 2014년 2015년 매출 

select 제휴사,year, sum(구매금액) from purprod p
join custdemo d on p.고객번호 = d.고객번호
where 거주지역 = '079'
group by 제휴사,year
order by 제휴사,year;

-- 각 거주지역별, 점포별, 년도별 매출액
select 점포코드,거주지역,year,sum(구매금액) from purprod p
join custdemo c on p.고객번호 = c.고객번호
group by 점포코드,거주지역,year
order by 점포코드,거주지역,year;

