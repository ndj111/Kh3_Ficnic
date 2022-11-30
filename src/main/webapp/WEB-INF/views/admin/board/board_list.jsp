<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <div class="row">
        <div class="col-lg">
            <div class="card">
                <div class="card-header bg-white border-0 pt-4 pl-4">총 <b class="text-primary"><fmt:formatNumber value="${totalCount}" /></b> 개의 게시판</div>

                <div class="card-body px-4 pt-0">
                    <table class="table-list mb-2">
                        <thead>
                            <tr>
                                <th style="width: 80px;" class="table-list-hide">게시판 No.</th>
                                <th style="width: 130px;" class="table-list-hide-mob">게시판 아이디</th>
                                <th style="width: 130px;">게시판 이름</th>
                                <th class="table-list-hide">게시판 권한</th>
                                <th style="width: 140px;">확인</th>
                                <th style="width: 140px;">기능</th>
                            </tr>
                        </thead>

                        <tbody>
							<c:choose>
							<c:when test="${!empty List}">
							<c:forEach items="${List }" var="dto">
                            	<c:choose>
                            		<c:when test="${dto.getBoard_level_list() eq 'user'}"><c:set var="level_list" value="회원" /></c:when>
                            		<c:when test="${dto.getBoard_level_list() eq 'admin'}"><c:set var="level_list" value="관리자" /></c:when>
                            		<c:otherwise><c:set var="level_list" value="모든사람" /></c:otherwise>
                            	</c:choose>
                            	<c:choose>
                            		<c:when test="${dto.getBoard_level_view() eq 'user'}"><c:set var="level_view" value="회원" /></c:when>
                            		<c:when test="${dto.getBoard_level_view() eq 'admin'}"><c:set var="level_view" value="관리자" /></c:when>
                            		<c:otherwise><c:set var="level_view" value="모든사람" /></c:otherwise>
                            	</c:choose>
                            	<c:choose>
                            		<c:when test="${dto.getBoard_level_write() eq 'user'}"><c:set var="level_write" value="회원" /></c:when>
                            		<c:when test="${dto.getBoard_level_write() eq 'admin'}"><c:set var="level_write" value="관리자" /></c:when>
                            		<c:otherwise><c:set var="level_write" value="모든사람" /></c:otherwise>
                            	</c:choose>
                            <tr>
                                <td class="py-4 table-list-hide">${dto.getBoard_no()}</td>
                                <td class="eng table-list-hide-mob">${dto.getBoard_id()}</td>
                                <td><a href="<%=request.getContextPath()%>/admin/board/board_modify.do?board_no=${dto.getBoard_no()}&keyword=${keyword}&page=${paging.getPage()}">${dto.getBoard_name()}</a></td>
                                <td class="text-center table-list-hide">
                                    <div class="d-flex flex-wrap justify-content-center">
                                        <div class="col-auto my-1"><b>목록보기 </b>(${level_list})</div>
                                        <div class="col-auto my-1"><b>내용읽기 </b>(${level_view})</div>
                                        <div class="col-auto my-1"><b>글쓰기 </b>(${level_write})</div>
                                    </div>
                                </td>
                                <td><a href="<%=request.getContextPath()%>/site/board/board_list.do?bbs_id=${dto.getBoard_id()}" class="btn btn-outline-info btn-sm"><i class="fa fa-link"></i> 게시판 보기</a></td>
                                <td>
                                    <a href="<%=request.getContextPath()%>/admin/board/board_modify.do?board_no=${dto.getBoard_no()}" class="btn btn-outline-success btn-sm mr-1">수정</a>
                                    <a href="<%=request.getContextPath()%>/admin/board/board_delete.do?board_no=${dto.getBoard_no()}" class="btn btn-outline-danger btn-sm" onclick="return confirm('정말 삭제하시겠습니까?\n되돌릴 수 없습니다.');">삭제</a>
                                </td>
                            </tr>
                        	</c:forEach>
							</c:when>

							<c:otherwise>
                            <tr>
                                <td colspan="7" class="nodata">No Data</td>
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




<div class="row mt-2 list-bottom-util">
    <div class="col-md-4 mt-3">
        <form name="search_form" method="get" action="<%=request.getContextPath()%>/admin/board/board_list.do">
        <div class="input-group list-search-form w-80">
            <div class="input-group-prepend">
                <label class="input-group-text" for="keyword">게시판 이름</label>
            </div>
            <input type="text" id="keyword" name="keyword" value="${keyword}" class="form-control rounded-right" />
            <button type="submit" class="btn btn-secondary ml-1"><i class="fa fa-search"></i> 검색</button>
        </form>
        </div>
    </div>

    <div class="col-md-4 text-center mt-3">
    	<c:if test="${!empty paging}">${pagingWrite}</c:if>
    </div>

    <div class="col-md-4 text-right mt-3">
        <c:choose>
        <c:when test="${!empty keyword}"><a href="<%=request.getContextPath()%>/admin/board/board_list.do" class="btn btn-outline-secondary"><i class="fa fa-list"></i> 게시판 목록</a></c:when>
        <c:otherwise><a href="<%=request.getContextPath()%>/admin/board/board_write.do" class="btn btn-primary"><i class="fa fa-plus"></i> 게시판 추가</a></c:otherwise>
        </c:choose>
    </div>
</div>



<%@ include file="../layout/layout_footer.jsp" %>