<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${!empty sess_id}"><script type="text/javascript">alert('이미 로그인 되어 있습니다.'); history.back();</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_member.css" />
<script language="javascript" src="${path}/resources/site/js/js_member.js"></script>




<div class="page-info w1100">
    <h2>로그인</h2>
    <ol>
        <li><a href="${path}/"><i class="icon-home"></i> HOME</a></li>
        <li><b>로그인</b></li>
    </ol>
</div>



<div class="contents w1100 member-login cont_login txtb">


	<form class="login-form" name="form1" method="post" action="${path}/member/member_login_check.do">
		
		<table>
		
		<tr class="login_tr">
		<td class="login_head">간편하게 로그인하고 피크닉의<br style="user-select: auto;"> 다양한 클래스를 만나보세요.</h4>
		</td> </tr>
		<tr></tr>
		
			<input type="hidden" name="member_name" value="${dto.getMember_name()}">
		
			<tr>
				<td><input id="member_id" name="member_id" required="required" placeholder="아이디를 입력해 주세요."></td>
			</tr>
			<tr>
				<td><input type="password" id="member_pw" name="member_pw" required="required" placeholder="비밀번호를 입력해 주세요."></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" class="btnLogin" value="로그인">

		<div class="mf-find">
		<a href="${path}/member/member_find.do">
		<i class="fa fa-question-circle"></i> 아이디/비밀번호 찾기</a></div>
				</td>
			</tr>

		</table>
	</form>


</div>



<%@ include file="../layout/layout_footer.jsp" %>