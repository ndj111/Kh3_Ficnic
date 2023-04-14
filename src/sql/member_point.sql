-- 회원 적립금 내역 테이블
drop table member_point purge;

create table member_point(
    point_no number(5) primary key,
    point_kind varchar2(30) not null,
    reserv_sess varchar2(30),
    review_no number(11),
    member_id varchar2(30) not null,
    point_type varchar2(5) default 'plus' not null,
    point_add number(11) default '0' not null,
    point_reason varchar2(200) not null,
    point_date date default sysdate
);

comment on column member_point.point_no is '적립금 번호';
comment on column member_point.point_kind is '적립 종류';
comment on column member_point.reserv_sess is '예약 번호';
comment on column member_point.review_no is '리뷰 번호';
comment on column member_point.member_id is '회원 아이디';
comment on column member_point.point_type is '적립금 구분 (plus/minus)';
comment on column member_point.point_add is '적립금 금액';
comment on column member_point.point_reason is '적립 이유';
comment on column member_point.point_date is '적립 일자';

insert into member_point values(1, 'join', null, null, 'test1', 'plus', 1000, '회원가입 축하 적립금 지급', sysdate);
insert into member_point values(2, 'join', null, null, 'test2', 'plus', 1000, '회원가입 축하 적립금 지급', sysdate);
insert into member_point values(3, 'review', null, 1, 'test1', 'plus', 500, '상품 후기 작성 적립금 지급', sysdate);
insert into member_point values(4, 'review', null, 2, 'test1', 'plus', 500, '상품 후기 작성 적립금 지급', sysdate);

commit;