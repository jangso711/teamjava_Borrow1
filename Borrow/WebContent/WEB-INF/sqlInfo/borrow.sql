--------------------------------
-----------drop table----------
--------------------------------
drop table review;
drop table rent_details;
drop table picture;
drop table item_category;
drop table category;
drop table item_add;
drop table item;
drop table member;
--------------------------------
--------drop sequence-----------
--------------------------------

drop sequence item_no_seq;
drop sequence rent_no_seq;
drop sequence cat_no_seq;
drop sequence review_no_seq;

--------------------------------
-------delete vue--------------
--------------------------------
delete from member;
delete from item;
delete from item_add;
delete from category;
delete from item_category;
delete from picture;
delete from rent_details;
delete from review;

--------------------------------
--------create table--------------
--------------------------------
-- 1.member --
-- type : 0=관리자,1=회원
create table member(
   id varchar2(100) primary key,
   pwd varchar2(100) not null,
   name varchar2(100) not null,
   address varchar2(100) not null,
   tel varchar2(100) not null,
   point number default 0,
   type number default 1
);

-- 2.item --
--1이 활성화 2가 비활성화 0이 삭제

create table item(
   item_no number primary key,
   id varchar2(100) not null,
   item_name varchar2(100) not null,
   item_brand varchar2(100),
   item_model varchar2(100),
   item_price number not null,
   item_regdate date not null,
   item_expdate date not null,
   item_status number default 1,   
   item_expl clob not null,
   constraint fk_item_id foreign key(id) references member ON DELETE CASCADE
);

--3.item_add---
create table item_add(
   item_no number primary key,
   rent_count number default 0,
   grade number default 0,   
   constraint fk_item_add_item_no foreign key(item_no) references item ON DELETE CASCADE
);
-- 4.category --
create table category(
   cat_no number primary key,
   cat_name varchar2(100) not null
)


-- 5. item_category
create table item_category(
   item_no number not null,
   cat_no number not null,
   
   constraint fk_item_category_item_no foreign key(item_no) references item ON DELETE CASCADE,
   constraint fk_item_category_cat_no foreign key(cat_no) references category ON DELETE CASCADE,
   constraint pk_item_category primary key(item_no,cat_no) 
);

-- 6. picture --
create table picture(
   item_no number not null,
   picture_path varchar2(200) not null,
   
   constraint fk_picture_item_no foreign key(item_no) references item ON DELETE CASCADE,
   constraint pk_picture primary key(item_no,picture_path) 
);

-- 7.rent_details--
create table rent_details(
   rent_no number primary key,
   item_no number not null,
   id varchar2(100) not null,
   rent_date date not null,
   return_date date not null, 
   tot_payment number not null,  
   review_status number default 0,
   constraint fk_rent_details_id foreign key(id) references member ON DELETE CASCADE,
   constraint fk_rent_details_item_no foreign key(item_no) references item ON DELETE CASCADE
);

alter table rental_details add review_status number default 0;

-- 8. review --
create table review(
	review_no number primary key,
	review_title varchar2(100) not null,
	review_content clob not null,
	review_grade number default 0,
	review_hit number default 0,
	review_regdate date not null,
	item_no number default 0,
	id varchar2(100) not null,
	rental_no number default 0,
	
    constraint fk_review_id foreign key(id) references member ON DELETE CASCADE,
    constraint fk_review_item_no foreign key(item_no) references item ON DELETE CASCADE,
    constraint fk_review_rental_no foreign key(rental_no) references rental_details ON DELETE CASCADE
);

update item set item_status=0,item_expdate=to_date('2018-09-08','YYYY-MM-DD') where item_no=10018;
select sysdate, to_char(max(return_date), 'yyyy-MM-DD') from rental_details where item_no=10018;

update rental_details set return_date=sysdate where rental_no=200005;

select r.review_no,r.review_title,to_char(r.review_regdate,'yyyy-MM-DD'), r.review_content,r.review_hit,m.id,m.name from review r, member m where r.id=m.id and r.review_no=8002;
=======
---------------------------------------
------------create sequence------------
---------------------------------------
--상품번호 : 10001~10999
--거래번호 : 200001~209999
--분류번호 : 3001~3020  
--리뷰번호 : 4000001~
create sequence item_no_seq start with 10001 nocache;
create sequence rental_no_seq start with 200001 nocache;
create sequence cat_no_seq start with 3001 nocache;
create sequence review_no_seq start with 4000001 nocache;

