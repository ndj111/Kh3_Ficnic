<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${!empty sess_id}"><script type="text/javascript">alert('이미 로그인 되어 있습니다.'); history.back();</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_member.css" />
<script language="javascript" src="${path}/resources/site/js/js_member.js"></script>




<div class="page-info w1100" align="center">
    <h2>비밀번호 찾기</h2>
    <ol>
        <li><a href="${path}/"><i class="icon-home"></i> HOME</a></li>
        <li><b>비밀번호 찾기</b></li>
    </ol>
</div>




<div class="contents w1100 member-find">



        <div align="center">
        <form name="find_form" method="post" action="<%=request.getContextPath()%>/member/member_find_pw_result.do">
    		
            <a href="<%=request.getContextPath()%>/member/member_find.do" class="login-tab-list__item active findfind" role="tab" aria-controls="tab-panel1">아이디 찾기</a>&nbsp;｜&nbsp;
            <b>비밀번호 찾기</b>
        	
        	<table>
	            <tr>
	            	<td><input type="text" name="member_id" placeholder="가입한 아이디" required autofocus /></td>
	            </tr>
	            
	            <tr>
	            	<td><input type="email" name="member_email" placeholder="가입한 이메일" required />
	            	</td>
	            </tr>
	            
	            <tr>
					<td>
						<p class="find_p"><button type="submit" class="btnFind">비밀번호 찾기</button></p>		
					</td>
				</tr>
			
			
			</table>
            </form>
        </div>



</div>



<%@ include file="../layout/layout_footer.jsp" %>