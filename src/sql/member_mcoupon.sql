-- 회원 보유 쿠폰 테이블
drop table member_mcoupon purge;

create table member_mcoupon(
    mcoupon_no number(5) primary key,
    coupon_no number(5) not null,
    reserv_sess varchar2(30),
    member_id varchar2(30) not null,
    mcoupon_use_price number(11) default '0' not null,
    mcoupon_start_date date,
    mcoupon_end_date date,
    mcoupon_use_date date,
    mcoupon_date date default sysdate
);

comment on column member_mcoupon.mcoupon_no is '보유 쿠폰 번호';
comment on column member_mcoupon.coupon_no is '쿠폰 번호';
comment on column member_mcoupon.reserv_sess is '예약 번호';
comment on column member_mcoupon.member_id is '회원 아이디';
comment on column member_mcoupon.mcoupon_use_price is '쿠폰 사용 금액';
comment on column member_mcoupon.mcoupon_start_date is '사용 시작 기간';
comment on column member_mcoupon.mcoupon_end_date is '사용 종료 기간';
comment on column member_mcoupon.mcoupon_use_date is '쿠폰 사용 일자';
comment on column member_mcoupon.mcoupon_date is '쿠폰 발급 일자';


insert into member_mcoupon values(1, 1, null, 'test1', 0, null, null, null, sysdate);

commit;