<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../layout/layout_header.jsp" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:if test="${level.view ne 'Y'}"><script>alert('게시물 보기 권한이 없습니다.'); history.back();</script></c:if>
<c:set var="folder" value="/resources/data/board/${param.bbs_id}/" />

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_board.css" />
<script language="javascript" src="${path}/resources/site/js/js_board.js"></script>


<%@ include file="../../layout/layout_csmenu.jsp" %>


<div class="contents w1100 view-form board-view">

    <div class="row vf-body">
        <div class="col-lg mb-4">
            <div class="card border-0">
                <div class="card-body p-0 pt-2">
                    <h2>${BoardConDto.getBdata_title()}</h2>

                    <div class="d-flex py-2 border-bottom vfb-info">
                        <div class="col text-left">
                            <p>${BoardConDto.getBdata_date()}</p>
                            <p>조회수 : <fmt:formatNumber value="${BoardConDto.getBdata_hit()}" /></p>
                        </div>

                        <div class="col text-right pt-2">
                        	<p class="writer">
                                <c:choose>
                                    <c:when test="${BoardConDto.getBdata_writer_type() eq 'admin'}"><img src="${path}/resources/site/images/admin_icon.png" alt="" /><b>관리자</b></c:when>
                                    <c:otherwise>${BoardConDto.getBdata_writer_name()}<c:if test="${!empty BoardConDto.getBdata_writer_id()}"> (${BoardConDto.getBdata_writer_id()})</c:if></c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>

                    <c:if test="${!empty BoardConDto.getBdata_link1()}">
                    	<div class="d-flex py-2 border-bottom">
            				<div class="col"><i class="fa fa-link"></i> 관련링크 #1 : <a href="${BoardConDto.getBdata_link1()}" target="_blank">${BoardConDto.getBdata_link1()}</a></div>
            			</div>
                    </c:if>
                    <c:if test="${!empty BoardConDto.getBdata_link2()}">
                    	<div class="d-flex py-2 border-bottom">
            				<div class="col"><i class="fa fa-link"></i> 관련링크 #2 : <a href="${BoardConDto.getBdata_link2()}" target="_blank">${BoardConDto.getBdata_link2()}</a></div>
            			</div>
                    </c:if>


					<c:if test="${!empty BoardConDto.getBdata_file1_img()}">
						<div class="pt-3 text-center vfb-photo"><img src="${path}${BoardConDto.getBdata_file1_img()}" alt="" /></div>
					</c:if>
					<c:if test="${!empty BoardConDto.getBdata_file2_img()}">
						<div class="pt-3 text-center vfb-photo"><img src="${path}${BoardConDto.getBdata_file2_img()}" alt="" /></div>
					</c:if>
					<c:if test="${!empty BoardConDto.getBdata_file3_img()}">
						<div class="pt-3 text-center vfb-photo"><img src="${path}${BoardConDto.getBdata_file3_img()}" alt="" /></div>
					</c:if>
					<c:if test="${!empty BoardConDto.getBdata_file4_img()}">
						<div class="pt-3 text-center vfb-photo"><img src="${path}${BoardConDto.getBdata_file4_img()}" alt="" /></div>
					</c:if>


                    <div class="d-flex pt-4 pb-5 border-bottom">
                        <div class="col">
                            ${BoardConDto.getBdata_cont().replace(newLine, '<br />')}
                        </div>
                    </div>


					<c:if test="${!empty BoardConDto.getBdata_file1_file()}">
						<div class="d-flex py-2 border-bottom">
							<div class="col"><i class="fa fa-save"></i> 첨부파일 #1 : <a href="${path}/board/board_download.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}&bdata_file=1">${BoardConDto.getBdata_file1_file().replace(folder, '')}</a></div>
                    	</div>
					</c:if>
					<c:if test="${!empty BoardConDto.getBdata_file2_file()}">
						<div class="d-flex py-2 border-bottom">
							<div class="col"><i class="fa fa-save"></i> 첨부파일 #2 : <a href="${path}/board/board_download.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}&bdata_file=2">${BoardConDto.getBdata_file2_file().replace(folder, '')}</a></div>
                    	</div>
					</c:if>
					<c:if test="${!empty BoardConDto.getBdata_file3_file()}">
						<div class="d-flex py-2 border-bottom">
							<div class="col"><i class="fa fa-save"></i> 첨부파일 #3 : <a href="${path}/board/board_download.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}&bdata_file=3">${BoardConDto.getBdata_file3_file().replace(folder, '')}</a></div>
                    	</div>
					</c:if>
					<c:if test="${!empty BoardConDto.getBdata_file4_file()}">
						<div class="d-flex py-2 border-bottom">
							<div class="col"><i class="fa fa-save"></i> 첨부파일 #4 : <a href="${path}/board/board_download.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}&bdata_file=4">${BoardConDto.getBdata_file4_file().replace(folder, '')}</a></div>
                    	</div>
					</c:if>
                </div>
            </div>
        </div>
    </div>
    <!-- 내용 //END -->



    <!-- 버튼 //START -->
    <div class="d-flex justify-content-center vf-btn mt-3 mb-5">
    	<c:choose>
    		<c:when test="${level.delete ne 'Y'}">
    			<c:choose>
    				<c:when test="${!empty BoardConDto.getBdata_writer_id()}">
    					<c:if test="${BoardConDto.getBdata_writer_id() eq sess_id}"><a href="board_delete.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}" class="btn btn-danger mx-1" onclick="return confirm('정말 삭제하시겠습니까?\n되돌릴 수 없습니다.');"><i class="icon-trash mr-1"></i> 삭제하기</a></c:if>
		    		</c:when>

		    		<c:otherwise>
		    			<c:choose>
		    				<c:when test="${BoardConDto.getBdata_writer_pw() eq sess_pw or sess_type eq 'admin'}">
		    					<a href="board_delete.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}" class="btn btn-danger mx-1" onclick="return confirm('정말 삭제하시겠습니까?\n되돌릴 수 없습니다.');"><i class="icon-trash mr-1"></i> 삭제하기</a>
		    				</c:when>
		    				<c:otherwise>
		    					<button type="button" class="btn btn-danger mx-1" data-toggle="modal" data-target="#deleteModal"><i class="icon-trash mr-1"></i> 삭제하기</button>
		    				</c:otherwise>
		    			</c:choose>
		    		</c:otherwise>
		    	</c:choose>
    		</c:when>
    		<c:otherwise>
        		<a href="board_delete.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}" class="btn btn-danger mx-1" onclick="return confirm('정말 삭제하시겠습니까?\n되돌릴 수 없습니다.');"><i class="icon-trash mr-1"></i> 삭제하기</a>
    		</c:otherwise>
    	</c:choose>


    	<c:choose>
    		<c:when test="${level.modify ne 'Y'}">
    			<c:choose>
    				<c:when test="${!empty BoardConDto.getBdata_writer_id()}">
    					<c:if test="${BoardConDto.getBdata_writer_id() eq sess_id}"><a href="board_modify.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}" class="btn btn-primary mx-1"><i class="icon-note mr-1"></i> 수정하기</a></c:if>
		    		</c:when>

		    		<c:otherwise>
		    			<c:choose>
		    				<c:when test="${BoardConDto.getBdata_writer_pw() eq sess_pw}">
		    					<a href="board_modify.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}" class="btn btn-primary mx-1"><i class="icon-note mr-1"></i> 수정하기</a>
		    				</c:when>
		    				<c:otherwise>
		    					<button type="button" class="btn btn-primary mx-1" data-toggle="modal" data-target="#modifyModal"><i class="icon-note mr-1"></i> 수정하기</button>
		    				</c:otherwise>
		    			</c:choose>
		    		</c:otherwise>
		    	</c:choose>
    		</c:when>
    		<c:otherwise>
    			<a href="board_modify.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}" class="btn btn-primary mx-1"><i class="icon-note mr-1"></i> 수정하기</a>
    		</c:otherwise>
    	</c:choose>


        <a href="board_list.do?bbs_id=${BoardConDto.getBoard_id()}&field=${param.field}&keyword=${param.keyword}&category=${param.category}&page=${param.page}" class="btn btn-secondary mx-1"><i class="icon-list mr-1"></i> 목록보기</a>
    </div>
    <!-- 버튼 //END -->




    <!-- 댓글 //START -->
    <div class="row vf-comment">
        <div class="col-lg">
            <div class="card border input-form">
                <div class="card-body pt-3 pb-4">
                    <ul class="vfc-list">
                		<c:if test="${!empty boardCommentList }">
                        <c:forEach var="comment" items="${boardCommentList}">
                        <li id="comment-${comment.getBcomm_no()}" class="d-flex border-bottom py-3">
                            <div class="vfcl-writer">
                            	<c:choose>
                            		<c:when test="${comment.getBcomm_type() eq 'admin'}"><img src="${path}/resources/site/images/admin_icon.png" alt="" /><b>관리자</b></c:when>
                            		<c:otherwise>${comment.getBcomm_name()}</c:otherwise>
                            	</c:choose>
                        	</div>
                            <div class="vfcl-body px-3">${comment.getBcomm_cont().replace(newLine, '<br />')}</div>
                            <div class="vfcl-date text-center">
                                <p>${comment.getBcomm_date().substring(0,10)}<br />${comment.getBcomm_date().substring(11)}</p>

                                <c:choose>
                                	<c:when test="${sess_type eq 'admin'}">
                                		<button type="button" class="btn btn-sm btn-outline-danger py-0 mt-2" onclick="delComment('nochk', '${BoardConDto.getBoard_id()}', ${comment.getBdata_no()}, ${comment.getBcomm_no()});"><i class="icon-close mr-1"></i> 삭제</button>
                                	</c:when>

                                	<c:otherwise>
		                                <c:choose>
		                                	<c:when test="${!empty comment.getBcomm_id() and comment.getBcomm_id() eq sess_id}">
		                                		<button type="button" class="btn btn-sm btn-outline-danger py-0 mt-2" onclick="delComment('nochk', '${BoardConDto.getBoard_id()}', ${comment.getBdata_no()}, ${comment.getBcomm_no()});"><i class="icon-close mr-1"></i> 삭제</button>
		                                	</c:when>

		                                	<c:otherwise>
	                                			<c:if test="${comment.getBcomm_type() ne 'admin'}">
	                                				<button type="button" class="btn btn-sm btn-outline-danger py-0 mt-2" onclick="setCommentDel('${BoardConDto.getBoard_id()}', ${comment.getBdata_no()}, ${comment.getBcomm_no()});"><i class="icon-close mr-1"></i> 삭제</button>
	                                			</c:if>
		                                	</c:otherwise>
		                                </c:choose>
                                	</c:otherwise>
                                </c:choose>
                            </div>
                        </li>
                    	</c:forEach>
                		</c:if>
                    </ul>

                    <c:if test="${level.comment eq 'Y'}">
                    <form name="comment_form" method="post">
                    <input type="hidden" name="bbs_id" value="${BoardConDto.getBoard_id()}" />
    				<input type="hidden" name="bdata_no" value="${BoardConDto.getBdata_no()}" />
                    <div class="d-flex justify-content-center vfc-form">
                        <div class="vfcf-writer">
                    	    <c:choose>
                    	    	<c:when test="${!empty sess_id}">
        							<input type="hidden" name="bcomm_id" value="${sess_id}" />
        							<input type="hidden" name="bcomm_pw" value="${sess_pw}" />
        							<input type="hidden" name="bcomm_name" value="${sess_name}" />
        							<input type="hidden" name="sess" value="${sess_type}" />
        							${sess_name}
        						</c:when>
        						<c:otherwise>
		                        	<input type="text" name="bcomm_name" value="" class="form-control my-2" placeholder="이름" />
		                        	<input type="password" name="bcomm_pw" value="" class="form-control my-2" placeholder="비번" />
        						</c:otherwise>
        					</c:choose>
                        </div>
                        <div class="vfcf-input"><textarea name="bcomm_cont" class="form-control" rows="4"></textarea></div>
                        <div class="vfcf-btn">
                            <button type="button" class="btn btn-info" onclick="addComment('comment_form')">
                                <i class="icon-pencil mr-1"></i> 댓글 등록
                            </button>
                        </div>
                    </div>
                    </form>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    <!-- 댓글 //END -->


