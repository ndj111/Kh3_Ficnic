<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/swiper.min.css" />
<script language="javascript" src="${path}/resources/site/js/swiper.min.js"></script>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_ficnic.css?${time}" />
<script language="javascript" src="${path}/resources/site/js/js_ficnic.js?${time}"></script>

<c:if test="${dto.getFicnic_date_use() eq 'Y'}">
<script src="${path}/resources/site/js/gijgo.min.js" type="text/javascript"></script>
<link href="${path}/resources/site/css/gijgo.min.css" rel="stylesheet" type="text/css" />
</c:if>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=05baaf0de0478dc909d89f4fbc30dcd1&libraries=services,clusterer,drawing" ></script>

<style>#footer { padding-bottom: 100px; }</style>



<div class="page-info w1100">
    <h2>${category_name}</h2>
    <ol>
        <li><a href="${path}/"><i class="icon-home"></i> HOME</a></li>
        <li>피크닉</li>
        <li><b>${category_name}</b></li>
    </ol>
</div>





<div class="contents w1100 ficnic-view">

	<!-- .fv-top //START -->
	<div class="fv-top">
		<div class="fvt-photo">
            <c:choose>
                <c:when test="${!empty dto.getFicnic_photo1() or !empty dto.getFicnic_photo2() or !empty dto.getFicnic_photo3() or !empty dto.getFicnic_photo4() or !empty dto.getFicnic_photo5()}">
                    <div class="swiper-pagination"></div>
                    <div class="swiper-button">
                    	<button class="swiper-button-prev"><i class="icon-arrow-left"></i></button>
                    	<button class="swiper-button-next"><i class="icon-arrow-right"></i></button>
                    </div>
                    <ul class="swiper-wrapper">
                        <c:if test="${!empty dto.getFicnic_photo1()}"><li class="swiper-slide"><img src="${path}${dto.getFicnic_photo1()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></li></c:if>
                        <c:if test="${!empty dto.getFicnic_photo2()}"><li class="swiper-slide"><img src="${path}${dto.getFicnic_photo2()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></li></c:if>
                        <c:if test="${!empty dto.getFicnic_photo3()}"><li class="swiper-slide"><img src="${path}${dto.getFicnic_photo3()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></li></c:if>
                        <c:if test="${!empty dto.getFicnic_photo4()}"><li class="swiper-slide"><img src="${path}${dto.getFicnic_photo4()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></li></c:if>
                        <c:if test="${!empty dto.getFicnic_photo5()}"><li class="swiper-slide"><img src="${path}${dto.getFicnic_photo5()}" onerror="this.src='${path}/resources/site/images/noimg.gif';" alt="" /></li></c:if>
                    </ul>
                </c:when>
                <c:otherwise><img src="${path}/resources/site/images/noimg.gif" alt="" /></c:otherwise>
            </c:choose>
		</div>


		<div class="fvt-cont">
			<div class="fvtc-basic">
				<h2>${dto.getFicnic_name()}</h2>
				<c:if test="${dto.getFicnic_market_price() > 0}"><p class="prev"><fmt:formatNumber value="${dto.getFicnic_market_price()}" />원</p></c:if>
				<p class="sale">
					<c:if test="${dto.getFicnic_market_price() > 0}"><span><fmt:formatNumber value="${1 - dto.getFicnic_sale_price() / dto.getFicnic_market_price()}" type="percent" /></span></c:if>
					<b><fmt:formatNumber value="${dto.getFicnic_sale_price()}" /></b>원
                    <button type="button" onclick="ficnicWish(this, ${dto.getFicnic_no()}, '${sess_id}', '${path}');"<c:if test="${ficnic_wish eq 'Y'}"> class="on"</c:if>><i class="fa fa-heart<c:if test="${ficnic_wish ne 'Y'}">-o</c:if>"></i></button>
				</p>
			</div>


            <c:if test="${!empty cdto}">
            <div class="fvtc-coupon">
                <button type="button" onclick="downloadCoupon('${path}', ${cdto.getCoupon_no()}, '${sess_id}');">
                    <span class="txt">받을 수 있는 <b><fmt:formatNumber value="${cdto.getCoupon_price()}" /><c:choose><c:when test="${cdto.getCoupon_price_type() eq 'price'}">원</c:when><c:otherwise>%</c:otherwise></c:choose> 할인</b>쿠폰이 있어요!</span>
                    <span class="dwn">쿠폰받기<i class="fa fa-download"></i></span>
                </button>
            </div>
            </c:if>


			<div class="fvtc-review">
				<c:choose>
					<c:when test="${count > 0}">
						<div class="fvtcr-star">
							<c:choose>
								<c:when test="${dto.getFicnic_review_point() > 0 and dto.getFicnic_review_point() <= 2}"><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:when>
								<c:when test="${dto.getFicnic_review_point() > 2 and dto.getFicnic_review_point() <= 4}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:when>
								<c:when test="${dto.getFicnic_review_point() > 4 and dto.getFicnic_review_point() <= 6}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:when>
								<c:when test="${dto.getFicnic_review_point() > 6 and dto.getFicnic_review_point() <= 8}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i></c:when>
								<c:when test="${dto.getFicnic_review_point() > 8}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i></c:when>
							</c:choose>
							<b>${dto.getFicnic_review_point()}</b>
							<span>${count}개 후기</span>
							<p class="avg">경험한 크루의 ${avg}%가 10점을 줬어요!</p>
							<a href="ficnic_review.do?ficnic_no=${param.ficnic_no}" class="link"><i class="fa fa-smile-o"></i> 전체보기</a>
						</div>


					    <ul class="fvtcr-list">
					    	<c:forEach var="dto" items="${rList}" end="2">
					    		<li>
					    			<p class="photo"><a href="ficnic_review.do?ficnic_no=${param.ficnic_no}"><c:choose><c:when test="${!empty dto.getReview_photo1()}"><img src="${path}${dto.getReview_photo1()}" alt="" /></c:when><c:when test="${!empty dto.getReview_photo2()}"><img src="${path}${dto.getReview_photo1()}" alt="" /></c:when><c:otherwise><img src="${path}/resources/site/images/noimg.gif" alt="" /></c:otherwise></c:choose></a></p>
					    			<p class="writer">${dto.getReview_name()}</p>
					    			<p class="cont">${dto.getReview_cont()}</p>
					    		</li>
					    	</c:forEach>
					    </ul>
					</c:when>

					<c:otherwise>
						<div class="fvtcr-noreview">
							<p><b><img alt="New" src="data:image/svg+xml,%3Csvg width='24' height='24' viewBox='0 0 24 24' fill='none' xmlns='http://www.w3.org/2000/svg'%3E %3Cpath fill-rule='evenodd' clip-rule='evenodd' d='M4.46084 20.8737H7.76847C8.1231 20.8737 8.46306 21.0137 8.71503 21.2683L11.0548 23.608C11.576 24.1307 12.4226 24.1307 12.9452 23.608L15.285 21.2683C15.5356 21.0177 15.8756 20.8763 16.2302 20.8763H19.5392C20.2777 20.8763 20.8763 20.2777 20.8763 19.5392V16.2302C20.8763 15.8756 21.0177 15.5356 21.2683 15.285L23.608 12.9452C24.1307 12.424 24.1307 11.5774 23.608 11.0548L21.2683 8.71503C21.0177 8.46439 20.8763 8.12443 20.8763 7.7698V4.46084C20.8763 3.72225 20.2777 3.12365 19.5392 3.12365H16.2302C15.8756 3.12365 15.5356 2.98234 15.285 2.7317L12.9452 0.391956C12.424 -0.130652 11.5774 -0.130652 11.0548 0.391956L8.71503 2.7317C8.46439 2.98234 8.12443 3.12365 7.7698 3.12365H4.46084C3.72225 3.12365 3.12365 3.72225 3.12365 4.46084V7.80047C3.12365 8.13376 2.99167 8.45239 2.75569 8.68837L0.391956 11.0521C-0.130652 11.5734 -0.130652 12.42 0.391956 12.9426L2.7317 15.2823C2.98234 15.5329 3.12365 15.8729 3.12365 16.2275V19.5365C3.12365 20.2751 3.72225 20.8737 4.46084 20.8737ZM10.0406 8.62642C9.7546 8.34042 9.32449 8.25486 8.95081 8.40965C8.57714 8.56443 8.3335 8.92906 8.3335 9.33352V14.664C8.3335 15.2163 8.78121 15.664 9.3335 15.664C9.88578 15.664 10.3335 15.2163 10.3335 14.664V11.7477L13.9569 15.3712C14.2429 15.6571 14.673 15.7427 15.0467 15.5879C15.4204 15.4331 15.664 15.0685 15.664 14.664V9.33352C15.664 8.78124 15.2163 8.33353 14.664 8.33353C14.1117 8.33353 13.664 8.78124 13.664 9.33352V12.2498L10.0406 8.62642Z' fill='%23F26E8A'/%3E %3C/svg%3E" /> 피크닉 후기 작성 이벤트</b></p>
							<p>피크닉 후기 작성 시 적립금 500원을 드립니다.</p>
							<p><span>적립금은 피크닉 구매 시 현금처럼 사용하실 수 있습니다.</span></p>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<!-- .fv-top //END -->





	<c:if test="${!empty infoList}">
	<!-- .fv-info //START -->
	<div class="fv-info">
		<h3>피크닉 정보</h3>
		<ul>
            <c:forEach var="iflist" items="${infoList}">
            <li><b>${iflist.title}</b>${iflist.cont}</li>
            </c:forEach>
		</ul>
	</div>
	<!-- .fv-info //END -->
	</c:if>




	<c:if test="${!empty dto.getFicnic_detail()}">
	<!-- .fv-detail //START -->
	<div class="fv-detail">
		<h3>피크닉 소개</h3>
		<div class="fvd-cont ">${dto.getFicnic_detail()}</div>
		<div class="fvd-btn">
			<button type="button" onclick="showFicnicCont();">상세정보 더보기 <i class="fa fa-chevron-down"></i></button>
		</div>
	</div>
	<!-- .fv-detail //END -->
	</c:if>




	<c:if test="${!empty dto.getFicnic_curriculum()}">
	<!-- .fv-curriculum //START -->
	<div class="fv-curriculum">
		<h4>커리큘럼</h4>
		<h5>당일 진행상황에 따라 일정이 변동될 수 있습니다.</h5>

        <ul>
            <c:forEach var="culist" items="${currList}">
            <li>
            	<p class="time">${culist.time}</p>
            	<p class="cont">${culist.cont}</p>
            </li>
            </c:forEach>
        </ul>
	</div>
	<!-- .fv-curriculum //END -->
	</c:if>




	<c:if test="${!empty dto.getFicnic_address()}">
	<!-- .fv-map //START -->
	<div class="fv-map">
		<h3>진행하는 장소</h3>

        <div class="fvm-box">
            <div class="fvmb-show" id="showmap"></div>
            <div class="fvmb-addr">${dto.getFicnic_address()}</div>
        </div>
	</div>
	<!-- .fv-map //END -->
	</c:if>




    <c:if test="${!empty dto.getFicnic_include() or !empty dto.getFicnic_notinclude() or !empty dto.getFicnic_prepare()}">
	<!-- .fv-required //START -->
	<div class="fv-required">
        <c:if test="${!empty dto.getFicnic_include()}">
        <h4>포함 사항</h4>
        <ul class="fvr-include">
            <c:forTokens items="${dto.getFicnic_include()}" delims="," var="include"><li>${include}</li></c:forTokens>
        </ul>
        </c:if>


        <c:if test="${!empty dto.getFicnic_notinclude()}">
        <h4>불포함 사항</h4>
        <ul class="fvr-notinclude">
            <c:forTokens items="${dto.getFicnic_notinclude()}" delims="," var="notinclude"><li>${notinclude}</li></c:forTokens>
        </ul>
        </c:if>


        <c:if test="${!empty dto.getFicnic_prepare()}">
        <h4>준비물</h4>
        <ul class="fvr-prepare">
            <c:forTokens items="${dto.getFicnic_prepare()}" delims="," var="prepare"><li>${prepare}</li></c:forTokens>
        </ul>
        </c:if>
	</div>
	<!-- .fv-required //END -->
    </c:if>




	<!-- .fv-tab //START -->
	<div class="fv-tab">
        <ul>
            <li>
                <div class="fvt-tit" onclick="location.href='ficnic_qna.do?ficnic_no=${param.ficnic_no}';">1:1 문의 작성 <i class="icon-arrow-right"></i></div>
            </li>

            <li>
                <div class="fvt-tit">유의 사항 <i class="icon-arrow-down"></i></div>
                <div class="fvt-cont">${dto.getFicnic_caution()}</div>
            </li>

            <li>
                <div class="fvt-tit">환불 정책 <i class="icon-arrow-down"></i></div>
                <div class="fvt-cont">1. 결제 후 1시간 이내에는 무료 취소가 가능합니다.
