package com.kh3.model.member;

import com.kh3.model.ficnic.FicnicDTO;

import lombok.Data;

@Data
public class WishDTO {

	private int wish_no;
	private int ficnic_no;
	private String member_id;
	private String wish_date;
	private FicnicDTO ficnic_cont;
	
}
