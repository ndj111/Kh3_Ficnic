


/////////////////////////////////////////////////////
// 결제 선택 폼 창 start
/////////////////////////////////////////////////////
$(function(){
	
	$("#ficnicPay_check").on("click",function(){
		$(".ficnic_pay_ficnicOtherpay").html("");
	});
	
	$(".ficnic_pay_modal").on("click",function(){
		
		
		
		var ficnic_pay_val = "";
		ficnic_pay_val  = $(this).val();
		
		if(ficnic_pay_val == "kakaopay"){
			ficnic_pay_val = "카카오 페이";
		}else if(ficnic_pay_val == "sampay"){
			ficnic_pay_val = "삼성 페이";
		}else if(ficnic_pay_val == "toss"){
			ficnic_pay_val = "토스";
		}else if(ficnic_pay_val == "bank"){
			ficnic_pay_val = "무통장 입금";
		}else if(ficnic_pay_val == "toss"){
			ficnic_pay_val = "";
		}else if(ficnic_pay_val == "naverpay"){
			ficnic_pay_val = "네이버 페이";
		}
		
		$(".ficnic_pay_ficnicOtherpay").html("<span class =\"mr-2\">"+ficnic_pay_val+"</span> <input type=\"hidden\" class=\"Form__Input-sc-1quypp7-1 dYnqqW\" value=\""+ficnic_pay_val+"\"> <input type=\"button\" class=\"btn btn-outline-dark\" value=\"변경\" data-bs-toggle=\"modal\" data-bs-target=\"#exampleModal\"/><input type=\"hidden\" value=\""+$(this).val()+"\" name=\"reserv_payment\"/>");
		
		
	});
	
	var price_over = 0;
	
	var memberPoint = $("#memberPoint").val();

	var SitePirceOrigin = $("#sitePriceView").html();
	
	let couponAfterPrice =0;
	
	
	$("input[name='canUsePoint']").on("blur",function(){
		
		var thisvalue = parseInt($("input[name='canUsePoint']").val().replace(/,/g , ''),10);
		
		if(memberPoint < thisvalue){
			$("input[name='canUsePoint']").val(memberPoint);
		}
		
		$("#sitePriceView").html(SitePirceOrigin);
		
		var changePoint = $("input[name='canUsePoint']").val();
		
	
		
		var origin_price = $("#orginPirceView").html();
		
		if(couponAfterPrice != 0){
			$("#sitePriceView").html(couponAfterPrice);
		}
		
		$("#sitePriceView").html($("#sitePriceView").html()-changePoint);
		$("input[name='reserv_total_price']").val($("#sitePriceView").html());
		
		
		
		couponAfterPrice = 0;
		
	});
	
	
	

	$("#ficnicCouponSelect").on("change",function(){
			// 쿠폰 조회
                $.ajax({
                    type : "post",
                    contentType : "application/x-www-form-urlencoded;charset=UTF-8",
                    url : "ficnicCouponSelect.do",
                    data : { coupon_no : $("#ficnicCouponSelect").val() },
        
                    success : function(data){
                    	var origin_price = $("#orginPirceView").html();
						$("#sitePriceView").html(origin_price);
						
						//변수 설정
						var price_type = data.price_type;
						price_over = data.price_over;
						var price_max = data.price_max;
						
						var date_type = data.date_type;
						var date_value = data.date_value;
						var start_date = data.start_date;
						var end_date = data.end_date;
						var coupon_price = data.coupon_price;
						var coupon_date = data.coupon_date;
						
						
						
						//가격 설정
						$("input[name='price_type']").val(price_type);
						$("input[name='price_over']").val(price_over);
						$("input[name='price_max']").val(price_max);
						$("input[name='coupon_price']").val(coupon_price);
						
						//기간 설정
						$("input[name='date_type']").val(date_type);
						$("input[name='date_value']").val(date_value);
						$("input[name='start_date']").val(start_date);
						$("input[name='end_date']").val(end_date);
						
						//날짜 설정
						
						var date = new Date(coupon_date);
						
						var current_date = new Date();
						
						var canuse = true;
						
						
						if(date_type == 'after'){
						 	
						 	date.setDate(date.getDate() + date_value);
						 	
						 	if(current_date <= date){
						 		canuse = true;
						 	}else{
						 		canuse = false;
						 	}
						}
						
						if(date_type == 'date'){
						 	
						 	var start_date = new Date(start_date);
						 	
						 	var end_date = new Date(end_date);
						 	
						 	if( start_date <= current_date <=end_date){
						 		canuse = true;
						 	}else{
						 		canuse = false;
						 	}
						 	
						}
						
						
						if(canuse){
							
							if(price_type == "price" ){
								var priceview= parseInt($("#sitePriceView").html().replace(/,/g , ''),10);
								var saleMax = coupon_price;
								
								if(saleMax > price_max){
									saleMax = price_max;
								}
							
								
							}else{
								var priceview= parseInt($("#sitePriceView").html().replace(/,/g , ''),10);
								var saleMax = priceview*(coupon_price/100);
								if(saleMax > price_max){
									saleMax = price_max;
								}
	
							}
													
							couponAfterPrice = priceview - saleMax - parseInt($("input[name='canUsePoint']").val());
	
							if(couponAfterPrice > price_over){
								$("#sitePriceView").html(couponAfterPrice );
								$("input[name='reserv_total_price']").val(couponAfterPrice);
								
							}else{
								alert('최소 결제 금액보다 낮아서 사용하실 수 없습니다.');
								$('#ficnicCouponSelect').val("").prop("selected",true);
								$("#sitePriceView").html(SitePirceOrigin);
								 $("input[name='canUsePoint']").val(0);
							}
						
						}else{
						 		alert('기간이 끝난 쿠폰입니다.');
								$('#ficnicCouponSelect').val("").prop("selected",true);
								$("#sitePriceView").html(SitePirceOrigin);
								$("input[name='canUsePoint']").val(0);
						}
						
                    },
        
                    error : function(e){
                        alert("선택된 쿠폰이 없습니다.");              
						$("#sitePriceView").html(SitePirceOrigin);
                       $("input[name='canUsePoint']").val(0);
                    }
                });
      });	


});



