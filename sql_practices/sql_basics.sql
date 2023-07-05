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

-- insert: DML(c)
insert
into pet
value('성탄이', '안대혁', 'dog', 'm', '2008-12-15', null);

-- select:DML(R)
select * from pet;

-- update: DML(U)
update pet
set name='sungtanee'
where name='성탄이';
    
    
    