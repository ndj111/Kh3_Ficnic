$(function() {

/////////////////////////////////////////////////////
// 문의 댓글 등록
/////////////////////////////////////////////////////
	// 댓글 등록
	$(".qnaWriteBtn").on("click", function() {
		if(!$("#comment_contentOk").val() || $("#comment_contentOk").val() == ""){
			alert("댓글 내용을 입력해 주세요.");
			$("#comment_contentOk").focus();
			return false;
		}

		let get_qna_no = $("#qna_no").val();
		let get_comment_content = $("#comment_contentOk").val();
		let get_comment_writer_name = $("#comment_writer_name").val();
		let get_comment_writer_pw = $("#comment_writer_pw").val();
		let get_member_id = $("#member_id").val();
		let listLength = $("#mComment-list td").length; 
		
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			datatype : "text",
			url : "mypage_qna_commentOk.do",
			data : {
					qna_no : get_qna_no,
					comment_content : get_comment_content,
					comment_writer_name : get_comment_writer_name,
					comment_writer_pw : get_comment_writer_pw,
					member_id : get_member_id
			},

			success : function(data) {
				if(listLength == 0) {
					$("#nodata").animate({opacity: "0"}, function(){
						$(this).remove();
					});	
				}
				if(data > 0){
				
					var today = new Date();
					var year = today.getFullYear();
					var month = ("0" + (today.getMonth() + 1)).slice(-2);
					var day = ("0" + today.getDate()).slice(-2);
					var hours = ("0" + today.getHours()).slice(-2); 
					var minutes = ("0" + today.getMinutes()).slice(-2);
					var seconds = ("0" + today.getSeconds()).slice(-2); 

					let new_comment = "<tr id=\"comment-"+data.trim()+"\">\n";
						new_comment += "\t<td>\n";
						new_comment += "\t\t<p><b>"+get_comment_writer_name+"</b></p>\n";
						new_comment += "\t</td>\n";
						new_comment += "\t<td class=\"text-left pl-4\">"+get_comment_content.replace("\n", "<br />")+"</td>\n";
						new_comment += "\t<td>\n";
						new_comment += "\t<p class=\"engnum\">"+year+"-"+month+"-"+day+"<br />"+hours+":"+minutes+":"+seconds+"</p>\n";"+get_comment_writer_name+"
						new_comment += "\t<button type=\"button\" class=\"btn btn-sm btn-outline-danger mt-1 px-1 py-0 qnaDeleteBtn\" name=\"comment_no\" value="+data+"><i class=\"fa fa-trash-o\"></i> 삭제</button>\n";
						new_comment += "\t</td>\n";
						new_comment += "</tr>\n";
					$("#mComment-list").append(new_comment);
					$("#comment_contentOk").val("");
					$("#comment_contentOk").focus();
				}else{
					alert("댓글 등록 중 에러가 발행하였습니다.");
				}
			},

			error : function(e) {
				alert("Error : "+e.status);
            }
        });
	});


/////////////////////////////////////////////////////
// 문의 댓글 삭제
/////////////////////////////////////////////////////
	$(document).on("click", ".qnaDeleteBtn", function(){
		if(!confirm("이 댓글을 삭제하시겠습니까?")){
			return false;
		}

		let comment_no = $(this).val();

		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			datatype : "text",
			url : "mypage_qna_comment_deleteOk.do",
			data : {
					comment_no : comment_no
			},

			success : function(data) {
				if(data > 0){
					$("#comment-"+comment_no).animate({opacity: "0"}, function(){
						$(this).remove();
					});
				}else{
					alert("댓글 삭제 중 에러가 발행하였습니다.");
				}
			},

			error : function(e) {
				alert("Error : "+e.status);
            }
		});
	});


/////////////////////////////////////////////////////
// 1대1문의 - 사진 삭제
/////////////////////////////////////////////////////
delQnaPhoto = function(btn, qna_no, img_num){
    if(confirm("이 사진을 삭제하시겠습니까?")){
    }else{
        return false;
    }

    $.ajax({
        type: "post",
        url : "qna_img_delete.do",
        data : {
                qna_no : qna_no,
                img_num : img_num
        },

        success: function(result){
            if(result != "N"){
                $("#qna_file"+img_num).remove();
                $(btn).remove();
            }else{
                alert("삭제 중 오류가 발생하였습니다.");
            }
        },

        error: function (xhr, textStatus, errorThrown){
            alert("Error : "+errorThrown);
        }
    });
}


});









