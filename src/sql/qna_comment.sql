-- 일대일문의(게시판) 댓글 테이블
drop table qna_comment purge;

create table qna_comment(
    comment_no number(5) primary key,
    qna_no number(5) not null,
    comment_content varchar2(2000) not null,
    comment_writer_name varchar2(50) not null,
    member_id varchar2(30) not null,
    comment_writer_pw varchar2(200) not null,
    comment_date date default sysdate not null
);

comment on column qna_comment.comment_no is '댓글 번호';
comment on column qna_comment.qna_no is '문의글 번호';
comment on column qna_comment.comment_content is '댓글 내용';
comment on column qna_comment.comment_writer_name is '작성자 이름';
comment on column qna_comment.member_id is '작성자 아이디';
comment on column qna_comment.comment_writer_pw is '작성자 비번';
comment on column qna_comment.comment_date is '작성일자';

insert into qna_comment values(1, 1, '댓글 내용1
줄바꿈', '관리자1', 'test', '1234', sysdate);
insert into qna_comment values(2, 1, '댓글 내용2
줄바꿈', '테스트', 'test2', '1234', sysdate);
insert into qna_comment values(3, 2, '댓글 내용3
줄바꿈', '관리자1', 'test', '1234', sysdate);

commit;