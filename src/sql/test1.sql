show tables;

-- 회원 정보 테이블
create table test1(
	idx int not null auto_increment primary key,	-- primary key : 고유번호, 중복은 안되지만 한 테이블에 여러개를 지정할 수 있음 / auto_increment는 가장 큰 수 +1증가하며 지정된다.
	mid varchar(20) not null,	-- 아이디					절대 중복 되지 않으며 한 번 지정된 번호는 삭제되어도 다시 생성되지 않는다. 또한 primary key를 안주면 생성이 안된다. 
	pwd varchar(20) not null,	-- 비밀번호
	name varchar(20) not null,	-- 성명
	age int default 20			-- 나이
);

insert into test1 values (default, 'hkd1234', '1234', '홍길동', default);
insert into test1 values (default, 'kms1234', '1234', '김말숙', 25);
insert into test1 values (default, 'lkj1234', '1234', '이기자', default);
insert into test1 values (default, 'snm1234', '1234', '소나무', 35);

/* drop table test1; */

select * from test1;

-- DVD 대여 테이블
create table test2(
	idx int not null auto_increment primary key,
	dvdname varchar(50) not null,
	mid varchar(20) not null,
	part varchar(10) not null default '액션',
	dvdIpgo datetime default now(),
	dvdSu int default 1
);

insert into test2 values (default, '전쟁과 평화', 'hkd1234', default, default, default);
insert into test2 values (default, '아침의 제국', 'hkd1234', '스릴러', '2021-4-5', default);
insert into test2 values (default, '프로그램과의 전쟁', 'kms1234', '교양', default, default);
insert into test2 values (default, '오늘이가면', 'lkj1234', '교양', '2021-4-10', default);
insert into test2 values (default, '세상밖으로', 'kms1234', default, '2021-4-10', default);
insert into test2 values (default, '자바의세상', 'java1234', default, '2021-4-14', default);

/* drop table test2; */
/* delete from test2; */	-- 데이터만 삭제
select * from test2;
 
-- 내부 조인 : inner join : 공통사항을 참조한다. / 기준이 되는 것이 앞 join 비교가 되는 것이 뒤
select a.mid, a.name, b.dvdname, b.part from test1 as a join test2 as b on a.mid=b.mid;

-- 외부조인 (outer join) : left join : 왼쪽 테이블을 중심으로 출력 (왼쪽테이블이 다 나와야 함)
select a.mid, a.name, b.dvdname, b.part from test1 as a left join test2 as b on a.mid=b.mid;

-- 외부조인(outer join) : right join : 오른쪽 테이블을 중심으로 출력 (오른쪽테이블이 다 나와야함)
select a.mid, a.name, b.dvdname, b.part from test1 as a right join test2 as b on a.mid=b.mid;