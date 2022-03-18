-- 분기별 라벨 붙이기
create table purprod3 as
(SELECT 제휴사,영수증번호,소분류코드,소분류명,통합분류,소비재분류,고객번호,점포코드,구매일자,구매시간,구매금액,year,월,
CASE WHEN 구매일자 > 20150931 then 'Q8'
WHEN 구매일자 > 20150631 then 'Q7'
WHEN 구매일자 > 20150331 then 'Q6'
WHEN 구매일자 > 20141231 then 'Q5'
WHEN 구매일자 > 20140931 then 'Q4'
WHEN 구매일자 > 20140631 then 'Q3'
WHEN 구매일자 > 20140331 then 'Q2' 
ELSE 'Q1' END AS 분기
FROM purprod2);

-- 분기별 평균매출데이터 탐색(기존고객)
select 분기, avg(구매금액) 평균매출 from purprod2 a
join custorigin b on a.고객번호 = b.고객번호
group by 분기
order by 분기;

-- 분기별 평균매출데이터 탐색(감소고객)

select 분기, avg(구매금액) 평균매출 from purprod2 a
join purbydiv b on a.고객번호 = b.고객번호
where 성장률 < 1.062483356
group by 분기
order by 분기;

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