use works;

show tables;

create table gagyebu (
	idx int not null auto_increment primary key,	-- 고유 번호
	wDate datetime default now(),					-- 수입 / 지출이 일어난 날짜	(datetime와 now()는 형식이 맞아야함)
	gCode char(1) not null,							-- 수입(+) / 지출(-)
	price int not null,								-- 수입 / 지출 금액
	content varchar(100) not null,					-- 수입 / 지출 내역
	balance int default 0							-- 잔고
);

desc gagyebu;

/* drop table gagyebu; */
/* delete from gagyebu; */	-- 구조가 남아있기때문에 auto_increment번호는 삭제된 번호 이후로 들어간다.

insert into gagyebu values (default, '2020-04-19', '+', 5000, '2021년 4월 용돈', 5000);
insert into gagyebu values (default, default, '+', 10000, '2021년 4월 추가 용돈', 15000);

select * from gagyebu;