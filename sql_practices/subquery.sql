-- subquery

-- 
-- 1) select 절, insert 절의 values(...)의 서브쿼리
-- 

-- 
-- 2) from절의 서브쿼리
-- 
select now() as n, sysdate() as s, 3+ 1 as r from dual;

select a.n, a.s, a.r
  from (select now() as n, sysdate() as s, 3+ 1 as r from dual) as a;
  
--
-- 3) where 절 또는 having절의 서브쿼리
--

-- 예제) 현재 Fai Bale이 근무하는 부서에서 근무하는 직원의 사번, 전체이름을 출력해보세요.
-- 서브쿼리 안쓸때
SELECT b.dept_no
  from employees a, dept_emp b
where a.emp_no = b.emp_no
  and b.to_date = '9999-01-01'
  and concat(first_name, ' ', last_name) = 'Fai Bale';

SELECT a.emp_no, a.first_name
  from employees a, dept_emp b
where a.emp_no = b.emp_no
  and b.to_date = '9999-01-01'
  and b.dept_no = 'd004';
-- 이렇게 두개의 쿼리를 사용해버리면 데이터가 실시간으로 바뀌는 비즈니스(증권, 은행 등 )에서는
-- 두개의 쿼리를 수행하는 그 사이에 데이터가 변경되어 결과가 다르게 나올 수 있음

-- SUBQUERY를 사용 할 때
SELECT a.emp_no, a.first_name
  from employees a, dept_emp b
where a.emp_no = b.emp_no
  and b.to_date = '9999-01-01'
  and b.dept_no = (SELECT b.dept_no
					from employees a, dept_emp b
					where a.emp_no = b.emp_no
					and b.to_date = '9999-01-01'
					and concat(first_name, ' ', last_name) = 'Fai Bale');
  
-- 주의 해야할 점
-- WHERE절에서 단일행 연산자를 사용한다면 서브쿼리의 결과도 단일 행 이어야함
  
-- 3-1) 단일행 연산자: =, >, <, <=, >=, <>, !=
-- 실습 문제1:
-- 현재, 전체 사원의 평균연봉보다 적은 연봉을 받는 사원의 이름과 급여를 출력하세요.
SELECT avg(salary)
  FROM salaries
 WHERE to_date = '9999-01-01';
 
select a.first_name, b.salary
  from employees a, salaries b
 where a.emp_no = b.emp_no
   and b.to_date = '9999-01-01'
   and b.salary < (SELECT avg(salary)
					 FROM salaries
					WHERE to_date = '9999-01-01')
order by b.salary desc;

-- 실습문제2:
-- 현재, 가장 적은 평균 급여의 직책과 그 평균급여를 출력하세요.
-- 1) 직책별 평균급여
-- 2) 가장적은 직책별 평균급여 
-- 3) 직책+평균급여 내기

-- 직책별 평균급여
select avg(b.salary)
  from titles a, salaries b
 where a.emp_no = b.emp_no
   and a.to_date='9999-01-01'
group by a.title;
-- order by avg(b.salary) desc; 확인용

-- 가장적은 직책별 평균급여
select min(c.s)
  from  (select avg(b.salary) as s
		   from titles a, salaries b
		  where a.emp_no = b.emp_no
			and a.to_date='9999-01-01'
	   group by a.title) as c;
       
-- 
select b.salary, a.title
  from titles a, salaries b
 where avg(b.salary) = (select min(c.s)
						  from  (select avg(b.salary) as s
								 from titles a, salaries b
								where a.emp_no = b.emp_no
								  and a.to_date='9999-01-01'
							 group by a.title) as c)
group by a.title;



--
-- 실습문제 2 강사님 답
-- 직책별 평균급여
  select a.title, avg(b.salary) as avg_salary
    from titles a, salaries b
   where a.emp_no = b.emp_no
     and a.to_date='9999-01-01'
     and b.to_date='9999-01-01'
group by a.title;

-- 가장적은 직책별 평균급여
select min(avg_salary)
  from  (  select a.title, avg(b.salary) as avg_salary
			from titles a, salaries b
			where a.emp_no = b.emp_no
			and a.to_date='9999-01-01'
			and b.to_date='9999-01-01'
		group by a.title) as a;
        
-- sol1: subquery
  select a.title, avg(b.salary) as avg_salary
    from titles a, salaries b
   where a.emp_no = b.emp_no
     and a.to_date='9999-01-01'
     and b.to_date='9999-01-01'
