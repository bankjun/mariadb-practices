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
-- 예) 근무 개월

SELECT emp_no, hire_date from employees;