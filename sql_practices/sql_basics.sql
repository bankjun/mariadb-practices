select version(), current_date(), now() 
from dual;

-- 주석 : 수학함수, 사칙연산도 한다.
select sign(pi()/4), 1+2*3-4/5
from dual;

-- 대소문자 구분이 없다.
seLect VERSION(), CUrRENt_DATE
From dual;

-- table 생성: DDL
create table pet(
	name varchar(100),
    owner varchar(20),
    species varchar(20),
    gender char(1),
    birth date,
    death date
);

-- schema 확인alter
describe pet;
desc pet;

-- insert: DML(C)
insert
into pet
value('성탄이', '안대혁', 'dog', 'm', '2008-12-15', null);

-- select:DML(R)
select * from pet;

-- update: DML(U)
UPDATE pet 
SET 
    name = 'sungtanee'
WHERE
    name = '성탄이';
    
-- delete: DML(D)
delete
from pet
where name = 'sungtanee';
    
-- 데이터 통으로 올리기 load data
load data local infile 'c:\\pet.txt' into table pet; 

update pet 
	set death =null
    where  name != 'bowser';

-- select 연습
select name, species
  from pet
  where name ='bowser';
  
select name, species, birth
  from pet
  where birth >= '1998-01-01';
  
select name, species, gender  
from pet
where species = 'dog' and gender = 'f';

select name, species
from pet
where species='snake' or species='bird';

-- orderby: 정렬(내림차순(낮아짐) = desc, 오름차순(높아짐) = asc)
select name, birth
from pet
order by birth desc;

-- null을 연산할 때는 is (not) 을 사용해야함
select name, death, birth
from pet
where death is not null;

-- like @@ : @@를 포함한 데이터
-- @@%: @@로 시작, %@@: @@로 끝, %@%: @를 포함
select name
from pet
where name like '%w%';

-- _ _ _ _: 글자수 4개인 데이터
-- b_____: b로시작하고 그 뒤 글자가 4개인 데이터
select name
from pet
where name like '____';

-- 통계(집계)함수
-- *: 전체, 특정컬럼셀때는 null값을 빼고 셈
select count(death)
from pet;
-- 커밋테스트0706
