show databases;

desc jusorok;

insert into jusorok values ('이기자', 27, '1995-01-04', default, '제주', '학생');
insert into jusorok values ('김말숙', 54, '1968-03-31', '여자', '대구', '공무원');
insert into jusorok values ('김말자', 42, '1970-12-25', '여자', '부산', '회사원');
insert into jusorok values ('박자바', 35, '1987-09-03', '남자', '청주', '군인');
insert into jusorok values ('홍두식', 63, '1951-03-12', default, '강릉', '경찰');
insert into jusorok values ('도레미', 16, '2006-07-23', '여자', '서울', '학생');
insert into jusorok values ('안숙자', 29, '1993-04-10', '여자', '대전', '의사');
insert into jusorok values ('황재민', 31, '1991-06-04', '남자', '전주', '무직');
insert into jusorok values ('강그린', 20, '2002-02-02', '여자', '포항', '학생');

/* delete from jusorok; */


-- 주석
/* 주석 */

-- 남자만 보여주세요.
select * from jusorok where gender = '남자';

-- 30살이상만 보여주세요.
select * from jusorok where age>= 30;

-- 서울 지역거주자만 보여주세요.
select * from jusorok where area = '서울';

-- 남자이면서 30살 이상인 사람을 보여주세요.
select * from jusorok where gender = '남자' and age >= 30;

-- jusorok 테이블의 '이름/나이/주소' 필드에 '오늘도/29/서울'을 추가하세요.
insert into jusorok (name, age, address) values ('오늘도', 29, '서울');

-- 성별이 여자 중에서 content가 학생인 자료를 보여주세요.
select * from jusorok where gender = '여자' and content = '학생';

-- 필드명 'content'를 'job'을 변경하세요.
alter table jusorok change content job varchar(15);
-- alter table jusorok modify content varchar(15) after job;
 
-- jusorok 테이블에 'pay'필드를 추가하세요.
alter table jusorok add column pay int;

-- 자료의 수정 : update 테이블명 set 필드명 = 수정할 내용... where 조건절...;

-- 모든 자료의 기본 pay를 1000000만원으로 변경하세요.
update jusorok set pay = 1000000;

-- 여자자료에 대하여 pay를 200000만원 추가 지급하세요.
update jusorok set pay = pay + 200000 where gender = '여자';

-- 대구와 제주 거주자는 pay를 100000만원 추가 지급하세요.
update jusorok set pay = pay + 100000 where address = '대구' or address = '제주';

-- jusorok의 테이블 구조를 보여주세요.
desc jusorok;

-- jusorok 테이블의 이름을 'juso'로 변결하세요.
alter table jusorok rename juso;
alter table juso rename jusorok;

-- jusorok 테이블에 'mbc'필드를 추가하세요.(varchar(50), not null)
alter table jusorok add mbc varchar(50) not null;

-- jusorok 테이블의 'mbc'필드를 삭제하세요.
alter table jusorok drop column mbc;

-- 데이터베이스에 저장된 모든 테이블을 보여주세요.
show tables;

-- 서울지역 거주자를 보여주세요.
select * from jusorok where address = '서울';

-- 서울지역 거주자중에서 남자를 삭제하세요. 
delete from jusorok where address = '서울' and gender = '남자';

-- 모든 자료를 이름순으로 정렬하세요. (오름차순) (order by 키값 / 정렬)
select * from jusorok order by name;

-- 모든 자료를 나이 내림차순으로 정렬하세요.
select * from jusorok order by age desc;

-- jusorok의 테이블 구조를 보여주세요.
desc jusorok;

-- 홍두식의 나이를 33세로 수정하세요.
update jusorok set age = 33 where name = '홍두식';

-- 홍두식의 자료만 검색하세요.
select * from jusorok where name = '홍두식';

-- 모든 자료들의 나이를 1살씩 더해주세요.
update jusorok set age = age+1;

-- 성별을 내림차순으로 정렬하되, 같은 성별은 나이 오름차순으로 정렬하세요.
select * from jusorok order by gender desc;
-- 앞에 키를 먼저 정렬하고 뒤에 키를 정렬한다. 어센딩은 생략가능하다.
select * from jusorok order by gender desc, age;

-- 모든 자료를 나이 내림차순으로 정렬하세요.
select * from jusorok order by age desc;

-- 나이가 30 ~ 40살까지(포함)인 자료를 모두 보여주세요.(and 연산자)
select * from jusorok where age >= 30 and age <= 40;
-- between ~ and : 지정된 범위의 자료를 처리
select * from jusorok where age between 30 and 40;

-- 회사원과 학생의 자료를 보여주세요.
select * from jusorok where job = '회사원' or job = '학생';
-- in() : 포함연산자 (모두 포함하고 있어야한다.)
select * from jusorok where job in ('회사원', '학생');
select * from jusorok where job in ('사원', '학생');

-- like % : 포함 연산자 (복수의 와일드카드)
-- job 필드에 사원으로 끝나는 단어를 모두 보여주세요.
select * from jusorok where job like '%사원';
-- 김씨 성을 가진 모든 사람을 보여주세요.
select * from jusorok where name like '김%';
-- 이름중에 '말'이라는 글자가 있는 사람을 모두 보여주세요.
select * from jusorok where name like '%말%';
-- 이름중에 '자'이라는 글자가 있는 사람을 모두 보여주세요.
select * from jusorok where name like '%자%';

-- like _ : 포함연산자(단수의 와일드카드) '_' 한개가 한글자 ex) __ 두글자 자리수
-- 이름의 2번째 글자가 '자'인 사람들 보여주세요.
select * from jusorok where name like '_자%';

-- limit : 한계치를 적용 / limit 보여줄 개수 / limit 시작인덱스, 보여줄 개수
-- 주소록의 자료를 처읍부터 5건만 보여주세요.
select * from jusorok limit 5;
-- 주소록의 자료를 3번째 자료부터 5건만 보여주세요.
select * from jusorok limit 3, 5;


select * from jusorok;