</div>




<c:if test="${level.delete ne 'Y'}">
<!-- 삭제하기 Modal //START -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body text-center p-5">
                <h4 class="mt-5">게시물 비밀번호를 입력하세요.</h4>
                <p>&nbsp;</p>
                <form name="delete_form" method="post" action="board_delete.do">
                <input type="hidden" name="bbs_id" value="${BoardConDto.getBoard_id()}" />
                <input type="hidden" name="bdata_no" value="${BoardConDto.getBdata_no()}" />
                <input type="password" name="input_pw" class="form-control rounded mb-2 w-50 m-auto text-center" required />
                <button type="submit" class="btn btn-outline-danger w-50 mb-5"><i class="fa fa-trash-o"></i> 삭제하기</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- 삭제하기 Modal //END -->
</c:if>


<c:if test="${level.delete ne 'Y'}">
<!-- 수정하기 Modal //START -->
<div class="modal fade" id="modifyModal" tabindex="-1" aria-labelledby="modifyModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body text-center p-5">
                <h4 class="mt-5">게시물 비밀번호를 입력하세요.</h4>
                <p>&nbsp;</p>
                <form name="delete_form" method="post" action="board_modify.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}">
                <input type="password" name="input_pw" class="form-control rounded mb-2 w-50 m-auto text-center" required />
                <button type="submit" class="btn btn-outline-primary w-50 mb-5"><i class="icon-note"></i> 비밀번호 확인</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- 수정하기 Modal //END -->
</c:if>



<c:if test="${sess_type ne 'admin'}">
<!-- 댓글삭제 Modal //START -->
<div class="modal fade" id="commentModal" tabindex="-1" aria-labelledby="commentModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-sm modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body text-center p-2">
                <h5 class="mt-4">댓글 비밀번호를 입력하세요.</h5>
                <p>&nbsp;</p>
                <input type="password" name="input_pw" class="form-control rounded mb-2 w-50 m-auto text-center" required />
                <button type="button" class="btn btn-outline-danger w-50 mb-4" onclick=""><i class="fa fa-trash-o"></i> 댓글삭제</button>
            </div>
        </div>
    </div>
</div>
<!-- 댓글삭제 Modal //END -->
</c:if>




<%@ include file="../../layout/layout_footer.jsp" %>