(단, 신청마감 이후 취소 시, 피크닉 진행 당일 결제 후 취소 시 취소 및 환불 불가)

2. 결제 후 1시간이 초과한 경우, 아래의 환불규정에 따라 취소수수료가 부과됩니다.
  - 신청마감 2일 이전 취소시 : 전액 환불
  - 신청마감 1일 ~ 신청마감 이전 취소시 : 결제 금액의 50% 취소 수수료 배상 후 환불
  - 신청마감 이후 취소시, 또는 당일 불참 : 환불 불가

※ 다회권의 경우, 1회라도 사용시 부분 환불이 불가하며, 기간 내 호스트와 예약 확정 되지 않은 피크닉은 피크닉 에너지로 환불 됩니다.

※ 취소 수수료는 신청 마감일을 기준으로 산정됩니다.

※ 신청 마감일은 무엇인가요?
호스트님들이 장소 대관, 강습, 재료 구비 등 피크닉 진행을 준비하기 위해, 피크닉 진행일보다 일찍 신청을 마감합니다.
환불은 진행일이 아닌 신청 마감일 기준으로 이루어집니다. 피크닉마다 신청 마감일이 다르니, 꼭 날짜와 시간을 확인 후 결제해주세요! : )

※신청 마감일 기준 환불 규정 예시
  - 피크닉 진행일 : 10월 27일
  - 신청 마감일 : 10월 26일
    10월 25일에 취소 할 경우, 신청마감일 1일 전에 해당하며 50%의 수수료가 발생합니다.

