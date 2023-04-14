<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../layout/layout_header.jsp" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:if test="${level.list ne 'Y'}"><script>alert('게시물 목록 접근 권한이 없습니다.'); history.back();</script></c:if>


<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_board.css" />
<script language="javascript" src="${path}/resources/site/js/js_board.js"></script>


<%@ include file="../../layout/layout_csmenu.jsp" %>



<div class="contents w1100 board-list board-faq">

    <div class="row">
        <div class="col-lg">
            <div class="card border-0">
                <div class="card-header bg-white border-0 p-0">
                    <form name="search_form" method="get" action="${path}/board/board_list.do" class="bf-search">
                    <input type="hidden" name="bbs_id" value="${param.bbs_id}" />
                    <input type="hidden" name="field" value="title" />
                    <input type="hidden" name="category" value="${param.category}" />
                    <i class="fa fa-search"></i>
                    <input type="text" name="keyword" value="${keyword}" placeholder="검색어를 입력하세요" />
                    <button type="submit" class="btn btn-dark">검색</button>
                    </form>


                    <c:if test="${conf.getBoard_use_category() eq 'Y' and !empty BoardCate}">
                    <ul class="bf-category">
                        <li<c:if test="${empty category}"> class="now"</c:if>><a href="board_list.do?bbs_id=${param.bbs_id}">전체보기</a></li>
                        <c:forEach var="cateList" items="${BoardCate}">
                        <li<c:if test="${category eq cateList.getBcate_no()}"> class="now"</c:if>><a href="board_list.do?bbs_id=${param.bbs_id}&field=${param.field}&keyword=${param.keyword}&category=${cateList.getBcate_no()}">${cateList.getBcate_name()}</a></li>
                        </c:forEach>
                    </ul>
                    </c:if>
                </div>

                <div class="card-body p-0">
                    <ul class="bf-list">
                        <c:choose>
                            <c:when test="${!empty List}">
                                <c:forEach var="dto" items="${List}">
                                <c:set var="result_title" value="<span class=\"search\">${keyword}</span>"></c:set>
                                <li>
                                    <div class="bfl-tit"><c:choose><c:when test="${field eq 'title' and keyword != ''}">${dto.getBdata_title().replace(keyword, result_title)}</c:when><c:otherwise>${dto.getBdata_title()}</c:otherwise></c:choose></div>


                                    <div class="bfl-cont">
                                        <c:if test="${!empty dto.getBdata_file1()}">
                                            <div class="pb-3 text-center bflc-photo"><img src="${path}${dto.getBdata_file1()}" alt="" /></div>
                                        </c:if>
                                        <c:if test="${!empty dto.getBdata_file2()}">
                                            <div class="pb-3 text-center bflc-photo"><img src="${path}${dto.getBdata_file2()}" alt="" /></div>
                                        </c:if>
                                        <c:if test="${!empty dto.getBdata_file3()}">
                                            <div class="pb-3 text-center bflc-photo"><img src="${path}${dto.getBdata_file3()}" alt="" /></div>
                                        </c:if>
                                        <c:if test="${!empty dto.getBdata_file4()}">
                                            <div class="pb-3 text-center bflc-photo"><img src="${path}${dto.getBdata_file4()}" alt="" /></div>
                                        </c:if>

                                        <div class="bflc-body">
                                            ${dto.getBdata_cont().replace(newLine, '<br />')}
                                        </div>

                                        <c:if test="${sess_type eq 'admin'}">
                                        <div class="bflc-btn">
                                            <a href="board_modify.do?bbs_id=${dto.getBoard_id()}&bdata_no=${dto.getBdata_no()}" class="btn btn-outline-success btn-sm m-1">수정</a>
                                            <a href="board_delete.do?bbs_id=${dto.getBoard_id()}&bdata_no=${dto.getBdata_no()}" class="btn btn-outline-danger btn-sm my-1" onclick="return confirm('정말 삭제하시겠습니까?\n되돌릴 수 없습니다.');">삭제</a>
                                        </div>
                                        </c:if>
                                    </div>
                                </li>
                                </c:forEach>
                            </c:when>

                            <c:otherwise>
                                <li class="nodata">No Data</li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </div>
    </div>



    <div class="row mt-4 list-bottom-util">
        <div class="col-sm-2 mb-3 text-left"></div>

        <div class="col-sm-8 mb-3 text-center">
            ${pagingWrite}
        </div>

        <div class="col-sm-2 mb-3 text-right">
            <c:if test="${level.write eq 'Y'}"><a href="${path}/board/board_write.do?bbs_id=${conf.getBoard_id()}" class="btn btn-primary"><i class="fa fa-pencil mr-1"></i> 글쓰기</a></c:if>
        </div>
    </div>

</div>


<%@ include file="../../layout/layout_footer.jsp" %>