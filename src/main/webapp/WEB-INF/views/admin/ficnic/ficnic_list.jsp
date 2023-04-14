<%@page import="com.kh3.model.ficnic.FicnicDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<script type="text/javascript">$("#header .navbar .nav-item:nth-child(1)").addClass("active");</script>


<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>피크닉 목록</h2>
        <ol class="m-0 p-2">
            <li>피크닉 관리</li>
            <li><b>피크닉 목록</b></li>
        </ol>
    </div>
</div>




<div class="page-cont">
    <div class="row mb-3">
        <div class="col-lg">
            <div class="card">
                <div class="card-body px-5 pt-4 pb-3">
                    <form name="search_form" method="get" action="${path}/admin/ficnic/ficnic_list.do" class="row py-2 px-3">
                    <div class="row justify-content-center">
                        <div class="col-lg-9">
                            <div class="row justify-content-center">
                                <div class="col-md-4 mb-2">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="search_location">지역</label>
                                        </div>
                                        <select id="search_location" name="search_location" class="custom-select">
                                            <option value="">- 전체보기 -</option>
                                            <option value="서울"<c:if test="${search_location.contains('서울')}"> selected="selected"</c:if>>서울</option>
                                            <option value="경기"<c:if test="${search_location.contains('경기')}"> selected="selected"</c:if>>경기</option>
                                            <option value="인천"<c:if test="${search_location.contains('인천')}"> selected="selected"</c:if>>인천</option>
                                            <option value="강원"<c:if test="${search_location.contains('강원')}"> selected="selected"</c:if>>강원</option>
                                            <option value="부산"<c:if test="${search_location.contains('부산')}"> selected="selected"</c:if>>부산</option>
                                            <option value="충남"<c:if test="${search_location.contains('충남')}"> selected="selected"</c:if>>충남</option>
                                            <option value="충북"<c:if test="${search_location.contains('충북')}"> selected="selected"</c:if>>충북</option>
                                            <option value="경남"<c:if test="${search_location.contains('경남')}"> selected="selected"</c:if>>경남</option>
                                            <option value="경북"<c:if test="${search_location.contains('경북')}"> selected="selected"</c:if>>경북</option>
                                            <option value="전남"<c:if test="${search_location.contains('전남')}"> selected="selected"</c:if>>전남</option>
                                            <option value="전북"<c:if test="${search_location.contains('전북')}"> selected="selected"</c:if>>전북</option>
                                            <option value="광주"<c:if test="${search_location.contains('광주')}"> selected="selected"</c:if>>광주</option>
                                            <option value="대전"<c:if test="${search_location.contains('대전')}"> selected="selected"</c:if>>대전</option>
                                            <option value="대구"<c:if test="${search_location.contains('대구')}"> selected="selected"</c:if>>대구</option>
                                            <option value="울산"<c:if test="${search_location.contains('울산')}"> selected="selected"</c:if>>울산</option>
                                            <option value="제주"<c:if test="${search_location.contains('제주')}"> selected="selected"</c:if>>제주</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4 mb-2">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="search_category">카테고리</label>
                                        </div>
                                        <select id="search_category" name="search_category" class="custom-select">
                                            <option value="">- 전체보기 -</option>
                                            <c:forEach var="dto" items="${clist}">
                                            <option value="${dto.getCategory_id()}"<c:if test="${search_category eq dto.getCategory_id()}"> selected="selected"</c:if>>${dto.getCategory_name()}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4 mb-2">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="search_name">피크닉 이름</label>
                                        </div>
                                        <input type="text" id="search_name" name="search_name" value="${search_name}" class="form-control">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="search-form-button col-lg-auto text-center">
                            <button type="submit" class="btn btn-secondary mb-2"><i class="fa fa-search"></i> 검색하기</button>
                            <a href="${path}/admin/ficnic/ficnic_list.do" class="btn btn-outline-secondary ml-1 mb-2"><i class="fa fa-refresh"></i> 초기화</a>
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
                <div class="card-header bg-white border-0 pt-4 pl-4">총 <b class="text-primary"><fmt:formatNumber value="${totalCount}" /></b> 개의 피크닉</div>

                <div class="card-body px-4 pt-0">
                    <table class="table-list hover mb-2">
                        <thead>
                            <tr>
                                <th style="width: 6.35%; min-width: 70px;" class="table-list-hide-mob">No.</th>
                                <th style="width: 9%; min-width: 100px;" class="table-list-hide">진행지역</th>
                                <th colspan="2">피크닉 이름</th>
                                <th style="width: 18%; min-width: 200px;" class="table-list-hide-mob">판매가격</th>
                                <th style="width: 10%; min-width: 110px;" class="table-list-hide">리뷰</th>
                                <th style="width: 7.25%; min-width: 80px;" class="table-list-hide">판매갯수</th>
                                <th style="width: 10%; min-width: 110px;">기능</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:choose>
                            <c:when test="${!empty flist}">
                            <c:forEach var="dto" items="${flist}">
                            <c:set var="showLink" value="onclick=\"popWindow('ficnic_view.do?no=${dto.getFicnic_no()}', '700', '900');\"" />
                            <c:set var="result_location" value="<span class=\"search\">${search_location}</span>"></c:set>
                            <c:set var="result_category" value="<span class=\"search\">${search_category}</span>"></c:set>
                            <c:set var="result_name" value="<span class=\"search\">${search_name}</span>"></c:set>
                            <tr>
                                <td ${showLink} class="py-4 table-list-hide-mob">${dto.getFicnic_no()}</td>
                                <td ${showLink} class="table-list-hide"><c:choose><c:when test="${search_location != ''}">${dto.getFicnic_location().replace(search_location, result_location)}</c:when><c:otherwise>${dto.getFicnic_location()}</c:otherwise></c:choose></td>
                                <td ${showLink} class="photo px-3" style="width: 120px;">
                                    <c:choose>
                                        <c:when test="${!empty dto.getFicnic_photo1()}"><img src="${path}${dto.getFicnic_photo1()}" alt="" /></c:when>
                                        <c:when test="${!empty dto.getFicnic_photo2()}"><img src="${path}${dto.getFicnic_photo2()}" alt="" /></c:when>
                                        <c:when test="${!empty dto.getFicnic_photo3()}"><img src="${path}${dto.getFicnic_photo3()}" alt="" /></c:when>
                                        <c:when test="${!empty dto.getFicnic_photo4()}"><img src="${path}${dto.getFicnic_photo4()}" alt="" /></c:when>
                                        <c:when test="${!empty dto.getFicnic_photo5()}"><img src="${path}${dto.getFicnic_photo5()}" alt="" /></c:when>
                                        <c:otherwise><span class="noimg">no img</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td ${showLink} class="text-left">
                                    <p class="mb-1">[${dto.getFicnic_category_name()}]</p>
                                    <p><b><c:choose><c:when test="${search_name != ''}">${dto.getFicnic_name().replace(search_name, result_name)}</c:when><c:otherwise>${dto.getFicnic_name()}</c:otherwise></c:choose></b></p>
                                </td>
                                <td ${showLink} class="table-list-hide-mob">
                                    <p>
                                        <c:if test="${dto.getFicnic_market_price() > 0}"><span class="text-secondary"><b class="eng"><fmt:formatNumber value="${dto.getFicnic_market_price()}" /></b>원</span> <i class="fa fa-arrow-right mx-1"></i></c:if>
                                        <span class="text-primary"><b class="eng"><fmt:formatNumber value="${dto.getFicnic_sale_price()}" /></b>원</span>
                                    </p>
                                    <c:if test="${dto.getFicnic_market_price() > 0}"><p class="text-danger">(<b class="eng"><fmt:formatNumber value="${1 - dto.getFicnic_sale_price() / dto.getFicnic_market_price()}" type="percent" /></b> 할인)</p></c:if>
                                </td>
                                <td ${showLink} class="table-list-hide eng">
                                    <p><fmt:formatNumber value="${dto.getFicnic_review_point()}" pattern="0.0" />점</p>
                                    <p>(<fmt:formatNumber value="${dto.getFicnic_review_count()}" />개)</p>
                                </td>
                                <td ${showLink} class="eng table-list-hide"><fmt:formatNumber value="${dto.getFicnic_sale()}" /></td>
                                <td>
                                    <a href="${path}/admin/ficnic/ficnic_modify.do?no=${dto.getFicnic_no()}" class="btn btn-outline-success btn-sm">수정</a>
                                    <a href="${path}/admin/ficnic/ficnic_delete.do?no=${dto.getFicnic_no()}" class="btn btn-outline-danger btn-sm my-1" onclick="return confirm('정말 삭제하시겠습니까?\n되돌릴 수 없습니다.');">삭제</a>
                                </td>
                            </tr>
                            </c:forEach>
                            </c:when>

                            <c:otherwise>
                            <tr>
                                <td colspan="8" class="nodata">No Data</td>
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
        <c:when test="${!empty keyword}"><a href="${path}/admin/ficnic/ficnic_list.do" class="btn btn-outline-secondary"><i class="fa fa-list"></i> 피크닉 목록</a></c:when>
        <c:otherwise><a href="${path}/admin/ficnic/ficnic_write.do" class="btn btn-primary"><i class="fa fa-plus"></i> 피크닉 추가</a></c:otherwise>
        </c:choose>
    </div>
</div>


<%@ include file="../layout/layout_footer.jsp" %>