---------------------------------------
------------insert values------------
---------------------------------------

-- 1.member --
insert into member(id,pwd,name,address,tel,point,type) values('miri', '1234', '미리', '판교','031',10000,1);
insert into member(id,pwd,name,address,tel,point,type) values('qqq', '1234', '동규', '수원','032',10000,1);
insert into member(id,pwd,name,address,tel,point,type) values('yosep', '1234', '요셉', '강남','033',10000,1);
insert into member(id,pwd,name,address,tel,point,type) values('lsy', '1234', '성열', '강남','034',10000,1);
insert into member(id,pwd,name,address,tel,point,type) values('jangso711', '1234', '소정', '강남','035',10000,1);
insert into member(id,pwd,name,address,tel,point,type) values('jb', '1234', '정빈', '강남','036',10000,1);
--관리자 아이디
insert into member(id,pwd,name,address,tel,point,type) values('admin', 'admin', '관리자', '-','-',0,0);

-- 2.item --
insert into item(item_no, id, item_name, item_brand, item_model, item_price, item_regdate, item_expdate, item_status, item_expl) 
values(item_no_seq.nextval, 'miri', '카시트', 'TEAMTEX', '페라리 코스모 SP', 25000, '2018/7/1', add_months('2018/7/1',3), 1,'어린아이 있는 집에 꼭 필요한 카시트입니다.');

insert into item(item_no, id, item_name, item_brand, item_model, item_price, item_regdate, item_expdate, item_status, item_expl) 
values(item_no_seq.nextval, 'yosep', '유모차', '드림아일랜드', '컴퍼트', 23000, sysdate, add_months(sysdate,3), 1,'럭셔리 끝판왕 유모차입니다');

insert into item(item_no, id, item_name, item_brand, item_model, item_price, item_regdate, item_expdate, item_status, item_expl) 
values(item_no_seq.nextval, 'miri', '모빌', '세도나', 'KOSTA', 11000, sysdate, add_months(sysdate,3), 1,'잠이 솔솔 모빌');

insert into item(item_no, id, item_name, item_brand, item_model, item_price, item_regdate, item_expdate, item_status,item_expl) 
values(item_no_seq.nextval, 'qqq', '뽀로로 유모차', '뽀로로친구들', '뽀롱뽀롱', 35000, sysdate, add_months(sysdate,3), 1,'아이들이 좋아하는 뽀로로 유모차입니다');

insert into item(item_no, id, item_name, item_brand, item_model, item_price, item_regdate, item_expdate, item_status,item_expl) 
values(item_no_seq.nextval, 'jangso711', '최고급 낚시대', '-', '-', 5000, '2018/9/1', add_months('2018/9/1',2), 1,'구매한지 1달 된 거의 새 제품입니다.');

insert into item(item_no, id, item_name, item_brand, item_model, item_price, item_regdate, item_expdate, item_status,item_expl) 
values(item_no_seq.nextval, 'qqq', 'G GG DD 텐트', '-', '-', 15000, '2018/5/1', add_months('2018/5/1',2), 1,'2017년 히트상품으로 판매하던 인기 짱짱 텐트입니다. 캠핑장 최고의 텐트로 다른 캠핑족들의 부러움을 사는 멋쟁이 텐트입니다. 개인적인 사정으로 캠핑을 주자 가지 못하게되어 대여합니다.');

