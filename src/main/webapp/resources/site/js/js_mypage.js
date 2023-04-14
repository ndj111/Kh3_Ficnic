	
	$(function(){
		
		$(".btn-js").on("click",function(){  
			$("#review_con").html("");
			$("#ori_review_photo1").attr("src","");
			$("#ori_review_photo2").attr("src","");
			
			var name = $(this).data('name')+"후기 작성";
			var no = $(this).data('no');
			var path = "/ficnic";
			$("#exampleModalLabel").html(name);
			$("input[name=ficnic_no]").val(no);
			if($(this).data('modi') != null){
				$("#review_con").html($(this).data('cont'));
				$("#mypage-form-div").attr("action","mypage_review_modify.do");
				$("#ori_review_photo1").attr("src",path+$(this).data('photo1'));
				$("#ori_review_photo2").attr("src",path+$(this).data('photo2'));
				$("#mypage-reserv-rno").val($(this).data("rno"));
				$("#mypage-reserv-subtn").val("수정 하기");
			}else{
				$("#mypage-form-div").attr("action","mypage_review_write.do");
			}
		});
	});
	
	
	
	
	

	
	





