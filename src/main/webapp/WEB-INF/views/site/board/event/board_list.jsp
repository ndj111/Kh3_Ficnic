<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../layout/layout_header.jsp" %>
<c:if test="${level.list ne 'Y'}"><script>alert('게시물 목록 접근 권한이 없습니다.'); history.back();</script></c:if>


<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_board.css" />
<script language="javascript" src="${path}/resources/site/js/js_board.js"></script>


<%@ include file="../../layout/layout_csmenu.jsp" %>



<div class="contents w1100 board-list board-event">

    <div class="row">
        <div class="col-lg">
            <div class="card border-0">
                <div class="card-body p-0">
                    <ul class="be-list">
                        <c:choose>
                            <c:when test="${!empty List}">
                                <c:forEach var="dto" items="${List}">
                                <li>
                                    <a href="board_view.do?bbs_id=${dto.getBoard_id()}&bdata_no=${dto.getBdata_no()}&field=${field}&keyword=${keyword}&category=${category}&page=${paging.getPage()}">
                                        <c:if test="${!empty dto.getBdata_file1()}">
                                        <div class="bel-photo"><img src="${path}${dto.getBdata_file1()}" alt="" /></div>
                                        </c:if>

                                        <div class="bel-cont">
                                            <p><b>${dto.getBdata_title()}</b><c:if test="${dto.getBdata_comment() > 0}"><span class="eng text-primary">(${dto.getBdata_comment()})</span></c:if></p>
                                            <p>${dto.getBdata_sub()}</p>
                                        </div>

                                        <div class="bel-date">
                                            <p>${dto.getBdata_date().substring(0,10)}</p>
                                            <p>${dto.getBdata_date().substring(11)}</p>
                                        </div>
                                    </a>
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