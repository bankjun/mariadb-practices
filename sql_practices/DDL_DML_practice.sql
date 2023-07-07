-- DDL --

drop table member;

create table member(
	no int not null auto_increment,
    email varchar(200) not null,
    password varchar(64) not null,
    name varchar(100) not null,
    department varchar(100),
    primary key(no)
);

desc member;

------------
-- ALTER --
------------
alter table member add column juminbunho char(13) not null;
-- 칼럼 추가
desc member;

alter table member drop column juminbunho;
-- 칼럼 제거
desc member;

alter table member add column juminbunho char(13) not null after email;
-- 칼럼을 특정 위치에 추가 after
desc member;

alter table member change column department dept varchar(100);
-- department 칼럼을 dept varchar(100)로 변경 change
desc member;

alter table member add column self_intro text;

desc member;

alter table member drop column juminbunho;

desc member;

------------
-- INSERT --
------------
insert
  into member
values (null, 'zhqkfxm0127@naver.com', password('123'), '이준오', '개발팀', null);

-- 위치 명시
insert into member( email, password, name, dept)
			values( 'zhqkfxm0127@naver.com', password('1234'), '이준오2', '개발팀');
-- 위치 명시 -> 뒤죽박죽
insert into member( name, password, dept, email)
			values( '이준오3', password('1234'),  '개발팀','zhqkfxm0127@naver.com3');

------------
-- UPDATE --
------------
update member
set email = 'zhqkfxm0127@naver.com4', password = password('5678')
where no =2;

------------
-- DELETE --
------------
delete from member
where no=2;

------------
-- SELECT --
------------
select * from member;