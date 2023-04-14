<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인이 필요합니다.'); location.href='${path}/member/member_login.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_mypage.css" />
<script language="javascript" src="${path}/resources/site/js/js_mypage.js"></script>


<c:set var="mypage_eng" value="qna" />
<c:set var="mypage_kor" value="내 1:1 문의 내역" />
<c:set var="qList" value="${qList}" />


<%@ include file="../layout/layout_mymenu.jsp" %>



<div class="contents w1100 mypage-qna">

<div class="row">
        <div class="col-lg">
            <div class="card border-0">

                <div class="card-body p-0">
                    <table class="table-list mb-2 board-list">
                        <thead>
                            <tr>
                                <th>제목</th>
                                <th style="width: 200px;" class="table-list-hide-mob">작성일자</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:choose>
                                <c:when test="${!empty qList}">
                                <c:forEach var="dto" items="${qList}">
								<tr onclick="location.href='${path}/mypage/mypage_qna_view.do?no=${dto.getQna_no() }';">                                
                                    <td ${showLink} class="text-center eng table-list-hide-mob">${dto.getQna_title() }</td>
                                    <td ${showLink} class="text-center eng table-list-mob">${dto.getQna_date()}</td>
                                </tr>
                                </c:forEach>
                                </c:when>

                                <c:otherwise>
                                <tr>
                                    <td colspan="2" class="nodata">1:1 문의글 내역이 없습니다.</td>
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