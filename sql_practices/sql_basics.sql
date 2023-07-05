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
  
