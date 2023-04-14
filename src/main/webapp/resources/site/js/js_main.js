/////////////////////////////////////////////////////
// 
/////////////////////////////////////////////////////
$(document).ready(function(){

    // 메인 비주얼
    var visualSwiper = new Swiper("#main-slide", {
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
            el: "#main-slide .swiper-pagination"
        },
        navigation: {
            nextEl: '#main-slide .swiper-button .swiper-button-next',
            prevEl: '#main-slide .swiper-button .swiper-button-prev',
        }
    });



    // 메인 기획전
    var exhibitionSwiper = new Swiper("#main-exhibition", {
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
            el: "#main-exhibition .swiper-pagination"
        },
        navigation: {
            nextEl: '#main-exhibition .swiper-button .swiper-button-next',
            prevEl: '#main-exhibition .swiper-button .swiper-button-prev',
        }
    });

});


