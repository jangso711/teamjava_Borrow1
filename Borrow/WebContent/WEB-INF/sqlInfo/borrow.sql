--1이 활성화 2가 비활성화 0이 삭제
--상품번호 : 10001~10999
--거래번호 : 200001~209999
--분류번호 : 3001~3020  
create sequence item_no_seq start with 10001 nocache;
create sequence rental_no_seq start with 200001 nocache;
create sequence cat_no_seq start with 3001 nocache;


drop sequence item_no_seq;
drop sequence rental_no_seq;
drop sequence cat_no_seq;
drop table member;
drop table item;
drop table category;
drop table picture;
drop table item_add;
drop table item_category;
drop table rental_details;
create table member(
   id varchar2(100) primary key,
   pwd varchar2(100) not null,
   name varchar2(100) not null,
   address varchar2(100) not null,
   tel varchar2(100) not null,
   point number default 0
);

insert into member values('miri', '1234', '미리', '판교','031',10000);
insert into member values('qqq', '1234', '동규', '수원','032',10000);
insert into member values('yosep', '1234', '요셉', '강남','033',10000);
insert into member values('lsy', '1234', '성열', '강남','034',10000);
insert into member values('jangso711', '1234', '소정', '강남','035',10000);
insert into member values('jb', '1234', '정빈', '강남','036',10000);

select * from member;

select add_months(sysdate,3) from dual;
select * from item_category;

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

create table rental_details(
   rental_no number primary key,
   item_no number not null,
   id varchar2(100) not null,
   rental_date date not null,
   return_date date not null,   
   constraint fk_rental_details_id foreign key(id) references member ON DELETE CASCADE,
   constraint fk_rental_details_item_no foreign key(item_no) references item ON DELETE CASCADE
);

create table picture(
   item_no number not null,
   picture_path varchar2(200) not null,
   
   constraint fk_picture_item_no foreign key(item_no) references item ON DELETE CASCADE,
   constraint pk_picture primary key(item_no,picture_path) 
);

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

insert into ITEM_CATEGORY(item_no, cat_no) values(10001,3003);  
insert into ITEM_CATEGORY(item_no, cat_no) values(10002,3007);  
insert into ITEM_CATEGORY(item_no, cat_no) values(10003,3007);  


-- CONTENTS 추가
alter table item add item_expl clob;
select * from picture;

insert into ITEM_CATEGORY(item_no, cat_no) values(10004,3007);  

--RENTAL DETAILS 추가
insert into rental_details(rental_no, item_no, id, rental_date, return_date)
values (rental_no_seq.nextval, 10001, 'yosep', '2018/8/1' , '2018/8/2');
insert into rental_details(rental_no, item_no, id, rental_date, return_date)
values (rental_no_seq.nextval, 10003, 'yosep', '2018/8/2' , '2018/8/5');
--'yosep'의 대여내역 조회 
select r.rental_no, i.item_no, i.item_name, i.item_price, i.id,  r.rental_date, r.return_date 
from rental_details r, item i
where r.item_no=i.item_no and r.id='yosep';

--'miri'의 등록아이템중 아이템 번호를 조회
select i.item_no from item i where i.id='miri';

--'miri'의 등록내역 조회
select r.* 
from Rental_details r,(select i.item_no from item i where i.id='miri') a
where r.item_no=a.item_no;

--'miri' 등록내역 상세 조회(조인)
 select r.rental_no, r.item_no, i.item_name, r.id, i.item_price, r.rental_date, r.return_date
from Rental_details r,(select i.item_no from item i where i.id='miri') a, item i
where r.item_no=a.item_no and r.item_no=i.item_no;

select * from item;

select i.id, i.item_name, i.item_brand, i.item_model, i.item_price,to_char(i.item_regdate, 'yyyy-MM-dd') as item_regdate,
		to_char(i.item_expdate, 'yyyy-MM-dd') as item_expdate, i.item_expl, ic.cat_no, c.cat_name
from item i, category c, item_category ic
where i.item_status=1 and i.item_no=10004 and i.item_no=ic.item_no and ic.cat_no=c.cat_no

select * from item_category;
select * from picture;

select * from item;

select * from rental_details;
insert into rental_details values(rental_no_seq.nextval,10001,'yosep',sysdate,(sysdate+10));
insert into rental_details values(rental_no_seq.nextval,10001,'yosep',sysdate+10,sysdate+20);
select sysdate,max(return_date) from rental_details where item_no=10001;
select * from item where item_no=10013;
update item set item_status=0,item_expdate=to_char(sysdate,'YYYY-MM-DD') where item_no=10013;

update member set pwd='1234',name='이동규',address='당진',tel='041' where id='qqq';
select * from member;
select m.name, i.item_name, i.item_brand, i.item_model, i.item_price, i.item_no, r.rental_no, r.rental_date, r.return_date
from member m, item i, rental_details r where m.id = i.id and i.item_no = r.item_no and rental_no=200018

delete from picture where item_no = 10001

select picture_path from picture where item_no = 10002

select to_char(rental_date,'yyyymmdd'),to_char(return_date,'yyyymmdd') from rental_details where item_no=10001;

select picture_path from picture where item_no = 10002;

select * from RENTAL_DETAILS;

update rental_details set return_date=sysdate where rental_no=200005;

select Max(return_date) from rental_details where item_no='10005';
delete from RENTAL_DETAILS where item_no=?;

update rental_details set return_date=sysdate where rental_no=200005;