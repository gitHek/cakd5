-- 분기,반기별 라벨 붙이기
create table purprod3 as
(SELECT 제휴사,영수증번호,소분류코드,소분류명,통합분류,소비재분류,고객번호,점포코드,구매일자,구매시간,구매금액,year,월,
CASE WHEN 구매일자 > 20150931 then 'Q8'
WHEN 구매일자 > 20150631 then 'Q7'
WHEN 구매일자 > 20150331 then 'Q6'
WHEN 구매일자 > 20141231 then 'Q5'
WHEN 구매일자 > 20140931 then 'Q4'
WHEN 구매일자 > 20140631 then 'Q3'
WHEN 구매일자 > 20140331 then 'Q2' 
ELSE 'Q1' END AS 분기,
CASE WHEN 구매일자 > 20150631 then 'H4'
WHEN 구매일자 > 20141231 then 'H3'
WHEN 구매일자 > 20140631 then 'H2' 
ELSE 'H1' END AS 반기
FROM purprod2);

-- 분기별 기존고객 총 매출
select 분기 , sum(구매금액) 총매출 from purprod2 a
join custorigin b on a.고객번호= b.고객번호
group by 분기
order by 분기;

-- 분기별 관리대상고객 총 매출
select 분기 , sum(구매금액) 총매출 from purprod2 a
join purbydiv b on a.고객번호= b.고객번호
where 성장률 < 0.8
group by 분기
order by 분기;

-- 분기별 고객당 평균매출데이터 탐색(기존고객)
select 분기, avg(평균매출) 평균매출 from (
select 분기,고객번호,avg(구매금액) 평균매출 from purprod2
group by 분기, 고객번호)a
join custorigin b on a.고객번호 = b.고객번호
group by 분기
order by 분기;

-- 분기별 고객당 평균매출데이터 탐색(관리대상고객)
select 분기, avg(평균매출) 평균매출 from (
select 분기,고객번호,avg(구매금액) 평균매출 from purprod2
group by 분기, 고객번호)a
join purbydiv b on a.고객번호 = b.고객번호
where 성장률 < 0.8
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

--관리대상고객 분기별 평균 방문빈도수 

select 분기, round(avg (빈도),2) from(
select 분기,고객번호, count(*) 빈도 from(
select p.고객번호,구매일자,분기,count(*) "방문" from purbydiv c
join purprod2 p on c.고객번호 = p.고객번호
where 성장률 < 0.8
group by p.고객번호,구매일자,분기)
group by 분기,고객번호)
group by 분기
order by 분기;



-- 제휴사별 분기별 기존고객의 평균매출

select 제휴사, 분기, avg(구매금액) from purprod2 p
join custorigin c on c.고객번호=p.고객번호
group by 제휴사, 분기
order by 제휴사, 분기;

-- 제휴사별 분기별 관리대상고객의 평균매출

select 제휴사, 분기, avg(구매금액) from purprod2 p
join purbydiv c on c.고객번호=p.고객번호
where 성장률 < 0.8
group by 제휴사, 분기
order by 제휴사, 분기;

-- 관리대상고객의 14년도 1반기 매출 : 56401500984 원

select sum(구매금액) from purprod2 a
join purbydiv b on a.고객번호 = b.고객번호
where 성장률 < 0.8 and (분기 = 'Q1' or 분기 = 'Q2');

-- 관리대상고객의 15년도 1반기 매출 : 30458845532 원

select sum(구매금액) from purprod2 a
join purbydiv b on a.고객번호 = b.고객번호
where 성장률 < 0.8 and (분기 = 'Q5' or 분기 = 'Q6');

-- 전체 고객의 15년 1반기 매출 : 165231857377 원
select sum(구매금액) from purprod2 a
where  분기 = 'Q5' or 분기 = 'Q6';


-- 기존고객 수 : 19147
select count(*) from custorigin;

-- 관리대상고객 수 : 4551
select count(*) from custorigin a
join purbydiv b on a.고객번호=b.고객번호
where 성장률 < 0.8;

-- 통합분류별 분기별 고객당 평균매출데이터 탐색(기존고객)
select 통합분류,분기, avg(평균매출) 평균매출 from (
select 통합분류,분기,고객번호,avg(구매금액) 평균매출 from purprod2
group by 통합분류,분기, 고객번호)a
join custorigin b on a.고객번호 = b.고객번호
group by 통합분류,분기
order by 통합분류,분기;

