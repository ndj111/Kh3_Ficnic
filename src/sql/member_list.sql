-- 회원 목록 테이블
drop table member_list purge;

create table member_list(
    member_no number(5) primary key,
    member_type varchar2(20) default 'user',
    member_id varchar2(30) not null,
    member_pw varchar2(100) not null,
    member_name varchar2(50) not null,
    member_email varchar2(100) not null,
    member_phone varchar2(20) not null,
    member_point number(11) default 0,
    member_joindate date default sysdate
);

comment on column member_list.member_no is '회원 번호';
comment on column member_list.member_type is '유형 (user/admin/exit)';
comment on column member_list.member_id is '아이디';
comment on column member_list.member_pw is '비밀번호';
comment on column member_list.member_name is '이름';
comment on column member_list.member_email is '이메일';
comment on column member_list.member_phone is '전화번호';
comment on column member_list.member_point is '적립금';
comment on column member_list.member_joindate is '가입일자';

insert into member_list values(1, 'admin', 'testadmin', '1234', '테스트관리자', 'testadmin@test.com', '010-1111-1111', '0', sysdate);
insert into member_list values(2, 'user', 'test1', '1234', '테스트회원1', 'testuser@test.com', '010-2222-2222', '2000', sysdate);
insert into member_list values(3, 'user', 'test2', '1234', '테스트회원2', 'testuser2@test.com', '010-3333-3333', '1000', sysdate);

commit;