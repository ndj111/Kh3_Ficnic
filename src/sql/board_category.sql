-- 게시판 카테고리 테이블 (샘플 faq)
drop table board_category_faq purge;

create table board_category_faq(
    bcate_no number(5) primary key,
    bcate_name varchar2(50) not null,
    bcate_rank number(5) default '99' not null,
    bcate_article number(11) default '0' not null,
    bcate_date date default sysdate
);

comment on column board_data_faq.bcate_no is '카테고리 번호';
comment on column board_data_faq.bcate_name is '카테고리 이름';
comment on column board_data_faq.bcate_rank is '카테고리 표시 순위';
comment on column board_data_faq.bcate_article is '카테고리 게시물 갯수';
comment on column board_data_faq.bcate_date is '카테고리 등록 일자';

insert into board_category_faq values(1, '주문관련', 1, 1, sysdate);
insert into board_category_faq values(2, '결제관련', 2, 0, sysdate);
insert into board_category_faq values(3, '배송관련', 3, 0, sysdate);

commit;