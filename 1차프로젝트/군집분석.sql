-- 라벨별 통합분류,제휴사,소비재분류 감소
-- 0
select a.통합분류 , round(H4-H1) from
(select 통합분류 , sum(구매금액)*1.045 H1 from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 라벨 = 0 and 반기 = 'H1'
group by 통합분류) a
join (select 통합분류 , sum(구매금액)*0.983 H4 from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 라벨 = 0 and 반기 = 'H4'
group by 통합분류) b on a.통합분류 = b.통합분류
order by H4-H1;

select a.제휴사 , round(H4-H1) from
(select 제휴사 , sum(구매금액)*1.045 H1 from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 라벨 = 0 and 반기 = 'H1'
group by 제휴사) a
join (select 제휴사 , sum(구매금액)*0.983 H4 from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 라벨 = 0 and 반기 = 'H4'
group by 제휴사) b on a.제휴사 = b.제휴사
order by H4-H1;

select a.소비재분류 , round(H4-H1) from
(select 소비재분류 , sum(구매금액)*1.045 H1 from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 라벨 = 0 and 반기 = 'H1'
group by 소비재분류) a
join (select 소비재분류 , sum(구매금액)*0.983 H4 from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 라벨 = 0 and 반기 = 'H4'
group by 소비재분류) b on a.소비재분류 = b.소비재분류
order by H4-H1;

-- 1
select a.통합분류 , round(H4-H1) from
(select 통합분류 , sum(구매금액)*1.045 H1 from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 라벨 = 1 and 반기 = 'H1'
group by 통합분류) a
join (select 통합분류 , sum(구매금액)*0.983 H4 from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 라벨 = 1 and 반기 = 'H4'
group by 통합분류) b on a.통합분류 = b.통합분류
order by H4-H1;

select a.제휴사 , round(H4-H1) from
(select 제휴사 , sum(구매금액)*1.045 H1 from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 라벨 = 1 and 반기 = 'H1'
group by 제휴사) a
join (select 제휴사 , sum(구매금액)*0.983 H4 from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 라벨 = 1 and 반기 = 'H4'
group by 제휴사) b on a.제휴사 = b.제휴사
order by H4-H1;

select a.소비재분류 , round(H4-H1) from
(select 소비재분류 , sum(구매금액)*1.045 H1 from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 라벨 = 1 and 반기 = 'H1'
group by 소비재분류) a
join (select 소비재분류 , sum(구매금액)*0.983 H4 from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 라벨 = 1 and 반기 = 'H4'
group by 소비재분류) b on a.소비재분류 = b.소비재분류
order by H4-H1;

-- 2
select a.통합분류 , round(H4-H1) from
(select 통합분류 , sum(구매금액)*1.045 H1 from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 라벨 = 2 and 반기 = 'H1'
group by 통합분류) a
join (select 통합분류 , sum(구매금액)*0.983 H4 from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 라벨 = 2 and 반기 = 'H4'
group by 통합분류) b on a.통합분류 = b.통합분류
order by H4-H1;

select a.제휴사 , round(H4-H1) from
(select 제휴사 , sum(구매금액)*1.045 H1 from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 라벨 = 2 and 반기 = 'H1'
group by 제휴사) a
join (select 제휴사 , sum(구매금액)*0.983 H4 from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 라벨 = 2 and 반기 = 'H4'
group by 제휴사) b on a.제휴사 = b.제휴사
order by H4-H1;

select a.소비재분류 , round(H4-H1) from
(select 소비재분류 , sum(구매금액)*1.045 H1 from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 라벨 = 2 and 반기 = 'H1'
group by 소비재분류) a
join (select 소비재분류 , sum(구매금액)*0.983 H4 from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 라벨 = 2 and 반기 = 'H4'
group by 소비재분류) b on a.소비재분류 = b.소비재분류
order by H4-H1;

-- 제휴사별 이용횟수
select 제휴사, round(avg(횟수)) 횟수 from(
select 제휴사 ,b.고객번호, count(영수증번호)횟수 from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 라벨 = 0
group by 제휴사, b.고객번호)
group by 제휴사
order by 횟수;

select 제휴사, round(avg(횟수)) 횟수 from(
select 제휴사 ,b.고객번호, count(영수증번호)횟수 from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 라벨 = 1
group by 제휴사, b.고객번호)
group by 제휴사
order by 횟수;

select 제휴사, round(avg(횟수)) 횟수 from(
select 제휴사 ,b.고객번호, count(영수증번호)횟수 from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 라벨 = 2
group by 제휴사, b.고객번호)
group by 제휴사
order by 횟수;







select 고객번호 from purbydiv2
where 성장률 <0.8 
order by 고객번호;

select 고객번호 from gunzip
order by 고객번호;

select sum(구매금액) from purprod2 a
join purbydiv2 b on a.고객번호 = b.고객번호
where 성장률<0.8 and 반기 = 'H4';

select sum(구매금액) from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 반기 = 'H4';

select round(avg(구매횟수)) from (
select b.고객번호, sum(구매금액) 구매횟수 from purprod2 a
join gunzip b on a.고객번호 = b.고객번호
where 라벨 = 2
group by b.고객번호);