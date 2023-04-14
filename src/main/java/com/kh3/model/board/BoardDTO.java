package com.kh3.model.board;

import lombok.Data;

@Data
public class BoardDTO {

	private int bdata_no;
	private String board_id;
	private int bdata_headnum;
	private int bdata_category;
	private String bdata_category_name;

	private String bdata_title;
	private String bdata_cont;
	private String bdata_sub;

	private String bdata_link1;
	private String bdata_link2;
	private String bdata_file1;
	private String bdata_file2;
	private String bdata_file3;
	private String bdata_file4;
	private String bdata_file1_img;
	private String bdata_file2_img;
	private String bdata_file3_img;
	private String bdata_file4_img;
    private String bdata_file1_file;
    private String bdata_file2_file;
    private String bdata_file3_file;
    private String bdata_file4_file;

	private String bdata_ficnic;
	private String bdata_use_notice;
	private String bdata_use_secret;

	private int bdata_hit;
	private int bdata_comment;
	private String bdata_writer_id;
	private String bdata_writer_pw;
	private String bdata_writer_type;
	private String bdata_writer_name;
	private String bdata_date;
	
}
