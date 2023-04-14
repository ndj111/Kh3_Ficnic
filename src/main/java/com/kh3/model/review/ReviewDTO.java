package com.kh3.model.review;

import lombok.Data;

@Data
public class ReviewDTO {
	
	private int review_no;
	private int ficnic_no;
	private int review_point;
	private String review_cont;
	private String review_photo1;
	private String review_photo2;
	private String member_id;
	private String review_pw;
	private String review_name;
	private String review_date;
	private String ficnic_name;

}
