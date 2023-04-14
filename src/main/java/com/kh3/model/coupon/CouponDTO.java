package com.kh3.model.coupon;

import lombok.Data;

@Data
public class CouponDTO {
	
	private int coupon_no;
	private String coupon_name;
	private String coupon_use_type;
	private String coupon_use_value;
	private int coupon_price;
	private String coupon_price_type;
	private int coupon_price_over;
	private int coupon_price_max;
	private String coupon_date_type;
	private int coupon_date_value;
	private String coupon_start_date;
	private String coupon_end_date;
	private int coupon_max_ea;
	private int coupon_down_ea;
	private int coupon_use_ea;
	private String coupon_date;
	// 카테고리 DB 저장 변수
	private String coupon_category_value;
	
}
