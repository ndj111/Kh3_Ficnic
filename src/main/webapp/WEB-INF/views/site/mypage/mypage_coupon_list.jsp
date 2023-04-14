<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인이 필요합니다.'); location.href='${path}/member/member_login.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_mypage.css" />
<script language="javascript" src="${path}/resources/site/js/js_mypage.js"></script>


<c:set var="mypage_eng" value="coupon" />
<c:set var="mypage_kor" value="쿠폰 보관함" />


<%@ include file="../layout/layout_mymenu.jsp" %>



<div class="contents w1100 mypage-coupon">

    <ul class="mc-list">
        <c:choose>
            <c:when test="${!empty List}">
                <c:forEach var="dto" items="${List}">
                    <c:forEach var="cdto" items="${dto.getCoupon_list()}">
                        <c:if test="${dto.getCoupon_no() eq cdto.getCoupon_no()}">
                        <li>
                            <div class="mcl-name"<c:if test="${empty cdto.getCoupon_start_date()}"> style="margin-top: 20px;"</c:if>>
                                <strong>
                                    <c:choose>
                                        <c:when test="${cdto.getCoupon_price_type() eq 'price'}"><fmt:formatNumber value="${cdto.getCoupon_price()}" />원</c:when>
                                        <c:otherwise><fmt:formatNumber value="${cdto.getCoupon_price()}" type="percent" pattern="##" />%</c:otherwise>
                                    </c:choose>
                                </strong>
                                <p>${cdto.getCoupon_name()}</p>
                            </div>

                            <div class="mcl-info">
                                <p><fmt:formatNumber value="${cdto.getCoupon_price_over()}" />원 이상 구매시 사용가능</p>
                                <c:if test="${!empty cdto.getCoupon_start_date()}"><p>${cdto.getCoupon_start_date().substring(0,10)} ~ ${cdto.getCoupon_end_date().substring(0,10)}</p></c:if>
                            </div>
                        </li>
                        </c:if>
                    </c:forEach>
                </c:forEach>
            </c:when>

            <c:otherwise>
                <li class="nodata">쿠폰 내역이 없습니다.</li>
            </c:otherwise>
        </c:choose>
    </ul>


</div>



<%@ include file="../layout/layout_footer.jsp" %>