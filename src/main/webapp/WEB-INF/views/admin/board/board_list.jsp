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
<body>
<div class="page-cont">
	<div align="center">
		<h5>총 ${List.size() }개의 게시판</h5>
		<table border="1" cellspacing="0">
			<tr>
				<th>노출 순위</th>
				<th>게시판 아이디</th>
				<th>게시판 이름</th>
				<th>게시판 권한</th>
				<th>확인</th>
				<th>기능</th>
			</tr>
			<c:choose>
				<c:when test="${!empty List}">
					<c:forEach items="${List }" var="dto">
						<tr>
							<td>${dto.getBoard_no()}</td>
							<td>${dto.getBoard_id()}</td>
							<td><a href="<%=request.getContextPath()%>/admin/board/board_modify.do?board_no=${dto.getBoard_no()}&field=${field}&keyword=${keyword}&page=${paging.getPage()}">${dto.getBoard_name()}</a></td>
							<td>${dto.getBoard_level_list()} ${dto.getBoard_level_view()} ${dto.getBoard_level_write()}</td>
							<td><input type="button" value="게시판 보기" onclick="location.href='<%=request.getContextPath()%>/site/board/board_list.do?bbs_id=${dto.getBoard_id()}'"></td>
							<td>
								<input type="button" value="수정" onclick="location.href='<%=request.getContextPath()%>/admin/board/board_modify.do?board_no=${dto.getBoard_no()}'">
								<input type="button" value="삭제" onclick="if(confirm('정말로 삭제하시겠습니까? 돌이키실 수 없습니다.')){location.href='<%=request.getContextPath()%>/admin/board/board_delete.do?board_no=${dto.getBoard_no()}';}else{return;}">
							
							</td>
						</tr>
					</c:forEach>
				
				</c:when>
				
				<c:otherwise>
						<tr>
							<td colspan="6">게시판 없음</td>
						</tr>
				
				</c:otherwise>
			</c:choose>
		</table>
		<c:if test="${!empty paging}">
            <div class="row list-bottom-util">
                <div class="col text-center">
                    ${pagingWrite}
                </div>
            </div>
        </c:if>
		
		<form action="<%=request.getContextPath()%>/admin/board/board_list.do">
				<div>
					<label for="searchbtn">게시판 이름</label>	
					<input type="hidden" value="board_name" name="field">
					<input name="keyword" placeholder="게시판 이름" id="searchbtn">
					<input type="submit" value="검색">
				</div>
		</form>
				<div>
					<input type="button" value="게시판 추가" onclick="location.href='<%=request.getContextPath()%>/admin/board/board_write.do'" >
				</div>
				
				<div class="col-6 text-right mt-3">
                    <c:choose>
                    <c:when test="${!empty field}"><a href="<%=request.getContextPath()%>/admin/board/board_list.do" class="btn btn-outline-secondary"><i class="fa fa-list mr-1"></i> 게시물 전체목록</a></c:when>
                    <c:otherwise><a href="<%=request.getContextPath()%>/admin/board//board_write.do" class="btn btn-primary"><i class="fa fa-pencil mr-1"></i> 새로운 글쓰기</a></c:otherwise>
                    </c:choose>
                </div>			
	</div>
</div>


<%@ include file="../layout/layout_footer.jsp" %>