-- 통합분류별 분기별 평균매출데이터 탐색(감소고객)
select 통합분류,분기, avg(평균매출) 평균매출 from (
select 통합분류,분기,고객번호,avg(구매금액) 평균매출 from purprod2
group by 통합분류,분기, 고객번호)a
join purbydiv b on a.고객번호 = b.고객번호
where 성장률 < 0.8
group by 통합분류,분기
order by 통합분류,분기;

create table purprod3 as
(SELECT a.제휴사,영수증번호,a.소분류코드,b.소분류명,b.통합분류,b.소비재분류,고객번호,점포코드,구매일자,구매시간,구매금액,year,월
FROM purprod2 a
join prodcl2 b on a.소분류코드 = b.소분류코드);

-- 성별에 따른 관리대상고객고객 수 및 성별별 기준고객 대비 비율
-- 여성 7034명, 남성 1583명
-- 여성 44.2% , 남성 45.4%

select a.성별,감소 감소고객수,전체,round(감소/전체,3) 비율
from (select 성별, count(a.고객번호) 전체 from custdemo a
join custorigin b on a.고객번호 = b.고객번호
group by 성별
order by 성별) a
join 
(select 성별,count(a.고객번호) 감소 from custdemo a
join purbydiv b on a.고객번호= b.고객번호
where 성장률 <0.8
group by 성별
order by 성별) b on a.성별 = b.성별;

-- 연령대에 따른 관리대상고객고객 수 및 성별별 기준고객 대비 비율

select a.연령대,감소 감소고객수,전체,round(감소/전체,3) 비율
from (select 연령대, count(a.고객번호) 전체 from custdemo a
join custorigin b on a.고객번호 = b.고객번호
group by 연령대
order by 연령대) a
join 
(select 연령대,count(a.고객번호) 감소 from custdemo a
join purbydiv b on a.고객번호= b.고객번호
where 성장률 <0.8
group by 연령대
order by 연령대) b on a.연령대 = b.연령대;

-- 거주지역에 따른 관리대상고객 수
select a.거주지역,감소 감소고객수,전체,round(감소/전체,3) 비율
from (select 거주지역, count(a.고객번호) 전체 from custdemo a
join custorigin b on a.고객번호 = b.고객번호
group by 거주지역
order by 거주지역) a
join 
(select 거주지역,count(a.고객번호) 감소 from custdemo a
join purbydiv b on a.고객번호= b.고객번호
where 성장률 <0.8
group by 거주지역
order by 거주지역) b on a.거주지역 = b.거주지역;

-- 경쟁사이용횟수에 분기, 반기라벨 붙이기
create table compet2 as
(SELECT 고객번호,제휴사,경쟁사,이용년월,
CASE WHEN 이용년월 > 201509 then 'Q8'
WHEN 이용년월 > 201506 then 'Q7'
WHEN 이용년월 > 201503 then 'Q6'
WHEN 이용년월 > 201412 then 'Q5'
WHEN 이용년월 > 201409 then 'Q4'
WHEN 이용년월 > 201406 then 'Q3'
WHEN 이용년월 > 201403 then 'Q2' 
ELSE 'Q1' END AS 분기,
CASE WHEN 이용년월 > 201506 then 'H4'
WHEN 이용년월 > 201412 then 'H3'
WHEN 이용년월 > 201406 then 'H2' 
ELSE 'H1' END AS 반기
FROM compet);

-- 기존고객들의 분기별 경쟁사 이용률 : 2015년의 데이터만 있기에 활용이 힘들듯.

select 분기, count(*) from compet2 group by 분기;
select 분기, count(*) from compet2 a
join custorigin b on a.고객번호 = b.고객번호 
group by 분기;

-- 기존고객들의 평균 채널이용횟수 : 5.61회
select round(avg(nvl("이용횟수",0)),2) 평균이용횟수 from channel a
join custorigin b on a.고객번호(+) = b.고객번호
order by 이용횟수 ;

-- 관리대상고객들의 평균 채널 이용횟수 : 4.8회
select round(avg(nvl("이용횟수",0)),2) 평균이용횟수 from channel a
join purbydiv b on a.고객번호(+) = b.고객번호
where 성장률 <0.8
order by 이용횟수 ;

-- 채널을 이용하지 않은 사람중에 관리대상고객의 비율?

