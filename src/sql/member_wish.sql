-- 회원 찜한 상품 내역 테이블
drop table member_wish purge;

create table member_wish(
    wish_no number(5) primary key,
    ficnic_no number(5) not null,
    member_id varchar2(30) not null,
    wish_date date default sysdate
);

comment on column member_wish.wish_no is '찜 번호';
comment on column member_wish.ficnic_no is '피크닉 번호';
comment on column member_wish.member_id is '회원 아이디';
comment on column member_wish.wish_date is '찜한 일자';

insert into member_wish values(1, 1, 'test1', sysdate);
insert into member_wish values(2, 1, 'test2', sysdate);
insert into member_wish values(3, 2, 'test1', sysdate);

commit;