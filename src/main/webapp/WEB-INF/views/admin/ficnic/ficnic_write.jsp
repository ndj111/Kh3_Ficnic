<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<script type="text/javascript">$("#header .navbar .nav-item:nth-child(1)").addClass("active");</script>


<c:choose>
	<c:when test="${!empty m}">
		<c:set var="tag" value="admin/ficnic/ficnic_modify_ok.do" />
		<c:set var="title" value="수정" />
		<c:set var="icon" value="save" />
		<c:set var="category" value="${fdto.getFicnic_category_no()}" />
		<c:set var="market_price" value="${fdto.getFicnic_market_price()}" />
		<c:set var="sale_price" value="${fdto.getFicnic_sale_price()}" />
	</c:when>

	<c:otherwise>
		<c:set var="tag" value="admin/ficnic/ficnic_write_ok.do" />
		<c:set var="title" value="등록" />
		<c:set var="icon" value="pencil" />
		<c:set var="market_price" value="0" />
		<c:set var="sale_price" value="0" />
	</c:otherwise>
</c:choose>




<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>피크닉 ${title}</h2>
        <ol class="m-0 p-2">
            <li>피크닉 관리</li>
            <li><b>피크닉 ${title}</b></li>
        </ol>
    </div>
</div>




<form name="ficnic_form" method="post" enctype="multipart/form-data" action="${path}/${tag}" onsubmit="return false;">
<c:if test="${!empty m}"><input type="hidden" name="ficnic_no" value="${fdto.getFicnic_no()}" /></c:if>
<div class="page-cont">
    <div class="row">
        <div class="col-lg mb-4">
            <div class="card input-form">
                <div class="card-body p-4">

                    <h4 class="view-limit">기본 정보</h4>
                    <div class="row form mb-5 view-limit">
                        <div class="form-group">
                            <label for="ficnic_name"><span>*</span> 피크닉 이름</label>
                            <input type="text" name="ficnic_name" id="ficnic_name" value="${fdto.getFicnic_name()}" class="form-control" required />
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group col-sm">
                            <label for="ficnic_market_price">이전 판매가</label>
                            <input type="text" name="ficnic_market_price" id="ficnic_market_price" value="${market_price}" class="form-control text-right w-30" onkeyup="NumberInput(this)" /> 원
                        </div>
                        <div class="form-group col-sm">
                            <label for="ficnic_sale_price"><span>*</span> 현재 판매가</label>
                            <input type="text" name="ficnic_sale_price" id="ficnic_sale_price" value="${sale_price}" class="form-control text-right w-30" onkeyup="NumberInput(this)" /> 원
                        </div>

                        <div class="w-100 border-bottom mt-2"></div>

                        <div class="form-group join-form">
                            <label><span>*</span> 기본 카테고리</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pb-2">
                                        <button type="button" class="btn btn-sm btn-warning mt-0" data-toggle="modal" data-target="#modalCategory" onclick="$('#modalCategory').attr('type', 'default');"><i class="fa fa-exclamation"></i> 등록할 분류 선택</button>
                                        <ul class="cate-show parent mt-2">
                                            <c:choose>
                                                <c:when test="${!empty fdto.getFicnic_category_name()}"><li>${fdto.getFicnic_category_name()}</li></c:when>
                                                <c:otherwise><p>등록된 기본 카테고리가 없습니다.</p></c:otherwise>
                                            </c:choose>
                                        </ul>
                                        <input type="hidden" name="ficnic_category_no" value="${fdto.getFicnic_category_no()}" />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group join-form">
                            <label>다중 카테고리</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pb-2">
                                        <button type="button" class="btn btn-sm btn-info mt-0" data-toggle="modal" data-target="#modalCategory" onclick="$('#modalCategory').attr('type', 'sub');"><i class="fa fa-exclamation"></i> 등록할 분류 선택</button>
                                        <ul class="cate-show sub mt-2">
                                            <c:choose>
                                                <c:when test="${empty fdto.getFicnic_category_sub1() and empty fdto.getFicnic_category_sub2() and empty fdto.getFicnic_category_sub3()}"><p>등록된 다중 카테고리가 없습니다.</p></c:when>
                                                <c:otherwise>
                                                    <c:if test="${!empty fdto.getFicnic_category_sub1()}"><li class="${fdto.getFicnic_category_sub1()}">${fdto.getFicnic_category_sub1_name()}<button type="button"><i class="fa fa-times"></i></button><input type="hidden" name="ficnic_category_sub[]" value="${fdto.getFicnic_category_sub1()}"></li></c:if>
                                                    <c:if test="${!empty fdto.getFicnic_category_sub2()}"><li class="${fdto.getFicnic_category_sub2()}">${fdto.getFicnic_category_sub2_name()}<button type="button"><i class="fa fa-times"></i></button><input type="hidden" name="ficnic_category_sub[]" value="${fdto.getFicnic_category_sub2()}"></li></c:if>
                                                    <c:if test="${!empty fdto.getFicnic_category_sub3()}"><li class="${fdto.getFicnic_category_sub3()}">${fdto.getFicnic_category_sub3_name()}<button type="button"><i class="fa fa-times"></i></button><input type="hidden" name="ficnic_category_sub[]" value="${fdto.getFicnic_category_sub3()}"></li></c:if>
                                                </c:otherwise>
                                            </c:choose>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>



                    <h4 class="view-limit">옵션 정보</h4>
                    <div class="row form mb-5 view-limit">
                        <div class="form-group join-form">
                            <label>선택 옵션</label>
                            <div id="ficnic_option" class="jf-input">
                                <c:choose>
                                    <c:when test="${!empty optionList}">
                                        <c:forEach var="optlist" items="${optionList}">
                                        <div class="row">
                                            <div class="col-sm-7 mb-1">
                                                <input type="text" name="ficnic_option_title" value="${optlist.title}" class="form-control h-auto" placeholder="옵션 제목" />
                                            </div>
                                            <div class="col-sm-3 mb-1">
                                                <input type="text" name="ficnic_option_price" value="${optlist.price}" class="form-control h-auto text-right" placeholder="옵션 가격" onkeyup="NumberInput(this)" />
                                            </div>
                                            <div class="col-sm-auto mb-1">
                                                <button type="button" class="btn btn-sm btn-outline-${optlist.cls} mt-0 px-3" onclick="formOptionBtn('${optlist.btn}', this);"><i class="fa fa-${optlist.btn}"></i></button>
                                            </div>
                                        </div>
                                        </c:forEach>
                                    </c:when>

                                    <c:otherwise>
                                    <div class="row">
                                        <div class="col-sm-7 mb-1">
                                            <input type="text" name="ficnic_option_title" value="" class="form-control h-auto" placeholder="옵션 제목" />
                                        </div>
                                        <div class="col-sm-3 mb-1">
                                            <input type="text" name="ficnic_option_price" value="0" class="form-control h-auto text-right" placeholder="옵션 가격" onkeyup="NumberInput(this)" />
                                        </div>
                                        <div class="col-sm-auto mb-1">
                                            <button type="button" class="btn btn-sm btn-outline-info mt-0 px-3" onclick="formOptionBtn('plus', this);"><i class="fa fa-plus"></i></button>
                                        </div>
                                    </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group join-form">
                            <label>추가 선택</label>
                            <div id="ficnic_select" class="jf-input">
                                <c:choose>
                                    <c:when test="${!empty selectList}">
                                        <c:forEach var="sellist" items="${selectList}">
                                        <div class="row">
                                            <div class="col-sm-7 mb-1">
                                                <input type="text" name="ficnic_select_title" value="${sellist.title}" class="form-control h-auto" placeholder="선택 제목" />
                                            </div>
                                            <div class="col-sm-3 mb-1">
                                                <input type="text" name="ficnic_select_price" value="${sellist.price}" class="form-control h-auto text-right" placeholder="선택 가격" onkeyup="NumberInput(this)" />
                                            </div>
                                            <div class="col-sm-auto mb-1">
                                                <button type="button" class="btn btn-sm btn-outline-${sellist.cls} mt-0 px-3" onclick="formSelectBtn('${sellist.btn}', this);"><i class="fa fa-${sellist.btn}"></i></button>
                                            </div>
                                        </div>
                                        </c:forEach>
                                    </c:when>

                                    <c:otherwise>
                                    <div class="row">
                                        <div class="col-sm-7 mb-1">
                                            <input type="text" name="ficnic_select_title" value="" class="form-control h-auto" placeholder="선택 제목" />
                                        </div>
                                        <div class="col-sm-3 mb-1">
                                            <input type="text" name="ficnic_select_price" value="0" class="form-control h-auto text-right" placeholder="선택 가격" onkeyup="NumberInput(this)" />
                                        </div>
                                        <div class="col-sm-auto mb-1">
                                            <button type="button" class="btn btn-sm btn-outline-info mt-0 px-3" onclick="formSelectBtn('plus', this);"><i class="fa fa-plus"></i></button>
                                        </div>
                                    </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group col mb-2">
                            <label>날짜 선택</label>
                            <div class="btn-group mt-2" role="group" data-toggle="buttons">
                                <label class="btn btn-outline-secondary<c:if test="${fdto.getFicnic_date_use() eq 'Y'}"> active</c:if>">
                                    <input type="radio" name="ficnic_date_use" value="Y"<c:if test="${fdto.getFicnic_date_use() eq 'Y'}"> checked="checked"</c:if> /><i class="fa fa-circle-o"></i> 사용
                                </label>
                                <label class="btn btn-outline-secondary<c:if test="${fdto.getFicnic_date_use() eq 'N' or empty fdto.getFicnic_date_use()}"> active</c:if>">
                                    <input type="radio" name="ficnic_date_use" value="N"<c:if test="${fdto.getFicnic_date_use() eq 'N' or empty fdto.getFicnic_date_use()}"> checked="checked"</c:if> /><i class="fa fa-times"></i> 안함
                                </label>
                            </div>
                        </div>
                    </div>



                	<h4 class="view-limit">피크닉 사진</h4>
                    <div class="row form mb-5 view-limit">
						<div class="form-group join-form">
							<label>사진 1</label>
                            <div class="jf-input">
                                <div class="row">
                                	<c:if test="${!empty fdto.getFicnic_photo1()}">
                                	<div id="ficnic_photo1" class="col-auto pb-2 pr-0"><a href="${path}${fdto.getFicnic_photo1()}" target="_blank"><img src="${path}${fdto.getFicnic_photo1()}" alt="" width="78" height="78" /></a></div>
                                	</c:if>
                                    <div class="col pb-2">
                                        <input type="file" name="ficnic_photo_file1" class="form-control" accept="image/jpeg, image/png, image/gif" />
                                        <c:if test="${!empty fdto.getFicnic_photo1()}">
                                            <button type="button" class="btn btn-sm btn-outline-danger mt-1" onclick="delFicnicPhoto(this, '${fdto.getFicnic_no()}', 1);"><i class="fa fa-trash-o"></i> 등록된 이미지 삭제</button>
                                            <input type="hidden" name="ori_ficnic_photo1" value="${fdto.getFicnic_photo1()}" />
                                        </c:if>
                                    </div>
                                </div>
                            </div>
						</div>

						<div class="w-100"></div>

						<div class="form-group join-form">
							<label>사진 2</label>
                            <div class="jf-input">
                                <div class="row">
                                	<c:if test="${!empty fdto.getFicnic_photo2()}">
                                	<div id="ficnic_photo2" class="col-auto pb-2 pr-0"><a href="${path}${fdto.getFicnic_photo2()}" target="_blank"><img src="${path}${fdto.getFicnic_photo2()}" alt="" width="78" height="78" /></a></div>
                                	</c:if>
                                    <div class="col pb-2">
                                        <input type="file" name="ficnic_photo_file2" class="form-control" accept="image/jpeg, image/png, image/gif" />
                                        <c:if test="${!empty fdto.getFicnic_photo2()}">
                                            <button type="button" class="btn btn-sm btn-outline-danger mt-1" onclick="delFicnicPhoto(this, '${fdto.getFicnic_no()}', 2);"><i class="fa fa-trash-o"></i> 등록된 이미지 삭제</button>
                                            <input type="hidden" name="ori_ficnic_photo2" value="${fdto.getFicnic_photo2()}" />
                                        </c:if>
                                    </div>
                                </div>
                            </div>
						</div>

						<div class="w-100"></div>

						<div class="form-group join-form">
							<label>사진 3</label>
                            <div class="jf-input">
                                <div class="row">
                                	<c:if test="${!empty fdto.getFicnic_photo3()}">
                                	<div id="ficnic_photo3" class="col-auto pb-2 pr-0"><a href="${path}${fdto.getFicnic_photo3()}" target="_blank"><img src="${path}${fdto.getFicnic_photo3()}" alt="" width="78" height="78" /></a></div>
                                	</c:if>
                                    <div class="col pb-2">
                                        <input type="file" name="ficnic_photo_file3" class="form-control" accept="image/jpeg, image/png, image/gif" />
                                        <c:if test="${!empty fdto.getFicnic_photo3()}">
                                            <button type="button" class="btn btn-sm btn-outline-danger mt-1" onclick="delFicnicPhoto(this, '${fdto.getFicnic_no()}', 3);"><i class="fa fa-trash-o"></i> 등록된 이미지 삭제</button>
                                            <input type="hidden" name="ori_ficnic_photo3" value="${fdto.getFicnic_photo3()}" />
                                        </c:if>
                                    </div>
                                </div>
                            </div>
						</div>

						<div class="w-100"></div>

						<div class="form-group join-form">
							<label>사진 4</label>
                            <div class="jf-input">
                                <div class="row">
                                	<c:if test="${!empty fdto.getFicnic_photo4()}">
                                	<div id="ficnic_photo4" class="col-auto pb-2 pr-0"><a href="${path}${fdto.getFicnic_photo4()}" target="_blank"><img src="${path}${fdto.getFicnic_photo4()}" alt="" width="78" height="78" /></a></div>
                                	</c:if>
                                    <div class="col pb-2">
                                        <input type="file" name="ficnic_photo_file4" class="form-control" accept="image/jpeg, image/png, image/gif" />
                                        <c:if test="${!empty fdto.getFicnic_photo4()}">
                                            <button type="button" class="btn btn-sm btn-outline-danger mt-1" onclick="delFicnicPhoto(this, '${fdto.getFicnic_no()}', 4);"><i class="fa fa-trash-o"></i> 등록된 이미지 삭제</button>
                                            <input type="hidden" name="ori_ficnic_photo4" value="${fdto.getFicnic_photo4()}" />
                                        </c:if>
                                    </div>
                                </div>
                            </div>
						</div>

						<div class="w-100"></div>

						<div class="form-group join-form">
							<label>사진 5</label>
                            <div class="jf-input">
                                <div class="row">
                                	<c:if test="${!empty fdto.getFicnic_photo5()}">
                                	<div id="ficnic_photo5" class="col-auto pb-2 pr-0"><a href="${path}${fdto.getFicnic_photo5()}" target="_blank"><img src="${path}${fdto.getFicnic_photo5()}" alt="" width="78" height="78" /></a></div>
                                	</c:if>
                                    <div class="col pb-2">
                                        <input type="file" name="ficnic_photo_file5" class="form-control" accept="image/jpeg, image/png, image/gif" />
                                        <c:if test="${!empty fdto.getFicnic_photo5()}">
                                            <button type="button" class="btn btn-sm btn-outline-danger mt-1" onclick="delFicnicPhoto(this, '${fdto.getFicnic_no()}', 5);"><i class="fa fa-trash-o"></i> 등록된 이미지 삭제</button>
                                            <input type="hidden" name="ori_ficnic_photo5" value="${fdto.getFicnic_photo5()}" />
                                        </c:if>
                                    </div>
                                </div>
                            </div>
						</div>
                    </div>



                    <h4 class="view-limit">피크닉 소개</h4>
                    <div class="mb-5 view-limit">
                        <textarea id="ficnic_detail" name="ficnic_detail" cols="80" rows="10">${fdto.getFicnic_detail()}</textarea>
                    </div>



                    <h4 class="view-limit">피크닉 상세 정보</h4>
                    <div class="row form mb-5 view-limit">
                        <div class="form-group join-form">
                            <label>피크닉 정보</label>
                            <div id="ficnic_info" class="jf-input">
                                <c:choose>
                                    <c:when test="${!empty infoList}">
                                        <c:forEach var="iflist" items="${infoList}">
                                        <div class="row">
                                            <div class="col-sm-4 mb-1">
                                                <input type="text" name="ficnic_info" value="${iflist.title}" class="form-control h-auto" placeholder="선택 제목" />
                                            </div>
                                            <div class="col-sm-6 mb-1">
                                                <input type="text" name="ficnic_info" value="${iflist.cont}" class="form-control h-auto" placeholder="선택 내용" />
                                            </div>
                                            <div class="col-sm-auto mb-1">
                                                <button type="button" class="btn btn-sm btn-outline-${iflist.cls} mt-0 px-3" onclick="formFicnicBtn('${iflist.btn}', this);"><i class="fa fa-${iflist.btn}"></i></button>
                                            </div>
                                        </div>
                                        </c:forEach>
                                    </c:when>

                                    <c:otherwise>
                                    <div class="row">
                                        <div class="col-sm-4 mb-1">
                                            <input type="text" name="ficnic_info" value="" class="form-control h-auto" placeholder="제목" />
                                        </div>
                                        <div class="col-sm-6 mb-1">
                                            <input type="text" name="ficnic_info" value="" class="form-control h-auto" placeholder="내용" />
                                        </div>
                                        <div class="col-sm-auto mb-1">
                                            <button type="button" class="btn btn-sm btn-outline-info mt-0 px-3" onclick="formFicnicBtn('plus', this);"><i class="fa fa-plus"></i></button>
                                        </div>
                                    </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="w-100 border-bottom mt-2"></div>

                        <div class="form-group join-form">
                            <label>커리큘럼</label>
                            <div id="ficnic_curriculum" class="jf-input">
                                <c:choose>
                                    <c:when test="${!empty currList}">
                                        <c:forEach var="culist" items="${currList}">
                                        <div class="row">
                                            <div class="col-sm-4 mb-1">
                                                <input type="text" name="ficnic_curriculum" value="${culist.time}" class="form-control h-auto" placeholder="시간" />
                                            </div>
                                            <div class="col-sm-6 mb-1">
                                                <input type="text" name="ficnic_curriculum" value="${culist.cont}" class="form-control h-auto" placeholder="내용" />
                                            </div>
                                            <div class="col-sm-auto mb-1">
                                                <button type="button" class="btn btn-sm btn-outline-${culist.cls} mt-0 px-3" onclick="formCurriculumBtn('${culist.btn}', this);"><i class="fa fa-${culist.btn}"></i></button>
                                            </div>
                                        </div>
                                        </c:forEach>
                                    </c:when>

                                    <c:otherwise>
                                    <div class="row">
                                        <div class="col-sm-4 mb-1">
                                            <input type="text" name="ficnic_curriculum" value="" class="form-control h-auto" placeholder="시간" />
                                        </div>
                                        <div class="col-sm-6 mb-1">
                                            <input type="text" name="ficnic_curriculum" value="" class="form-control h-auto" placeholder="내용" />
                                        </div>
                                        <div class="col-sm-auto mb-1">
                                            <button type="button" class="btn btn-sm btn-outline-info mt-0 px-3" onclick="formCurriculumBtn('plus', this);"><i class="fa fa-plus"></i></button>
                                        </div>
                                    </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group">
                            <label for="ficnic_etc" style="padding: 38px 0;">기타사항</label>
                            <textarea name="ficnic_etc" cols="80" rows="3" class="form-control">${fdto.getFicnic_etc()}</textarea>
                        </div>

                        <div class="w-100 border-bottom mt-2"></div>

                        <div class="form-group">
                            <label for="ficnic_location">진행 지역</label>
                            <select name="ficnic_location" id="ficnic_location" class="custom-select w-50">
                                <option value="서울" <c:if test="${fdto.getFicnic_location() eq '서울'}"> selected="selected"</c:if>> 서울</option>
                                <option value="경기" <c:if test="${fdto.getFicnic_location() eq '경기'}"> selected="selected"</c:if>> 경기</option>
                                <option value="인천" <c:if test="${fdto.getFicnic_location() eq '인천'}"> selected="selected"</c:if>> 인천</option>
                                <option value="강원" <c:if test="${fdto.getFicnic_location() eq '강원'}"> selected="selected"</c:if>> 강원</option>
                                <option value="부산" <c:if test="${fdto.getFicnic_location() eq '부산'}"> selected="selected"</c:if>> 부산</option>
                                <option value="충남" <c:if test="${fdto.getFicnic_location() eq '충남'}"> selected="selected"</c:if>> 충남</option>
                                <option value="충북" <c:if test="${fdto.getFicnic_location() eq '충북'}"> selected="selected"</c:if>> 충북</option>
                                <option value="경남" <c:if test="${fdto.getFicnic_location() eq '경남'}"> selected="selected"</c:if>> 경남</option>
                                <option value="경북" <c:if test="${fdto.getFicnic_location() eq '경북'}"> selected="selected"</c:if>> 경북</option>
                                <option value="전남" <c:if test="${fdto.getFicnic_location() eq '전남'}"> selected="selected"</c:if>> 전남</option>
                                <option value="전북" <c:if test="${fdto.getFicnic_location() eq '전북'}"> selected="selected"</c:if>> 전북</option>
                                <option value="광주" <c:if test="${fdto.getFicnic_location() eq '광주'}"> selected="selected"</c:if>> 광주</option>
                                <option value="대전" <c:if test="${fdto.getFicnic_location() eq '대전'}"> selected="selected"</c:if>> 대전</option>
                                <option value="대구" <c:if test="${fdto.getFicnic_location() eq '대구'}"> selected="selected"</c:if>> 대구</option>
                                <option value="울산" <c:if test="${fdto.getFicnic_location() eq '울산'}"> selected="selected"</c:if>> 울산</option>
                                <option value="제주" <c:if test="${fdto.getFicnic_location() eq '제주'}"> selected="selected"</c:if>> 제주</option>
                            </select>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group">
                            <label for="ficnic_address">진행 주소</label>
                            <input type="text" name="ficnic_address" id="ficnic_address" value="${fdto.getFicnic_address()}" class="form-control" />
                        </div>

                        <div class="w-100 border-bottom mt-2"></div>

                        <div class="form-group join-form">
                            <label for="ficnic_include" style="padding-top: 23px;">포함 사항</label>
                            <div class="jf-input">
                                <div class="row pb-1">
                                    <input type="text" name="ficnic_include" id="ficnic_include" value="${fdto.getFicnic_include()}" class="form-control w-100" data-role="tagsinput" />
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group join-form">
                            <label for="ficnic_notinclude" style="padding-top: 23px;">불포함 사항</label>
                            <div class="jf-input">
                                <div class="row pb-1">
                                    <input type="text" name="ficnic_notinclude" id="ficnic_notinclude" value="${fdto.getFicnic_notinclude()}" class="form-control" data-role="tagsinput" />
                                </div>
                            </div>
                        </div>

                        <div class="form-group join-form">
                            <label for="ficnic_prepare" style="padding-top: 23px;">준비물</label>
                            <div class="jf-input">
                                <div class="row pb-1">
                                    <input type="text" name="ficnic_prepare" id="ficnic_prepare" value="${fdto.getFicnic_prepare()}" class="form-control" data-role="tagsinput" />
                                </div>
                            </div>
                        </div>

                        <div class="w-100 border-bottom mt-2"></div>

                        <div class="form-group">
                            <label for="ficnic_caution" style="padding: 90px 0;">유의사항</label>
                            <textarea name="ficnic_caution" cols="80" rows="8" class="form-control">${fdto.getFicnic_caution()}</textarea>
                        </div>


                    </div>

                </div>
            </div>
        </div>
    </div>
