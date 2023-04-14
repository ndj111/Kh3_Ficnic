/////////////////////////////////////////////////////
// 상세 페이지
/////////////////////////////////////////////////////
$(function(){

    // 이미지 슬라이드
    if($(".ficnic-view .fv-top .fvt-photo .swiper-wrapper").length > 0){
        var photoSwiper = new Swiper(".ficnic-view .fv-top .fvt-photo", {
            effect: "fade",
            slidesPerView: 1,
            spaceBetween: 0,
            speed: 500,
            loop: true,
            touchEnabled: false,
            autoplay: {
                delay: 3000,
                disableOnInteraction: false,
            },
            pagination: {
                el: ".ficnic-view .fv-top .fvt-photo .swiper-pagination",
                type: "fraction"
            },
            navigation: {
                nextEl: '.ficnic-view .fv-top .fvt-photo .swiper-button-next',
                prevEl: '.ficnic-view .fv-top .fvt-photo .swiper-button-prev'
            }
        });
    }


    // 옵션 선택 타이틀 클릭
    $(".ficnic-view .fv-join .fvj-sel .fvjs-option .fvjso-btn").on("click", function(){
        if($(this).parent().hasClass("open")){
            $(this).parent().removeClass("open");
            $(this).find("i").removeClass("fa-angle-up").addClass("fa-angle-down");
        }else{
            $(".ficnic-view .fv-join .fvj-sel .fvjs-option.open").removeClass("open");
            $(this).parent().addClass("open");
            $(this).find("i").removeClass("fa-angle-down").addClass("fa-angle-up");
        }
    });


    // 옵션 선택 목록 클릭
    $(".ficnic-view .fv-join .fvj-sel .fvjs-option .fvjso-list li").on("click", function(){
        let select_type = $(this).attr("type");
        let select_title = $(this).find("strong").text();
        let select_price = RemoveComma($(this).find("span b").text());

        $(this).parent().parent().find(".fvjso-btn").html("<strong>" + select_title + "</strong><span><b>" + setComma(select_price) + "</b>원</span>");
        $(this).parent().parent().removeClass("open");

        if(select_title == "선택안함"){
            select_title = "";
        }
        $("input[name='reserv_ficnic_" + select_type + "_title']").val(select_title);
        $("input[name='reserv_ficnic_" + select_type + "_price']").val(select_price);


        // 총 합계가격
        let get_sale_price = Number($("input[name='reserv_ficnic_sale_price']").val());
        let get_option_price = Number($("input[name='reserv_ficnic_option_price']").val());
        let get_select_price = Number($("input[name='reserv_ficnic_select_price']").val());

        let setTotalPrice = 0;
        if(get_option_price > 0){
            setTotalPrice = get_option_price + get_select_price;
        }else{
            setTotalPrice = get_sale_price + get_select_price;
        }

        $(".ficnic-view .fv-join .fvj-sel .fvjs-done .fvjsd-price span b").text(setComma(setTotalPrice));
    });





    // 하단 유의사항 목록 클릭
    $(".ficnic-view .fv-tab ul li .fvt-tit").on("click", function(){
        if($(this).parent().hasClass("open")){
            $(this).parent().removeClass("open");
            $(this).find("i").removeClass("icon-arrow-up").addClass("icon-arrow-down");
        }else{
            $(".ficnic-view .fv-tab ul li.open").removeClass("open");
            $(this).parent().addClass("open");
            $(this).find("i").removeClass("icon-arrow-down").addClass("icon-arrow-up");
        }
    });



    // 상단으로 버튼 클릭
    if($(".ficnic-view .fv-top").length > 0){
        var chkOffsetPos = $(".ficnic-view .fv-top").height() / 2;

        $(window).scroll(function(){
            var winNowScroll = $(window).scrollTop();

            if(winNowScroll > chkOffsetPos){
                $("button.goto-top").addClass("show");
            }else{
                $("button.goto-top").removeClass("show");
            }
        });
    }
});




/////////////////////////////////////////////////////
// 상세정보 전체보기
/////////////////////////////////////////////////////
showFicnicCont = function() {
    $(".ficnic-view .fv-detail .fvd-cont").addClass("show");
    $(".ficnic-view .fv-detail .fvd-btn").hide();
}




/////////////////////////////////////////////////////
// 참여하기 버튼
/////////////////////////////////////////////////////
showFicnicJoin = function() {
    $(".ficnic-view .fv-join .fvj-btn").toggle();
    $(".ficnic-view .fv-join .fvj-sel").toggle();
}




/////////////////////////////////////////////////////
// 피크닉 참여하기 폼 전송 체크
/////////////////////////////////////////////////////
chkReservJoin = function() {
    let form = $("form[name='reserv_form']");

    if($(".ficnic-view .fv-join .fvj-sel .fvjs-option").length > 0){
        let option_title = $(form).find("input[name='reserv_ficnic_option_title']");
        if(option_title.val() == ""){
            alert("[선택 옵션]을 선택해 주세요.");
            option_title.focus();
            return false;
        }
    }

    form.submit();
}



/////////////////////////////////////////////////////
// 피크닉 날짜 선택 달력
/////////////////////////////////////////////////////
$(document).ready(function(){
    $("#reserv_ficnic_date").datepicker({
        format: "yyyy-mm-dd",
        showRightIcon: false,
        iconsLibrary: "fontawesome"
    });
});




/////////////////////////////////////////////////////
// 쿠폰 다운로드
/////////////////////////////////////////////////////
downloadCoupon = function(path, coupon_no, sess_id) {

    // 회원 체크
    if(!sess_id || sess_id == null || sess_id == "undefined" || sess_id == ""){
        alert("회원 로그인 후 사용 하실 수 있습니다.");
        return false;
    }


    $.ajax({
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        type : "post",
        url : path + "/ficnic/download_coupon.do",
        data : {
            coupon_no : coupon_no,
            sess_id : sess_id
        },

        success : function(data) {
            if(data == "ok") {
                if(confirm("쿠폰이 발급되었습니다.\n지금 바로 확인하시겠습니까?")){
                    location.href = path + '/mypage/mypage_coupon_list.do';
                }

            }else if(data == "has") {
                alert("이미 발급 받은 쿠폰입니다.");

            }else if(data == "max") {
                alert("쿠폰 최대 다운로드 갯수를 초과하였습니다.");

            }else{
                alert("쿠폰 발급 중 에러가 발생하였습니다.");
            }
        },

        error : function(e){
            alert("Error : " + e.status);
        }
    });
}








/////////////////////////////////////////////////////
// 이미지 오버 시 확대
/////////////////////////////////////////////////////
$(document).ready(function() {
    var xOffset = 10;
    var yOffset = 30;

    // 마우스 오버 시
    $(document).on("mouseover",".thumbnail",function(e){
        //보여줄 이미지를 선언
        $("body").append("<p id='preview'><img src='"+ $(this).attr("src") +"' width='500px' /></p>");

        //미리보기 화면 설정 셋팅
        $("#preview").css({
            "top" : (e.pageY - xOffset) + "px",
            "left" : (e.pageX + yOffset) + "px"
        }).fadeIn("fast");
    });


    // 마우스 이동시
    $(document).on("mousemove",".thumbnail",function(e){
        $("#preview").css({
            "top" : (e.pageY - xOffset) + "px",
            "left" : (e.pageX + yOffset) + "px"
        });
    });


    // 마우스 아웃시
    $(document).on("mouseout",".thumbnail",function(){
        $("#preview").remove();
    });
});

