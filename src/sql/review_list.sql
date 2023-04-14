-- 리뷰 목록 테이블
drop table review_list purge;

create table review_list(
    review_no number(5) primary key,
    ficnic_no number(11) not null,
    review_point number(2) default '10' not null,
    review_cont varchar2(3000) not null,
    review_photo1 varchar2(200),
    review_photo2 varchar2(200),
    member_id varchar2(30) not null,
    review_pw varchar2(50) not null,
    review_name varchar2(50) not null,
    review_date date default sysdate
);

comment on column review_list.review_no is '리뷰 번호';
comment on column review_list.ficnic_no is '피크닉 번호';
comment on column review_list.review_point is '리뷰 평점';
comment on column review_list.review_cont is '리뷰 내용';
comment on column review_list.review_photo1 is '리뷰 사진1';
comment on column review_list.review_photo2 is '리뷰 사진2';
comment on column review_list.member_id is '작성자 아이디';
comment on column review_list.review_pw is '작성자 비번';
comment on column review_list.review_name is '작성자 이름';
comment on column review_list.review_date is '리뷰 작성일';


insert into review_list values(1, 1, 9, '리뷰 내용
리뷰내용 123
아아아아asdbc
345345345', null, null, 'test1', '1234', '테스트회원1', sysdate);
insert into review_list values(2, 1, 10, '재구매 했습니다.', null, null, 'test1', '1234', '테스트회원1', sysdate);

commit;