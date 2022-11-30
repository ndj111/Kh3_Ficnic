<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../layout/layout_header.jsp" %>


<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>게시판 목록</h2>
        <ol class="m-0 p-2">
            <li>게시판 관리</li>
            <li><b>게시판 목록</b></li>
        </ol>
    </div>
</div>
<div class="page-cont">
	<c:set var="m" value="${modify}"/>
	<c:if test="${!empty m }">
		<c:set var="tag" value="/admin/board/board_modify_ok.do"/>
		<c:set var="conid" value="${Cont.getBoard_id() }"/>
		<c:set var="conname" value="${Cont.getBoard_name() }"/>
		<c:set var="conskin" value="${Cont.getBoard_skin() }"/>
		<c:set var="conLnum" value="${Cont.getBoard_list_num() }"/>
		<c:set var="conPnum" value="${Cont.getBoard_page_num() }"/>
		<c:set var="con_use_cate" value="${Cont.getBoard_use_category() }"/>
		<c:set var="con_use_comm" value="${Cont.getBoard_use_comment() }"/>
		<c:set var="con_use_sec"  value="${Cont.getBoard_use_secret() }"/>
		<c:set var="con_use_only_sec" value="${Cont.getBoard_use_only_secret() }"/>
		<c:set var="con_link1" value="${Cont.getBoard_use_link1() }"/>
		<c:set var="con_link2" value="${Cont.getBoard_use_link2() }"/>
		<c:set var="con_file1" value="${Cont.getBoard_use_file1() }"/>
		<c:set var="con_file2" value="${Cont.getBoard_use_file2() }"/>
		<c:set var="con_file3" value="${Cont.getBoard_use_file3() }"/>
		<c:set var="con_file4" value="${Cont.getBoard_use_file4() }"/>
		<c:set var="con_lv_list" value="${Cont.getBoard_level_list() }"/>
		<c:set var="con_lv_view" value="${Cont.getBoard_level_view() }"/>
		<c:set var="con_lv_write" value="${Cont.getBoard_level_write() }"/>
		<c:set var="con_lv_comm" value="${Cont.getBoard_level_comment() }"/>
		<c:set var="con_lv_not" value="${Cont.getBoard_level_notice() }"/>
		<c:set var="con_lv_mod" value="${Cont.getBoard_level_modify() }"/>
		<c:set var="con_lv_del" value="${Cont.getBoard_level_delete() }"/>
	</c:if>
	
	<c:if test="${empty m }">
		<c:set var="tag" value="/admin/board/board_write_ok.do"></c:set>
	</c:if>
	
	<form action="<%=request.getContextPath() %>${tag}" method="post">
	<c:if test="${!empty m }">
		<input type="hidden" value="${Cont.getBoard_no() }" name="board_no">
	</c:if>
	<div>
		<h3>게시판 설정</h3>
		<div>
			<h5>기본 설정</h5>
			<label for="id">게시판 아이디</label>
			<input name="board_id" id="id" value="${conid}"><br>
			
			<label for="name">게시판 이름</label>
			<input name="board_name" id="name" value="${conname }"><br>
		
			<!-- 스킨부분 처리파트 어떻게  -->
			<label for="skin">게시판 스킨</label>
			<select name="board_skin" id="skin" >
				<option value="basic" <c:if test="${cnskin == 'basic'}">selected</c:if> >basic</option>
				<option value="test"<c:if test="${cnskin == 'test'}">selected</c:if> >test</option>
			</select><br>
				
			<label for="list_num">페이지 목록 갯수</label>
			<input  name="board_list_num" id="list_num" value="${conLnum}"><br>
			
			
			<label for="page_num">페이지 구분 갯수</label>
			<input  name="board_page_num" id="page_num" value="${conPnum}"><br>
		
			
			<h5>기능 설정</h5>
			<label>글보기시 목록표시
				
				<input type="radio" value="Y" name="board_use_category" <c:if test="${!empty con_use_cate and con_use_cate == 'Y'}">checked</c:if>  >O
				<input type="radio" value="N" name="board_use_category" <c:if test="${empty con_use_cate or con_use_cate == 'N'}">checked</c:if> >X
			</label><br>
			
			<label>댓글 기능
				<input type="radio" value="Y" name="board_use_comment" <c:if test="${!empty con_use_comm and con_use_comm == 'Y'}">checked</c:if>  >O
				<input type="radio" value="N" name="board_use_comment" <c:if test="${empty con_use_comm or con_use_comm == 'N'}">checked</c:if> >X
			</label><br>
			
			<label >비밀글 기능
				<input type="radio" value="Y" name="board_use_secret" <c:if test="${!empty con_use_sec and con_use_sec == 'Y'}">checked</c:if>  >O
				<input type="radio" value="N" name="board_use_secret"  <c:if test="${empty con_use_sec or con_use_sec == 'N'}">checked</c:if>  >X
			</label><br>
			
			<label>비밀글 전용
				<input type="radio" value="Y" name="board_use_only_secret" <c:if test="${!empty con_use_only_sec and con_use_only_sec == 'Y'}">checked</c:if> >O
				<input type="radio" value="N" name="board_use_only_secret" <c:if test="${empty con_use_only_sec or con_use_only_sec == 'N'}">checked</c:if>  >X
			</label><br>
			
			<label>관련 사이트 링크#1
				<input type="radio" value="Y" name="board_use_link1" <c:if test="${!empty con_link1 and con_link1 == 'Y' }">checked</c:if> >O
				<input type="radio" value="N" name="board_use_link1" <c:if test="${empty con_link1 or con_link1 == 'N'}">checked</c:if> >X
			</label><br>
			
			<label>관련 사이트 링크#2
				<input type="radio" value="Y" name="board_use_link2"  <c:if test="${!empty con_link2 and con_link2 == 'Y' }">checked</c:if>  >O
				<input type="radio" value="N" name="board_use_link2"<c:if test="${empty con_link2 or con_link2 == 'N'}">checked</c:if>  >X
			</label><br>
			
			<label>첨부파일 #1
				<input type="radio" value="Y" name="board_use_file1"  <c:if test="${!empty con_file1 and con_file1 == 'Y' }">checked</c:if>  >O
				<input type="radio" value="N" name="board_use_file1" <c:if test="${empty con_file1 or con_file1 == 'N' }">checked</c:if>  >X
			</label><br>
			<label>첨부파일 #2
				<input type="radio" value="Y" name="board_use_file2" <c:if test="${!empty con_file2 and con_file2 == 'Y' }">checked</c:if> >O
				<input type="radio" value="N" name="board_use_file2" <c:if test="${empty con_file2 or con_file2 == 'N' }">checked</c:if>  >X
			</label><br>
			<label>첨부파일 #3
				<input type="radio" value="Y" name="board_use_file3" <c:if test="${!empty con_file3 and con_file3 == 'Y' }">checked</c:if> >O
				<input type="radio" value="N" name="board_use_file3" <c:if test="${empty con_file3 or con_file3 == 'N' }">checked</c:if> >X
			</label><br>
			<label>첨부파일 #4
				<input type="radio" value="Y" name="board_use_file4" <c:if test="${!empty con_file4 and con_file4 == 'Y' }">checked</c:if> >O
				<input type="radio" value="N" name="board_use_file4" <c:if test="${empty con_file4 or con_file4 == 'N' }">checked</c:if> >X
			</label><br>
			
			<h5>권한설정</h5>
			
			<label for="level_list">목록 보기 권한</label>
			<select id="level_list" name="board_level_list">
				<option value="null" <c:if test="${con_lv_list =='null'}">selected</c:if> >[0]모든사람</option>
				<option value="user" <c:if test="${con_lv_list =='user'}">selected</c:if> >[1]회원</option>
				<option value="admin" <c:if test="${con_lv_list =='admin'}">selected</c:if> >[2]관리자</option>
			</select><br>
			
			<label for="level_view">게시물 보기 권한</label>
			<select id="level_view" name="board_level_view">
				<option value="null" <c:if test="${con_lv_view =='null'}">selected</c:if> >[0]모든사람</option>
				<option value="user" <c:if test="${con_lv_view =='user'}">selected</c:if> >[1]회원</option>
				<option value="admin"<c:if test="${con_lv_view =='admin'}">selected</c:if> >[2]관리자</option>
			</select><br>
			
			<label for="level_write">목록 작성 권한</label>
			<select id="level_write" name="board_level_write">
				<option value="null" <c:if test="${con_lv_write =='null'}">selected</c:if> >[0]모든사람</option>
				<option value="user" <c:if test="${con_lv_write =='user'}">selected</c:if> >[1]회원</option>
				<option value="admin" <c:if test="${con_lv_write =='admin'}">selected</c:if> >[2]관리자</option>
			</select><br>
			
			<label for="level_comment">댓글 작성 권한</label>
			<select id="level_comment" name="board_level_comment">
				<option value="null" <c:if test="${con_lv_comm =='null'}">selected</c:if> >[0]모든사람</option>
				<option value="user" <c:if test="${con_lv_comm =='usesr'}">selected</c:if> >[1]회원</option>
				<option value="admin" <c:if test="${con_lv_comm =='amdin'}">selected</c:if> >[2]관리자</option>
			</select><br>
			
			<label for="level_notice">공지사항 작성 권한</label>
			<select id="level_notice" name="board_level_notice">
				<option value="null" <c:if test="${con_lv_not =='null'}">selected</c:if> >[0]모든사람</option>
				<option value="user" <c:if test="${con_lv_not =='user'}">selected</c:if> >[1]회원</option>
				<option value="admin" <c:if test="${con_lv_not =='admin'}">selected</c:if> >[2]관리자</option>
			</select><br>
			
			<label for="level_modify">게시물 수정 권한</label>
			<select id="level_modify" name="board_level_modify">
				<option value="null" <c:if test="${con_lv_mod =='null'}">selected</c:if> >[0]모든사람</option>
				<option value="user" <c:if test="${con_lv_mod =='user'}">selected</c:if> >[1]회원</option>
				<option value="admin" <c:if test="${con_lv_mod =='admin'}">selected</c:if> >[2]관리자</option>
			</select><br>
			
			<label for="level_delete">게시물 삭제 권한</label>
			<select id="level_delete" name="board_level_delete">
				<option value="null" <c:if test="${con_lv_del =='null'}">selected</c:if> >[0]모든사람</option>
				<option value="user" <c:if test="${con_lv_del =='user'}">selected</c:if> >[1]회원</option>
				<option value="admin" <c:if test="${con_lv_del =='admin'}">selected</c:if> >[2]관리자</option>
			</select><br>
		</div>
	</div>
	<div>
		<c:choose>
			<c:when test="${!empty m }">
				<input type="button" value="삭제하기" onclick="if(confirm('정말로 삭제하시겠습니까? 삭제시, 돌이키실 수 없습니다.')){location.href='<%=request.getContextPath()%>/admin/board/board_delete.do?board_no=${Cont.getBoard_no()}';}else{return;}">
				<input type="submit" value="수정하기">
			</c:when>
			<c:otherwise>
				<input type="submit" value="등록하기">
			</c:otherwise>
		</c:choose>
		<input type="button" value="목록보기" onclick="location.href='board_list.do'">
	</div>
		
	</form>
</div>
<%@ include file="../layout/layout_footer.jsp" %>