-- 날짜 함수

-- curdate(), current_date: 시스템날짜 반환
SELECT curdate(), current_date from dual;

-- curtime(), current_time: 시스템시간 반환
SELECT curtime(), current_time from dual;

-- now(), sysdate(): 시스템 날짜 시간 같이 나오는거
select now(), sysdate() from dual;

-- sleep(x): x초 후에 출력
-- now() vs sysdate()
select now(), sleep(2), now() from dual; -- now(): 쿼리가 실행된 시간
select sysdate(), sleep(2), sysdate() from dual; -- sysdate(): 함수가 실행된 시간

-- date_format: 포멧을 원하는 문자열 포멧으로 반환 
select date_format(now(), '%Y년 %m월 %d일 %h시 %i분 %s초') from dual;

select date_format(now(), '%d %b \'%y') from dual;

-- period_diff
-- 포멧팅(YYMM, YYYYMM ...)
-- 예) 근무 개월
SELECT emp_no, 
	   hire_date,
       period_diff(date_format(curdate(), '%y%m'), date_format(hire_date, '%y%m')) as 'month'
from employees;

-- date_add(=adddate), date_sub(subdate): 날짜 더하기 빼기
-- 시간을 date 타입의 컬럼이나 값에 type(year, month, day)의 표현식으로 더하거나 뺼 수 있다.
-- 예) 각 사원의 근속 년수가 5년이 되는 날에 휴가를 보내준다면
-- 	   각 사원의 근속휴가 날짜는?
select first_name,
	   hire_date,
       date_add(hire_date, interval 5 year)
  from employees;
  
-- cast
select '12345' + 10 from dual; -- 앞의 문자열이 정수형으로 바뀜
select '12345' + 10, cast('12345' as int) + 10 from dual;
-- cast -> 문자열의 date 캐스팅
select date_format('2023-07-06', '%Y년 %m월 %d일') as '암시적캐스팅', 
       date_format(cast('2023-07-06' as date), '%Y년 %m월 %d일') as '명시적캐스팅'
from dual;
  
select cast(cast(1-2 as unsigned) as signed) from dual; -- unsigned: 굉장히 큰수
select cast(cast(1-2 as unsigned) as int) from dual;
select cast(cast(1-2 as unsigned) as integer) from dual;
-- unsigned 가 BIGINT까지는 포함하고 있음,
-- int = signed임

-- type
-- 문자: varchar, char, text(큰문서), CLOB(Character Large OBject, 더큰문서)
-- varchar vs char 차이점:
-- char -> 할당된 공간이 고정되어서 낭비하게됨, char(5)면 'asd'여도 빈공간 2자리가 남음, ex) 전화번호 
-- varchar -> 할당된 공간이 동적임, 그래서 연산과정이 들어가게됨, 속도가 char보단 느림, 대신 공간의 효율성

-- 정수: tiny int < medium int < int(signed < integer) < unsigned < big int  
-- 실수 : float, double
-- 시간 : date, datetime
-- LOB: CLOB, BLOB(Binary Large Object, 이미지나 음악 등 을 저장할 수 있는 타입)


