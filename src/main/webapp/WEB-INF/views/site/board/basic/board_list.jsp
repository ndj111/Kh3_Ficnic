<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../layout/layout_header.jsp" %>
<c:if test="${level.list ne 'Y'}"><script>alert('게시물 목록 접근 권한이 없습니다.'); history.back();</script></c:if>


<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_board.css" />
<script language="javascript" src="${path}/resources/site/js/js_board.js"></script>


<%@ include file="../../layout/layout_csmenu.jsp" %>



<div class="contents w1100 board-list">

    <div class="row">
        <div class="col-lg">
            <div class="card border-0">
                <div class="card-header bg-white border-0 pt-0 px-0 d-flex justify-content-between">
                    <div class="pt-3">총 <b class="text-primary"><fmt:formatNumber value="${totalCount}" /></b> 개의 게시물</div>
                    <c:if test="${conf.getBoard_use_category() eq 'Y' and !empty BoardCate}">
                    <div>
                        <select name="category" class="custom-select" onchange="location.href='${path}/board/board_list.do?bbs_id=${param.bbs_id}&field=${field}&keyword=${keyword}&category='+this.value;">
                            <option value="">- 전체보기 -</option>
                            <c:forEach var="cateList" items="${BoardCate}">
                            <option value="${cateList.getBcate_no()}"<c:if test="${category eq cateList.getBcate_no()}"> selected=\"selected\"</c:if>>${cateList.getBcate_name()}</option>
                            </c:forEach>
                        </select>
                    </div>
                    </c:if>
                </div>

                <div class="card-body p-0">
                    <table class="table-list mb-2 board-list">
                        <thead>
                            <tr>
                                <th style="width: 7.25%; min-width: 80px;" class="table-list-hide">No.</th>
                                <th>제목</th>
                                <th style="width: 11%; min-width: 120px;" class="table-list-hide-mob">글쓴이</th>
                                <th style="width: 11%; min-width: 120px;">작성일</th>
                                <th style="width: 7.25%; min-width: 80px;" class="table-list-hide-mob">조회수</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:choose>
                                <c:when test="${!empty List}">
                                <c:forEach var="dto" items="${List}">
                                <c:if test="${!empty dto.getBdata_file1()}"><c:set var="file1" value="<i class=\"fa fa-picture-o mx-1\"></i>" /></c:if>
                                <c:if test="${!empty dto.getBdata_file2()}"><c:set var="file2" value="<i class=\"fa fa-picture-o mx-1\"></i>" /></c:if>
                                <c:if test="${!empty dto.getBdata_file3()}"><c:set var="file3" value="<i class=\"fa fa-picture-o mx-1\"></i>" /></c:if>
                                <c:if test="${!empty dto.getBdata_file4()}"><c:set var="file4" value="<i class=\"fa fa-picture-o mx-1\"></i>" /></c:if>

                                <c:set var="result_title" value="<span class=\"search\">${keyword}</span>"></c:set>
                                <c:set var="result_writer" value="<span class=\"search\">${keyword}</span>"></c:set>
                                <tr onclick="location.href='${path}/board/board_view.do?bbs_id=${dto.getBoard_id()}&bdata_no=${dto.getBdata_no()}&field=${field}&keyword=${keyword}&category=${category}&page=${paging.getPage()}';">
                                    <td class="text-center eng table-list-hide">
                                        <c:choose>
                                            <c:when test="${dto.getBdata_use_notice() eq 'Y'}"><i class="fa fa-bell-o"></i> 공지</c:when>
                                            <c:otherwise>${dto.getBdata_no()}</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-left pl-3 subject">
                                        <c:if test="${conf.getBoard_use_category() eq 'Y' and !empty dto.getBdata_category_name()}"><span class="mr-2">[${dto.getBdata_category_name()}]</span></c:if>
                                        <c:if test="${dto.getBdata_use_secret() eq 'Y'}"><i class="fa fa-lock"></i></c:if>
                                        <c:choose><c:when test="${field eq 'title' and keyword != ''}">${dto.getBdata_title().replace(keyword, result_title)}</c:when><c:otherwise>${dto.getBdata_title()}</c:otherwise></c:choose>
                                        ${file1}${file2}${file3}${file4}
                                        <c:if test="${dto.getBdata_comment() > 0}"><span class="eng text-primary">(${dto.getBdata_comment()})</span></c:if>
                                    </td>
                                    <td class="text-center table-list-hide-mob">
                                        <c:choose>
                                            <c:when test="${dto.getBdata_writer_type() eq 'admin'}"><img src="${path}/resources/site/images/admin_icon.png" alt="" /><b>관리자</b></c:when>
                                            <c:otherwise><c:choose><c:when test="${field eq 'writer' and keyword != ''}">${dto.getBdata_writer_name().replace(keyword, result_writer)}</c:when><c:otherwise>${dto.getBdata_writer_name()}</c:otherwise></c:choose></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center eng">${dto.getBdata_date().substring(0,10)}</td>
                                    <td class="text-center eng table-list-hide-mob"><fmt:formatNumber value="${dto.getBdata_hit()}" /></td>
                                </tr>
                                </c:forEach>
                                </c:when>

                                <c:otherwise>
                                <tr>
                                    <td colspan="5" class="nodata">No Data</td>
                                </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>



    <div class="row mt-4 list-bottom-util">
        <div class="col-sm-4 mb-3 text-left">
            <form name="search_form" method="get" action="${path}/board/board_list.do">
            <input type="hidden" name="bbs_id" value="${param.bbs_id}" />
            <input type="hidden" name="category" value="${param.category}" />
            <div class="input-group list-search-form w-80">
                <select name="field" class="custom-select col-sm-4">
                   <option value="title"<c:if test="${field eq 'title'}"> selected="selected"</c:if>>제목</option>
                   <option value="cont"<c:if test="${field eq 'cont'}"> selected="selected"</c:if>>내용</option>
                   <option value="writer"<c:if test="${field eq 'writer'}"> selected="selected"</c:if>>작성자</option>
                </select>
                <input type="text" name="keyword" value="${keyword}" class="form-control rounded-right" />
                <button type="submit" class="btn btn-secondary ml-1"><i class="icon-magnifier"></i> 검색</button>
            </div>
            </form>
        </div>

        <div class="col-sm-4 mb-3 text-center">
            ${pagingWrite}
        </div>

        <div class="col-sm-4 mb-3 text-right">
            <c:if test="${level.write eq 'Y'}"><a href="${path}/board/board_write.do?bbs_id=${conf.getBoard_id()}" class="btn btn-primary"><i class="fa fa-pencil mr-1"></i> 글쓰기</a></c:if>
        </div>
    </div>

</div>


<%@ include file="../../layout/layout_footer.jsp" %>