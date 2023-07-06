-- 수학 함수

-- abs: 절댓값
select abs(1), abs(-1) from dual;

-- ceil(ceiling): 올림한 정수
select ceil(3.14), ceiling(3.14) from dual;

-- floor: 내림한 정수
select floor(3.14), ceiling(3.14) from dual;

-- mod: 나머지 함수
select mod(10, 3), 10 % 3 from dual;

-- round(x): x에 가장 근접한 정수
-- round(x,D): x의 소수점 d자리에 가장 근접한 정수
select round(1.498), round(1.498, 1),round(1.498, 0) from dual;

-- power(x,y) = pow(x,y): x의 y제곱
select power(2,10), pow(2, 10) from dual;

-- sign: 음수 = -1, 0이면 0, 양수 = 1
select sign(20), sign(-100), sign(0) from dual;

-- greates(x,y, ... ), least(x,y, ... )
select greatest(10,40,20,50), least(10,40,20,50) from dual;
select greatest('A','D','C','b'), least('hello','hella','helli') from dual;