package com.kh3.model.member;

import java.util.List;

import com.kh3.model.coupon.CouponDTO;

import lombok.Data;

@Data
public class McouponDTO {
	
	private int mcoupon_no;
	private int coupon_no;
	private String reserv_sess;
	private String member_id;
	private int mcoupon_use_price;
	private String mcoupon_start_date;
	private String mcoupon_end_date;
	private String mcoupon_use_date;
	private String mcoupon_date;
	private String coupon_name;
	private List<CouponDTO> coupon_list;
}
