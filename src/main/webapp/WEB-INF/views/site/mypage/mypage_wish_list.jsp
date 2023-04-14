<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인이 필요합니다.'); location.href='${path}/member/member_login.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_mypage.css" />
<script language="javascript" src="${path}/resources/site/js/js_mypage.js"></script>


<c:set var="mypage_eng" value="wish" />
<c:set var="mypage_kor" value="위시 리스트" />


<%@ include file="../layout/layout_mymenu.jsp" %>



<div class="contents w1100 mypage-reserv">

	<c:if test="${!empty List}">
	<ul class="ficnic-list">
		<c:forEach var="fdto" items="${List}">
			<c:set var="dto" value="${fdto.getFicnic_cont()}" />
			<li>
				<button type="button" onclick="if(confirm('위시리스트에서 삭제하시겠습니까?')){ location.href='${path}/mypage/wish_cancel.do?ficnic_no=${dto.getFicnic_no()}'; }else{ return false; }"><i class="fa fa-heart"></i></button>
				<a href="${path}/ficnic/ficnic_view.do?category=${param.category}&ficnic_no=${dto.getFicnic_no()}">
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
	</c:if>



	<c:if test="${empty List}">
	<div class="mypage-wish-mainDiv d-flex flex-column w1000 d-flex justify-content-center">
		<div class="f_rlist" align="center">
			<p><img src="data:image/svg+xml,%3Csvg width='40' height='46' viewBox='0 0 40 46' fill='none' xmlns='http://www.w3.org/2000/svg%27%3E %3Cpath d='M38.4977 43.5996L32.5307 39.5187L32.5246 39.5146C27.6377 36.2071 24.9328 34.4736 23.346 33.5648C21.7658 32.6598 21.0819 32.4412 20.3095 32.435L20.2784 32.4347L20.2474 32.4358L19.8949 32.4476L19.8343 32.4496L19.774 32.4565C19.2931 32.5117 18.8036 32.6823 18.1544 33.0045C17.507 33.3258 16.6122 33.8436 15.301 34.6727C12.79 36.2606 8.62466 39.0719 1.50033 44.0514V8.09877V6.28378V6.27556L1.50024 6.26735C1.48672 5.03394 2.04874 3.78126 3.18016 2.79743C4.03484 2.06619 5.22049 1.59279 6.52134 1.51218L6.91633 1.5H33.0754C36.3134 1.62522 38.4364 3.77129 38.4977 5.90409V36.5925V43.5996Z' stroke='%23777777' stroke-width='3'/%3E %3C/svg%3E" /></p>
			<p class="f_rlistf"> 아직 위시 리스트에 담은 피크닉이 없어요. </p>
			<p class="f_rlists">관심 있는 피크닉을 담아 보세요!</p>
			<p><a class="f_rlistbtn" href="${path}/main.do">홈으로 이동</a></p>
		</div>
	</div>
	</c:if>



    <div class="row mt-4 list-bottom-util">
        <div class="col mb-3 text-center">
            ${pagingWrite}
        </div>
    </div>

</div>



<%@ include file="../layout/layout_footer.jsp" %>