group by a.title
  having avg_salary = (select min(avg_salary)
						from  (  select a.title, avg(b.salary) as avg_salary
									from titles a, salaries b
									where a.emp_no = b.emp_no
									and a.to_date='9999-01-01'
									and b.to_date='9999-01-01'
								group by a.title) as a);
                                
-- 4) sol2: top-k
  select a.title, avg(b.salary) as avg_salary
    from titles a, salaries b
   where a.emp_no = b.emp_no
     and a.to_date='9999-01-01'
     and b.to_date='9999-01-01'
group by a.title
order by avg_salary asc
   limit 0, 1;
   
-- 3-2) 복수행 연산자: in, not in, (=, <>, >, <, <=, >=)any, (=, <>, >, <, <=, >=)all

-- any 사용법
-- 1. =any: in -> 1개라도 같으면 참
-- 2. >any, >=any: 최솟값
-- 3. <any, <=any: 최댓값
-- 4. <>any, !=any: not in

-- all 사용법
-- 1. =all : X
-- 2. >all, >=all :최댓값
-- 3. <all, <=all :최솟값
-- 4. <>all, !=all: 다 같지않아야함

-- 실습문제 3
-- 현재, 급여가 50000 이상인 직원의 이름과 급여를 출력하세요.
-- 둘리 55000
-- 또치 60000

-- sol1: join
select a.first_name, b.salary
  from employees a, salaries b
 where a.emp_no = b.emp_no
   and b.to_date='9999-01-01'
   and b.salary >= 50000
order by b.salary asc;

-- sol2: subquery
select emp_no, salary
  from salaries
 where to_date='9999-01-01'
   and salary >= 50000;
   
-- in
select a.first_name, b.salary
  from employees a, salaries b
 where a.emp_no = b.emp_no
   and (a.emp_no, b.salary) in (select emp_no, salary
								from salaries
								where to_date='9999-01-01'
								and salary >= 50000)
order by b.salary asc;

-- =any
select a.first_name, b.salary
  from employees a, salaries b
 where a.emp_no = b.emp_no
   and (a.emp_no, b.salary) =any (select emp_no, salary
								from salaries
								where to_date='9999-01-01'
								and salary >= 50000)
order by b.salary asc;

-- 실습문제 4: 현재, 각 부서별로 최고 연봉을 받고 있는 직원의 이름(frist)과 부서이름, 연봉, 을 출력하세요.
-- SOL1: join
-- 부서별 최고연봉
select a.salary, c.dept_name
  from salaries a, dept_emp b, departments c
 where a.emp_no = b.emp_no
   and b.dept_no = c.dept_no
   and a.to_date = '9999-01-01'
   and b.to_date = '9999-01-01'
group by c.dept_name
having max(a.salary);
-- 부서별 최고연봉과 그 직원의 이름 
select a.first_name, b.A, b.B
  from employees a, (select a.salary as A, c.dept_name as B
						from salaries a, dept_emp b, departments c
						where a.emp_no = b.emp_no
						and b.dept_no = c.dept_no
						and a.to_date = '9999-01-01'
						and b.to_date = '9999-01-01'
						group by c.dept_name
						having max(a.salary)) b
where a.emp_no = b.emp_no;


-- 
-- 강사님 정답
--

select a.dept_no, max(b.salary)
  from dept_emp a, salaries b
where a.emp_no = b.emp_no
  and a.to_date='9999-01-01'
  and b.to_date='9999-01-01'
group by a.dept_no;

-- sol1: where절 subquery & in
select c.dept_name, a.first_name, d.salary
  from employees a, dept_emp b, departments c, salaries d
 where a.emp_no = b.emp_no
   and b.dept_no = c.dept_no
   and a.emp_no = d.emp_no
   and b.to_date='9999-01-01'
   and d.to_date='9999-01-01'
   and (b.dept_no, d.salary) in (select a.dept_no, max(b.salary)
									from dept_emp a, salaries b
									where a.emp_no = b.emp_no
									and a.to_date='9999-01-01'
									and b.to_date='9999-01-01'
									group by a.dept_no)
	order by d.salary desc;
    
-- sol2: join & 
select c.dept_name, a.first_name, d.salary
  from employees a, dept_emp b, departments c, salaries d,
		(select a.dept_no, max(b.salary) as max_salary
		from dept_emp a, salaries b
		where a.emp_no = b.emp_no
		and a.to_date='9999-01-01'
		and b.to_date='9999-01-01'
		group by a.dept_no)
 where a.emp_no = b.emp_no
   and b.dept_no = c.dept_no
   and a.emp_no = d.emp_no
   
   and b.to_date='9999-01-01'
   and d.to_date='9999-01-01'
   and d.salary = e.max_salary;