-- 3.item_add --
insert into item_add(item_no,rental_count,grade) values(10001,3,4.5);
insert into item_add(item_no) values(10002);
insert into item_add(item_no) values(10003);
insert into item_add(item_no) values(10004);
insert into item_add(item_no) values(10005);
insert into item_add(item_no) values(10006);
-- 4.category --
insert into category(cat_no, cat_name) values(cat_no_seq.nextval, '등산');
insert into category(cat_no, cat_name) values(cat_no_seq.nextval, '물놀이');
insert into category(cat_no, cat_name) values(cat_no_seq.nextval, '캠핑');
insert into category(cat_no, cat_name) values(cat_no_seq.nextval, '낚시');
insert into category(cat_no, cat_name) values(cat_no_seq.nextval, '여행');
insert into category(cat_no, cat_name) values(cat_no_seq.nextval, '겨울스포츠');
insert into category(cat_no, cat_name) values(cat_no_seq.nextval, '야외스포츠');
insert into category(cat_no, cat_name) values(cat_no_seq.nextval, '유아/아동');
insert into category(cat_no, cat_name) values(cat_no_seq.nextval, '기타');

-- 5.item_category --
insert into ITEM_CATEGORY(item_no, cat_no) values(10001,3008);  
insert into ITEM_CATEGORY(item_no, cat_no) values(10002,3008);  
insert into ITEM_CATEGORY(item_no, cat_no) values(10003,3008);  
insert into ITEM_CATEGORY(item_no, cat_no) values(10004,3008); 
insert into ITEM_CATEGORY(item_no, cat_no) values(10004,3009); 
insert into ITEM_CATEGORY(item_no, cat_no) values(10005,3004); 
insert into ITEM_CATEGORY(item_no, cat_no) values(10005,3007); 
insert into ITEM_CATEGORY(item_no, cat_no) values(10006,3003); 
insert into ITEM_CATEGORY(item_no, cat_no) values(10006,3004); 
insert into ITEM_CATEGORY(item_no, cat_no) values(10006,3005); 
insert into ITEM_CATEGORY(item_no, cat_no) values(10006,3007); 
-- 6. picture --

insert into picture(item_no,picture_path) values(10001,'carseat.jpg');
insert into picture(item_no,picture_path) values(10001,'carseat2.jpg');
insert into picture(item_no,picture_path) values(10002,'stroller.jpg');
insert into picture(item_no,picture_path) values(10003,'mobile.jpg');
insert into picture(item_no,picture_path) values(10004,'pororo.jpg');
insert into picture(item_no,picture_path) values(10005,'fishingrod.jpg');
insert into picture(item_no,picture_path) values(10005,'rod.jpg');
insert into picture(item_no,picture_path) values(10006,'tent.jpg');

-- 7.rental_details--
insert into rental_details(rental_no, item_no, id, rental_date, return_date,total_payment)
values (rental_no_seq.nextval, 10001, 'lsy', '2018/7/11' , '2018/7/15',100000);
insert into rental_details(rental_no, item_no, id, rental_date, return_date,total_payment)
values (rental_no_seq.nextval, 10001, 'yosep', '2018/9/1' , '2018/9/15',350000);
insert into rental_details(rental_no, item_no, id, rental_date, return_date,total_payment)
values (rental_no_seq.nextval, 10001, 'jangso711', '2018/10/1' , '2018/10/12',275000);
insert into rental_details(rental_no, item_no, id, rental_date, return_date,total_payment)
values (rental_no_seq.nextval, 10005, 'miri', '2018/9/20' , '2018/9/22',10000);
insert into rental_details(rental_no, item_no, id, rental_date, return_date,total_payment)
values (rental_no_seq.nextval, 10006, 'jb', '2018/5/2' , '2018/5/4',30000);
insert into rental_details(rental_no, item_no, id, rental_date, return_date,total_payment)
values (rental_no_seq.nextval, 10005, 'yosep', '2018/9/5' , '2018/9/7',10000);

-- 8. review --
insert into review(review_no,review_title,review_content,review_grade,review_hit,review_regdate,item_no,id,rental_no) values(review_no_seq.nextval,'카시트 좋아요','조카가 잠깐와서 빌렸어요. 감사합니다.',5,0,'2018/07/18',10001,'lsy',200001);
insert into review(review_no,review_title,review_content,review_grade,review_hit,review_regdate,item_no,id,rental_no) values(review_no_seq.nextval,'텐트 최고에요','대가족이 모두 들어가서 잘 수 있는 정도의 크기에요! 다음에 또 대여하겠습니다. 감사합니다.',4,0,'2018/09/02',10001,'qqq',200002);
insert into review(review_no,review_title,review_content,review_grade,review_hit,review_regdate,item_no,id,rental_no) values(review_no_seq.nextval,'카시트 ','조카가 잠깐와서 빌렸어요. 감사합니다.',5,0,'2018/07/18',10001,'qqq',200001);
insert into review(review_no,review_title,review_content,review_grade,review_hit,review_regdate,item_no,id,rental_no) values(review_no_seq.nextval,'텐트','대가족이 모두 들어가서 잘 수 있는 정도의 크기에요! 다음에 또 대여하겠습니다. 감사합니다.',4,0,'2018/09/02',10001,'qqq',200003);

