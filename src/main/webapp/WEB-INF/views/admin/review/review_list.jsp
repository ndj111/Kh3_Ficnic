<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<script type="text/javascript">$("#header .navbar .nav-item:nth-child(6)").addClass("active");</script>


<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>리뷰 목록</h2>
        <ol class="m-0 p-2">
            <li>리뷰 관리</li>
            <li><b>리뷰 목록</b></li>
        </ol>
    </div>
</div>



<div class="page-cont">
    <div class="row mb-3">
        <div class="col-lg">
            <div class="card">
                <div class="card-body px-5 pt-4 pb-3">
                    <form name="search_form" method="get" action="${path}/admin/review/review_list.do" class="row py-2 px-3">
                    <div class="row justify-content-center">
                    	<div class="col-lg-9">
                    		<div class="row justify-content-center">
		                        <div class="col-md-4 mb-2">
		                            <div class="input-group">
		                                <div class="input-group-prepend">
		                                    <label class="input-group-text" for="search_ficnic">피크닉</label>
		                                </div>
		                                <input type="text" id="search_ficnic" name="search_ficnic" value="${search_ficnic}" class="form-control">
		                            </div>
		                        </div>
		                        <div class="col-md-4 mb-2">
		                            <div class="input-group">
		                                <div class="input-group-prepend">
		                                    <label class="input-group-text" for="search_review">리뷰내용</label>
		                                </div>
		                                <input type="text" id="search_review" name="search_review" value="${search_review}" class="form-control">
		                            </div>
		                        </div>
		                        <div class="col-md-4 mb-2">
		                            <div class="input-group">
		                                <div class="input-group-prepend">
		                                    <label class="input-group-text" for="search_writer">작성자</label>
		                                </div>
		                                <input type="text" id="search_writer" name="search_writer" value="${search_writer}" class="form-control">
		                            </div>
		                        </div>
                    		</div>
                    	</div>
                        <div class="search-form-button col-lg-auto text-center">
                            <button type="submit" class="btn btn-secondary mb-2"><i class="fa fa-search"></i> 검색하기</button>
                            <a href="${path}/admin/review/review_list.do" class="btn btn-outline-secondary ml-1 mb-2"><i class="fa fa-refresh"></i> 초기화</a>
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
                <div class="card-header bg-white border-0 pt-4 pl-4">총 <b class="text-primary"><fmt:formatNumber value="${totalCount}" /></b> 개의 리뷰</div>

                <div class="card-body px-4 pt-0">
                    <table class="table-list hover mb-2">
                        <thead>
                            <tr>
								<th style="width: 4.5%; min-width: 50px;" class="table-list-hide">No.</th>
								<th style="width: 10%; min-width: 120px;">리뷰 사진</th>
								<th style="width: 18%; min-width: 200px;" class="table-list-hide">피크닉</th>
								<th style="width: 6%; min-width: 70px;">평점</th>
								<th>리뷰 내용</th>
								<th style="width: 10%; min-width: 110px;" class="table-list-hide">작성자<br />아이디</th>
								<th style="width: 11%; min-width: 120px;" class="table-list-hide-mob">작성일</th>
								<th style="width: 10%; min-width: 110px;" class="table-list-hide-mob">기능</th>
                            </tr>
                        </thead>

                        <tbody>
                        	<c:set var="list" value="${List}" />
							<c:choose>
							<c:when test="${!empty List}">
							<c:forEach items="${list}" var="dto">
							<c:set var="showLink" value="onclick=\"popWindow('review_view.do?no=${dto.getReview_no()}', '700', '900');\"" />
							<c:set var="result_ficnic" value="<span class=\"search\">${search_ficnic}</span>"></c:set>
							<c:set var="result_review" value="<span class=\"search\">${search_review}</span>"></c:set>
							<c:set var="result_writer" value="<span class=\"search\">${search_writer}</span>"></c:set>
                            <tr>
                                <td ${showLink} class="py-4 table-list-hide">${dto.getReview_no()}</td>
								<td class="photo px-3" ${showLink}>
				                    <c:choose>
				                    <c:when test="${!empty dto.getReview_photo1() }"><img src="${path}${dto.getReview_photo1()}" alt="" /></c:when>
				                    <c:otherwise><span class="noimg" style="height: 98px; padding-top: 42px;">no img</span></c:otherwise>
				                    </c:choose>
								</td>
								<td ${showLink} class="text-left table-list-hide"><c:choose><c:when test="${search_ficnic != ''}">${dto.getFicnic_name().replace(search_ficnic, result_ficnic)}</c:when><c:otherwise>${dto.getFicnic_name()}</c:otherwise></c:choose></td>
								<td ${showLink} class="eng">${dto.review_point}</td>
								<td ${showLink} class="px-2"><c:choose><c:when test="${dto.review_cont.length() > 24}">${dto.review_cont.substring(0,24)} ...</c:when><c:otherwise>${dto.review_cont}</c:otherwise></c:choose></td>
								<td ${showLink} class="table-list-hide">
                                    <p><b><c:choose><c:when test="${search_writer != ''}">${dto.getReview_name().replace(search_writer, result_writer)}</c:when><c:otherwise>${dto.getReview_name()}</c:otherwise></c:choose></b></p>
                                    <p class="eng"><c:choose><c:when test="${search_writer != ''}">${dto.getMember_id().replace(search_writer, result_writer)}</c:when><c:otherwise>${dto.getMember_id()}</c:otherwise></c:choose></p>
                                </td>
								<td ${showLink} class="table-list-hide-mob eng">${dto.review_date.substring(0,10)}<br />${dto.review_date.substring(11)}</td>
                                <td class="table-list-hide-mob">
                                    <a href="${path}/admin/review/review_modify.do?no=${dto.getReview_no()}&search_ficnic=${search_ficnic}&search_review=${search_review}&search_writer=${search_writer}&page=${paging.getPage()}" class="btn btn-outline-success btn-sm m-1">수정</a>
                                    <a href="${path}/admin/review/review_delete.do?review_no=${dto.getReview_no()}&ficnic_no=${dto.getFicnic_no()}&search_ficnic=${search_ficnic}&search_review=${search_review}&search_writer=${search_writer}" class="btn btn-outline-danger btn-sm my-1" onclick="return confirm('정말 삭제하시겠습니까?\n되돌릴 수 없습니다.');">삭제</a>
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
        <c:otherwise><a href="${path}/admin/review/review_write.do" class="btn btn-primary"><i class="fa fa-plus"></i> 리뷰 추가</a></c:otherwise>
        </c:choose>
    </div>
</div>


<%@ include file="../layout/layout_footer.jsp" %>