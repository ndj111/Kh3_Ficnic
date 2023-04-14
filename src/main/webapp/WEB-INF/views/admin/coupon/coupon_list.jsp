<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../layout/layout_header.jsp" %>
<script type="text/javascript">$("#header .navbar .nav-item:nth-child(4)").addClass("active");</script>


<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>쿠폰 목록</h2>
        <ol class="m-0 p-2">
            <li>쿠폰 관리</li>
            <li><b>쿠폰 목록</b></li>
        </ol>
    </div>
</div>



<div class="page-cont">
    <div class="row mb-3">
        <div class="col-lg">
            <div class="card">
                <div class="card-body px-5 pt-4 pb-3">
                    <form name="search_form" method="get" action="<%=request.getContextPath()%>/admin/coupon/coupon_list.do" class="row py-2 px-3">
                    <div class="row justify-content-center">
                        <div class="col-lg-6">
                            <div class="row justify-content-center">
                                <div class="col-md-6 mb-2">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="search_type">사용구분</label>
                                        </div>
                                        <select id="search_type" name="search_type" class="custom-select">
                                            <option value="">- 전체보기 -</option>
                                            <option value="cart"<c:if test="${search_type eq 'cart'}"> selected="selected"</c:if>>장바구니</option>
                                            <option value="category"<c:if test="${search_type eq 'category'}"> selected="selected"</c:if>>카테고리</option>
                                            <option value="goods"<c:if test="${search_type eq 'goods'}"> selected="selected"</c:if>>상품</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-2">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="search_name">쿠폰이름</label>
                                        </div>
                                        <input type="text" id="search_name" name="search_name" value="${search_name}" class="form-control">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="search-form-button col-lg-auto text-center">
                            <button type="submit" class="btn btn-secondary mb-2"><i class="fa fa-search"></i> 검색하기</button>
                            <a href="<%=request.getContextPath()%>/admin/coupon/coupon_list.do" class="btn btn-outline-secondary ml-1 mb-2"><i class="fa fa-refresh"></i> 초기화</a>
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
                <div class="card-header bg-white border-0 pt-4 pl-4">총 <b class="text-primary"><fmt:formatNumber value="${totalCount}" /></b> 개의 쿠폰</div>

                <div class="card-body px-4 pt-0">
                    <table class="table-list hover mb-2">
                        <thead>
                            <tr>
                                <th style="width: 4.5%; min-width: 50px;" class="table-list-hide-mob">No.</th>
                                <th style="width: 8%; min-width: 88px;" class="table-list-hide-mob">사용 구분</th>
                                <th>쿠폰 이름</th>
                                <th style="width: 14%; min-width: 154px;">할인 금액</th>
                                <th style="width: 16%; min-width: 154px;" class="table-list-hide">사용 기간</th>
                                <th style="width: 11%; min-width: 100px;" class="table-list-hide">사용 갯수</th>
                                <th style="width: 10%; min-width: 110px;" class="table-list-hide">발행 현황</th>
                                <th style="width: 11%; min-width: 120px;" class="table-list-hide">등록일</th>
                                <th style="width: 10%; min-width: 110px;">기능</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:set var="list" value="${List}" />
                            <c:choose>
                            <c:when test="${!empty list}">
                            <c:forEach items="${list}" var="dto">                        
                            <c:set var="showLink" value="onclick=\"popWindow('coupon_view.do?no=${dto.getCoupon_no()}', '700', '900');\"" />
                            <c:set var="result_name" value="<span class=\"search\">${search_name}</span>"></c:set>
                            <tr>
                                <td ${showLink} class="py-4 table-list-hide-mob">${dto.getCoupon_no()}</td>
                                <td ${showLink} class="table-list-hide-mob">
                                    <c:choose>
                                    <c:when test="${dto.getCoupon_use_type() eq 'cart'}">장바구니</c:when>
                                    <c:when test="${dto.getCoupon_use_type() eq 'category'}">카테고리</c:when>
                                    <c:otherwise>상품</c:otherwise>
                                    </c:choose>
                                </td>
                                <td ${showLink}><c:choose><c:when test="${search_name != ''}">${dto.getCoupon_name().replace(search_name, result_name)}</c:when><c:otherwise>${dto.getCoupon_name()}</c:otherwise></c:choose></td>
                                <td ${showLink} class="eng">
                                    <c:choose>
                                    <c:when test="${dto.getCoupon_price_type() eq 'price'}"><fmt:formatNumber value="${dto.getCoupon_price()}" />원</c:when>
                                    <c:otherwise>${dto.getCoupon_price()}%<br>(최대 <fmt:formatNumber value="${dto.getCoupon_price_max()}" />원)</c:otherwise>
                                    </c:choose>
                                </td>
                                <td ${showLink} class="eng table-list-hide">
                                    <c:choose>
                                    <c:when test="${dto.getCoupon_date_type() eq 'free'}">무제한</c:when>
                                    <c:when test="${dto.getCoupon_date_type() eq 'after'}">발급 후 ${dto.getCoupon_date_value()}일</c:when>
                                    <c:otherwise>${dto.getCoupon_start_date().substring(0, 10)}~<br>${dto.getCoupon_end_date().substring(0, 10)}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td ${showLink} class="eng table-list-hide">${dto.getCoupon_use_ea()}</td>
                                <td ${showLink} class="eng table-list-hide">
                                <b class="text-primary">${dto.getCoupon_down_ea()}</b>
                                / ${dto.getCoupon_max_ea()}</td>
                                <td ${showLink} class="eng table-list-hide">${dto.getCoupon_date().substring(0, 10)}<br />${dto.getCoupon_date().substring(11, 19)}</td>
                                <td>
                                    <a href="<%=request.getContextPath()%>/admin/coupon/coupon_modify.do?no=${dto.getCoupon_no()}&search_type=${search_type}&search_name=${search_name}&page=${paging.getPage()}" class="btn btn-outline-success btn-sm m-1">수정</a>
                                    <a href="<%=request.getContextPath()%>/admin/coupon/coupon_delete.do?no=${dto.getCoupon_no()}&search_type=${search_type}&search_name=${search_name}" class="btn btn-outline-danger btn-sm my-1" onclick="return confirm('정말 삭제하시겠습니까?\n되돌릴 수 없습니다.');">삭제</a>
                                </td>
                            </tr>
                            </c:forEach>
                            </c:when>

                            <c:otherwise>
                            <tr>
                                <td colspan="9" class="nodata">No Data</td>
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
        <c:when test="${!empty keyword}"><a href="<%=request.getContextPath()%>/admin/coupon/coupon_list.do" class="btn btn-outline-secondary"><i class="fa fa-list"></i> 쿠폰 목록</a></c:when>
        <c:otherwise><a href="<%=request.getContextPath()%>/admin/coupon/coupon_write.do" class="btn btn-primary"><i class="fa fa-plus"></i> 쿠폰 추가</a></c:otherwise>
        </c:choose>
    </div>
</div>


<%@ include file="../layout/layout_footer.jsp" %>