---------------------------------------
------------select values------------
---------------------------------------
select * from member;
select * from item;
select * from item_add;
select * from category;
select * from item_category;
select * from picture;
select * from rental_details;
select * from review;


--9. test --
select b.post_no, b.hits, b.title, b.regdate, m.name
from(select row_number() over(order by post_no desc) as rnum, post_no, title, to_char(regdate, 'YYYY.MM.DD') as regdate, hits, id
from post) b, boardmember m 
where rnum between 1 and 5 and b.id=m.id;	

select rental_no, item_no, item_name, id, rental_date, return_date
from( select row_number() over(order by r.rental_no asc) as rnum, r.rental_no, i.item_no, i.item_name, i.id,  to_char(r.rental_date,'yyyy-MM-DD') as rental_date, to_char(r.return_date,'yyyy-MM-DD') as return_date
from rental_details r, item i where r.item_no=i.item_no and r.id='miri')  where rnum between 2 and 5;

select count(*)
from rental_details r, item i 
where r.item_no=i.item_no and r.id='miri'

select row_number() over(order by item_no desc) as rnum, item_no, item_name, item_expl, item_price, id 
from item 
where item_status=1
order by item_no desc

select r.rnum, r.item_no, r.item_name, r.item_expl, r.item_price, r.id
	from (
	select row_number() over(order by item_no desc) as rnum, item_no, item_name, item_expl, item_price, id 
from item) r, member m
where r.rnum between 2 and 4 and r.id=m.id
order by item_no desc

SELECT r.review_no,r.review_title,to_char(review_regdate,'YYYY.MM.DD') 
						,r.review_hit,m.id,m.name,i.item_no,i.item_name,r.review_grade
						FROM(select row_number() over(ORDER BY review_no DESC)
						as rnum,review_no,review_title,to_char(review_regdate,'YYYY.MM.DD')
						,review_hit FROM review where id='qqq') rn, review r, member m, item i 
						WHERE r.id=m.id and r.item_no=i.item_no and rn.review_no=r.review_no AND
						rnum BETWEEN 1 AND 5 ORDER BY review_no DESC
from item) r
where r.rnum between 2 and 4
order by item_no desc

select i.id, i.item_no, i.item_name, i.item_expl, i.item_price, c.cat_name
from item i, item_category ic, category c
where i.item_status=1 and i.item_no=ic.item_no and ic.cat_no=c.cat_no and ic.cat_no=3008

select r.id, r.item_no, r.item_name, r.item_expl, r.item_price, r.cat_name
from (
	select row_number() over(order by i.item_no desc) as rnum, i.id, i.item_no, i.item_name, i.item_expl, i.item_price, c.cat_name
	from item i, item_category ic, category c
	where i.item_status=1 and i.item_no=ic.item_no and ic.cat_no=c.cat_no and ic.cat_no=3008
) r
where rnum between 2 and 4
order by item_no desc

select id, item_no, item_name, item_expl, item_price
from item
where item_status=1 and item_name like'%테%'
order by item_no desc

select r.rnum, r.id, r.item_no, r.item_name, r.item_expl, r.item_price
from(
	select row_number() over(order by item_no desc) as rnum, id, item_no, item_name, item_expl, item_price
	from item
	where item_status=1 and item_name like '%테%'
) r
where r.rnum between 2 and 4
order by item_no desc

select row_number() over(order by i.item_no desc) as rnum, i.item_no, i.item_name, i.item_expl, i.item_price, i.id, a.grade 
from item i , item_add a where i.item_no=a.item_no;

update item set item_status=0,item_expdate=to_char(sysdate,'YYYY-MM-DD') where item_no=10022;

