package com.kh3.model.qna;


import lombok.Data;

@Data
public class QnaCommentDTO {

	private int comment_no;
	private int qna_no;
	private String comment_content;
	private String comment_writer_name;
	private String member_id;
	private String comment_writer_pw;
	private String comment_date;
	
}

