<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>


<script type="text/javascript">
$("#header .navbar .nav-item:nth-child(3)").addClass("active");

var mailJ = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;

$(function(){
    // 아이디 중복여부 확인
	$("input[name='member_id']").keyup(function(){
        let userId = $(this).val();
		
        if($.trim(userId).length < 6){
            $("#idchk-txt").html("<span class=\"text-danger\">* 아이디는 6글자 이상이어야 합니다.</span>");
            return false;
        }

        $.ajax({
            type : "post",
            contentType : "application/x-www-form-urlencoded;charset=UTF-8",
            datatype : "html",
            url : "${path}/admin/member/memberIdCheck.do",
            data : { paramId : userId },

            success : function(data){
                let ajaxTxt = "";
                if(data > 0){
                    ajaxTxt = "<span class=\"text-danger\">* 이미 사용중인 아이디입니다.</span>";
                    $("input[name='idchk_join']").val("false");
                }else{
                    ajaxTxt = "<span class=\"text-primary\">* 사용 할 수 있는 아이디입니다.</span>";
                    $("input[name='idchk_join']").val("true");
                }
                $("#idchk-txt").html(ajaxTxt);
            },

            error : function(e){
                alert("Error : " + e.status);
                $("input[name='idchk_join']").val("N");
            }
        });
	});	
});


$(function(){
	// 이메일 정규표현식
	$("input[name='member_email']").keyup(function(){
        let userEmail = $(this).val();
        console.log(userEmail);
        
        if(!mailJ.test($(this).val())) {
             $("#mailchk-txt").html("<span style=\"color:red\">이메일을 확인해주세요. :)</span>");
             return false;
            }

       
 		// 이메일 중복
        $.ajax({
            type : "post",
            contentType : "application/x-www-form-urlencoded;charset=UTF-8",
            datatype : "html",
            url : "${path}/admin/member/memberMailCheck.do",
            data : { paramEmail : userEmail },

            success : function(data){
                if(data > 0){
                	ajaxTxt = "<span style=\"color:red\">이미 존재하는 이메일 주소입니다.</span>";
                    $("input[name='mailchk_join']").val("false");
                }else{
                	 ajaxTxt = "<span style=\"color:blue\">Good.</span>";
                     $("input[name='mailchk_join']").val("true");
                }
                $("#mailchk-txt").html(ajaxTxt);
            },

            error : function(e){
                alert("Error : " + e.status);
                $("input[name='mailchk_join']").val("N");
            }
        });
	});
});

</script>



<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>회원 등록</h2>
        <ol class="m-0 p-2">
            <li>회원 관리</li>
            <li><b>회원 등록</b></li>
        </ol>
    </div>
</div>




<form name="form_input" method="post" action="${path}/admin/member/memberWriteOk.do">

<div class="page-cont">
    <div class="row">
        <div class="col-lg mb-4">
            <div class="card input-form">
                <div class="card-body p-4">
                    <div class="row form my-4 view-limit">
                        <div class="form-group col mb-2">
                            <label>회원 유형</label>
                            <div class="btn-group mt-2" role="group" data-toggle="buttons">
                                <label class="btn btn-outline-secondary active">
                                    <input type="radio" name="member_type" value="user" checked="checked" /> 일반회원
                                </label>
                                <label class="btn btn-outline-secondary">
                                    <input type="radio" name="member_type" value="admin" /> 관리자
                                </label>
                            </div>
                        </div>
                        <div class="w-100 border-bottom"></div>
                        <div class="form-group col">
                            <label for="member_id">아이디</label>
                            <input type="text" name="member_id" id="member_id" class="form-control d-inline w-30" onkeydown="EngNumInput(this);" placeholder="6자 이상을 입력해주세요." required />
                            <div id="idchk-txt" class="d-inline ml-2" ></div>
                            <input type="hidden" name="idchk_join" value="false" />
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col mb-2">
                            <label for="member_pw">비밀번호</label>
                            <input type="password" name="member_pw" id="member_pw" class="form-control w-50" placeholder="8자 이상의 영문, 숫자, 특수문자 조합" required />
                        </div>
                        <div class="form-group col mb-2">
                            <label for="member_pw_re">비밀번호 확인</label>
                            <input type="password" name="member_pw_re" id="member_pw_re" class="form-control w-50" placeholder="다시 입력해주세요." required />
                        </div>


                        <div class="w-100 border-bottom"></div>

                        <div class="form-group col">
                            <label for="member_name">이름</label>
                            <input type="text" name="member_name" id="member_name" class="form-control w-30" placeholder="이름을 입력해주세요." required />
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col">
                            <label for="member_email">이메일</label>
                            <input type="text" name="member_email" id="member_email" class="form-control w-30" onkeydown="EmailInput(this);" placeholder="이메일을 입력해주세요." required />
                        	<div id="mailchk-txt" class="d-inline ml-2"></div>
							<input type="hidden" name="mailchk_join" value="false" />
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col">
                            <label for="member_phone">연락처</label>
                            <input type="text" name="member_phone" id="member_phone" maxlength="15" class="form-control w-30" onkeydown="NumSpInput(this);" placeholder="-을 포함한 전화번호를 입력해주세요." required />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>




<div class="d-flex mt-2 input-form-button">
    <div class="col-lg text-center">
        <a href="${path}/admin/member/member_list.do?search_type=${search_type}&search_name=${search_name}&search_id=${search_id}&search_email=${search_email}&search_phone=${search_phone}&page=${param.page}" class="btn btn-secondary btn-lg m-2"><i class="fa fa-bars"></i> 목록보기</a>
        <button type="submit" class="btn btn-primary btn-lg m-2"><i class="fa fa-pencil"></i> 등록하기</button>
    </div>
</div>
</form>




<%@ include file="../layout/layout_footer.jsp" %>