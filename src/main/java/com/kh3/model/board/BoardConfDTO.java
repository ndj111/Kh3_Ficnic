package com.kh3.model.board;

import lombok.Data;

@Data
public class BoardConfDTO {

	 private int board_no;
	 private String board_id;
	 private String board_name;
	 private String board_skin;
	 private int board_list_num;
	 private int board_page_num;
	 private String board_use_category;
	 private String board_use_comment;
	 private String board_use_secret;
	 private String board_use_only_secret;
	 private String board_use_link1;
	 private String board_use_link2;
	 private String board_use_file1;
	 private String board_use_file2;
	 private String board_use_file3;
	 private String board_use_file4;
	 private String board_level_list;
	 private String board_level_view;
	 private String board_level_write;
	 private String board_level_comment;
	 private String board_level_notice;
	 private String board_level_modify;
	 private String board_level_delete;
	 private String board_date;
}
