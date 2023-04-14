-- 1:1문의 목록 테이블
drop table qna_list purge;

create table qna_list(
    qna_no number(5) primary key,
    ficnic_no number(11) not null,
    qna_title varchar2(200) not null,
    qna_cont varchar2(1000) not null,
    qna_file1 varchar2(200),
    qna_file2 varchar2(200),
    member_id varchar2(30) not null,
    qna_pw varchar2(200) not null,
    qna_name varchar2(50) not null,
    qna_date date default sysdate
);

comment on column qna_list.qna_no is '문의 번호';
comment on column qna_list.ficnic_no is '피크닉 번호';
comment on column qna_list.qna_title is '문의 제목';
comment on column qna_list.qna_cont is '문의 내용';
comment on column qna_list.qna_file1 is '문의 파일1';
comment on column qna_list.qna_file2 is '문의 파일2';
comment on column qna_list.member_id is '작성자 아이디';
comment on column qna_list.qna_pw is '작성자 비번';
comment on column qna_list.qna_name is '작성자 이름';
comment on column qna_list.qna_date is '문의 작성일자';


insert into qna_list values(1, 1, '문의 제목입니다.', '문의 내용입니다.', null, null, 'test1', '1234', '테스트회원1', sysdate);

commit;