<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_ficnic.css?${time}" />
<script language="javascript" src="${path}/resources/site/js/js_ficnic.js?${time}"></script>



<div class="page-info w1100">
    <h2>${category_name}<c:if test="${totalCount > 0}"> <span><fmt:formatNumber value="${totalCount}" /></span></c:if></h2>
    <ol>
        <li><a href="${path}/"><i class="icon-home"></i> HOME</a></li>
        <li>피크닉</li>
        <li><b>${category_name}</b></li>
    </ol>
</div>



<div class="contents w1100 goods-list">


	<c:choose>
		<c:when test="${cdto.getCategory_show() eq 'N' and !empty cdto.getCategory_image()}">
		<div class="gl-img"><img src="${path}${cdto.getCategory_image()}" alt="" /></div>
		</c:when>

		<c:otherwise>
			<c:if test="${!empty clist}">
				<div class="gl-top">
					<select name="sort" class="custom-select glt-sort" onchange="location.href=this.value;">
						<option value="ficnic_list.do?category=${param.category}&search=${param.search}&sort=popular"<c:if test="${param.sort eq 'popular'}"> selected="selected"</c:if>>인기순</option>
						<option value="ficnic_list.do?category=${param.category}&search=${param.search}&sort=date"<c:if test="${param.sort eq 'date'}"> selected="selected"</c:if>>등록일순</option>
						<option value="ficnic_list.do?category=${param.category}&search=${param.search}&sort=review"<c:if test="${param.sort eq 'review'}"> selected="selected"</c:if>>평점순</option>
						<option value="ficnic_list.do?category=${param.category}&search=${param.search}&sort=high"<c:if test="${param.sort eq 'high'}"> selected="selected"</c:if>>가격높은순</option>
						<option value="ficnic_list.do?category=${param.category}&search=${param.search}&sort=low"<c:if test="${param.sort eq 'low'}"> selected="selected"</c:if>>가격낮은순</option>
					</select>

					<ul class="glt-category">
						<li<c:if test="${param.category eq parent_category_no}"> class="now"</c:if>><a href="ficnic_list.do?category=${parent_category_no}&sort=${param.sort}">전체보기</a></li>
					  	<c:forEach var="sub" items="${clist}">
					  	<li<c:if test="${param.category eq sub.getCategory_id()}"> class="now"</c:if>><a href="ficnic_list.do?category=${sub.getCategory_id()}&sort=${param.sort}">${sub.getCategory_name()}</a></li>
					  	</c:forEach>
					</ul>
				</div>
			</c:if>
		</c:otherwise>
	</c:choose>


	<ul class="gl-list ficnic-list">
		<c:choose>
			<c:when test="${!empty flist}">
				<c:forEach items="${flist}" var="dto">
					<li>
						<button type="button" onclick="ficnicWish(this, ${dto.getFicnic_no()}, '${sess_id}', '${path}');"<c:if test="${dto.getFicnic_wish() > 0}"> class="on"</c:if>><i class="fa fa-heart<c:if test="${dto.getFicnic_wish() eq 0}">-o</c:if>"></i></button>
						<a href="ficnic_view.do?category=${param.category}&ficnic_no=${dto.getFicnic_no()}">
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
			</c:when>

			<c:otherwise><li class="nodata">등록된 피크닉이 없어요...</li></c:otherwise>
		</c:choose>
	</ul>




    <div class="row mt-4 list-bottom-util">
        <div class="col mb-3 text-center">
            ${pagingWrite}
        </div>
    </div>

</div>



<%@ include file="../layout/layout_footer.jsp" %>