[환불 신청 방법]
1. 해당 피크닉 결제한 계정으로 로그인
2. 마이페잊 - 예약목록
3. 취소를 원하는 피크닉 상세 정보 버튼 - 취소

※ 결제 수단에 따라 예금주, 은행명, 계좌번호 입력
                </div>
            </li>
        </ul>
	</div>
	<!-- .fv-tab //END -->





    <!-- .fv-join //START -->
    <div class="fv-join">
    	<div class="fvj-btn">
    		<button type="button" onclick="showFicnicJoin();">참여하기</button>
    	</div>


    	<div class="fvj-sel">
            <button type="button" class="fvjs-close" onclick="showFicnicJoin();"><i class="fa fa-chevron-down"></i></button>


            <form name="reserv_form" method="post" action="reserv_form.do">
            <input type="hidden" name="ficnic_no" value="${dto.getFicnic_no()}" />
            <input type="hidden" name="reserv_ficnic_name" value="${dto.getFicnic_name()}" />
            <input type="hidden" name="reserv_ficnic_sale_price" value="${dto.getFicnic_sale_price()}" />
            <input type="hidden" name="reserv_ficnic_photo" value="${dto.getFicnic_photo1()}" />
            <input type="hidden" name="reserv_ficnic_option_title" value="" />
            <input type="hidden" name="reserv_ficnic_option_price" value="0" />
            <input type="hidden" name="reserv_ficnic_select_title" value="" />
            <input type="hidden" name="reserv_ficnic_select_price" value="0" />
            <c:if test="${dto.getFicnic_date_use() ne 'Y'}"><input type="hidden" name="reserv_ficnic_date" value="" /></c:if>

            <c:if test="${dto.getFicnic_date_use() eq 'Y' or !empty optionList or !empty selectList}">
            <div class="fvjs-wrap">
        		<c:if test="${dto.getFicnic_date_use() eq 'Y'}">
        		<div class="fvjs-date">
        			<label for="reserv_ficnic_date">날짜 선택</label>
        			<input id="reserv_ficnic_date" name="reserv_ficnic_date" value="${todayDate}" readonly="readonly" />
        		</div>
        		</c:if>


        		<c:if test="${!empty optionList}">
        		<div class="fvjs-option open">
                    <button type="button" class="fvjso-btn">선택 옵션 <i class="fa fa-angle-down"></i></button>
                    <ul class="fvjso-list">
                        <c:forEach var="optlist" items="${optionList}">
                        <li type="option">
                            <strong>${optlist.title}</strong>
                            <span><b><fmt:formatNumber value="${optlist.price}" /></b>원</span>
                        </li>
                        </c:forEach>
                    </ul>
        		</div>
        		</c:if>


                <c:if test="${!empty selectList}">
                <div class="fvjs-option">
                    <button type="button" class="fvjso-btn">추가 선택 <i class="fa fa-angle-down"></i></button>
                    <ul class="fvjso-list">
                        <li type="select">
                            <strong>선택안함</strong>
                            <span><b>0</b>원</span>
                        </li>
                        <c:forEach var="sellist" items="${selectList}">
                        <li type="select">
                            <strong>${sellist.title}</strong>
                            <span><b><fmt:formatNumber value="${sellist.price}" /></b>원</span>
                        </li>
                        </c:forEach>
                    </ul>
                </div>
                </c:if>
            </div>
            </c:if>



    		<div class="fvjs-done">
                <div class="fvjsd-price">
                    <p>총 예약금액</p>
                    <span><b><fmt:formatNumber value="${dto.getFicnic_sale_price()}" /></b>원</span>
                </div>
                <button type="button" class="fvjsd-btn" onclick="chkReservJoin();">참여하기</button>
    		</div>
            </form>
    	</div>
    </div>
    <!-- .fv-join //END -->
</div>



<button type="button" class="goto-top" onclick="gotoTop();"><i class="fa fa-angle-up"></i></button>




<c:if test="${!empty dto.getFicnic_address()}">

<script type="text/javascript" defer="defer">
    var mapContainer = document.getElementById('showmap'); // 지도를 표시할 div
    var mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

    // 지도를 생성합니다
    var map = new kakao.maps.Map(mapContainer, mapOption);

    // 주소-좌표 변환 객체를 생성합니다
    var geocoder = new kakao.maps.services.Geocoder();

    // 주소로 좌표를 검색합니다
    geocoder.addressSearch('${dto.getFicnic_address()}', function(result, status) {
        // 정상적으로 검색이 완료됐으면 
        if (status === kakao.maps.services.Status.OK) {
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

            // 결과값으로 받은 위치를 마커로 표시합니다
            var marker = new kakao.maps.Marker({
                map: map,
                position: coords
            });

            // 인포윈도우로 장소에 대한 설명을 표시합니다
            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="width:150px;text-align:center;padding:6px 0;">진행 장소</div>'
            });

            infowindow.open(map, marker);

            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
            map.setCenter(coords);
        }
    });
</script>
</c:if>


<%@ include file="../layout/layout_footer.jsp" %>