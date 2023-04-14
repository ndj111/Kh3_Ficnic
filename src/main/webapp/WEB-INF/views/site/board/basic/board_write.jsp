<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../layout/layout_header.jsp" %>
<c:if test="${level.write ne 'Y'}"><script>alert('게시물 작성/수정 권한이 없습니다.'); history.back();</script></c:if>


<c:choose>
	<c:when test="${!empty m }">
		<c:set var="tag" value="${path}/board/board_modify_ok.do" />
		<c:set var="category" value="${Cont.getBdata_category()}" />
		<c:set var="title" value="${Cont.getBdata_title()}" />
		<c:set var="cont" value="${Cont.getBdata_cont()}" />
		<c:set var="subcont" value="${Cont.getBdata_sub()}" />
		<c:set var="link1" value="${Cont.getBdata_link1()}" />
		<c:set var="link2" value="${Cont.getBdata_link2()}" />
		<c:set var="file1" value="${Cont.getBdata_file1()}" />
		<c:set var="file2" value="${Cont.getBdata_file2()}" />
		<c:set var="file3" value="${Cont.getBdata_file3()}" />
		<c:set var="file4" value="${Cont.getBdata_file4()}" />
		<c:set var="ficnic" value="${Cont.getBdata_ficnic()}" />
		<c:set var="notice" value="${Cont.getBdata_use_notice()}" />
		<c:set var="secret" value="${Cont.getBdata_use_secret()}" />
		<c:set var="id" value="${Cont.getBdata_writer_id()}" />
		<c:set var="name" value="${Cont.getBdata_writer_name()}" />
		<c:set var="bdata_no" value="${Cont.getBdata_no()}" />
		<c:set var="bbs_id" value="${Cont.getBoard_id()}" />
	</c:when>
	<c:otherwise>
		<c:set var="tag" value="${path}/board/board_write_ok.do" />
        <c:set var="bbs_id" value="${param.bbs_id}" />
	</c:otherwise>
</c:choose>
<c:set var="folder" value="/resources/data/board/${param.bbs_id}/" />


<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_board.css" />
<script language="javascript" src="${path}/resources/site/js/js_board.js"></script>


<%@ include file="../../layout/layout_csmenu.jsp" %>



