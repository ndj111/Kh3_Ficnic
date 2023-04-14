<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp"%>
<c:if test="${empty sess_id}">
	<script type="text/javascript">
		alert('회원 로그인이 필요합니다.');
		location.href = '${path}/member/member_login.do';
	</script>
</c:if>

<link type="text/css" rel="stylesheet"
	href="${path}/resources/site/css/css_mypage.css" />
<script language="javascript"
	src="${path}/resources/site/js/js_mypage.js"></script>


<c:set var="mypage_eng" value="info" />
<c:set var="mypage_kor" value="회원정보 수정" />
<c:set var="dto" value="${member}" />


<%@ include file="../layout/layout_mymenu.jsp"%>




<div class="contents w1100 mypage-info">

	<form name="form_input" method="post"
		action="${path}/mypage/mypage_info_modifyOk.do">

		
			<!-- 아이디 -->
				<p><label for="member_id">아이디</label></p>
				<p><input class="join_id" id="member_id" name="member_id" value="${dto.getMember_id()}" readonly></p>
					<div class="rowrow"></div>
			<!-- 비밀번호 -->
				<p><label for="member_pw">변경할 비밀번호</label></p>
				<p><input type="password" class="join_pw placeholder_mod" id="member_pw" name="member_pw" placeholder="8자 이상의 영문, 숫자, 특수문자 조합"></p>
					<div class="check_font join_check join_pw_check rowrow" id="pw_check"></div>
			
			<!-- 비밀번호 재확인 -->
				<p><label for="member_pw">비밀번호 재입력</label></p>
				<p><input type="password" class="join_pw_re placeholder_mod" id="member_pw_re" name="member_pw_re" placeholder="비밀번호를 다시 입력해주세요."></p>
					<div class="check_font join_check join_pw_re_check rowrow" id="pw_re_check"></div>
			
			<!-- 이름 -->
				<p><label for="member_name">이름</label>
				<p><input id="member_name"  name="member_name" value="${dto.getMember_name()}"></p>
					<div class="rowrow"></div>
					
			<!-- 이메일 -->
				<p><label for="member_email">이메일</label></p>
				<p><input type="email" class="join_email" id="member_email" name="member_email" value="${dto.getMember_email()}" readonly
				onkeydown="EmailInput(this);" required></p>
					<div id="mailchk-txt" class="check_font join_check join_mail_check rowrow"></div>
					<input type="hidden" name="mailchk_join" value="false" />
			
			<!-- 연락처 -->
				<p><label for="member_phone">연락처</label></p>
				<p><input class="join_check join_phone" id="member_phone" name="member_phone"
					value="${dto.getMember_phone()}" onkeydown="NumSpInput(this);" required></p>
					<div class="check_font join_check join_phone_check rowrow" id="phone_check"></div></td>


				<p><input type="submit" class="btnMod" value="수정하기"></p>
				<p><a href="<%=request.getContextPath()%>/mypage/mypage_secession.do" class="member_secession" onclick="return confirm('정말로 탈퇴하시겠습니까?\n돌이키실 수 없습니다.')">회원 탈퇴</a></p>
         
			
		</table>

	</form>



</div>



<%@ include file="../layout/layout_footer.jsp"%>