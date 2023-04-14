-- 피크닉 카테고리 테이블
drop table ficnic_category purge;

create table ficnic_category(
    category_no number(5) primary key,
    category_show varchar2(1) default 'Y' not null,
    category_id varchar2(8) not null,
    category_depth number(2) default '1' not null,
    category_id_up varchar2(8) not null,
    category_rank number(11) default '1' not null,
    category_name varchar2(100) not null,
    category_image varchar2(200)
);

comment on column ficnic_category.category_no is '카테고리 번호';
comment on column ficnic_category.category_show is '카테고리 노출';
comment on column ficnic_category.category_id is '카테고리 아이디';
comment on column ficnic_category.category_depth is '카테고리 레벨';
comment on column ficnic_category.category_id_up is '부모 카테고리 아이디';
comment on column ficnic_category.category_rank is '카테고리 표시 순위';
comment on column ficnic_category.category_name is '카테고리 이름';
comment on column ficnic_category.category_image is '카테고리 이미지';


insert into ficnic_category values(1, 'N', '00000000', 0, 'M', 0, '카테고리 미지정', null);
insert into ficnic_category values(2, 'Y', '01000000', 1, 'M', 1, '아웃도어', null);
insert into ficnic_category values(17, 'Y', '01010000', 2, '01000000', 16, '서핑', null);
insert into ficnic_category values(18, 'Y', '01020000', 2, '01000000', 17, '등산·트레킹', null);
insert into ficnic_category values(19, 'Y', '01030000', 2, '01000000', 18, '캠핑', null);
insert into ficnic_category values(20, 'Y', '01040000', 2, '01000000', 19, '승마', null);
insert into ficnic_category values(21, 'Y', '01050000', 2, '01000000', 20, '러닝', null);
insert into ficnic_category values(22, 'Y', '01060000', 2, '01000000', 21, '라이딩', null);
insert into ficnic_category values(23, 'Y', '01070000', 2, '01000000', 22, '요트·보트', null);
insert into ficnic_category values(24, 'Y', '01080000', 2, '01000000', 23, '보드·인라인', null);
insert into ficnic_category values(25, 'Y', '01090000', 2, '01000000', 24, '다이빙', null);
insert into ficnic_category values(26, 'Y', '01100000', 2, '01000000', 25, '스키·스노우보드', null);
insert into ficnic_category values(27, 'Y', '01110000', 2, '01000000', 26, '낚시', null);
insert into ficnic_category values(28, 'Y', '01120000', 2, '01000000', 27, '패러글라이딩', null);
insert into ficnic_category values(29, 'Y', '01130000', 2, '01000000', 28, '기타', null);
insert into ficnic_category values(3, 'Y', '02000000', 1, 'M', 2, '피트니스', null);
insert into ficnic_category values(30, 'Y', '02010000', 2, '02000000', 29, '요가', null);
insert into ficnic_category values(31, 'Y', '02020000', 2, '02000000', 30, '필라테스', null);
insert into ficnic_category values(32, 'Y', '02030000', 2, '02000000', 31, '헬스·PT·GX', null);
insert into ficnic_category values(33, 'Y', '02040000', 2, '02000000', 32, '크로스핏', null);
insert into ficnic_category values(34, 'Y', '02050000', 2, '02000000', 33, '홈 피트니스', null);
insert into ficnic_category values(35, 'Y', '02060000', 2, '02000000', 34, '기타', null);
insert into ficnic_category values(4, 'Y', '03000000', 1, 'M', 3, '공예DIY', null);
insert into ficnic_category values(36, 'Y', '03010000', 2, '03000000', 35, '가죽', null);
insert into ficnic_category values(37, 'Y', '03020000', 2, '03000000', 36, '도자기', null);
insert into ficnic_category values(38, 'Y', '03030000', 2, '03000000', 37, '플라워', null);
insert into ficnic_category values(39, 'Y', '03040000', 2, '03000000', 38, '목공', null);
insert into ficnic_category values(40, 'Y', '03050000', 2, '03000000', 39, '캔들', null);
insert into ficnic_category values(41, 'Y', '03060000', 2, '03000000', 40, '비누', null);
insert into ficnic_category values(42, 'Y', '03070000', 2, '03000000', 41, '향수', null);
insert into ficnic_category values(43, 'Y', '03080000', 2, '03000000', 42, '레진아트', null);
insert into ficnic_category values(44, 'Y', '03090000', 2, '03000000', 43, '액세서리', null);
insert into ficnic_category values(45, 'Y', '03100000', 2, '03000000', 44, '유리', null);
insert into ficnic_category values(46, 'Y', '03110000', 2, '03000000', 45, '실공예', null);
insert into ficnic_category values(47, 'Y', '03120000', 2, '03000000', 46, '라탄', null);
insert into ficnic_category values(48, 'Y', '03130000', 2, '03000000', 47, '기타', null);
insert into ficnic_category values(5, 'Y', '04000000', 1, 'M', 4, '스포츠', null);
insert into ficnic_category values(6, 'Y', '05000000', 1, 'M', 5, '베이킹', null);
insert into ficnic_category values(7, 'Y', '06000000', 1, 'M', 6, '문화예술', null);
insert into ficnic_category values(8, 'Y', '07000000', 1, 'M', 7, '자기계발', null);
insert into ficnic_category values(9, 'Y', '08000000', 1, 'M', 8, '온라인', null);
insert into ficnic_category values(10, 'Y', '09000000', 1, 'M', 9, '뷰티', null);
insert into ficnic_category values(11, 'Y', '10000000', 1, 'M', 10, '모임', null);
insert into ficnic_category values(13, 'Y', '12000000', 1, 'M', 12, '심리·상담', null);
insert into ficnic_category values(14, 'Y', '13000000', 1, 'M', 13, '수상레포츠', null);
insert into ficnic_category values(15, 'Y', '14000000', 1, 'M', 14, '음료', null);
insert into ficnic_category values(16, 'Y', '15000000', 1, 'M', 15, '요리', null);


commit;