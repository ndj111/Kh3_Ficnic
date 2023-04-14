<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<script type="text/javascript">$("#header .navbar .nav-item:nth-child(6)").addClass("active");</script>


<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>리뷰 등록</h2>
        <ol class="m-0 p-2">
            <li>리뷰 관리</li>
            <li><b>리뷰 등록</b></li>
        </ol>
    </div>
</div>




<form name="form_input" method="post" enctype="multipart/form-data" action="${path}/admin/review/review_write_ok.do">
<input type="hidden" name="review_pw" value="1111" />
<div class="page-cont">
    <div class="row">
        <div class="col-lg mb-4">
            <div class="card input-form">
                <div class="card-body p-4">
                    <div class="row form my-4 view-limit">
                        <div class="form-group col">
                            <label for="member_id">작성자 아이디</label>
                            <input type="text" name="member_id" id="member_id" class="form-control" value="${randomId}" onkeydown="EngNumInput(this);" required />
                        </div>
                        <div class="form-group col">
                            <label for="review_name">작성자 이름</label>
                            <input type="text" name="review_name" id="review_name" class="form-control" required autofocus />
                        </div>

                        <div class="w-100 border-bottom mt-2"></div>

                        <div class="form-group col">
                            <label for="ficnic_no">피크닉 선택</label>
                            <select id="search_type" name="ficnic_no" id="ficnic_no" class="custom-select">
                                <c:forEach var="fdto" items="${fdto}">
                                <option value="${fdto.getFicnic_no() }">${fdto.getFicnic_name() }</option>
                                </c:forEach>
                            </select>
                        </div>

                        <w class="-100"></w>

                        <div class="form-group join-form">
                            <label>리뷰 평점</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col py-2">
                                        <c:forEach begin="1" end="10" var="i">
                                        <div class="form-check form-check-inline mx-2">
                                            <input class="form-check-input" type="radio" name="review_point" id="review_point" value="${i}" <c:if test="${i == 10}"> checked="checked"</c:if>/>
                                            <label class="form-check-label" for="review_point${i}">${i}</label>
                                        </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group col">
                            <label for="review_cont" style="padding: 60px 0;">리뷰 내용</label>
                            <textarea name="review_cont" id="review_cont" cols="20" rows="5" class="form-control">${dto.review_cont}</textarea>
                        </div>

                        <div class="w-100 border-bottom mt-2"></div>

                        <div class="form-group join-form">
                            <label for="board_list_num">리뷰 사진 1</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pb-2">
                                        <input type="file" name="review_photo_modi1" class="form-control" accept="image/jpeg, image/png, image/gif" />
                                        <c:if test="${!empty dto.review_photo1}">
                                        <p class="mt-2"><img src="${path}${dto.review_photo1}" style="max-width: 400px;" alt="" /></p>
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
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group col">
                            <label for="review_date">작성 일자</label>
                            <input type="text" name="review_date" id="review_date" value="${reviewDate}" class="form-control w-100" required />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>




<div class="d-flex mt-2 input-form-button">
    <div class="col-lg text-center">
        <a href="${path}/admin/review/review_list.do?search_ficnic=${param.search_ficnic}&search_review=${param.search_review}&search_writer=${param.search_writer}&page=${param.page}" class="btn btn-secondary btn-lg m-2"><i class="fa fa-bars"></i> 목록보기</a>
        <button type="submit" class="btn btn-primary btn-lg m-2"><i class="fa fa-save"></i> 등록하기</button>
    </div>
</div>
</form>





<%@ include file="../layout/layout_footer.jsp" %>