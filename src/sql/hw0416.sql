create table book(
	bookid int not null auto_increment primary key,	-- 책 고유번호
	bookname varchar(30) not null,		-- 책 이름	
	publisher varchar(20) not null,		-- 출판사명
	price int not null					-- 책 가격
);

create table customer(
	idx int not null auto_increment primary key,	-- 고유번호
	custid int not null,			-- 고객 아이디
	name varchar(20) not null,		-- 고객 아이디
	adress varchar(30) not null,	-- 고객 주소
	phone varchar(15)				-- 고객 연락처
);

create table orders(
	orederid int not null auto_increment primary key,	-- 주문 고유번호 
	custid int not null,			-- 고객 아이디
	bookid int not null,		-- 책 고유번호
	saleprice int not null,		-- 책 가격
	orderdate datetime default now()	-- 책 주문날짜
);


insert into book values(1, '축구의 역사', '굿스포츠', 7000);
insert into book values(2, '축구아는 여자', '나무수', 13000);
insert into book values(3, '축구의 이해', '대한미디어', 22000);
insert into book values(4, '골프 바이블', '대한미디어', 35000);
insert into book values(5, '피겨 교본', '굿스포츠', 8000);
insert into book values(6, '역도 단계별기술', '굿스포츠', 6000);
insert into book values(7, '야구의 추억', '이상미디어', 20000);
insert into book values(8, '야구를 부탁해', '이상미디어', 13000);
insert into book values(9, '올림픽 이야기', '삼성당', 7500);
insert into book values(10, 'Olympic Champions', 'Pearson', 13000);
insert into book values(11, '가나다', '삼성당', 17500);
insert into book values(12, '포토샵CS6', '제우미디어', 25000);
insert into book values(13, '아시안게임 이야기', '스포츠북', 19500);
insert into book values(14, '우리들 이야기', '우리출판사', 5000);

insert into customer values (default, 1, '박지성', '영국 맨체스타', '000-5000-0001');
insert into customer values (default, 2, '김연아', '대한민국 서울', '000-6000-0001');  
insert into customer values (default, 3, '장미란', '대한민국 강원도', '000-7000-0001');
insert into customer values (default, 4, '추신수', '미국 클리블랜드', '000-8000-0001');
insert into customer values (default, 5, '박세리', '대한민국 대전',  NULL);
insert into customer values (default, 6, '이순신', '대한민국 아산',  NULL);

insert into orders values (1, 1, 1, 6000, '2020-07-01'); 
insert into orders values (2, 1, 3, 21000, '2020-02-03');
insert into orders values (3, 2, 5, 8000, '2020-05-03'); 
insert into orders values (4, 3, 6, 6000, '2020-06-04'); 
insert into orders values (5, 4, 7, 20000, '2020-11-05');
insert into orders values (6, 1, 2, 12000, '2020-09-07');
insert into orders values (7, 4, 8, 13000, '2020-03-07');
insert into orders values (8, 3, 10, 12000, '2020-07-08'); 
insert into orders values (9, 2, 10, 7000, '2020-05-09'); 
insert into orders values (10, 3, 8, 13000, '2020-06-10');

select * from book;
select * from customer;
select * from orders;

/* drop table book; */
/* drop table customer; */
/* drop table orders; */

-- 1. book테이블을 출판사이름으로 오름차순 정렬하되, 같은 출판사는 책이름순으로 내림차순 정렬하여 출력하시오.
select * from book order by publisher, bookname desc;

-- 2. book테이블에서 모든 책의 가격에 부가세 10%를 추가하시오.
update book set price = price*1.1;

-- 3. 도서테이블에서 중복된 출판사는 1번만 출력하시오.
select distinct publisher from book;


-- 4. 책의 가격이 1만원에서 2만원 사이값을 출력하시오. (and / between and 두가지 방법 다 출력)
select * from book where price>=10000 and price<=20000;
select * from book where price between 10000 and 20000;


-- 5.  '굿스포츠' 와 '대한미디어' 출판사의 목록을 보여주시오.(or / in() 2가지 방법 다 출력)
select * from book where publisher = '굿스포츠' or publisher = '대한미디어'; 
select * from book where publisher in('굿스포츠', '대한미디어'); 


-- 6. '축구'라는 문구가 들어있는 책 목록을 출력하시오.
select * from book where bookname like '%축구%';

-- 7. '의'라는 문구가 들어있는 책 목록을 출력하시오.
select * from book where bookname like '%의%';

-- 8. book 의 전체자료를 price 내림차순으로 5건만 확인해 보시오.
select * from book order by price desc limit 5;

-- 9. book 의 전체자료를 책이름 오름차순으로 두번째 자료부터 5건만 확인해 보시오.
select * from book order by bookname limit 2, 5;

