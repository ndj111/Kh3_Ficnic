-- 게시판 댓글 테이블 (샘플 faq)
drop table board_comment_faq purge;

create table board_comment_faq(
    bcomm_no number(5) primary key,
    bdata_no number(5) not null,
    bcomm_id varchar2(50),
    bcomm_pw varchar2(200),
    bcomm_name varchar2(100),
    bcomm_cont varchar2(2000),
    bcomm_date date default sysdate
);

comment on column board_data_faq.bcomm_no is '댓글 번호';
comment on column board_data_faq.bdata_no is '게시물 번호';
comment on column board_data_faq.bcomm_id is '작성자 아이디';
comment on column board_data_faq.bcomm_pw is '작성자 비밀번호';
comment on column board_data_faq.bcomm_name is '작성자 이름';
comment on column board_data_faq.bcomm_cont is '댓글 내용';
comment on column board_data_faq.bcomm_date is '댓글 작성일자';

insert into board_comment_faq values(1, 1, 'test1', '1234', '테스트회원1', '댓글 내용
123213123123
adawdawdawd', sysdate);

commit;