<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${!empty sess_id}"><script type="text/javascript">alert('이미 로그인 되어 있습니다.'); history.back();</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_member.css" />
<script language="javascript" src="${path}/resources/site/js/js_member.js"></script>



<div class="page-info w1100">
    <h2>FIND RESULT</h2>
    <ol>
        <li><a href="${path}/"><i class="icon-home"></i> HOME</a></li>
        <li>아이디 찾기</li>
        <li><b>아이디 찾기 결과</b></li>
    </ol>
</div>



<div class="contents w1100 member-find-result" align="center">

            	<p> 회원님의 아이디는 </p>
            	<p> <strong>${id }</strong> 입니다.</p>
            	<p><button class="pBtn" onclick="location.href='${path}/member/member_login.do'">로그인</button></p>
    
</div>



<%@ include file="../layout/layout_footer.jsp" %>