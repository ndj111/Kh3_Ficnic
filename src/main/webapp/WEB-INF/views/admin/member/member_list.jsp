<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<script type="text/javascript">$("#header .navbar .nav-item:nth-child(3)").addClass("active");</script>


<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>회원 목록</h2>
        <ol class="m-0 p-2">
            <li>회원 관리</li>
            <li><b>회원 목록</b></li>
        </ol>
    </div>
</div>



<div class="page-cont">
    <div class="row mb-3">
        <div class="col-lg">
            <div class="card">
                <div class="card-body px-5 pt-4 pb-3">
                    <form name="search_form" method="get" action="${path}/admin/member/member_list.do" class="row py-2 px-3">
                    <div class="row justify-content-center">
                        <div class="col-lg-9">
                            <div class="row justify-content-center">
                                <div class="col-md-4 mb-2">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="search_type">유형</label>
                                        </div>
                                        <select id="search_type" name="search_type" class="custom-select">
                                            <option value="">- 전체보기 -</option>
                                            <option value="user"<c:if test="${search_type eq 'user'}"> selected="selected"</c:if>>회원</option>
                                            <option value="admin"<c:if test="${search_type eq 'admin'}"> selected="selected"</c:if>>관리자</option>
                                            <option value="exit"<c:if test="${search_type eq 'exit'}"> selected="selected"</c:if>>탈퇴회원</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4 mb-2">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="search_name">이름</label>
                                        </div>
                                        <input type="text" id="search_name" name="search_name" value="${search_name}" class="form-control">
                                    </div>
                                </div>
                                <div class="col-md-4 mb-2">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="search_id">아이디</label>
                                        </div>
                                        <input type="text" id="search_id" name="search_id" value="${search_id}" class="form-control">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row justify-content-center">
                        <div class="col-lg-6">
                            <div class="row justify-content-center">
                                <div class="col-md-6 mb-2">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="search_email">이메일</label>
                                        </div>
                                        <input type="text" id="search_email" name="search_email" value="${search_email}" class="form-control">
                                    </div>
                                </div>
                                <div class="col-md-6 mb-2">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="search_phone">전화번호</label>
                                        </div>
                                        <input type="text" id="search_phone" name="search_phone" value="${search_phone}" class="form-control">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="search-form-button col-lg-auto text-center">
                            <button type="submit" class="btn btn-secondary mb-2"><i class="fa fa-search"></i> 검색하기</button>
                            <a href="${path}/admin/member/member_list.do" class="btn btn-outline-secondary ml-1 mb-2"><i class="fa fa-refresh"></i> 초기화</a>
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
                <div class="card-header bg-white border-0 pt-4 pl-4">총 <b class="text-primary"><fmt:formatNumber value="${totalCount}" /></b> 명의 회원</div>

                <div class="card-body px-4 pt-0">
                    <table class="table-list hover mb-2">
                        <thead>
                            <tr>
                                <th style="width: 4.5%; min-width: 50px;" class="table-list-hide-mob">No.</th>
                                <th style="width: 10%; min-width: 100px;">유형</th>
                                <th>이름/아이디</th>
                                <th style="width: 17%; min-width: 180px;" class="table-list-hide">이메일</th>
                                <th style="width: 17%; min-width: 180px;" class="table-list-hide">전화번호</th>
                                <th style="width: 10%; min-width: 100px;" class="table-list-hide">적립금</th>
                                <th style="width: 11%; min-width: 120px;" class="table-list-hide-mob">등록일</th>
                                <th style="width: 10%; min-width: 110px;">기능</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:set var="list" value="${List}" />
                            <c:choose>
                            <c:when test="${!empty list}">
                            <c:forEach items="${list}" var="dto">
                            <c:set var="showLink" value="onclick=\"popWindow('member_view.do?no=${dto.getMember_no()}&id=${dto.getMember_id()}', '700', '900');\"" />
                            <c:set var="result_name" value="<span class=\"search\">${search_name}</span>"></c:set>
                            <c:set var="result_id" value="<span class=\"search\">${search_id}</span>"></c:set>
                            <c:set var="result_email" value="<span class=\"search\">${search_email}</span>"></c:set>
                            <c:set var="result_phone" value="<span class=\"search\">${search_phone}</span>"></c:set>
                            <tr>
                                <td ${showLink} class="py-4 table-list-hide-mob">${dto.getMember_no()}</td>
                                <td ${showLink}>
                                    <c:choose>
                                    <c:when test="${dto.getMember_type() eq 'admin'}">관리자</c:when>
                                    <c:when test="${dto.getMember_type() eq 'exit'}">탈퇴회원</c:when>
                                    <c:otherwise>회원</c:otherwise>
                                    </c:choose>
                                </td>
                                <td ${showLink}>
                                    <p><b><c:choose><c:when test="${search_name != ''}">${dto.getMember_name().replace(search_name, result_name)}</c:when><c:otherwise>${dto.getMember_name()}</c:otherwise></c:choose></b></p>
                                    <p class="eng"><c:choose><c:when test="${search_id != ''}">${dto.getMember_id().replace(search_id, result_id)}</c:when><c:otherwise>${dto.getMember_id()}</c:otherwise></c:choose></p>
                                </td>
                                <td ${showLink} class="eng table-list-hide"><c:choose><c:when test="${search_email != ''}">${dto.getMember_email().replace(search_email, result_email)}</c:when><c:otherwise>${dto.getMember_email()}</c:otherwise></c:choose></td>
                                <td ${showLink} class="eng table-list-hide"><c:choose><c:when test="${search_phone != ''}">${dto.getMember_phone().replace(search_phone, result_phone)}</c:when><c:otherwise>${dto.getMember_phone()}</c:otherwise></c:choose></td>
                                <td ${showLink} class="eng table-list-hide"><fmt:formatNumber value="${dto.getMember_point()}" /></td>
                                <td ${showLink} class="eng table-list-hide-mob">${dto.getMember_joindate().substring(0,10)}<br />${dto.getMember_joindate().substring(11)}</td>
                                <td>
                                    <a href="${path}/admin/member/member_modify.do?no=${dto.getMember_no()}&search_type=${search_type}&search_name=${search_name}&search_id=${search_id}&search_email=${search_email}&search_phone=${search_phone}&page=${paging.getPage()}" class="btn btn-outline-success btn-sm m-1">수정</a>
                                    <a href="${path}/admin/member/member_delete.do?no=${dto.getMember_no()}" class="btn btn-outline-danger btn-sm my-1" onclick="return confirm('정말 삭제하시겠습니까?\n되돌릴 수 없습니다.');">삭제</a>
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
        <c:when test="${!empty keyword}"><a href="${path}/admin/member/member_list.do" class="btn btn-outline-secondary"><i class="fa fa-list"></i> 회원 목록</a></c:when>
        <c:otherwise><a href="${path}/admin/member/member_write.do" class="btn btn-primary"><i class="fa fa-plus"></i> 회원 추가</a></c:otherwise>
        </c:choose>
    </div>
</div>


<%@ include file="../layout/layout_footer.jsp" %>