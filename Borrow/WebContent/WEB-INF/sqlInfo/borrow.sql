--------------------------------
-----------drop table----------
--------------------------------
drop table review;
drop table rental_details;
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
drop sequence rental_no_seq;
drop sequence cat_no_seq;
drop sequence review_no_seq;

--------------------------------
-------delete value--------------
--------------------------------
delete from member;
delete from item;
delete from item_add;
delete from category;
delete from item_category;
delete from picture;
delete from rental_details;
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

insert into item(item_no, id, item_name, item_brand, item_model, item_price, item_regdate, item_expdate, item_status) 
values(item_no_seq.nextval, 'miri', '카시트', 'TEAMTEX', '페라리 코스모 SP', 25000, sysdate, add_months(sysdate,3), 1);

insert into item(item_no, id, item_name, item_brand, item_model, item_price, item_regdate, item_expdate, item_status) 
values(item_no_seq.nextval, 'yosep', '유모차', '드림아일랜드', '컴퍼트', 23000, sysdate, add_months(sysdate,3), 1);

insert into item(item_no, id, item_name, item_brand, item_model, item_price, item_regdate, item_expdate, item_status) 
values(item_no_seq.nextval, 'miri', '모빌', '세도나', 'KOSTA', 11000, sysdate, add_months(sysdate,3), 1);

insert into item(item_no, id, item_name, item_brand, item_model, item_price, item_regdate, item_expdate, item_status) 
values(item_no_seq.nextval, 'qqq', '뽀로로 유모차', '뽀로로친구들', '뽀롱뽀롱', 35000, sysdate, add_months(sysdate,3), 1);

update item set item_status=1 where item_no=10004;

select item_no, item_name, item_price, id, item_expl, item_status from item where item_status=1;
select item_no, id, item_name, item_brand, item_model, item_price, item_regdate, item_expdate from item where item_status=1 and item_no=10001;

select id, item_name, item_brand, item_model, item_price,
	to_char(item_regdate, 'yyyy-MM-dd') as item_regdate, to_char(item_expdate, 'yyyy-MM-dd') as item_expdate,
	item_expl
from item
where item_status=1 and item_no=10008

select i.item_no, i.item_name, i.item_price, i.id, i.item_expl, p.picture_path
from item i, picture p
where i.item_status=1;

select c.cat_no, c.cat_name
from item_category ic, category c
where ic.cat_no=c.cat_no and ic.item_no=10008

insert into picture values(10007,'Cutting.png');

update item set item_expl='카시트~' where item_no=10001;
update item set item_expl='유모롱롱' where item_no=10002;
update item set item_expl='모비루쨩~' where item_no=10003;
update item set item_expl='크롱크롱' where item_no=10004;

select  i.item_no, i.id, i.item_name, i.item_brand, i.item_model, i.item_price, to_char(i.item_regdate, 'yyyy-MM-dd') as item_regdate, to_char(i.item_expdate, 'yyyy-MM-dd') as item_expdate, ic.cat_no, c.cat_name 
from item i, category c, item_category ic 
where i.item_status=1 and i.item_no=10001 and i.item_no=ic.item_no and ic.cat_no=c.cat_no;

select id, item_no, item_name, item_expl, item_price
from item
where item_status=1 and item_name like '%유모차%'
order by item_no asc;

select i.id, i.item_no, i.item_name, i.item_expl, i.item_price, c.cat_name
from item i, item_category ic, category c
where i.item_no=ic.item_no and ic.cat_no=3007 and ic.cat_no=c.cat_no

select * from item;
select * from member;
select * from picture;
select * from item_category;
select * from category;

insert into picture(item_no, picture_path) values(10010,'Glass.png');
insert into picture(item_no, picture_path) values(10008,'Module1.png');

select * from rental_details;
delete item where item_no=10020

insert into picture(item_no, picture_path) values(10002,'Cell Buffer.png');
insert into picture(item_no, picture_path) values(10003,'Cell_2.png');
insert into picture(item_no, picture_path) values(10004,'cell_selected.png');
update picture set picture_path='EmptyTray.png' where item_no=10007;

create table item_add(
   item_no number primary key,
   rental_count number default 0,
   grade number default 0,   
   constraint fk_item_add_item_no foreign key(item_no) references item ON DELETE CASCADE
);
-- 4.category --
create table category(
   cat_no number primary key,
   cat_name varchar2(100) not null
)

update picture set picture_path='배경5.jpg' where picture_path='배경51.jpg'

update item
set item_expl='가나다라마바사아자차카타파하가나다라마바사아자차카타파하'
	||chr(13)||chr(10)||'가나다라마바사아자차카타파하가나다라마바사아자차카타파하'
	||chr(13)||chr(10)||'가나다라마바사아자차카타파하가나다라마바사아자차카타파하'
	||chr(13)||chr(10)||'가나다라마바사아자차카타파하가나다라마바사아자차카타파하'
where item_no=10021;

insert into category(cat_no, cat_name) values(cat_no_seq.nextval, '등산용품');
insert into category(cat_no, cat_name) values(cat_no_seq.nextval, '물놀이용품');
insert into category(cat_no, cat_name) values(cat_no_seq.nextval, '캠핑용품');
insert into category(cat_no, cat_name) values(cat_no_seq.nextval, '겨울스포츠');
insert into category(cat_no, cat_name) values(cat_no_seq.nextval, '낚시용품');
insert into category(cat_no, cat_name) values(cat_no_seq.nextval, '야외스포츠');
insert into category(cat_no, cat_name) values(cat_no_seq.nextval, '유아용품');

select * from category;

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

-- 7.rental_details--
create table rental_details(
   rental_no number primary key,
   item_no number not null,
   id varchar2(100) not null,
   rental_date date not null,
   return_date date not null, 
   total_payment number not null,  
   constraint fk_rental_details_id foreign key(id) references member ON DELETE CASCADE,
   constraint fk_rental_details_item_no foreign key(item_no) references item ON DELETE CASCADE
);

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

-- 3.item_add --
insert into item_add(item_no,rental_count,grade) values(10001,3,5);
insert into item_add(item_no) values(10002);
insert into item_add(item_no) values(10003);
insert into item_add(item_no) values(10004);

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

-- 6. picture --

insert into picture(item_no,picture_path) values(10001,'carseat.jpg');
insert into picture(item_no,picture_path) values(10001,'carseat2.jpg');
insert into picture(item_no,picture_path) values(10002,'stroller.jpg');
insert into picture(item_no,picture_path) values(10003,'mobile.jpg');
insert into picture(item_no,picture_path) values(10004,'pororo.jpg');

-- 7.rental_details--
insert into rental_details(rental_no, item_no, id, rental_date, return_date,total_payment)
values (rental_no_seq.nextval, 10001, 'lsy', '2018/7/11' , '2018/7/15',100000);
insert into rental_details(rental_no, item_no, id, rental_date, return_date,total_payment)
values (rental_no_seq.nextval, 10001, 'yosep', '2018/9/1' , '2018/9/15',350000);
insert into rental_details(rental_no, item_no, id, rental_date, return_date,total_payment)
values (rental_no_seq.nextval, 10001, 'jangso711', '2018/10/1' , '2018/10/12',275000);

-- 8. review --
insert into review(review_no,review_title,review_content,review_grade,review_hit,review_regdate,item_no,id,rental_no) values(review_no_seq.nextval,'카시트 좋아요','조카가 잠깐와서 빌렸어요. 감사합니다.',5,0,'2018/07/18',10001,'lsy',200001);
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




