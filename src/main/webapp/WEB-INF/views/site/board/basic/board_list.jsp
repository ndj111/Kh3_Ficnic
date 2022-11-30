<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%@ include file="../layout/layout_header.jsp" %> --%>


<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>${board.getBoard_name()}</h2>
        <ol class="m-0 p-2">
        	<li>게시판</li>
            <li><b>${board.getBoard_name()}</b></li>
        </ol>
    </div>
</div>


<div class="page-cont" align="center">
	
	<div>
		${board.getBoard_id()} &nbsp; >${board.getBoard_id()}<br>
	</div>
	<table class="table-list mb-2" border="1">
      <thead>
          <tr>
			<th>제목</th>
			<th>글쓴이</th>
			<th>작성일</th>
			<th>조회수</th>
         </tr>
   </thead>
   <tbody>
		<c:forEach items="${List}" var="dto">
			<tr>
				<td>${dto.getBdata_title() }</td>
				<td>${dto.getBdata_writer_name() }</td>
				<td>${dto.getBdata_date() }</td>
				<td>${dto.getBdata_hit() }</td>
			
			</tr>
		</c:forEach>
	<tbody>
	</table>
	<c:if test="${!empty paging}">
            <div class="row list-bottom-util">
                <div class="col text-center">
                    ${pagingWrite}
                </div>
            </div>
    </c:if>
    
	    <div class="row mt-2 list-bottom-util">
	       <div class="col-6 mt-3">
	           <form name="search_form" method="get" action="<%=request.getContextPath()%>/site/board/board_list.do">
	               <!-- action 속성에 값이 안 넘어갔습니다.-->
	               <input type="hidden" value="${board.getBoard_id()}" name="bbs_id">
	               <div class="input-group w-80">
	                   <div class="col-sm-4">
	                       <select name="field" class="form-select">
	                           <option value="title"<c:if test="${field eq 'title'}"> selected="selected"</c:if>>제목</option>
	                           <option value="cont"<c:if test="${field eq 'cont'}"> selected="selected"</c:if>>내용</option>
	                           <option value="writer"<c:if test="${field eq 'writer'}"> selected="selected"</c:if>>작성자</option>
	                       </select>
	                   </div>
	                   <input type="text" name="keyword" value="${keyword}" class="form-control" />
	                   <button type="submit" class="btn btn-secondary ml-1"><i class="fa fa-search"></i> 검색</button>
	               </div>
	           </form>
	       </div>
	
		<div class="col-6 text-right mt-3">
             <c:choose>
             <c:when test="${!empty field}">
             	<a href="<%=request.getContextPath()%>/site/board/board_list.do?bbs_id=${board.getBoard_id()}" class="btn btn-outline-secondary"><i class="fa fa-list mr-1"></i> 게시물 전체목록</a>
             </c:when>
             <c:otherwise>
             	<a href="<%=request.getContextPath()%>/site/board/${board.getBoard_skin() }/board_write.do?bbs_id=${board.getBoard_id()}" class="btn btn-primary"><i class="fa fa-pencil mr-1"></i> 새로운 글쓰기</a>
             </c:otherwise>
             </c:choose>
	</div>	
	

</div>
</div>


<%-- <%@ include file="../layout/layout_footer.jsp" %> --%>