<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp"%>
<c:if test="${!empty sess_id}">
	<script type="text/javascript">
		alert('이미 로그인 되어 있습니다.');
		history.back();
	</script>
</c:if>

<link type="text/css" rel="stylesheet"
	href="${path}/resources/site/css/css_member.css" />
<script language="javascript"
	src="${path}/resources/site/js/js_member.js"></script>


<div class="page-info w1100">
	<h2>회원 가입</h2>
	<ol>
		<li><a href="${path}/"><i class="icon-home"></i> HOME</a></li>
		<li><b>회원 가입</b></li>
	</ol>
</div>



<div class="contents w1100 member-join">


	<form name="form_input" method="post"
		action="${path}/member/member_join_ok.do">

		<table>

			<tr class="join_tr">
				<td class="join_td">간편하게 가입하고 피크닉의<br
					style="user-select: auto;"> 다양한 클래스를 만나보세요.
					</h4>
				</td>
			</tr>
			<tr></tr>
			<!-- 아이디 -->
			<tr>
				<td><label for="member_id">아이디</label> <input class="join_id"
					id="member_id" name="member_id" placeholder="6자 이상을 입력해주세요."
					onkeydown="EngNumInput(this);" required>
					<div id="idchk-txt" class="join_check join_id_check"></div> <input
					type="hidden" class="join_check" name="idchk_join" value="false" />
				</td>
			</tr>
			<!-- 비밀번호 -->
			<tr>
				<td><label for="member_pw">비밀번호</label> <input type="password"
					class="join_pw" id="member_pw" name="member_pw"
					placeholder="8자 이상의 영문, 숫자, 특수문자 조합" required>
					<div class="check_font join_check join_pw_check" id="pw_check"></div>
				</td>
			</tr>
			<!-- 비밀번호 재확인 -->
			<tr>
				<td><label for="member_pw2">비밀번호 확인</label> <input
					type="password" class="join_pw_re" id="member_pw_re"
					name="member_pw_re" placeholder="비밀번호를 다시 입력해주세요." required>
					<div class="check_font join_check join_pw_re_check"
						id="pw_re_check"></div></td>
			</tr>
			<!-- 이름 -->
			<tr>
				<td><label for="member_name">이름</label> <input id="member_name"
					name="member_name" placeholder="이름을 입력해주세요." required>
					<div class="check_font join_check" id="name_check"></div></td>
			</tr>
			<!-- 이메일 -->
			<tr>
				<td><label for="member_email">이메일</label> <input type="email"
					class="join_email" id="member_email" name="member_email"
					placeholder="이메일을 입력해주세요." onkeydown="EmailInput(this);" required>
					<div id="mailchk-txt" class="check_font join_check join_mail_check"></div>
					<input type="hidden" name="mailchk_join" value="false" /></td>
			</tr>
			<!-- 연락처 -->
			<tr>
				<td><label for="member_phone">연락처</label> <input
					class="join_check join_phone" id="member_phone" name="member_phone"
					placeholder="-을 포함한 전화번호를 입력해주세요." onkeydown="NumSpInput(this);"
					required>
					<div class="check_font join_check join_phone_check"
						id="phone_check"></div></td>
			</tr>

			<td><a href="${pageContext.request.contextPath}">
					<button class="btnJoin">가입하기</button></td>
		</table>
	</form>



</div>



<%@ include file="../layout/layout_footer.jsp"%>