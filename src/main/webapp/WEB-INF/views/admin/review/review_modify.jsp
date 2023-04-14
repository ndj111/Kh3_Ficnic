<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<script type="text/javascript">$("#header .navbar .nav-item:nth-child(6)").addClass("active");</script>


<c:set var="dto" value="${Modify}" />
<c:set var="rlist" value="${rlist }" />



<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>리뷰 수정</h2>
        <ol class="m-0 p-2">
            <li>리뷰 관리</li>
            <li><b>리뷰 수정</b></li>
        </ol>
    </div>
</div>




<form name="form_input" method="post" enctype="multipart/form-data" action="${path}/admin/review/review_modify_ok.do">
<input type="hidden" name="review_no" value="${dto.review_no}" />
<input type="hidden" name="ficnic_no" value="${dto.ficnic_no}" />
<div class="page-cont">
    <div class="row">
        <div class="col-lg mb-4">
            <div class="card input-form">
                <div class="card-body p-4">
                    <div class="row form my-4 view-limit">
                        <div class="form-group col mb-2">
                            <label for="member_id">작성자 아이디</label>
                            <input type="text" name="member_id" id="member_id" value="${dto.member_id}" maxlength="30" class="form-control-plaintext w-100" readonly="readonly" />
                        </div>
                        <div class="form-group col mb-2">
                            <label for="review_name">작성자 이름</label>
                            <input type="text" name="review_name" id="review_name" value="${dto.review_name}" maxlength="30" class="form-control-plaintext w-100" readonly="readonly" />
                        </div>

                        <div class="w-100 border-bottom"></div>

                        <div class="form-group join-form">
                            <label>피크닉</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2">${dto.getFicnic_name()}</div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group join-form">
                            <label>리뷰 평점</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col py-2">
                                        <c:forEach begin="1" end="10" var="i">
                                        <div class="form-check form-check-inline mx-2">
                                            <input class="form-check-input" type="radio" name="review_point" id="review_point${i}" value="${i}"<c:if test="${dto.review_point == i}"> checked="checked"</c:if> />
                                            <label class="form-check-label" for="review_point${i}">${i}</label>
                                        </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col mb-2">
                            <label for="review_cont" style="padding: 60px 0;">리뷰 내용</label>
                            <textarea name="review_cont" id="review_cont" cols="20" rows="5" class="form-control">${dto.review_cont}</textarea>
                        </div>

                        <div class="w-100 border-bottom"></div>

                        <div class="form-group join-form">
                            <label for="board_list_num">리뷰 사진 1</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pb-2">
                                        <input type="file" name="review_photo_modi1" class="form-control" accept="image/jpeg, image/png, image/gif" />
                                        <c:if test="${!empty dto.review_photo1}">
                                        <p class="mt-2"><img src="${path}${dto.review_photo1}" style="max-width: 400px;" alt="" /></p>
                                        <input type="hidden" name="ori_review_photo1" value="${dto.review_photo1}" />
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group join-form">
                            <label for="board_list_num">리뷰 사진 2</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pb-2">
                                        <input type="file" name="review_photo_modi2" class="form-control" accept="image/jpeg, image/png, image/gif" />
                                        <c:if test="${!empty dto.review_photo2}">
                                        <p class="mt-2"><img src="${path}${dto.review_photo2}" style="max-width: 400px;" alt="" /></p>
                                        <input type="hidden" name="ori_review_photo2" value="${dto.review_photo2}" />
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>




<div class="d-flex mt-2 input-form-button">
    <div class="col-lg text-center">
        <a href="${path}/admin/review/review_delete.do?review_no=${dto.getReview_no()}&ficnic_no=${dto.getFicnic_no()}&search_ficnic=${search_ficnic}&search_review=${search_review}&search_writer=${search_writer}" class="btn btn-danger btn-lg m-2" onclick="return confirm('정말 삭제하시겠습니까?\n되돌릴 수 없습니다.');"><i class="fa fa-trash-o"></i> 삭제하기</a>
        <a href="${path}/admin/review/review_list.do?search_ficnic=${param.search_ficnic}&search_review=${param.search_review}&search_writer=${param.search_writer}&page=${param.page}" class="btn btn-secondary btn-lg m-2"><i class="fa fa-bars"></i> 목록보기</a>
        <button type="submit" class="btn btn-primary btn-lg m-2"><i class="fa fa-save"></i> 수정하기</button>
    </div>
</div>
</form>





<%@ include file="../layout/layout_footer.jsp" %>