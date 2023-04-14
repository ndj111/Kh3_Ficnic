<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="layout/layout_header.jsp" %>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/swiper.min.css" />
<script language="javascript" src="${path}/resources/site/js/swiper.min.js"></script>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_main.css?${time}" />
<script language="javascript" src="${path}/resources/site/js/js_main.js?${time}"></script>



<div class="contents w1100 main-page">

    <!-- #main-slide //메인 슬라이드 START -->
    <section id="main-slide">
        <div class="swiper-pagination"></div>
        <div class="swiper-button">
            <button class="swiper-button-prev"><i class="icon-arrow-left"></i></button>
            <button class="swiper-button-next"><i class="icon-arrow-right"></i></button>
        </div>
        <ul class="swiper-wrapper">
            <li class="swiper-slide"><a href="${path}/ficnic/ficnic_list.do?category=24000000"><img src="${path}/resources/site/images/main_slide_1.jpg" alt="" /></a></li>
            <li class="swiper-slide"><a href="${path}/ficnic/ficnic_list.do?category=25000000"><img src="${path}/resources/site/images/main_slide_2.jpg" alt="" /></a></li>
            <li class="swiper-slide"><a href="${path}/ficnic/ficnic_list.do?category=26000000"><img src="${path}/resources/site/images/main_slide_3.jpg" alt="" /></a></li>
            <li class="swiper-slide"><a href="${path}/ficnic/ficnic_list.do?category=23000000"><img src="${path}/resources/site/images/main_slide_4.jpg" alt="" /></a></li>
        </ul>
    </section>
    <!-- #main-slide //메인 슬라이드 START -->





    <!-- #main-icon //메인 아이콘 START -->
    <section id="main-icon">
        <ul>
            <li><a href="${path}/ficnic/ficnic_rank.do"><p><img src="${path}/resources/site/images/main_icon_01.png" alt="" /></p>실시간랭킹</a></li>
            <li><a href="${path}/ficnic/ficnic_new.do"><p><img src="${path}/resources/site/images/main_icon_02.png" alt="" /></p>신규피크닉</a></li>
            <li><a href="${path}/ficnic/ficnic_list.do?category=06040000"><p><img src="${path}/resources/site/images/main_icon_03.png" alt="" /></p>도전!댄스</a></li>
            <li><a href="${path}/ficnic/ficnic_list.do?category=09000000"><p><img src="${path}/resources/site/images/main_icon_04.png" alt="" /></p>헤메코</a></li>
            <li><a href="${path}/ficnic/ficnic_list.do?category=01000000"><p><img src="${path}/resources/site/images/main_icon_05.png" alt="" /></p>일상탈출</a></li>
            <li><a href="${path}/ficnic/ficnic_list.do?category=07020000"><p><img src="${path}/resources/site/images/main_icon_06.png" alt="" /></p>N잡러</a></li>
            <li><a href="${path}/ficnic/ficnic_list.do?category=12010000"><p><img src="${path}/resources/site/images/main_icon_07.png" alt="" /></p>사주/타로</a></li>
            <li><a href="${path}/ficnic/ficnic_list.do?category=03090000"><p><img src="${path}/resources/site/images/main_icon_08.png" alt="" /></p>액세서리</a></li>
            <li><a href="${path}/ficnic/ficnic_list.do?category=05000000"><p><img src="${path}/resources/site/images/main_icon_09.png" alt="" /></p>쿠킹/베이킹</a></li>
            <li><a href="${path}/ficnic/ficnic_list.do?category=07060000"><p><img src="${path}/resources/site/images/main_icon_10.png" alt="" /></p>외국어</a></li>
        </ul>
    </section>
    <!-- #main-icon //메인 아이콘 START -->





    <c:if test="${!empty flist1}">
    <!-- #main-recommend //메인 추천 START -->
    <section id="main-recommend">
        <h4>이런 피크닉은 어때요? <a href="${path}/ficnic/ficnic_list.do?category=16000000">전체보기</a></h4>

        <ul class="ficnic-list">
            <c:forEach items="${flist1}" var="dto">
                <li>
                    <button type="button" onclick="ficnicWish(this, ${dto.getFicnic_no()}, '${sess_id}', '${path}');"<c:if test="${dto.getFicnic_wish() > 0}"> class="on"</c:if>><i class="fa fa-heart<c:if test="${dto.getFicnic_wish() eq 0}">-o</c:if>"></i></button>
                    <a href="${path}/ficnic/ficnic_view.do?category=${dto.getFicnic_category_no()}&ficnic_no=${dto.getFicnic_no()}">
                        <div class="fl-photo">
                            <c:choose>
                                <c:when test="${!empty dto.getFicnic_photo1()}"><img src="${path}${dto.getFicnic_photo1()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></c:when>
                                <c:when test="${!empty dto.getFicnic_photo2()}"><img src="${path}${dto.getFicnic_photo2()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></c:when>
                                <c:when test="${!empty dto.getFicnic_photo3()}"><img src="${path}${dto.getFicnic_photo3()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></c:when>
                                <c:when test="${!empty dto.getFicnic_photo4()}"><img src="${path}${dto.getFicnic_photo4()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></c:when>
                                <c:when test="${!empty dto.getFicnic_photo5()}"><img src="${path}${dto.getFicnic_photo5()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></c:when>
                                <c:otherwise><img src="${path}/resources/site/images/noimg.gif" alt="" /></c:otherwise>
                            </c:choose>
                        </div>


                        <div class="fl-info">
                            <div class="fli-location">${dto.getFicnic_location()}</div>

                            <div class="fli-name">${dto.getFicnic_name()}</div>

                            <c:if test="${dto.getFicnic_review_count() > 0}">
                            <div class="fli-review">
                                <span>
                                    <c:choose>
                                        <c:when test="${dto.getFicnic_review_point() > 0 and dto.getFicnic_review_point() <= 2}"><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:when>
                                        <c:when test="${dto.getFicnic_review_point() > 2 and dto.getFicnic_review_point() <= 4}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:when>
                                        <c:when test="${dto.getFicnic_review_point() > 4 and dto.getFicnic_review_point() <= 6}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:when>
                                        <c:when test="${dto.getFicnic_review_point() > 6 and dto.getFicnic_review_point() <= 8}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i></c:when>
                                        <c:when test="${dto.getFicnic_review_point() > 8}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i></c:when>
                                    </c:choose>
                                </span>
                                후기 <fmt:formatNumber value="${dto.getFicnic_review_count()}" />
                            </div>
                            </c:if>

                            <div class="fli-price">
                                <c:if test="${dto.getFicnic_market_price() > 0}"><p class="prev">${dto.getFicnic_market_price()}원</p></c:if>
                                <p class="sale">
                                    <c:if test="${dto.getFicnic_market_price() > 0}"><span><fmt:formatNumber value="${1 - dto.getFicnic_sale_price() / dto.getFicnic_market_price()}" type="percent" /></span></c:if>
                                    <fmt:formatNumber value="${dto.getFicnic_sale_price()}" />원
                                </p>
                            </div>
                        </div>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </section>
    <!-- #main-recommend //메인 추천 START -->
    </c:if>





    <!-- #main-banner //메인 배너 START -->
    <section id="main-banner">
        <a href="${path}/ficnic/ficnic_view.do?category=02010000&ficnic_no=89"><img src="${path}/resources/site/images/main_banner.jpg" alt="" /></a>
    </section>
    <!-- #main-banner //메인 배너 START -->





    <c:if test="${!empty flist2}">
    <!-- #main-hot //메인 인기 START -->
    <section id="main-hot">
        <h4>인기 급상승🚀 <a href="${path}/ficnic/ficnic_list.do?category=17000000">전체보기</a></h4>

        <ul class="ficnic-list">
            <c:forEach items="${flist2}" var="dto">
                <li>
                    <button type="button" onclick="ficnicWish(this, ${dto.getFicnic_no()}, '${sess_id}', '${path}');"<c:if test="${dto.getFicnic_wish() > 0}"> class="on"</c:if>><i class="fa fa-heart<c:if test="${dto.getFicnic_wish() eq 0}">-o</c:if>"></i></button>
                    <a href="${path}/ficnic/ficnic_view.do?category=${dto.getFicnic_category_no()}&ficnic_no=${dto.getFicnic_no()}">
                        <div class="fl-photo">
                            <c:choose>
                                <c:when test="${!empty dto.getFicnic_photo1()}"><img src="${path}${dto.getFicnic_photo1()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></c:when>
                                <c:when test="${!empty dto.getFicnic_photo2()}"><img src="${path}${dto.getFicnic_photo2()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></c:when>
                                <c:when test="${!empty dto.getFicnic_photo3()}"><img src="${path}${dto.getFicnic_photo3()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></c:when>
                                <c:when test="${!empty dto.getFicnic_photo4()}"><img src="${path}${dto.getFicnic_photo4()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></c:when>
                                <c:when test="${!empty dto.getFicnic_photo5()}"><img src="${path}${dto.getFicnic_photo5()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></c:when>
                                <c:otherwise><img src="${path}/resources/site/images/noimg.gif" alt="" /></c:otherwise>
                            </c:choose>
                        </div>


                        <div class="fl-info">
                            <div class="fli-location">${dto.getFicnic_location()}</div>

                            <div class="fli-name">${dto.getFicnic_name()}</div>

                            <c:if test="${dto.getFicnic_review_count() > 0}">
                            <div class="fli-review">
                                <span>
                                    <c:choose>
                                        <c:when test="${dto.getFicnic_review_point() > 0 and dto.getFicnic_review_point() <= 2}"><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:when>
                                        <c:when test="${dto.getFicnic_review_point() > 2 and dto.getFicnic_review_point() <= 4}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:when>
                                        <c:when test="${dto.getFicnic_review_point() > 4 and dto.getFicnic_review_point() <= 6}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:when>
                                        <c:when test="${dto.getFicnic_review_point() > 6 and dto.getFicnic_review_point() <= 8}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i></c:when>
                                        <c:when test="${dto.getFicnic_review_point() > 8}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i></c:when>
                                    </c:choose>
                                </span>
                                후기 <fmt:formatNumber value="${dto.getFicnic_review_count()}" />
                            </div>
                            </c:if>

                            <div class="fli-price">
                                <c:if test="${dto.getFicnic_market_price() > 0}"><p class="prev">${dto.getFicnic_market_price()}원</p></c:if>
                                <p class="sale">
                                    <c:if test="${dto.getFicnic_market_price() > 0}"><span><fmt:formatNumber value="${1 - dto.getFicnic_sale_price() / dto.getFicnic_market_price()}" type="percent" /></span></c:if>
                                    <fmt:formatNumber value="${dto.getFicnic_sale_price()}" />원
                                </p>
                            </div>
                        </div>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </section>
    <!-- #main-hot //메인 인기 START -->
    </c:if>





    <!-- #main-exhibition //메인 기획전 START -->
    <section id="main-exhibition">
        <div class="swiper-pagination"></div>
        <div class="swiper-button">
            <button class="swiper-button-prev"><i class="icon-arrow-left"></i></button>
            <button class="swiper-button-next"><i class="icon-arrow-right"></i></button>
        </div>
        <ul class="swiper-wrapper">
            <li class="swiper-slide"><a href="${path}/ficnic/ficnic_list.do?category=20000000"><img src="${path}/resources/site/images/exhibition_slide_1.jpg" alt="" /></a></li>
            <li class="swiper-slide"><a href="${path}/ficnic/ficnic_list.do?category=21000000"><img src="${path}/resources/site/images/exhibition_slide_2.jpg" alt="" /></a></li>
            <li class="swiper-slide"><a href="${path}/ficnic/ficnic_list.do?category=22000000"><img src="${path}/resources/site/images/exhibition_slide_3.jpg" alt="" /></a></li>
        </ul>
    </section>
    <!-- #main-exhibition //메인 기획전 START -->





    <c:if test="${!empty flist3}">
    <!-- #main-winter //메인 겨울나기 START -->
    <section id="main-winter">
        <h4>따뜻하고🧶 뜨거운💪🏻 겨울나기 <a href="${path}/ficnic/ficnic_list.do?category=18000000">전체보기</a></h4>

        <ul class="ficnic-list">
            <c:forEach items="${flist3}" var="dto">
                <li>
                    <button type="button" onclick="ficnicWish(this, ${dto.getFicnic_no()}, '${sess_id}', '${path}');"<c:if test="${dto.getFicnic_wish() > 0}"> class="on"</c:if>><i class="fa fa-heart<c:if test="${dto.getFicnic_wish() eq 0}">-o</c:if>"></i></button>
                    <a href="${path}/ficnic/ficnic_view.do?category=${dto.getFicnic_category_no()}&ficnic_no=${dto.getFicnic_no()}">
                        <div class="fl-photo">
                            <c:choose>
                                <c:when test="${!empty dto.getFicnic_photo1()}"><img src="${path}${dto.getFicnic_photo1()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></c:when>
                                <c:when test="${!empty dto.getFicnic_photo2()}"><img src="${path}${dto.getFicnic_photo2()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></c:when>
                                <c:when test="${!empty dto.getFicnic_photo3()}"><img src="${path}${dto.getFicnic_photo3()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></c:when>
                                <c:when test="${!empty dto.getFicnic_photo4()}"><img src="${path}${dto.getFicnic_photo4()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></c:when>
                                <c:when test="${!empty dto.getFicnic_photo5()}"><img src="${path}${dto.getFicnic_photo5()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></c:when>
                                <c:otherwise><img src="${path}/resources/site/images/noimg.gif" alt="" /></c:otherwise>
                            </c:choose>
                        </div>


                        <div class="fl-info">
                            <div class="fli-location">${dto.getFicnic_location()}</div>

                            <div class="fli-name">${dto.getFicnic_name()}</div>

                            <c:if test="${dto.getFicnic_review_count() > 0}">
                            <div class="fli-review">
                                <span>
                                    <c:choose>
                                        <c:when test="${dto.getFicnic_review_point() > 0 and dto.getFicnic_review_point() <= 2}"><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:when>
                                        <c:when test="${dto.getFicnic_review_point() > 2 and dto.getFicnic_review_point() <= 4}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:when>
                                        <c:when test="${dto.getFicnic_review_point() > 4 and dto.getFicnic_review_point() <= 6}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:when>
                                        <c:when test="${dto.getFicnic_review_point() > 6 and dto.getFicnic_review_point() <= 8}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i></c:when>
                                        <c:when test="${dto.getFicnic_review_point() > 8}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i></c:when>
                                    </c:choose>
                                </span>
                                후기 <fmt:formatNumber value="${dto.getFicnic_review_count()}" />
                            </div>
                            </c:if>

                            <div class="fli-price">
                                <c:if test="${dto.getFicnic_market_price() > 0}"><p class="prev">${dto.getFicnic_market_price()}원</p></c:if>
                                <p class="sale">
                                    <c:if test="${dto.getFicnic_market_price() > 0}"><span><fmt:formatNumber value="${1 - dto.getFicnic_sale_price() / dto.getFicnic_market_price()}" type="percent" /></span></c:if>
                                    <fmt:formatNumber value="${dto.getFicnic_sale_price()}" />원
                                </p>
                            </div>
                        </div>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </section>
    <!-- #main-winter //메인 겨울나기 START -->
    </c:if>





    <c:if test="${!empty eventList}">
    <!-- #main-event //메인 이벤트 START -->
    <section id="main-event">
        <h4>이벤트 <a href="${path}/board/board_list.do?bbs_id=event">전체보기</a></h4>
        <ul>
            <c:forEach var="event" items="${eventList}" end="2">
                <li>
                    <a href="${path}/board/board_view.do?bbs_id=event&bdata_no=${event.getBdata_no()}">
                        <p class="photo"><img src="${path}${event.getBdata_file1()}" alt="" /></p>
                        <p class="title">${event.getBdata_title()}</p>
                        <p class="sub">${event.getBdata_sub()}</p>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </section>
    <!-- #main-event //메인 이벤트 START -->
    </c:if>





    <c:if test="${!empty flist4}">
    <!-- #main-quite //메인 조용히 START -->
    <section id="main-quite">
        <h4>조용히 나를 돌아보는 시간🌿 <a href="${path}/ficnic/ficnic_list.do?category=19000000">전체보기</a></h4>

        <ul class="ficnic-list">
            <c:forEach items="${flist4}" var="dto">
                <li>
                    <button type="button" onclick="ficnicWish(this, ${dto.getFicnic_no()}, '${sess_id}', '${path}');"<c:if test="${dto.getFicnic_wish() > 0}"> class="on"</c:if>><i class="fa fa-heart<c:if test="${dto.getFicnic_wish() eq 0}">-o</c:if>"></i></button>
                    <a href="${path}/ficnic/ficnic_view.do?category=${dto.getFicnic_category_no()}&ficnic_no=${dto.getFicnic_no()}">
                        <div class="fl-photo">
                            <c:choose>
                                <c:when test="${!empty dto.getFicnic_photo1()}"><img src="${path}${dto.getFicnic_photo1()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></c:when>
                                <c:when test="${!empty dto.getFicnic_photo2()}"><img src="${path}${dto.getFicnic_photo2()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></c:when>
                                <c:when test="${!empty dto.getFicnic_photo3()}"><img src="${path}${dto.getFicnic_photo3()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></c:when>
                                <c:when test="${!empty dto.getFicnic_photo4()}"><img src="${path}${dto.getFicnic_photo4()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></c:when>
                                <c:when test="${!empty dto.getFicnic_photo5()}"><img src="${path}${dto.getFicnic_photo5()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></c:when>
                                <c:otherwise><img src="${path}/resources/site/images/noimg.gif" alt="" /></c:otherwise>
                            </c:choose>
                        </div>


                        <div class="fl-info">
                            <div class="fli-location">${dto.getFicnic_location()}</div>

                            <div class="fli-name">${dto.getFicnic_name()}</div>

                            <c:if test="${dto.getFicnic_review_count() > 0}">
                            <div class="fli-review">
                                <span>
                                    <c:choose>
                                        <c:when test="${dto.getFicnic_review_point() > 0 and dto.getFicnic_review_point() <= 2}"><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:when>
                                        <c:when test="${dto.getFicnic_review_point() > 2 and dto.getFicnic_review_point() <= 4}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:when>
                                        <c:when test="${dto.getFicnic_review_point() > 4 and dto.getFicnic_review_point() <= 6}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:when>
                                        <c:when test="${dto.getFicnic_review_point() > 6 and dto.getFicnic_review_point() <= 8}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i></c:when>
                                        <c:when test="${dto.getFicnic_review_point() > 8}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i></c:when>
                                    </c:choose>
                                </span>
                                후기 <fmt:formatNumber value="${dto.getFicnic_review_count()}" />
                            </div>
                            </c:if>

                            <div class="fli-price">
                                <c:if test="${dto.getFicnic_market_price() > 0}"><p class="prev">${dto.getFicnic_market_price()}원</p></c:if>
                                <p class="sale">
                                    <c:if test="${dto.getFicnic_market_price() > 0}"><span><fmt:formatNumber value="${1 - dto.getFicnic_sale_price() / dto.getFicnic_market_price()}" type="percent" /></span></c:if>
                                    <fmt:formatNumber value="${dto.getFicnic_sale_price()}" />원
                                </p>
                            </div>
                        </div>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </section>
    <!-- #main-quite //메인 조용히 START -->
    </c:if>

</div>



<%@ include file="layout/layout_footer.jsp" %>