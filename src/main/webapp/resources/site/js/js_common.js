/////////////////////////////////////////////////////
// 페이지 로딩
/////////////////////////////////////////////////////
(function($){
    $(window).on("load", function(){
        $("#preloader").fadeOut("slow");
    });

    var angle = 0;
    setInterval(function(){
        $("#preloader img")
            .css('-webkit-transform', 'rotate(' + angle + 'deg)')
            .css('-moz-transform', 'rotate(' + angle + 'deg)')
            .css('-ms-transform', 'rotate(' + angle + 'deg)');
        angle++;
        angle++;
        angle++;
    }, 10);
})(jQuery);




/////////////////////////////////////////////////////
// 피크닉 찜하기 처리
/////////////////////////////////////////////////////
ficnicWish = function(btn, ficnic_no, sess_id, path) {

    // 회원 체크
    if(!sess_id || sess_id == null || sess_id == "undefined" || sess_id == ""){
        alert("회원 로그인 후 사용 하실 수 있습니다.");
        return false;
    }


    // 찜 되어 있는지 여부
    let wish_mode = "add";
    if($(btn).hasClass("on")) {
        wish_mode = "del";
    }


    $.ajax({
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        type : "post",
        url : path + "/mypage/wish_ok.do",
        data : {
            wish_mode : wish_mode,
            ficnic_no : ficnic_no,
            sess_id : sess_id
        },

        success : function(data) {
            let wish_btn = $(btn);
            let wish_ico = $(btn).find("i.fa");

            if(data.trim() == "add_ok") {
                wish_btn.addClass("on");
                wish_ico.removeClass("fa-heart-o").addClass("fa-heart");

            }else if(data.trim() == "del_ok") {
                wish_btn.removeClass("on");
                wish_ico.removeClass("fa-heart").addClass("fa-heart-o");

            }else{
                alert('처리중 오류가 발생하였습니다.');
            }
        },

        error : function(e){
            alert("Error : " + e.status);
        }
    });
}




//////////////////////////////////////////////////////////////////////////
// 위로이동
//////////////////////////////////////////////////////////////////////////
function gotoTop(){
    $("html, body").stop().animate({ scrollTop : 0 }, 50, "swing", function(){});
}


//////////////////////////////////////////////////////////////////////////
// 아래로이동
//////////////////////////////////////////////////////////////////////////
function gotoDown(){
    $("html, body").stop().animate({ scrollTop : $(document).height() }, 50, "swing", function(){});
}





/////////////////////////////////////////////////////
// 팝업창 띄우기
/////////////////////////////////////////////////////
popWindow = function(ps_url, ps_width, ps_height){
    var setLeft = ($(window).width() - ps_width) / 2;
    var setTop = ($(window).height() - ps_height) / 2;
    window.open(ps_url, "", "location=no,directories=no,resizable=no,status=no,toolbar=no,scrollbars=no,width="+ps_width+",height="+ps_height+",top="+setTop+",left="+setLeft)
}




/////////////////////////////////////////////////////
// 숫자만 입력
/////////////////////////////////////////////////////
function NumberInput(el){
    $(el).keyup(function(){
        $(this).val($(this).val().replace(/[^0-9]/g,""));
    });
}


/////////////////////////////////////////////////////
// 영문+숫자만 입력
/////////////////////////////////////////////////////
function EngNumInput(el){
    $(el).keyup(function(){
        $(this).val($(this).val().replace(/[ㄱ-힣~!@#$%^&*()_+|<>?:{}= ]/g,''));
    });
}


/////////////////////////////////////////////////////
// 숫자, - 만 입력
/////////////////////////////////////////////////////
function NumSpInput(el){
    $(el).keyup(function(){
        $(this).val($(this).val().replace(/[a-zA-Zㄱ-힣~!@#$%^&*()_+|<>?:{}= ]/g,''));
    });
}


/////////////////////////////////////////////////////
// 이메일 입력
/////////////////////////////////////////////////////
function EmailInput(el){
    $(el).keyup(function(){
        $(this).val($(this).val().replace(/[ㄱ-힣~!#$%^&*()+|<>?:;{}= ]/g,''));
    });
}




/////////////////////////////////////////////////////
// 천단위 콤마 추가
/////////////////////////////////////////////////////
function setComma(str){
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}


/////////////////////////////////////////////////////
// 천단위 콤마 제거
/////////////////////////////////////////////////////
function RemoveComma(str){
    str = String(str);
    return Number(str.replace(/[^\d]+/g, ''));
}




/////////////////////////////////////////////////////
// jQuery UI 달력
/////////////////////////////////////////////////////
$(document).ready(function(){
    var clareCalendar = {
        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        dayNamesMin: ['일','월','화','수','목','금','토'],
        weekHeader: 'Wk',
        dateFormat: 'yy-mm-dd', //형식
        autoSize: false, //오토리사이즈(body등 상위태그의 설정에 따른다)
        changeMonth: true, //월변경가능
        changeYear: true, //년변경가능
        showMonthAfterYear: true, //년 뒤에 월 표시
        buttonImageOnly: false, //이미지표시
        yearRange: '2022:2040' //2022년부터 2040년까지,
    };
    $("#startDt").datepicker(clareCalendar);
    $("#endDt").datepicker(clareCalendar);
    $("#datePick1").datepicker(clareCalendar);
    $("#datePick2").datepicker(clareCalendar);
    $("#datePick3").datepicker(clareCalendar);
    $("#datePick4").datepicker(clareCalendar);
    $("#datePick5").datepicker(clareCalendar);
    $("#datePick6").datepicker(clareCalendar);
    $("#datePick7").datepicker(clareCalendar);
    $("#datePick8").datepicker(clareCalendar);
    $("#datePick9").datepicker(clareCalendar);

    $("img.ui-datepicker-trigger").attr("style","margin-left:5px; vertical-align:middle; cursor:pointer;"); //이미지버튼 style적용
    $("#ui-datepicker-div").hide(); //자동으로 생성되는 div객체 숨김  
});




