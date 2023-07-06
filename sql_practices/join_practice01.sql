--
-- inner join
-- 

-- equi join
-- 예제1) 현재, 근무하고 있는 직원의 이름과 직책을 출력하세요.
select a.emp_no, a.first_name, b.title -- 이때 emp_no는 A와 B 테이블 둘다 있기 때문에 테이블을 꼭 명시해줘야함
  from employees as a, titles as b
 where a.emp_no = b.emp_no 				-- join 조건(n-1)
   and b.to_date = '9999-01-01';		-- row 선택 조건
   
-- 예제2) 현재, 근무하고 있는 직원의 이름과 직책을 출력하되 여성 엔지니어만 출력하세요.
select a.emp_no, a.first_name, b.title, a.gender
  from employees as a, titles as b
 where a.emp_no = b.emp_no						-- join조건(n-1)
   and b.to_date = '9999-01-01' 				-- row선택조건1
   and a.gender ='f' and b.title = 'Engineer';  -- row선택조건 2, 3

--   
-- ANSI/ISO SQL1999 JOIN 표준 문법
-- 

-- 1) natural join: 같은 이름의 칼럼이 있으면 그 칼럼을 조건으로 암시적으로 쪼인함
-- 거의 안씀, 조인대상이 되는 두 테이블에 이름이 같은 공통 칼럼이 있으면 조인 조건을 명시하지않고 암묵적으로 쪼인
select a.first_name, b.title
  from employees as a natural JOIN titles as b
 where b.to_date = '9999-01-01';

-- 표준 JOIN ~ ON
-- select a.first_name, b.title
--   from employees as a JOIN titles as b ON a.emp_no = b.emp_no
--  where b.to_date = '9999-01-01';
 
 -- natural join의 문제점
 select count(*)
   from salaries as a natural join titles as b 
  where a.to_date = '9999-01-01'
    and b.to_date = '9999-01-01';
    
-- 2) JOIN ~ USING
select count(*)
   from salaries as a join titles as b using(emp_no)
  where a.to_date = '9999-01-01'
    and b.to_date = '9999-01-01';

-- 3) JOIN ~ ON => 표준
-- 예제) 현재, 직책별 평균 연봉을 큰 순서대로 출력하세요.
  select b.title, avg(a.salary)
    from salaries a 
    join titles b on a.emp_no = b.emp_no
   where a.to_date = '9999-01-01'
     and b.to_date = '9999-01-01'
group by b.title
order by avg(a.salary) desc;

-- 실습문제 1
-- 현재, 직원들의 근무 부서를 출력해보세요.
-- 사번, 직원이름(first_name), 부서명 순으로 출력하세요.
select a.emp_no, a.first_name, b.dept_name
  from employees a, departments b, dept_emp c
 where a.emp_no = c.emp_no
   and b.dept_no = c.dept_no
   and c.to_date = '9999-01-01';

-- 실습문제 2
-- 현재, 지급되고 있는 급여를 출력해보세요.
-- 사번, 이름 , 급여 순으로 출력
select b.title, avg(salary), count(*)
  from salaries a, titles b
 where a.emp_no = b.emp_no
   and a.to_date = '9999-01-01'
   and b.to_date = '9999-01-01'
group by b.title
having count(*) >= 100;

-- 실습문제 3
-- 현재, 직책별 평균연봉과 직원수를 구하되 직원수가 100명 이상인 직책만 출력하세요.
SELECT 
    a.dept_name, avg(d.salary)
FROM
    departments a,
    dept_emp b,
    titles c,
    salaries d
WHERE
    a.dept_no = b.dept_no
	AND b.emp_no = c.emp_no
	AND c.emp_no = d.emp_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
        AND d.to_date = '9999-01-01'
        AND c.title = 'Engineer'
group by a.dept_name
order by avg(d.salary) desc;