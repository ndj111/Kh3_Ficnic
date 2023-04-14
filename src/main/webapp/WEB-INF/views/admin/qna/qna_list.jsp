<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<script type="text/javascript">$("#header .navbar .nav-item:nth-child(5)").addClass("active");</script>



<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>문의 목록</h2>
        <ol class="m-0 p-2">
            <li>문의 관리</li>
            <li><b>문의 목록</b></li>
        </ol>
    </div>
</div>




<div class="page-cont">
    <div class="row mb-3">
        <div class="col-lg">
            <div class="card">
                <div class="card-body px-5 pt-4 pb-3">
                    <form name="search_form" method="get" action="${path}/admin/qna/qna_list.do" class="row py-2 px-3">
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
		                                    <label class="input-group-text" for="search_qna">문의제목</label>
		                                </div>
		                                <input type="text" id="search_qna" name="search_qna" value="${search_qna}" class="form-control">
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
                            <a href="${path}/admin/qna/qna_list.do" class="btn btn-outline-secondary ml-1 mb-2"><i class="fa fa-refresh"></i> 초기화</a>
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
                <div class="card-header bg-white border-0 pt-4 pl-4">총 <b class="text-primary"><fmt:formatNumber value="${totalCount}" /></b> 개의 문의</div>

                <div class="card-body px-4 pt-0">
                    <table class="table-list hover mb-2">
                        <thead>
                            <tr>
								<th style="width: 4.5%; min-width: 50px;">No.</th>
								<th style="width: 18%; min-width: 200px;" class="table-list-hide">피크닉</th>
								<th>제목</th>
								<th style="width: 10%; min-width: 110px;" class="table-list-hide-mob">작성자<br />아이디</th>
								<th style="width: 11%; min-width: 120px;" class="table-list-hide-mob">작성일</th>
								<th style="width: 7%; min-width: 70px;">기능</th>
                            </tr>
                        </thead>

                        <tbody>
                        	<c:set var="list" value="${List}" />
							<c:choose>
							<c:when test="${!empty list}">
							<c:forEach items="${list}" var="dto">
							<c:set var="showLink" value="onclick=\"popWindow('qna_view.do?no=${dto.getQna_no()}', '700', '900');\"" />
							<c:set var="result_ficnic" value="<span class=\"search\">${search_ficnic}</span>"></c:set>
							<c:set var="result_qna" value="<span class=\"search\">${search_qna}</span>"></c:set>
							<c:set var="result_writer" value="<span class=\"search\">${search_writer}</span>"></c:set>
                            <tr>
                                <td ${showLink} class="py-4">${dto.getQna_no()}</td>
                                <td ${showLink} class="px-3 table-list-hide">
                                	<c:choose>
                                		<c:when test="${search_ficnic != ''}">${dto.getFicnic_name().replace(search_ficnic, result_ficnic)}</c:when>
                                		<c:otherwise>${dto.getFicnic_name()}</c:otherwise>
                                	</c:choose>
                                </td>
								<td ${showLink}>
									<c:choose>
										<c:when test="${search_qna != ''}">${dto.getQna_title().replace(search_qna, result_qna)}</c:when>
										<c:otherwise>${dto.getQna_title()}</c:otherwise>
									</c:choose>
									<c:if test="${dto.getQna_comment() > 0}"><span class="comnum"><i class="fa fa-comment-o"></i> ${dto.getQna_comment()}</span></c:if>
								</td>
								<td ${showLink} class="table-list-hide-mob">
									<p><b><c:choose><c:when test="${search_writer != ''}">${dto.getQna_name().replace(search_writer, result_writer)}</c:when><c:otherwise>${dto.getQna_name()}</c:otherwise></c:choose></b></p>
									<p class="eng"><c:choose><c:when test="${search_writer != ''}">${dto.getMember_id().replace(search_writer, result_writer)}</c:when><c:otherwise>${dto.getMember_id()}</c:otherwise></c:choose></p>
								</td>
								<td ${showLink} class="table-list-hide-mob eng">${dto.qna_date.substring(0,10)}<br />${dto.qna_date.substring(11)}</td>
                                <td>
                                    <a href="${path}/admin/qna/qna_delete.do?no=${dto.qna_no}" class="btn btn-outline-danger btn-sm my-1" onclick="return confirm('정말 삭제하시겠습니까?\n되돌릴 수 없습니다.');">삭제</a>
                                </td>
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
    <div class="col text-center mt-3">
    	<c:if test="${!empty paging}">${pagingWrite}</c:if>
    </div>
</div>


<%@ include file="../layout/layout_footer.jsp" %>