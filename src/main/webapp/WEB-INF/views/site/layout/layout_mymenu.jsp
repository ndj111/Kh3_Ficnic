<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="page-info w1100">
    <h2>
    	<ul>
    		<li<c:if test="${mypage_eng eq 'reserv'}"> class="now"</c:if>><a href="${path}/mypage/mypage_reserv_list.do">예약 목록</a></li>
            <li<c:if test="${mypage_eng eq 'wish'}"> class="now"</c:if>><a href="${path}/mypage/mypage_wish_list.do">위시 리스트</a></li>
            <li<c:if test="${mypage_eng eq 'coupon'}"> class="now"</c:if>><a href="${path}/mypage/mypage_coupon_list.do">쿠폰 보관함</a></li>
            <li<c:if test="${mypage_eng eq 'point'}"> class="now"</c:if>><a href="${path}/mypage/mypage_point_list.do">적립금 내역</a></li>
            <li<c:if test="${mypage_eng eq 'qna'}"> class="now"</c:if>><a href="${path}/mypage/mypage_qna_list.do">1:1 문의</a></li>
            <li<c:if test="${mypage_eng eq 'info'}"> class="now"</c:if>><a href="${path}/mypage/mypage_info_modify.do">정보 수정</a></li>
    	</ul>
    </h2>
    <ol>
        <li><a href="${path}/"><i class="icon-home"></i> HOME</a></li>
        <li>마이페이지</li>
        <li><b>${mypage_kor}</b></li>
    </ol>
</div>