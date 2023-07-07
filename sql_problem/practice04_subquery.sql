-- 서브쿼리(SUBQUERY) SQL 문제입니다.

-- 문제1. 평균연봉 -> where in
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
-- 1)평균연봉
select avg(salary)
  from salaries;
 -- 2) 평균연봉보다 많은 연봉받는 직원 수
select count(a.emp_no)
  from employees a, salaries b
 where a.emp_no = b.emp_no
   and b.to_date = '9999-01-01'
   and b.salary > (select avg(salary)
					from salaries);
-- *참고 240124 현재 총직원수
--  select count(a.emp_no)
--   from employees a, salaries b
--  where a.emp_no = b.emp_no
--    and b.to_date = '9999-01-01';

  
-- 문제2. 했었음
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서, 연봉을 조회하세요. 
-- 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 
-- 1) 부서별 최고 급여(연봉, 부서번호)
select max(a.salary), b.dept_no
  from salaries a, dept_emp b
 where a.emp_no = b.emp_no
   and a.to_date = '9999-01-01'
   and b.to_date = '9999-01-01'
group by dept_no;
-- 2) where & in
select a.emp_no, a.first_name, d.dept_name, b.salary
  from employees a, salaries b, dept_emp c, departments d
 where a.emp_no = b.emp_no
   and a.emp_no = c.emp_no
   and c.dept_no = d.dept_no
   and b.to_date = '9999-01-01'
   and c.to_date = '9999-01-01'
   and (b.salary, c.dept_no) in (select max(a.salary) as max_salary, b.dept_no
									from salaries a, dept_emp b
									where a.emp_no = b.emp_no
									and a.to_date = '9999-01-01'
									and b.to_date = '9999-01-01'
									group by dept_no)
order by b.salary desc;

-- 문제3. join추천
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 
-- 부서평균 급여 구하고 그 급여보다 큰사원들 구하기
-- 1) 부서평균 연봉
select avg(a.salary) as avg_salary, b.dept_no
  from salaries a, dept_emp b
 where a.emp_no = b.emp_no
   and a.to_date = '9999-01-01'
   and b.to_date = '9999-01-01'
group by b.dept_no;
-- 2) 
select a.emp_no, a.first_name, b.salary
  from employees a,
	   salaries b, 
       dept_emp c, 
       departments d, 
	   (select avg(a.salary) as avg_salary, b.dept_no
		  from salaries a, dept_emp b
		 where a.emp_no = b.emp_no
		   and a.to_date = '9999-01-01'
		   and b.to_date = '9999-01-01'
	  group by b.dept_no) e
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and c.dept_no = d.dept_no
  and d.dept_no = e.dept_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and b.salary > any(e.avg_salary);

-- 문제4. 같은 테이블은 두번 올릴 수도 있음
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.

-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.

-- 문제6.
-- 평균 연봉이 가장 높은 부서는? 
-- 부서이름,평균연봉

-- 문제7.
-- 평균 연봉이 가장 높은 직책?
-- 직책이름,평균연봉

-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.

