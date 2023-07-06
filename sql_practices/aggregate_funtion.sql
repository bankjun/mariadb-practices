--
-- 1) 집계(통계) 쿼리
-- select 절에 그룹(통계, 집계) 함수가 projection 된 쿼리
-- 그룹합수: avg, max, min, count, sum, stddev(분산), variance(표준편차)
select avg(salary), sum(salary)
from salaries;

-- 2) select 절에 그룹(통계집계)함수가 붙는 경우, 어떤 칼럼도 select절에 올 수 없다!!!!!(논리적으로)
-- 논리,문법 오류!!! ex)
select emp_no, sum(salary) from salaries;
-- 위에서 emp_no는 아무 의미가 없다.

-- 3) query 순서
-- 1. FROM: 접근테이블을 확인
-- 2. where: 조건에 맞는 row를 선택(임시테이블)
-- 3. 집계(임시테이블 -> 결과테이블)(projection)
-- 4. 출력

-- 예제: 사번이 10060인 사원이 받은 평균 연봉?
select avg(salary)
from salaries
where emp_no = '10060';

-- 4) GROUP BY에 참여하고 있는 칼럼은 select절에 올 수 있다.
-- 예제: 사원별 평균 연봉은?
SELECT emp_no, avg(salary)
from salaries
group by emp_no;

-- 5) having: 집계가 완료된 테이블에서의 조건
-- 집계결과(결과 테이블)에서 row를 선택해야 하는 경우
-- 이미 where절은 실행이 되었기 때문에 having절에서 조건을 주어야 한다.
-- 예제: 평균 월급이 60000 달러 이상인 직원의 사번과 평균 월급을 출력하세요.
select emp_no, avg(salary)
from salaries
group by emp_no
having avg(salary) > 60000; -- 여기서 또 연산되는 것이아니라 프로젝션에서 완성된 임시테이블의 칼럼의 이름임

-- 6) order by
--    order by는 항상 맨 마지막 출력전에 한다.
select emp_no, avg(salary)
from salaries
group by emp_no
having avg(salary) > 60000
order by avg(salary) asc;

-- 주의)
-- 예제) 사번이 10060인 직원의 급여평균, 급여총합
select emp_no, avg(salary), sum(salary)
from salaries
where emp_no ='10060';
-- 문법적인 오류
-- 의미적으로 맞다: where절의 조건 때문에

-- 옳은 문법
select emp_no, avg(salary), sum(salary)
from salaries
group by emp_no
having emp_no = '10060';
