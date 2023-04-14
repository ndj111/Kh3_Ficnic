-- 쿠폰 목록 테이블
drop table coupon_list purge;

create table coupon_list(
    coupon_no number(5) primary key,
    coupon_name varchar2(100) not null,
    coupon_use_type varchar2(30) default 'cart' not null,
    coupon_use_value varchar2(3000),
    coupon_price number(11) default '0' not null,
    coupon_price_type varchar2(30) default 'price' not null,
    coupon_price_over number(11) default '0' not null,
    coupon_price_max number(11) default '0' not null,
    coupon_date_type varchar2(30) default 'free' not null,
    coupon_date_value number(3) default '0' not null,
    coupon_start_date date,
    coupon_end_date date,
    coupon_max_ea number(11) default '0' not null,
    coupon_down_ea number(11) default '0' not null,
    coupon_use_ea number(11) default '0' not null,
    coupon_date date default sysdate
);

comment on column coupon_list.coupon_no is '쿠폰 번호';
comment on column coupon_list.coupon_name is '쿠폰 이름';
comment on column coupon_list.coupon_use_type is '쿠폰 사용 구분 (cart/category/goods)';
comment on column coupon_list.coupon_use_value is '쿠폰 사용 구분 값';
comment on column coupon_list.coupon_price is '할인 금액';
comment on column coupon_list.coupon_price_type is '할인 금액 구분 (price/percent)';
comment on column coupon_list.coupon_price_over is '최소 사용 금액';
comment on column coupon_list.coupon_price_max is '최대 할인 금액';
comment on column coupon_list.coupon_date_type is '사용 기간 구분 (free/after/date)';
comment on column coupon_list.coupon_date_value is '사용 기간 구분 값';
comment on column coupon_list.coupon_start_date is '사용 기간 시작';
comment on column coupon_list.coupon_end_date is '사용 기간 끝';
comment on column coupon_list.coupon_max_ea is '쿠폰 최대 발행 갯수';
comment on column coupon_list.coupon_down_ea is '쿠폰 현재 발행 갯수';
comment on column coupon_list.coupon_use_ea is '쿠폰 현재 사용 갯수';
comment on column coupon_list.coupon_date is '쿠폰 등록일자';


insert into coupon_list values(1, '테스트 쿠폰', 'cart', null, 2000, 'price', 30000, 0, 'after', 30, null, null, 100, 1, 0, sysdate);
insert into coupon_list values(2,'카테고리 쿠폰', 'category', '1000000★2000000', 10, 'percent', 15000, 3000, 'date', 0, to_date('2022/12/01 00:00:00','YYYY/MM/DD HH24:MI:SS'), to_date('2022/12/31 23:59:59','YYYY/MM/DD HH24:MI:SS'), 50, 2, 1, sysdate);


commit;