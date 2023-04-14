<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인이 필요합니다.'); location.href='${path}/member/member_login.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_mypage.css" />
<script language="javascript" src="${path}/resources/site/js/js_mypage.js"></script>


<c:set var="mypage_eng" value="point" />
<c:set var="mypage_kor" value="적립금 내역" />
<c:set var="pList" value="${pList}" />


<%@ include file="../layout/layout_mymenu.jsp" %>



<div class="contents w1100 mypage-point">

<div class="row">
        <div class="col-lg">
            <div class="card border-0">

                <div class="card-body p-0">
                    <table class="table-list mb-2 board-list">
                        <thead>
                            <tr>
                                <th>적립 제목</th>
                                <th style="width: 120px;">적립 금액</th>
                                <th style="width: 80px;" class="table-list-hide-mob">적립 일자</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:choose>
                                <c:when test="${!empty pList}">
                                <c:forEach var="dto" items="${pList}">
                                <tr>
                                    <td class="text-center eng table-list-mob">${dto.getPoint_reason()}</td>
                                    <td class="text-center eng table-list-hide-mob">
                                    <c:choose>
                                        <c:when test="${dto.getPoint_type() eq 'plus'}"><span class="text-primary">+<fmt:formatNumber value="${dto.getPoint_add()}" /></span></c:when>
                                        <c:when test="${dto.getPoint_type() eq 'minus'}"><span class="text-danger">-<fmt:formatNumber value="${dto.getPoint_add()}" /></span></c:when>
                                    </c:choose>
                                    </td>
                                    <td class="text-center eng table-list-mob">${dto.getPoint_date().substring(0,10)}</td>
                                </tr>
                                </c:forEach>
                                </c:when>

                                <c:otherwise>
                                <tr>
                                    <td colspan="3" class="nodata">적립금 내역이 없습니다.</td>
                                </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</div>



<%@ include file="../layout/layout_footer.jsp" %>