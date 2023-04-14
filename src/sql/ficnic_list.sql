-- 피크닉 목록 테이블
drop table ficnic_list purge;

create table ficnic_list(
    ficnic_no number(5) primary key,
    ficnic_category_no varchar2(8) default '00000000' not null,
    ficnic_category_sub1 varchar2(8),
    ficnic_category_sub2 varchar2(8),
    ficnic_category_sub3 varchar2(8),
    ficnic_name varchar2(100) not null,
    ficnic_market_price number(11) default '0',
    ficnic_sale_price number(11) default '0' not null,
    ficnic_option_title varchar2(3000),
    ficnic_option_price varchar2(3000),
    ficnic_select_title varchar2(3000),
    ficnic_select_price varchar2(3000),
    ficnic_date_use varchar2(1) default 'N' not null,
    ficnic_photo1 varchar2(200),
    ficnic_photo2 varchar2(200),
    ficnic_photo3 varchar2(200),
    ficnic_photo4 varchar2(200),
    ficnic_photo5 varchar2(200),
    ficnic_info varchar2(3000),
    ficnic_detail clob,
    ficnic_curriculum varchar2(3000),
    ficnic_etc varchar2(1000),
    ficnic_location varchar2(100),
    ficnic_address varchar2(1000),
    ficnic_include varchar2(1000),
    ficnic_notinclude varchar2(1000),
    ficnic_prepare varchar2(1000),
    ficnic_caution varchar2(3000),
    ficnic_review_point number(11,2) default '0' not null,
    ficnic_review_count number(11) default '0' not null,
    ficnic_hit number(11) default '0' not null,
    ficnic_sale number(11) default '0' not null,
    ficnic_date date default sysdate
);

comment on column ficnic_list.ficnic_no is '피크닉 번호';
comment on column ficnic_list.ficnic_category_no is '피크닉 카테고리';
comment on column ficnic_list.ficnic_category_sub1 is '피크닉 서브 카테고리1';
comment on column ficnic_list.ficnic_category_sub2 is '피크닉 서브 카테고리2';
comment on column ficnic_list.ficnic_category_sub3 is '피크닉 서브 카테고리3';
comment on column ficnic_list.ficnic_name is '피크닉 이름';
comment on column ficnic_list.ficnic_market_price is '이전 판매가';
comment on column ficnic_list.ficnic_sale_price is '현재 판매가';
comment on column ficnic_list.ficnic_option_title is '옵션 타이틀';
comment on column ficnic_list.ficnic_option_price is '옵션 가격';
comment on column ficnic_list.ficnic_select_title is '추가선택 타이틀';
comment on column ficnic_list.ficnic_select_price is '추가선택 가격';
comment on column ficnic_list.ficnic_date_use is '날짜 선택 사용여부 (N/Y)';
comment on column ficnic_list.ficnic_photo1 is '피크닉 사진1';
comment on column ficnic_list.ficnic_photo2 is '피크닉 사진2';
comment on column ficnic_list.ficnic_photo3 is '피크닉 사진3';
comment on column ficnic_list.ficnic_photo4 is '피크닉 사진4';
comment on column ficnic_list.ficnic_photo5 is '피크닉 사진5';
comment on column ficnic_list.ficnic_info is '피크닉 정보';
comment on column ficnic_list.ficnic_detail is '피크닉 상세';
comment on column ficnic_list.ficnic_curriculum is '커리큘럼';
comment on column ficnic_list.ficnic_etc is '기타 정보';
comment on column ficnic_list.ficnic_location is '진행 지역';
comment on column ficnic_list.ficnic_address is '진행 장소';
comment on column ficnic_list.ficnic_include is '포함 사항';
comment on column ficnic_list.ficnic_notinclude is '불포함 사항';
comment on column ficnic_list.ficnic_prepare is '준비물';
comment on column ficnic_list.ficnic_caution is '유의 사항';
comment on column ficnic_list.ficnic_review_point is '리뷰 총점';
comment on column ficnic_list.ficnic_review_count is '리뷰 갯수';
comment on column ficnic_list.ficnic_hit is '피크닉 조회수';
comment on column ficnic_list.ficnic_sale is '피크닉 판매 갯수';
comment on column ficnic_list.ficnic_date is '피크닉 등록 일자';


insert into ficnic_list values(1, '05000000', null, null, null, '[제주] 제주로컬푸드 이용한 셀프 베이킹 (예약 가능)', 0, 30000, '[제주] 제주로컬푸드 이용한 셀프 베이킹 (예약 가능)★[11세~대인] 제주고사리파스타★[10세~대인] 제주통밀당근파운드케이크', '30000★27000★30000', '10:00 타임★11:00 타임★13:30 타임★14:30 타임', '0★0★0★0', 'N', null, null, null, null, null, '<dt>연령</dt><dd>11세 이상 권장</dd>★<dt>사용기간</dt><dd>구매일로부터 90일</dd>', '<img src="https://res.cloudinary.com/frientrip/image/upload/c_limit,dpr_3.0,f_auto,q_auto:best,w_500/01_8_fqpvuy.jpg" class="fr-fic fr-dib">', null, null, '제주', '제주특별자치도 제주시 애월읍 상귀리 152', '강습비 재료비', '주차 별도 문의', '가벼운 마음', '[신청 시 유의사항]
① 당일 예약시 현장으로 가능 여부 먼저 확인 후 결제해주세요!!


· 구매시 호스트 연락처를 카톡 혹은 문자로 보내드립니다.
· 호스트 연락처로 진행 가능한 날짜 예약 바랍니다.
· 예약 확정 시 환불이 불가합니다.
· 예약 시간에 맞추어 늦지 않게 도착해주시기 바랍니다.', 9.5, 2, 0, 0, sysdate);

commit;