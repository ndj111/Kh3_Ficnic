-- 예약 목록 테이블
drop table reserv_list purge;

create table reserv_list(
    reserv_no number(5) primary key,
    reserv_sess varchar2(30) not null,
    reserv_status varchar2(50) default 'reserv' not null,
    ficnic_no number(5) not null,
    reserv_ficnic_name varchar2(100) not null,
    reserv_ficnic_sale_price number(11) default '0' not null,
    reserv_ficnic_option_title varchar2(1000),
    reserv_ficnic_option_price number(11),
    reserv_ficnic_select_title varchar2(1000),
    reserv_ficnic_select_price number(11),
    reserv_ficnic_photo varchar2(200),
    reserv_ficnic_date date,
    reserv_use_coupon number(11) default '0' not null,
    reserv_coupon_price number(11) default '0' not null,
    reserv_use_point number(11) default '0' not null,
    reserv_payment varchar2(100),
    reserv_total_price number(11) default '0' not null,
    reserv_with varchar2(100),
    member_id varchar2(30) not null,
    reserv_name varchar2(50) not null,
    reserv_phone varchar2(14) not null,
    reserv_email varchar2(200) not null,
    reserv_date date default sysdate
);

comment on column reserv_list.reserv_no is '예약 no';
comment on column reserv_list.reserv_sess is '예약 번호';
comment on column reserv_list.reserv_status is '예약 상태 (reserv/confirm/done/cancel)';
comment on column reserv_list.ficnic_no is '피크닉 번호';
comment on column reserv_list.reserv_ficnic_name is '피크닉 이름';
comment on column reserv_list.reserv_ficnic_sale_price is '피크닉 가격';
comment on column reserv_list.reserv_ficnic_option_title is '옵션 타이틀';
comment on column reserv_list.reserv_ficnic_option_price is '옵션 가격';
comment on column reserv_list.reserv_ficnic_select_title is '선택 타이틀';
comment on column reserv_list.reserv_ficnic_select_price is '선택 가격';
comment on column reserv_list.reserv_ficnic_photo is '피크닉 사진';
comment on column reserv_list.reserv_ficnic_date is '피크닉 날짜';
comment on column reserv_list.reserv_use_coupon is '사용 쿠폰 번호';
comment on column reserv_list.reserv_coupon_price is '사용 쿠폰 금액';
comment on column reserv_list.reserv_use_point is '사용 적립금 금액';
comment on column reserv_list.reserv_payment is '결제 수단';
comment on column reserv_list.reserv_total_price is '최종 결제 금액';
comment on column reserv_list.reserv_with is '누구와 함께';
comment on column reserv_list.member_id is '회원 아이디';
comment on column reserv_list.reserv_name is '회원 이름';
comment on column reserv_list.reserv_phone is '회원 연락처';
comment on column reserv_list.reserv_email is '회원 이메일';
comment on column reserv_list.reserv_date is '예약 일자';


insert into reserv_list values(1, '221212-123456', 'reserv', 1, '[제주] 제주로컬푸드 이용한 셀프 베이킹 (예약 가능)', 30000, '[11세~대인] 제주고사리파스타', 30000, '13:30 타임', 0, null, sysdate, 0, 0, 0, 'toss', 30000, 'alone', 'test1', '테스트회원1', '010-1234-5678', 'awdknlawd@awdawd.com', sysdate);

commit;