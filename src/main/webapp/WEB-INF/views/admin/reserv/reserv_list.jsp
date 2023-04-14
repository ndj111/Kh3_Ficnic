<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<script type="text/javascript">$("#header .navbar .nav-item:nth-child(2)").addClass("active");</script>


<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>예약 목록</h2>
        <ol class="m-0 p-2">
            <li>예약 관리</li>
            <li><b>예약 목록</b></li>
        </ol>
    </div>
</div>



<div class="page-cont">
    <div class="row mb-3">
        <div class="col-lg">
            <div class="card">
                <div class="card-body px-5 pt-4 pb-3">
                    <form name="search_form" method="get" action="${path}/admin/reserv/reserv_list.do" class="row py-2 px-3">
                    <div class="row justify-content-center">
                        <div class="col-lg-9">
                            <div class="row justify-content-center">
                                <div class="col-md-4 mb-2">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="search_status">예약상태</label>
                                        </div>
                                        <select id="search_status" name="search_status" class="custom-select">
                                            <option value="">- 전체보기 -</option>
                                            <option value="reserv" class="text-info"<c:if test="${search_status eq 'reserv'}"> selected="selected"</c:if>>체험신청</option>
                                            <option value="confirm" class="text-primary"<c:if test="${search_status eq 'confirm'}"> selected="selected"</c:if>>예약확정</option>
                                            <option value="done" class="text-secondary"<c:if test="${search_status eq 'done'}"> selected="selected"</c:if>>체험완료</option>
                                            <option value="cancel" class="text-danger"<c:if test="${search_status eq 'cancel'}"> selected="selected"</c:if>>예약취소</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-md-4 mb-2">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i class="fa fa-calendar mr-1"></i> 예약일자</span>
                                        </div>
                                        <input type="text" name="search_date_start" value="${search_date_start}" id="startDt" class="form-control text-center eng" />
                                    </div>
                                </div>
                                <div class="col-md-4 mb-2">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                         <span class="input-group-text"><i class="fa fa-calendar mr-1"></i> 예약일자</span>
                                        </div>
                                        <input type="text" name="search_date_end" value="${search_date_end}" id="endDt" class="form-control text-center eng" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="search-form-button col-lg-3"></div>
                    </div>


                    <div class="row justify-content-center">
                        <div class="col-lg-9">
                            <div class="row justify-content-center">
                                <div class="col-md-4 mb-2">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="search_sess">예약번호</label>
                                        </div>
                                        <input type="text" id="search_sess" name="search_sess" value="${search_sess}" class="form-control">
                                    </div>
                                </div>

                                <div class="col-md-4 mb-2">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="search_ficnic">피크닉 이름</label>
                                        </div>
                                        <input type="text" id="search_ficnic" name="search_ficnic" value="${search_ficnic}" class="form-control">
                                    </div>
                                </div>

                                <div class="col-md-4 mb-2">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="search_name">예약자 이름</label>
                                        </div>
                                        <input type="text" id="search_name" name="search_name" value="${search_name}" class="form-control">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="search-form-button col-lg-3">
                            <button type="submit" class="btn btn-secondary mb-2"><i class="fa fa-search"></i> 검색하기</button>
                            <a href="${path}/admin/reserv/reserv_list.do" class="btn btn-outline-secondary ml-1 mb-2"><i class="fa fa-refresh"></i> 초기화</a>
                        </div>
                    </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <div class="row">
        <div class="col-lg">
            <div class="card">
                <div class="card-header bg-white border-0 pt-4 pl-4">총 <b class="text-primary"><fmt:formatNumber value="${totalCount}" /></b> 개의 예약</div>

                <div class="card-body px-4 pt-0">
                    <table class="table-list hover mb-2">
                        <thead>
                            <tr>
                                <th style="width: 10%; min-width: 110px;" class="table-list-hide-mob">예약상태</th>
                                <th style="width: 11%; min-width: 120px;">예약번호</th>
                                <th colspan="2">피크닉</th>
                                <th style="width: 13%; min-width: 140px;" class="table-list-hide">결제금액</th>
                                <th style="width: 10%; min-width: 110px;" class="table-list-hide">예약자</th>
                                <th style="width: 12%; min-width: 130px;" class="table-list-hide-mob">예약일자</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:set var="list" value="${List}" />
                            <c:choose>
                            <c:when test="${!empty list}">
                            <c:forEach var="dto" items="${list}">
                            <c:set var="showLink" value="onclick=\"popWindow('reserv_view.do?no=${dto.getReserv_no()}&sess=${dto.getReserv_sess()}', '700', '900');\"" />
                            <c:set var="result_sess" value="<span class=\"search\">${search_sess}</span>"></c:set>
                            <c:set var="result_name" value="<span class=\"search\">${search_name}</span>"></c:set>
                            <c:set var="result_ficnic" value="<span class=\"search\">${search_ficnic}</span>"></c:set>
                            <tr>
                                <td ${showLink} class="py-5">
                                    <c:choose>
                                        <c:when test="${dto.getReserv_status() eq 'reserv'}"><span class="text-info">체험신청</span></c:when>
                                        <c:when test="${dto.getReserv_status() eq 'confirm'}"><span class="text-primary">예약확정</span></c:when>
                                        <c:when test="${dto.getReserv_status() eq 'done'}"><span class="text-secondary">체험완료</span></c:when>
                                        <c:otherwise><span class="text-danger">예약취소</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td ${showLink} class="eng table-list-hide-mob"><c:choose><c:when test="${search_sess != ''}">${dto.getReserv_sess().replace(search_sess, result_sess)}</c:when><c:otherwise>${dto.getReserv_sess()}</c:otherwise></c:choose></td>
                                <td ${showLink} class="photo px-3" style="width: 100px;">
                                    <c:choose>
                                        <c:when test="${!empty dto.getReserv_ficnic_photo()}"><img src="${path}${dto.getReserv_ficnic_photo()}" onerror="this.src='${path}/resources/admin/images/noimg.gif'" alt="" /></c:when>
                                        <c:otherwise><span class="noimg" style="width: 100%;">no img</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td ${showLink} class="text-left">
                                    <p class="mb-2"><b><c:choose><c:when test="${search_ficnic != ''}">${dto.getReserv_ficnic_name().replace(search_ficnic, result_ficnic)}</c:when><c:otherwise>${dto.getReserv_ficnic_name()}</c:otherwise></c:choose></b></p>
                                    <p class="eng"> - ${dto.getReserv_ficnic_option_title()}</p>
                                </td>
                                <td ${showLink} class="table-list-hide">
                                    <p>
                                        <c:choose>
                                            <c:when test="${dto.getReserv_payment() eq 'naverpay'}">네이버페이</c:when>
                                            <c:when test="${dto.getReserv_payment() eq 'kakaopay'}">카카오페이</c:when>
                                            <c:when test="${dto.getReserv_payment() eq 'sampay'}">삼성페이</c:when>
                                            <c:when test="${dto.getReserv_payment() eq 'toss'}">토스</c:when>
                                            <c:when test="${dto.getReserv_payment() eq 'bank'}">무통장 입금</c:when>
                                            <c:when test="${dto.getReserv_payment() eq 'card'}">카드</c:when>
                                        </c:choose>
                                    </p>
                                    <p class="text-primary"><b class="eng"><fmt:formatNumber value="${dto.getReserv_total_price()}" /></b>원</p>
                                </td>
                                <td ${showLink} class="eng table-list-hide"><c:choose><c:when test="${search_name != ''}">${dto.getReserv_name().replace(search_name, result_name)}</c:when><c:otherwise>${dto.getReserv_name()}</c:otherwise></c:choose><br>${dto.getMember_id()}</td>
                                <td ${showLink} class="eng table-list-hide-mob">${dto.getReserv_date().substring(0,10)}<br />${dto.getReserv_date().substring(11)}</td>
                            </tr>
                            </c:forEach>
                            </c:when>

                            <c:otherwise>
                            <tr>
                                <td colspan="6" class="nodata">No Data</td>
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
    <div class="col-md-4 mt-3"></div>

    <div class="col-md-4 text-center mt-3">
        <c:if test="${!empty paging}">${pagingWrite}</c:if>
    </div>

    <div class="col-md-4 text-right mt-3">
        <c:choose>
        <c:when test="${!empty keyword}"><a href="${path}/admin/reserv/reserv_list.do" class="btn btn-outline-secondary"><i class="fa fa-list"></i> 예약 목록</a></c:when>
        </c:choose>
    </div>
</div>


<%@ include file="../layout/layout_footer.jsp" %>