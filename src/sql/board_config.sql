-- 게시판 설정 테이블
drop table board_config purge;

create table board_config(
    board_no number(5) primary key,
    board_id varchar2(30) not null,
    board_name varchar2(30) not null,
    board_skin varchar2(100) default 'basic' not null,
    board_list_num number(5) default '15' not null,
    board_page_num number(5) default '3' not null,
    board_use_category varchar2(1) default 'N' not null,
    board_use_comment varchar2(1) default 'Y' not null,
    board_use_secret varchar2(1) default 'N' not null,
    board_use_only_secret varchar2(1) default 'N' not null,
    board_use_link1 varchar2(1) default 'Y' not null,
    board_use_link2 varchar2(1) default 'Y' not null,
    board_use_file1 varchar2(1) default 'Y' not null,
    board_use_file2 varchar2(1) default 'Y' not null,
    board_use_file3 varchar2(1) default 'Y' not null,
    board_use_file4 varchar2(1) default 'Y' not null,
    board_level_list varchar2(30),
    board_level_view varchar2(30),
    board_level_write varchar2(30),
    board_level_comment varchar2(30),
    board_level_notice varchar2(30),
    board_level_modify varchar2(30),
    board_level_delete varchar2(30),
    board_date date default sysdate
);

comment on column board_config.board_no is '게시판 번호';
comment on column board_config.board_id is '게시판 아이디';
comment on column board_config.board_name is '게시판 이름';
comment on column board_config.board_skin is '게시판 스킨';
comment on column board_config.board_list_num is '목록 표시 게시물 갯수';
comment on column board_config.board_page_num is '페이징 표시 갯수';
comment on column board_config.board_use_category is '카테고리 사용여부 (N/Y)';
comment on column board_config.board_use_comment is '댓글 사용여부 (N/Y)';
comment on column board_config.board_use_secret is '비밀글 사용여부 (N/Y)';
comment on column board_config.board_use_only_secret is '무조건 비밀글 사용여부 (N/Y)';
comment on column board_config.board_use_link1 is '링크1 사용여부 (N/Y)';
comment on column board_config.board_use_link2 is '링크2 사용여부 (N/Y)';
comment on column board_config.board_use_file1 is '첨부파일1 사용여부 (N/Y)';
comment on column board_config.board_use_file2 is '첨부파일2 사용여부 (N/Y)';
comment on column board_config.board_use_file3 is '첨부파일3 사용여부 (N/Y)';
comment on column board_config.board_use_file4 is '첨부파일4 사용여부 (N/Y)';
comment on column board_config.board_level_list is '목록 보기 권한 (null/user/admin)';
comment on column board_config.board_level_view is '게시물 보기 권한 (null/user/admin)';
comment on column board_config.board_level_write is '게시물 작성 권한 (null/user/admin)';
comment on column board_config.board_level_comment is '댓글 작성 권한 (null/user/admin)';
comment on column board_config.board_level_notice is '공지사항 작성 권한 (null/user/admin)';
comment on column board_config.board_level_modify is '게시물 수정 권한 (null/user/admin)';
comment on column board_config.board_level_delete is '게시물 삭제 권한 (null/user/admin)';
comment on column board_config.board_date is '게시판 등록 일자';

insert into board_config values(1, 'faq', '자주묻는질문', 'faq', 10, 3, 'Y', 'Y', 'N', 'N', 'N', 'N', 'Y', 'Y', 'N', 'N', null, null, 'admin', 'admin', 'admin', 'admin', 'admin', sysdate);

commit;