-- 10. 책이름중에서 '축'이란 글자가 들어있는 모든자료중에서 '자'로 끝나는 책들을 출력하시오.
select * from book where bookname like '%축%자';

-- 11. 첫글자는 모든항목이 가능하지만 두번째 글자는 '구'으로 시작하는 책이름을 출력하시오.
select * from book where bookname like '_구%';

-- 12. 축구에 관한 도서중에서 가격이 1만원 이상인 도서를 검색하시오
-- (단, 가격 내림차순 출력하되 가격이 같으면 출판사 오름차순출력)
select * from book where bookname like '%축구%' and price >= 10000 order by price desc, publisher;
 
-- 13. 고객이 주문한 도서의 '총 도서가격'을 구하시오.
select sum(saleprice) as '총 도서가격' from orders;

-- 14. 고객이 주문한 도서의 '총가격/평균가격/최고가격/최저가격'을 구한다. 이때 필드명은 '총가격/평균가격/최고가격/최저가격'으로한다.
select sum(saleprice) as '총 가격', avg(saleprice) as '평균가격', max(saleprice) as '최고가격', min(saleprice) as '최저가격' from orders;

-- 15. 주문이 들어온 총 건수
select count(*) as '총 주문 건' from orders;


-- 16. 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오.
select custid as '고객 아이디', count(*) as '총 주문 수량', sum(saleprice)as '총 판매액' from orders group by custid;

-- 17. 가격이 8000원 이상인 도서를 구매한 고객에 대하여, 고객별 주문도서의 총 수량을 구하시오.
select custid as '고객 아이디', count(*) as '총 주문 수량' from orders where saleprice>=8000 group by custid;

-- 18. 가격이 8000원 이상인 도서를 구매한 고객에 대하여, 고객별 주문도서의 총 수량을 구하시오.
-- 단, 두권이상 구매한 고객만을 대상으로 처리하시오.
-- select custid as '고객 아이디', count(*) as '총 주문 수량' from orders where saleprice>=8000 group by custid having '총 주문 수량'>=2;
select custid as '고객 아이디', count(*) as cnt from orders where saleprice>=8000 group by custid having cnt>=2;
  

-- 19. 출판사명이 '굿스포츠'인곳에 대하여 처음부터 2개의 자료만 출력해 본다.
select * from book where publisher = '굿스포츠' limit 2;
-- 주문서 테이블(orders테이블)  : select * from orders;

-- 20. 고객별  평균 주문금액(saleprice)을 구하되 백원단위에서 반올림해서 출력하시오?(예:7500)
select custid as '고객 아이디', round(avg(saleprice), -2) as '평균 주문금액' from orders group by custid;

-- 21. 도서제목중에서 '야구'가 포함된 도서를 '농구'로 변경한후 도서목록을 출력하시오.
-- update book set bookname like '%농구%' where bookname like '%야구%';

-- LENGTH : 문자열의 길이를 구하는 함수
-- CHAR_LENGTH() : 문자수를 구하는 함수

-- 22. 굿스포츠에서 출판한 도서의 제목과 제목의 글자수를 출력하시오.
-- 참고 : length()는 1문자당 3byte, char_length()는 1문자당 1개씩 처리, 아래 문제를 2개 함수 모두 사용해서 각각 처리하시오.
select bookname as '책 제목', length(bookname) as '제목 글자 수(문자열 길이)' , char_length(bookname) as '제목 글자 수(문자 수)' from book;

-- 23. 고객이름중에서 같은 '성(姓)'을 가진 사람이 몇명인지 인원수를 구하시오.


-- 날짜 형식 변환함수 : date_format(날짜, 형식);
-- 24. 주문서 테이블에서 2020년 7월 8일에 주문받은 도서의 '주문번호','주문일','고객번호','도서번호'를 출력하시오.
-- // select orderid as '주문번호', orderdate as '주문일', custid as '고객번호', bookid as '도서번호' from orders where date_format(orderdate, '%Y-%m-%m')=2020-07-08;
select * from orders;
 


-- 25. 주문서 테이블에서 2020년 7월 8일에 주문받은 도서의 '주문번호','주문일','고객번호','도서번호'를 출력하시오
-- (출력형식: 년도2글자-영어표현달-숫자일 요일영어로)

 


-- 26. book테이블의 책가격중 가장 비싼 책과 가장 싼 책의 차이가 얼마인지 출력하시오?
select max(price) - min(price) as'최고가와 최저가의 차이' from book;

-- 27. 고객이 구매한 책에 대하여 '고객명/책 고유번호/주문날짜/고객주소'를 보여주시오(join)
select a.custid, a.bookid, a.orderdate, b.address from orders as a join customer as b on a.custid=b.custid;