</div>







<div class="d-flex mt-2 input-form-button">
    <div class="col-lg text-center">
        <a href="ficnic_list.do?category=${finic_category_no}&location=${ficnic_location}&page=${page}" class="btn btn-secondary btn-lg m-2"><i class="fa fa-bars"></i> 목록보기</a>
        <button type="button" class="btn btn-primary btn-lg m-2" onclick="chkFicnicWrite();"><i class="fa fa-${icon}"></i> ${title}하기</button>
    </div>
</div>
</form>




<!-- 상품 분류 선택 //START -->
<div class="modal fade" id="modalCategory" tabindex="-1" aria-hidden="true" type="">
	<div class="modal-dialog modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title"><i class="fa fa-exclamation"></i> 카테고리 선택</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
			</div>
			<div class="modal-body">
				<ul class="folder-tree">
					<c:forEach var="cate" items="${clist}">
					<!-- 대 카테고리 반복 -->
					<c:choose>
						<c:when test="${cate.getSub_category().size() > 0}">
							<c:set var="show_big_class" value="plus" />
							<c:set var="show_big_count" value="<span class=\"count\" />[${cate.getSub_category().size()}]</span>" />
						</c:when>
						<c:otherwise>
							<c:set var="show_big_class" value="normal" />
							<c:set var="show_big_count" value="" />
						</c:otherwise>
					</c:choose>

					<c:choose>
						<c:when test="${cate.getCategory_show() eq 'N'}">
							<c:set var="show_big_disshow" value=" [비노출]" />
							<c:set var="show_big_disclass" value=" noshow" />
						</c:when>
						<c:otherwise>
							<c:set var="show_big_disshow" value="" />
							<c:set var="show_big_disclass" value="" />
						</c:otherwise>
					</c:choose>
					<li class="line-plus depth01-${show_big_class}${show_big_disclass}">
						<div class="ft-title ft-title-large" ctid="${cate.getCategory_id()}" path="${cate.getCategory_name()}">
							<span class="name">${cate.getCategory_name()}${show_big_disshow}</span>
							${show_big_count}
						</div>

						<c:if test="${!empty cate.getSub_category()}">
						<!-- 중 카테고리 반복 -->
						<ul class="sort-list displaynone">
							<c:forEach var="subc" items="${cate.getSub_category()}">
							<c:choose>
								<c:when test="${subc.getCategory_show() eq 'N'}">
									<c:set var="show_sub_disshow" value=" [비노출]" />
									<c:set var="show_sub_disclass" value="noshow" />
								</c:when>
								<c:otherwise>
									<c:set var="show_sub_disshow" value="" />
									<c:set var="show_sub_disclass" value="" />
								</c:otherwise>
							</c:choose>
							<li class="${show_sub_disclass}">
								<div class="ft-title" ctid="${subc.getCategory_id()}" path="${cate.getCategory_name()} &gt; ${subc.getCategory_name()}">
									<span class="name">${subc.getCategory_name()}${show_sub_disshow}</span>
								</div>
							</li>
							</c:forEach>
						</ul>
						</c:if>
					</li>
					</c:forEach>
				</ul>
			</div>
			<div class="modal-footer text-center" style="display: block;">
				<button type="button" class="btn btn-secondary btn-close" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" onclick="setCategory();">적용하기</button>
			</div>
		</div>
	</div>
</div>
<!-- 상품 분류 선택 //END -->




<script type="text/javascript">
CKEDITOR.disableAutoInline = true;
CKEDITOR.replace('ficnic_detail', {
	height: "300px"
});
</script>



<%@ include file="../layout/layout_footer.jsp" %>