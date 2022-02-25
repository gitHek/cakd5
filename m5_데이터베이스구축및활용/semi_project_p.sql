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
-- 여성 44.2% , 남성 45.4%

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

-- 점포별 연도별 감소고객의 증감액
create table jumpo_year_2014 as
select 점포코드,YEAR,SUM(구매금액) 구매액 from PURBYGAP G
join custdemo c on G.고객번호 = c.고객번호
join purprod p on P.고객번호 = c.고객번호
where c.고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2014
group by 점포코드,YEAR
order by 점포코드,YEAR;

create table jumpo_year_2015 as
select 점포코드,YEAR,SUM(구매금액) 구매액 from PURBYGAP G
join custdemo c on G.고객번호 = c.고객번호
join purprod p on P.고객번호 = c.고객번호
where c.고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2015
group by 점포코드,YEAR
order by 점포코드,YEAR;

select j4.점포코드, j5.구매액-j4.구매액 점포별차이 from jumpo_year_2014 j4
join jumpo_year_2015 j5 on j4.점포코드 = j5.점포코드
order by 점포별차이;

-- 통합분류별 구매감소고객의 연도별 총 매출과 증감액

create table gapbytong14 as 
select 통합분류, sum(구매금액) 총구매금액 from purprod p
join prodcl_new c on c.소분류코드 = p.소분류코드
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2014
group by 통합분류
order by 총구매금액 desc;

select * from gapbytong14

create table gapbytong15 as 
select 통합분류, sum(구매금액) 총구매금액 from purprod p
join prodcl_new c on c.소분류코드 = p.소분류코드
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2015
group by 통합분류
order by 총구매금액 desc;

select * from gapbytong15;

select g4.통합분류, g5."총구매금액"-g4."총구매금액" 증감 from gapbytong14 g4
join gapbytong15 g5 on g4.통합분류 = g5.통합분류
order by 증감;

-- 통합분류별 성별별 2014년대비 2015년도 구매감소고객매출 증감액

select 통합분류, sum(구매금액) 총구매금액 from purprod p
join prodcl_new c on c.소분류코드 = p.소분류코드
join custdemo d on d.고객번호 = p.고객번호
where p.고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2015 and 성별 = 'F'
group by 통합분류
order by 총구매금액 desc;

select g4.통합분류,nvl(g5."총구매금액",0)-nvl(g4."총구매금액",0) 증감 from
(select 통합분류, sum(구매금액) 총구매금액 from purprod p
join prodcl_new c on c.소분류코드 = p.소분류코드
join custdemo d on d.고객번호 = p.고객번호
where p.고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2014 and 성별 = 'M'
group by 통합분류
order by 총구매금액 desc) g4
join (select 통합분류, sum(구매금액) 총구매금액 from purprod p
join prodcl_new c on c.소분류코드 = p.소분류코드
join custdemo d on d.고객번호 = p.고객번호
where p.고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2015 and 성별 = 'M'
group by 통합분류
order by 총구매금액 desc) g5 on g4.통합분류 = g5.통합분류
order by 증감;

-- 인원 자체가 차이가 나서인지 여성의 구매감소가 압도적으로 많음
-- 여성의 주요 구매 품목인 패션,명품,쥬얼리에 관련된 것들에서 구매 감소가 심함
-- 이를 좀더 파고들 방법이 있을까??

-- 구매 감소 고객에서 변화하는 항목을 찾아볼까?

-- 구매감소고객의 평균 경쟁사 이용횟수 : 1.53회
select round(avg(nvl(횟수,0)),2) from(
select c.고객번호,횟수 from custdemo c
join (select 고객번호 , count(고객번호) 횟수 from compet
group by 고객번호
order by 고객번호) d on c.고객번호 = d.고객번호(+))
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%');

-- 전체 고객들의 평균 경쟁사 이용횟수 : 1.45회
select round(avg(nvl(횟수,0)),2) from(
select c.고객번호,횟수 from custdemo c
join (select 고객번호 , count(고객번호) 횟수 from compet
group by 고객번호
order by 고객번호) d on c.고객번호 = d.고객번호(+));
