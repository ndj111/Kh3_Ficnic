-- 게시판 데이터 테이블 (샘플 faq)
drop table board_data_faq purge;

create table board_data_faq(
    bdata_no number(5) primary key,
    board_id varchar2(30) not null,
    bdata_headnum number(10) default '0' not null,
    bdata_category number(5) default '0' not null,
    bdata_title varchar2(200) not null,
    bdata_cont varchar2(3000) not null,
    bdata_sub varchar2(200),
    bdata_link1 varchar2(300),
    bdata_link2 varchar2(300),
    bdata_file1 varchar2(300),
    bdata_file2 varchar2(300),
    bdata_file3 varchar2(300),
    bdata_file4 varchar2(300),
    bdata_ficnic varchar2(1000),
    bdata_use_notice varchar2(1) default 'N' not null,
    bdata_use_secret varchar2(1) default 'N' not null,
    bdata_hit number(5) default '0' not null,
    bdata_comment number(5) default '0' not null,
    bdata_writer_id varchar2(50),
    bdata_writer_pw varchar2(200) not null,
    bdata_writer_name varchar2(50) not null,
    bdata_date date default sysdate
);

comment on column board_data_faq.bdata_no is '게시물 번호';
comment on column board_data_faq.board_id is '게시판 아이디';
comment on column board_data_faq.bdata_headnum is '게시물 정렬 번호';
comment on column board_data_faq.bdata_category is '게시물 카테고리 번호';
comment on column board_data_faq.bdata_title is '게시물 제목';
comment on column board_data_faq.bdata_cont is '게시물 내용';
comment on column board_data_faq.bdata_sub is '게시물 추가내용';
comment on column board_data_faq.bdata_link1 is '게시물 링크1';
comment on column board_data_faq.bdata_link2 is '게시물 링크2';
comment on column board_data_faq.bdata_file1 is '게시물 첨부파일1';
comment on column board_data_faq.bdata_file2 is '게시물 첨부파일2';
comment on column board_data_faq.bdata_file3 is '게시물 첨부파일3';
comment on column board_data_faq.bdata_file4 is '게시물 첨부파일4';
comment on column board_data_faq.bdata_ficnic is '게시물 피크닉 지정';
comment on column board_data_faq.bdata_use_notice is '공지사항 사용여부 (N/Y)';
comment on column board_data_faq.bdata_use_secret is '비밀글 사용여부 (N/Y)';
comment on column board_data_faq.bdata_hit is '게시물 조회수';
comment on column board_data_faq.bdata_comment is '게시물 댓글 갯수';
comment on column board_data_faq.bdata_writer_id is '작성자 아이디';
comment on column board_data_faq.bdata_writer_pw is '작성자 비밀번호';
comment on column board_data_faq.bdata_writer_name is '작성자 이름';
comment on column board_data_faq.bdata_date is '게시물 작성일자';

insert into board_data_faq values(1, 'faq', 2000000000, 1, '테스트 게시물', '게시물 내용', null, null, null, null, null, null, null, null, 'N', 'N', 0, 1, 'testadmin', '1234', '테스트관리자', sysdate);

commit;