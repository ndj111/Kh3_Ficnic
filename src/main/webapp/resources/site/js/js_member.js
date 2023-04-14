
/////////////////////////////////////////////////////
// 회원가입
/////////////////////////////////////////////////////


    //모든 공백 체크 정규식
    var empJ = /\s/g;
    //아이디 정규식
    var idJ = /^[a-z0-9]{6,12}$/;
    //비밀번호 정규식
    var pwJ = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
    //이메일 검사 정규식
    var mailJ = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
    //휴대폰 번호 정규식
    var phoneJ = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;
    


    
        $(function(){
  		  let ajaxTxt_j = "";

            $(".join_id").keyup(function(){
                let userId = $(this).val();
                
                 if($.trim(userId).length < 6){
                     $(".join_id_check").html("<span style=\"color:red\">아이디는 6글자 이상이어야 합니다.</span>");
                     return false;
                 } 
                 
                // 아이디 중복
                $.ajax({
                    type : "post",
                    contentType : "application/x-www-form-urlencoded;charset=UTF-8",
                    datatype : "html",
                    url : "memberIdCheck.do",
                    data : { paramId : userId },
        
                    success : function(data){
                        if(data > 0){
                            ajaxTxt_j = "<span style=\"color:red\">이미 사용중인 아이디입니다.</span>";
                            $("input[name='idchk_join']").val("false");
                        }else{
                            ajaxTxt_j = "<span style=\"color:blue\">Good.</span>";
                             $("input[name='idchk_join']").val("true");
                        }
                        $(".join_id_check").html(ajaxTxt_j);
                    },
        
                    error : function(e){
                        alert("Error : " + e.status);
                        $("input[name='idchk_join']").val("N");
                    }
                });
            });	

});
				 $(function(){
				  let ajaxTxt_j = "";
                // 이메일 정규표현식
                $(".join_email").keyup(function(){
                let userEmail = $(this).val();
            
                if(!mailJ.test($(this).val())) {
                    $(".join_mail_check").html("<span style=\"color:red\">이메일을 확인해주세요. :)</span>");
                    return false;
                    }
        
           
             // 이메일 중복
            $.ajax({
                type : "post",
                contentType : "application/x-www-form-urlencoded;charset=UTF-8",
                datatype : "html",
                url : "memberMailCheck.do",
                data : { paramEmail : userEmail },
    
                success : function(data){
                    if(data > 0){
                        ajaxTxt_j = "<span style=\"color:red\">이미 존재하는 이메일 주소입니다.</span>";
                        $("input[name='mailchk_join']").val("false");
                    }else{
                        ajaxTxt_j = "<span style=\"color:blue\">Good.</span>";
                         $("input[name='mailchk_join']").val("true");
                    }
                    $(".join_mail_check").html(ajaxTxt_j);
                },
    
                error : function(e){
                    alert("Error : " + e.status);
                    $("input[name='mailchk_join']").val("N");
                }
            });
        });

	

        // 비밀번호
        $('.join_pw').keyup(function(){
            if(pwJ.test($(this).val())){
                ajaxTxt_j = "<span style=\"color:blue\">Good.</span>";
            } else {
                ajaxTxt_j = "<span style=\"color:red\">비밀번호를 확인해주세요 :)</span>";
            }
            $(".join_pw_check").html(ajaxTxt_j);
        });
    
    
        // 비밀번호 확인 ***********일치하나 확인**********
        $('.join_pw_re').keyup(function(){
            if($('.join_pw').val() == ($('.join_pw_re').val())) {
                ajaxTxt_j = "<span style=\"color:blue\">일치합니다.</span>";
            } else {
                ajaxTxt_j = "<span style=\"color:red\">일치하는 번호를 적어주세요 :)</span>";
            }
            $(".join_pw_re_check").html(ajaxTxt_j);
        });
    

            // 연락처
            $(".join_phone").keyup(function() {
                if (phoneJ.test($(this).val())) {
                    ajaxTxt_j = "<span style=\"color:blue\">Good.</span>";
                } else {
                    ajaxTxt_j = "<span style=\"color:red\">번호를 다시 확인해주세요 :)</span>";
                }
                $(".join_phone_check").html(ajaxTxt_j);
        }); 
        
    });
    