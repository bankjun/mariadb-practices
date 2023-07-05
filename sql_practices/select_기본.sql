-- 현재: to_date = '9999-01-01'

--
-- select 기본
--
-- 예제1 : departments 테이블의 모든 데이터 출력.
select * 
  from departments; 
  
  -- projection(프로젝션): 칼럼지정
  -- 예제 2 :departments 데이블에서 부서의 이름, 부서 번호를 출력
select dept_name, dept_no
from departments;

-- as(alias, 생략가능): 칼럼이름 변경, 별명
-- 에제3 : employees 테이블에서 직원의 이름, 성별, 입사일을 출력
select first_name as '이름', last_name as '성', hire_date as '입사일'
  from employees;
 -- limit 0, 1000;

-- concat() : 문자열 합치는 함수
select concat(first_name, ' ', last_name ) as '이름', hire_date as '입사일'
  from employees;
  
-- distinct : 중복 없애기?
-- 예제 4-1: titles 테이블에서 모든 직급의 이름을 출력
select title from titles;

-- 예제 4-2: title 테이블에서 직급은 어떤 것들이 있는 지 직급이르믈 한번씩만 출력
select distinct(title) from titles;

--
-- where 절: 조건
--

-- 예제1 :비교연산자: employees 테이블에서 1991년 이전에 입사한 직원의 이름, 성별, 입사일을 출력
select first_name as '이름',
	   gender as '성별',
       hire_date as '입사일'
  from employees
  where hire_date < '1991-01-01';

-- 예제2 :논리연산자:employees 테이블에서 1989년 이전에 입사한 여직원의 이름, 입사일을 출력
select first_name as '이름',
	   gender as '성별',
       hire_date as '입사일'
from employees
where hire_date < '1991-01-01' 
  and gender = 'f';
  
-- 예제3 :in연산자: dept_emp 테이블에서 부서 번호가 d005나 d009에 속한 사원의 사번, 부서번호 출력
select emp_no as '사번',
	   dept_no as '부서번호'
from dept_emp
where dept_no = 'd005' or dept_no ='d009';

-- 예제3 다른방법 -> in연산자를 사용하는 방법
select emp_no as '사번',
	   dept_no as '부서번호'
from dept_emp
where dept_no in('d005', 'd009');

-- 예제4 :like검색: employees 테이블에서 1989년에 입사한 직원의 이름, 입사일을 출력  
-- 방법 1)
select first_name,
	   hire_date
from employees
where '1989-01-01' <= hire_date and hire_date <= '1989-12-31';
-- 방법2)
select first_name,
	   hire_date
from employees
where hire_date between'1989-01-01'and '1989-12-31';

-- 방법3) like
select first_name,
	   hire_date
from employees
where hire_date like '1989%';
--
-- order by
--
-- 예제 1: employees 테이블에서 last_name이 acton인 사원의 이름, 성별, 입사일 출력
select first_name, gender, hier_date
from employees
order by hire_date asc;

-- 예제2: salaries 테이블에서 2001년 월급을 가장 높은 순으로 사번
select emp_no, salary
from salaries
where from_date like '2001%'
order by salary desc, emp_no asc; -- 월급으로 정렬후 사원번호로 또 정렬
