use works;

show tables;

/* 중복되는 테이터가 있을 시 히니민 키운트하는 함수 : distinct */
-- 남자 / 여자 군(중복을 배제)의 자료 1건씩 출력
select distinct gender as 성별 from jusorok;
-- 각 직업군에 대한 자료출력
select distinct job as 직업 from jusorok;

-- 개수를 구하는 함수 : count(); / 조건을 줄 수도 있고 전체에서 사용할 수도 있다.
select count(*) from jusorok;
-- 주소록에 사용된 직업의 개수
select count(distinct job) as '사용된 직업개수' from jusorok;
-- 성별이 남자인 자료의 개수
select count(name) from jusorok where gender = '남자';
-- 서울에 사는 여자는 몇명인지 출력
select count(gender = '여자') from jusorok where address = '서울';
select count(*) from jusorok where address = '서울' and gender = '여자';

-- 합계를 구하는 함수 : sum()
-- 전체 pay의 합계 출력
select sum(pay) as 급여 from jusorok;
-- 서울에 사는 여자의 총 급여 합계 출력
select sum(pay) from jusorok where address = '서울' and gender = '여자';

-- 평균을 구하는 함수 : avg()
-- 전체 pay의 평균출력
select avg(pay) from jusorok;
-- 남자의 급여 평균 출력
select avg(pay) from jusorok where gender = '남자';

-- 최대값을 구하는 함수 : max()
-- 최대 급여액 출력
select max(pay) from jusorok;

-- 최소값을 구하는 함수 : min()
-- 최소 급여액 출력
select min(pay) from jusorok;

-- 그룹(군)을 지어서 표시하고자 할 때? group by 절 ~ having 조건
-- where 은 작업을 하기전에 먼저 걸러서
-- having 은 작업 후 그룹을 지을 때		//같은 조건이지만 처리 순서가 다르다.
select gender from jusorok group by gender;
-- 성별에 따른 급여액의 평균
select gender, avg(pay) from jusorok group by gender;
-- 각 성별에 따른 인원수와 급여의 합계 출력
select gender, count(*), sum(pay) from jusorok group by gender;
-- 필드를 찍어주기위해, 카운트, 합계					-- 성별에 따른
-- 각 성별에 따른 인원수와 급여의 합계를 출력 (단, 나이가 30세 이상인 자료만 출력)
select gender, count(*), sum(pay) from jusorok where age>=30 group by gender;
-- 각 직업군 출력(group by 절 사용)
select job from jusorok group by job;
-- 각 직업군의 개수를 출력
select job, count(*) from jusorok group by job;
-- 각 직업군의 개수를 출력 (단, 직업운의 개수가 2개 이상인 경우만 출력)
select job, count(*) as cnt from jusorok group by job having cnt>=2;
-- 각 직업군의 남자의 개수를 출력
select job, count(*) from jusorok where gender = '남자' group by job;
-- 각 직업군의 남자의 개수를 출력 (단, 직업군의 개수가 2개 이상인 경우만 출력)
select job, count(*) as cnt from jusorok where gender = '남자' group by job having cnt>=2;

-- 반올림 : round() / round(소수이하 자리수)
select round(123.456);
select round(123.456, 1);
select round(123.456, -1);
-- 주소록의 평균 나이 출력
select avg(age) from jusorok;
-- 주소록의 평균 나이 출력 (정수부 반올림 처리)
select round(avg(age)) from jusorok;

-- 절삭함수 : truncate(표현자리수)
select truncate(125.678, 0);
select truncate(125.678, 1);
select truncate(125.678, -1);
-- 주소록의 평균나이 (정수로 출력 : 소수 이하 절삭)
select truncate(avg(age), 0) from jusorok;

-- 무조건 올림 : ceil() / 무조건 내림 : floor()
select ceil(123.456);
select ceil(-123.456);
select floor(123.956);
select floor(-123.956);
-- 나이의 평균을 구하되 소수이하 내림하여 출력
select floor(avg(age)) from jusorok;
-- 성별에 따른 나이의 평균을 구하되 소수이하 내림하여 출력
select gender, floor(avg(age)) from jusorok group by gender;

-- 절대값(양수값 표현) : abs()
select abs(1234);
select abs(-1234);
select (123-456);
select abs(123-456);

-- 나머지 함수 : mod(정수1, 정수2)
select mod(10, 3);
-- 10을 3으로 나누었을 때의 몫과 나머지를 출력
select floor(10/3) as '몫', mod(10, 3) as '나머지';

-- 지수(승수)함수 : power(n1, n2) / 밑수 n1, 지수 n2
select power(2,5) as '2^5';

/* 문자함수 */
-- 영문자의 대/소문자 변환 : upper() / lower()
select upper('seOul');
select lower('seOul');
select upper('Welcome to Korea');
select lower('Welcome to Korea');

-- 문자열의 길이 : lenght / 한글은 3byte
-- 문자수를 구하는 함수 : CHAR_LENGTH()
select length('seoul');
select job, length(job) from jusorok;
-- 문자열의 길이 출력
select length('seoul서울');
select length('welcome to 한국korea');

-- 결합연산자 : concat(문자열1, 문자열2, ...)
select concat('a', 'b', 'c');
select name, age from jusorok;
select concat(name), concat(age) from jusorok;
select concat('이름 : ', name), concat('나이 : ', age) from jusorok;

