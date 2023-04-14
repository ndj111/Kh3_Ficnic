/////////////////////////////////////////////////////
// 자주묻는 질문 목록 클릭
/////////////////////////////////////////////////////
$(function(){
    $(".board-faq .bf-list li .bfl-tit").on("click", function(){
        if($(this).parent().hasClass("open")){
            $(this).parent().removeClass("open");
        }else{
            $(".board-faq .bf-list li.open").removeClass("open");
            $(this).parent().addClass("open");
        }
    });
});





/////////////////////////////////////////////////////
// 댓글 작성
/////////////////////////////////////////////////////
addComment = function(form) {
    let form_name = $("form[name='"+form+"']");
    let form_bbs_id = form_name.find("input[name='bbs_id']");
    let form_write_name = form_name.find("input[name='bcomm_name']");
    let form_write_pw = form_name.find("input[name='bcomm_pw']");
    let form_write_cont = form_name.find("textarea[name='bcomm_cont']");

    if(form_write_name.val() == "") {
        alert("댓글 작성자 이름을 입력해주세요.");
        form_write_name.focus();
        return false;
    }

    if(form_write_pw.val() == "") {
        alert("댓글 작성 비밀번호를 입력해주세요.");
        form_write_pw.focus();
        return false;
    }

    if(form_write_cont.val() == "") {
        alert("댓글 내용을 입력해주세요.");
        form_write_cont.focus();
        return false;
    }

	let sess = $("input[name='sess']").val();
	let sess_id = $("input[name='bcomm_id']").val();

    $.ajax({
        type : "post",
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        url : "baord_comment_insert.do",
        datatype : "text",
        data : form_name.serialize(),

        success : function(data) {
            let epd_data = data.split("☆");
            if(epd_data[0] == "Y"){
            
                let addComment = "<li id=\"comment-"+epd_data[1]+"\" class=\"d-flex border-bottom py-3\">\n";
                    addComment += "\t<div class=\"vfcl-writer\">";
                    if(epd_data[5] == "admin"){
                        addComment += "<img src=\"../resources/site/images/admin_icon.png\" alt=\"\" /><b>관리자</b>";
                    }else{
                        addComment += epd_data[6];
                    }
                    addComment += "\t</div>\n";
                    addComment += "\t<div class=\"vfcl-body px-3\">"+epd_data[7].replaceAll('\r\n', '<br />')+"</div>\n";
                    addComment += "\t<div class=\"vfcl-date text-center\">\n";
                    addComment += "\t\t<p>"+epd_data[8].substr(0, 10)+"<br />"+epd_data[8].substr(11)+"</p>\n";
                   
                    if(sess == 'admin' || sess_id == epd_data[3] ){
                    	addComment += "\t\t<button type=\"button\" class=\"btn btn-sm btn-outline-danger py-0 mt-2\" onclick=\"delComment('nochk', '"+form_bbs_id.val()+"', "+epd_data[2]+", "+epd_data[1]+");\"><i class=\"icon-close mr-1\"></i> 삭제</button>\n";
                    }else{
                    	addComment += "\t\t<button type=\"button\" class=\"btn btn-sm btn-outline-danger py-0 mt-2\" onclick=\"setCommentDel('"+form_bbs_id.val()+"', "+epd_data[2]+", "+epd_data[1]+");\"><i class=\"icon-close mr-1\"></i> 삭제</button>\n";
                    }
                    
                    
                    addComment += "\t</div>\n";
                    addComment += "</li>\n";

                $(".view-form .vf-comment .vfc-list").append(addComment);

            }else{
                alert("댓글 등록 중 에러가 발생하였습니다.");
            }
           
           
           	if($("input[name='bcomm_id']").val() === undefined){
           		 $(form_write_name).val("");
           		 $(form_write_pw).val("");
			}
            
            $(form_write_cont).val("");
            
        },

        error : function(e) {
            alert("Error : "+e.status);
        }
    });

    return false;
}





/////////////////////////////////////////////////////
// 댓글 삭제
/////////////////////////////////////////////////////
delComment = function(btn_type, bbs_id, bdata_no, bcomm_no) {
    let bcomm_pw = "";

    if(confirm('이 댓글을 삭제하시겠습니까?')){
        if(btn_type == "check"){
            let get_pw = $("#commentModal input[type='password']");

            if(get_pw.val() == "") {
                alert("댓글 비밀번호를 입력해주세요.");
                get_pw.focus();
                return false;
            }

            bcomm_pw = get_pw.val();

            get_pw.val("");
            $("#commentModal button").attr("onclick", "");
        }


        $.ajax({
            type : "post",
            contentType : "application/x-www-form-urlencoded;charset=UTF-8",
            url : "baord_comment_delete.do",
            data : {
                    bbs_id : bbs_id,
                    bdata_no : bdata_no,
                    bcomm_no : bcomm_no,
                    bcomm_pw : bcomm_pw
            },

            success : function(data) {
                if(data == "Y"){
                    $("#comment-"+bcomm_no).animate({opacity: "0"}, function(){
                        $("#comment-" + bcomm_no).remove();
                        
                    });
                }else if(data == "PW"){
                    alert("댓글 비밀번호가 일치하지 않습니다.");
                }else{
                    alert("댓글 삭제 중 에러가 발생하였습니다.");
                }
            },

            error : function(e) {
                alert("Error : "+e.status);
            }
        });

        $("#commentModal").modal("hide");
    }
}


setCommentDel = function(bbs_id, bdata_no, bcomm_no) {
    $("#commentModal").modal("show");
    $("#commentModal input[type='password']").focus();
    $("#commentModal button").attr("onclick", "delComment('check', '"+bbs_id+"', '"+bdata_no+"', "+bcomm_no+")");
}






