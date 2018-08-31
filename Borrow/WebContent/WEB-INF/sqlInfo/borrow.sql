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



select * from item;

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