-- 지정된 문자열을 반환 : substr(문자열, 시작위치(1), 빌췌할 개수) 
-- sql은 대소문자 구분 안함 시작위치 1 / 자바 대소문자 구분함 시작위치 1
select substr('welcome to korea', 4, 4);		-- come 출력
select substr('welcome to korea', 9, 2);		-- to 출력
select substr('welcome to korea', 12);			-- korea 출력
select substr('welcome to 한국korea', 12, 2);		-- 한국 출력
-- jusorok 테이블 직업의 2번째 글자만 출력
select name, substr(job, 2, 1) from jusorok;
-- 생일을 'xxxx년 xx월xx일'로 이름과 함께 출려
select name, concat(substr(birthday, 1, 4), '년', substr(birthday, 6, 2), '일', substr(birthday, 9, 2), '일') as 'b-day' from jusorok;

-- 중간 위치값을 출력 : mid(문자열, 시작위치, 추출의 크기)
select mid('Welcome to Korea', 4, 4);
select mid('Welcome to Korea', 4);

-- 문자열 중에서 특정 문자의 존재유무 : instr()
select instr('Welcome To Korea', 'o');
select instr('Welcome To Korea', 'O');
select instr('Welcome To Korea', ' ');	-- 공백의 위치도 알려줌
select instr('Welcome To Korea', '  ');	-- 존재하지 않으면 0으로 알려줌

-- 왼쪽, 오른쪽, 중간 문자열 추출 : left(), right(), mid()
select left('Welcome To Korea', 3);
select right('Welcome To Korea', 3);
select mid('Welcome To Korea', 4, 4);

-- 문자열 치환 : replace(str, char1, char2) / 문자열(str) 중에서 특정문자(char1)를 지정문자(char2)로 치환
select('Welcome to Korea');
select replace('Welcome to Korea', ' ', '');
SELECT REPLACE('WELCOME TO KOREA', ' ', '_');

/* 날짜 함수 */
-- 시스템의 오늘 날짜/시간 출력
select now();

-- 년도를 출력 : year()
select year(now());
-- 월을 출력 : month() / 자바는 +1을 해야하지만 sql은 안해도됨
select month(now());
-- 일을 출력 : day()
select day(now());

select concat(year(now()), '년 ', month(now()), '월 ', day(now()), '일' );

-- 요일 dayname() / week()
select dayname(now());	-- 현재 요일을 영어로 출력
select week(now());		-- 현재가 올해의 몇 번째 주인지 출력(0부터 시작) 

select monthname(now());	-- 현재 달을 영어로 출력

/* 시간 함수 */
-- 시간 : hour() / 분 : minute() / 초 : second()
select hour(now());
select minute(now());
select second(now());
select concat(hour(now()),'시 ',minute(now()), '분 ', second(now()), '초');

-- 지정된 형식으로 날짜 출력 : date_format() / 날짜기호 앞에 '%'붙여서 서식지정
select date_format(now(), '%y-%m-%d;');		-- %y : 년도 2자리 / %m %d : 월과 일이 두자리
select date_format(now(), '%Y-%m-%d');		-- %Y : 년도 4자리
select date_format(now(), '%Y-%M-%d');		-- %M : 월을 영어로
select date_format(now(), '%y-%m-%d %W');	-- %W : 요일을 영어로
select date_format(now(), '%y-%m-%d %w');	-- %w : 요일을 숫자로 (일요일 : 0)
select name, birthday from jusorok;
select date_format(birthday, '%Y-%m-%d %W') from jusorok;
select date_format(birthday, '%Y-%m-%d %w') from jusorok;

select date_format(now(), '%h : %i : %s');	-- 12시간제 (01~12)
select date_format(now(), '%H : %i : %s');	-- 24시간제
select date_format(now(), '%l : %i : %s');	-- 시간이 한자리로 출력 (1~12)
select date_format(now(), '%r');			-- 12시간제 am/pm 출력
select date_format(now(), '%Y-%c-%e'); 		-- 월과 일을 0을 포함하지 않고 출력
select date_format(birthday, '%Y-%c-%e') from jusorok;

-- 현재 날짜 : now() / sysdate() / current_timestamp()
select now();
select sysdate();
select current_timestamp();

-- 날짜 연산 : date_add(기준날짜, 계산수치값) / interval 명령어와 함꼐 사용
select now();								-- 오늘 날짜
select date_add(now(), interval 1 day);		-- 오늘 +1
select date_add(now(), interval -1 day);	-- 오늘 -1
select date_add(now(), interval 1 hour);	-- 현재 시간 +1
select date_add(now(), interval -1 hour);	-- 현재 시간 -1
select date_add(now(), interval 24 hour);	-- 현재 시간 +24
select date_add(birthday, interval 1 day) from jusorok;
select date_add(birthday, interval 24 day) from jusorok;

-- 달의 마지막 일자 : last_day()
select last_day(now());
select last_day('2021-2-1');
select last_day('2020-2-1');

-- 날짜 차이 계산 : to_days()
select to_days(now()) - to_days('2021-4-1');	-- (오늘 날짜) - (2021-4-1)
-- 오늘부터 5일이 지났음을 표시
select to_days(now()) - to_days(date_add(now(), interval -5 day));

-- 날짜 차이 비교 계산 : datediff()
select datediff(now(), '2021-4-1');		-- (오늘 날짜) - (2021-4-1)