<div class="contents w1100 board-write">

	<form name="form_input" method="post" enctype="multipart/form-data" action="${tag}">
    <div class="row">
        <div class="col-lg mb-4">
            <div class="card input-form">
                <div class="card-body p-4">
					<c:if test="${!empty m}">
					<input type="hidden" name="bdata_no" value="${bdata_no}" />
					<input type="hidden" name="bbs_id" value="${bbs_id}" />
					</c:if>
					<input type="hidden" name="board_id" value="${bbs_id}" />
					<c:if test="${!empty sess_id}"><input type="hidden" name="bdata_writer_id" value="${sess_id}" /></c:if>

                    <h4 class="mb-3">게시물 <c:choose><c:when test="${!empty m}">수정</c:when><c:otherwise>등록</c:otherwise></c:choose>하기</h4>
                    <div class="row form">
						<c:choose>
							<c:when test="${!empty sess_id and empty m}">
		                        <div class="form-group">
		                            <label for="bdata_writer_name"><span>*</span> 작성자 이름</label>
									<input type="text" name="bdata_writer_name" id="bdata_writer_name" value="${sess_name}" maxlength="30" class="form-control w-20" readonly="readonly" />
									<input type="hidden" name="bdata_writer_pw" value="${sess_pw}" />
		                        </div>
							</c:when>

							<c:when test="${!empty m}">
		                        <div class="form-group">
		                            <label for="bdata_writer_name"><span>*</span> 작성자 이름</label>
									<input type="text" name="bdata_writer_name" id="bdata_writer_name" value="${name}" maxlength="30" class="form-control w-20" readonly="readonly" />
		                        </div>
							</c:when>

							<c:otherwise>
		                        <div class="form-group col-sm-6">
		                            <label for="bdata_writer_name"><span>*</span> 작성자 이름</label>
									<input type="text" name="bdata_writer_name" id="bdata_writer_name" maxlength="30" class="form-control w-40" required />
		                        </div>
		                        <div class="form-group col-sm-6">
		                            <label for="bdata_writer_pw"><span>*</span> 작성자 비밀번호</label>
									<input type="password" name="bdata_writer_pw" id="bdata_writer_pw" maxlength="30" class="form-control w-40" required />
		                        </div>
							</c:otherwise>
						</c:choose>
                        <div class="w-100 mt-2 border-bottom"></div>


                        <c:if test="${conf.getBoard_use_secret() eq 'Y' or level.notice eq 'Y'}">
                        <div class="form-group col">
                            <label>글작성 옵션</label>
                            <div class="custom-control custom-checkbox">
		                        <c:choose>
		                        	<c:when test="${conf.getBoard_use_only_secret() eq 'Y'}">
		                        		<span class="mr-5">
		                                	<input type="checkbox" name="bdata_use_secret" value="Y" class="custom-control-input" id="bdata_use_secret" checked="checked" disabled="disabled" />
		                                	<label class="custom-control-label" for="bdata_use_secret">비밀글</label>
		                                </span>
		                        	</c:when>

		                        	<c:otherwise>
		                        		<c:choose>
		                        			<c:when test="${conf.getBoard_use_secret() eq 'Y'}">
		                        				<span class="mr-5">
				                                	<input type="checkbox" name="bdata_use_secret" value="Y" class="custom-control-input" id="bdata_use_secret"<c:if test="${secret eq 'Y'}"> checked="checked"</c:if> />
				                                	<label class="custom-control-label" for="bdata_use_secret">비밀글</label>
				                                </span>
		                        			</c:when>

		                        			<c:otherwise><input type="hidden" name="bdata_use_secret" value="N" /></c:otherwise>
		                        		</c:choose>
		                        	</c:otherwise>
		                        </c:choose>


		                        <c:choose>
		                        	<c:when test="${level.notice eq 'Y'}">
		                        		<span>
		                					<input type="checkbox" name="bdata_use_notice" value="Y" class="custom-control-input" id="bdata_use_notice"<c:if test="${notice eq 'Y'}"> checked="checked"</c:if> />
		                        			<label class="custom-control-label" for="bdata_use_notice">공지사항</label>
		                        		</span>
		                        	</c:when>
		                        	<c:otherwise><input type="hidden" name="bdata_use_notice" value="N" /></c:otherwise>
		                        </c:choose>

                            </div>
                        </div>
                        <div class="w-100"></div>
                        </c:if>


                        <c:if test="${conf.getBoard_use_category() eq 'Y'}">
	                        <div class="form-group">
	                            <label for="bdata_category">카테고리</label>
	                            <select name="bdata_category" id="bdata_category" class="custom-select w-20">
		                            <c:forEach var="cateList" items="${BoardCate}">
		                            <option value="${cateList.getBcate_no()}"<c:if test="${category eq cateList.getBcate_no()}"> selected=\"selected\"</c:if>>${cateList.getBcate_name()}</option>
		                            </c:forEach>
	                            </select>
	                        </div>
	                        <div class="w-100"></div>
                    	</c:if>


                        <div class="form-group">
                            <label for="bdata_title"><span>*</span> 제목</label>
                            <input type="text" name="bdata_title" id="bdata_title" value="${title}" maxlength="255" class="form-control" required />
                        </div>
                        <div class="w-100 mt-2 border-bottom"></div>


                        <div class="form-group col">
                            <label for="bdata_cont" style="padding: 132px 0;"><span>*</span> 글 내용</label>
                            <textarea name="bdata_cont" id="bdata_cont" class="form-control" rows="12" required>${cont}</textarea>
                        </div>
                        <div class="w-100 mt-2 border-bottom"></div>


                        <c:if test="${conf.getBoard_use_link1() eq 'Y'}">
	                        <div class="form-group">
	                            <label for="bdata_link1" style="padding: 9px 0;">관련사이트<br />링크 #1</label>
	                            <input type="text" name="bdata_link1" id="bdata_link1" value="${link1}" maxlength="255" class="form-control" placeholder="http:// 를 포함하여 전체 URL을 입력해 주세요" />
	                        </div>
                        </c:if>

                        <c:if test="${conf.getBoard_use_link2() eq 'Y'}">
	                        <div class="form-group">
	                            <label for="bdata_link2" style="padding: 9px 0;">관련사이트<br />링크 #1</label>
	                            <input type="text" name="bdata_link2" id="bdata_link2" value="${link2}" maxlength="255" class="form-control" placeholder="http:// 를 포함하여 전체 URL을 입력해 주세요" />
	                        </div>
                        </c:if>

                        <c:if test="${conf.getBoard_use_link1() eq 'Y' or conf.getBoard_use_link2() eq 'Y'}">
                        	<div class="w-100 mt-2 border-bottom"></div>
                    	</c:if>


                    	<c:if test="${conf.getBoard_use_file1() eq 'Y' }">
	                        <div class="form-group join-form">
	                            <label for="file1">첨부파일 #1</label>
	                            <div class="jf-input pb-1">
	                                <div class="row">
	                                    <div class="col-md-5"><input type="file" name="file1" id="file1" class="form-control" /></div>

	                                    <c:if test="${!empty file1}">
	                                    <div class="col-md-auto align-self-center pl-0">
	                                        <div class="custom-control">등록된 파일 (<b>${file1.replace(folder, '')}</b>)</div>
	                                    </div>
	                                    </c:if>
                                        <c:if test="${!empty m}"><input type="hidden" name="ori_file1" value="${file1}" /></c:if>
	                                </div>
	                            </div>
	                        </div>
                    	</c:if>

                    	<c:if test="${conf.getBoard_use_file2() eq 'Y' }">
	                        <div class="form-group join-form">
	                            <label for="file2">첨부파일 #2</label>
	                            <div class="jf-input pb-1">
	                                <div class="row">
	                                    <div class="col-md-5"><input type="file" name="file2" id="file2" class="form-control" /></div>

	                                    <c:if test="${!empty file2}">
	                                    <div class="col-md-auto align-self-center pl-0">
	                                        <div class="custom-control">등록된 파일 (<b>${file2.replace(folder, '')}</b>)</div>
	                                    </div>
	                                    </c:if>
                                        <c:if test="${!empty m}"><input type="hidden" name="ori_file2" value="${file2}" /></c:if>
	                                </div>
	                            </div>
	                        </div>
                    	</c:if>

                    	<c:if test="${conf.getBoard_use_file3() eq 'Y' }">
	                        <div class="form-group join-form">
	                            <label for="file3">첨부파일 #3</label>
	                            <div class="jf-input pb-1">
	                                <div class="row">
	                                    <div class="col-md-5"><input type="file" name="file3" id="file3" class="form-control" /></div>

	                                    <c:if test="${!empty file3}">
	                                    <div class="col-md-auto align-self-center pl-0">
	                                        <div class="custom-control">등록된 파일 (<b>${file3.replace(folder, '')}</b>)</div>
	                                    </div>
	                                    </c:if>
                                        <c:if test="${!empty m}"><input type="hidden" name="ori_file3" value="${file3}" /></c:if>
	                                </div>
	                            </div>
	                        </div>
                    	</c:if>

                    	<c:if test="${conf.getBoard_use_file4() eq 'Y' }">
	                        <div class="form-group join-form">
	                            <label for="file4">첨부파일 #4</label>
	                            <div class="jf-input pb-1">
	                                <div class="row">
	                                    <div class="col-md-5"><input type="file" name="file4" id="file4" class="form-control" /></div>

	                                    <c:if test="${!empty file4}">
	                                    <div class="col-md-auto align-self-center pl-0">
	                                        <div class="custom-control">등록된 파일 (<b>${file4.replace(folder, '')}</b>)</div>
	                                    </div>
	                                    </c:if>
                                        <c:if test="${!empty m}"><input type="hidden" name="ori_file4" value="${file4}" /></c:if>
	                                </div>
	                            </div>
	                        </div>
                    	</c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <div class="mt-2 input-form-button text-center">
        <div class="col text-center">
            <button type="button" class="btn btn-secondary btn-lg mx-2" onclick="history.back();"><i class="icon-arrow-left"></i> 취소하기</button>
            <button type="submit" class="btn btn-primary btn-lg"><c:choose><c:when test="${!empty m}"><i class="icon-note mr-1"></i> 수정하기</c:when><c:otherwise><i class="icon-pencil mr-1"></i> 등록하기</c:otherwise></c:choose></button>
        </div>
    </div>
    </form>

</div>



<%@ include file="../../layout/layout_footer.jsp" %>