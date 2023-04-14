<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<script type="text/javascript">$("#header .navbar .nav-item:nth-child(4)").addClass("active");</script>


<c:set var="dto" value="${Modify}" />



<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>쿠폰 수정</h2>
        <ol class="m-0 p-2">
            <li>쿠폰 관리</li>
            <li><b>쿠폰 수정</b></li>
        </ol>
    </div>
</div>




<form name="form_input" method="post" enctype="multipart/form-data" action="<%=request.getContextPath() %>/admin/coupon/coupon_modify_ok.do">
<input type="hidden" name="coupon_no" value="${dto.getCoupon_no() }" />
<div class="page-cont">
    <div class="row">
        <div class="col-lg mb-4">
            <div class="card input-form">
                <div class="card-body p-4">
                    <h4 class="view-limit">쿠폰 기본 정보</h4>
                    <div class="row form mb-5 view-limit">
                        <div class="form-group col mb-2">
                            <label for="coupon_name">쿠폰 이름</label>
                            <input type="text" name="coupon_name" id="coupon_name" value="${dto.getCoupon_name() }" maxlength="30" class="form-control w-100" required />
                        </div>

                        <div class="w-100 border-bottom"></div>

                        <div class="form-group col">
                            <label for="coupon_use_type">사용 구분</label>
                            <div class="btn-group mt-2" role="group" data-toggle="buttons">
                                <label class="btn btn-outline-secondary<c:if test="${dto.getCoupon_use_type() == 'cart'}"> active</c:if>" onclick="$('#category_layer, #goods_layer').collapse('hide');">
                                    <input type="radio" name="coupon_use_type" value="cart"<c:if test="${dto.getCoupon_use_type() == 'cart'}"> checked="checked"</c:if> /> 장바구니
                                </label>
                                <label class="btn btn-outline-secondary<c:if test="${dto.getCoupon_use_type() == 'category'}"> active</c:if>" onclick="$('#category_layer').collapse('show'); $('#goods_layer').collapse('hide');">
                                    <input type="radio" name="coupon_use_type" value="category"<c:if test="${dto.getCoupon_use_type() == 'category'}"> checked="checked"</c:if> /> 카테고리
                                </label>
                                <label class="btn btn-outline-secondary<c:if test="${dto.getCoupon_use_type() == 'goods'}"> active</c:if>" onclick="$('#goods_layer').collapse('show'); $('#category_layer').collapse('hide');">
                                    <input type="radio" name="coupon_use_type" value="goods"<c:if test="${dto.getCoupon_use_type() == 'goods'}"> checked="checked"</c:if> /> 피크닉지정
                                </label>
                            </div>
                        </div>

                        <div class="px-0 collapse hide<c:if test="${dto.getCoupon_use_type() == 'category'}"> show</c:if>" id="category_layer">
                            <div class="w-100"></div>
                            <div class="form-group join-form">
                                <label>사용 카테고리</label>
                                <div class="jf-input">
                                    <div class="row">
                                        <div class="col pb-2">
                                            <button type="button" class="btn btn-sm btn-outline-info" data-toggle="modal" data-target="#modalCategory">카테고리 지정</button>
                                            <ul class="cate-show sub mt-2">
                                                <c:choose>
                                                    <c:when test="${dto.getCoupon_use_type() ne 'category' or empty dto.getCoupon_use_value()}"><p>등록된 카테고리가 없습니다.</p></c:when>
                                                    <c:otherwise>
                                                        <c:forEach var="cate" items="${cateList}">
                                                        <li class="${cate.cate_id}">${cate.cate_path}<button type="button"><i class="fa fa-times"></i></button><input type="hidden" name="coupon_use_category_value[]" value="${cate.cate_id}"></li>
                                                        </c:forEach>
                                                    </c:otherwise>
                                                </c:choose>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="px-0 collapse<c:if test="${dto.getCoupon_use_type() == 'goods'}"> show</c:if>" id="goods_layer">
                            <div class="w-100"></div>
                            <div class="form-group join-form">
                                <label>사용 피크닉</label>
                                <div class="jf-input">
                                    <div class="row">
                                        <div class="col pb-2">
                                            <button type="button" class="btn btn-sm btn-outline-success" data-toggle="modal" data-target="#modalFicnic">피크닉 지정</button>
                                            <ul class="cate-show ficnic mt-2">
                                                <c:choose>
                                                    <c:when test="${dto.getCoupon_use_type() ne 'goods' or empty dto.getCoupon_use_value()}"><p>등록된 피크닉이 없습니다.</p></c:when>
                                                    <c:otherwise>
                                                        <c:forEach var="goods" items="${goodsList}">
                                                        <li class="${goods.ficnic_no}">${goods.ficnic_name}<button type="button"><i class="fa fa-times"></i></button><input type="hidden" name="coupon_use_goods_value[]" value="${goods.ficnic_no}"></li>
                                                        </c:forEach>
                                                    </c:otherwise>
                                                </c:choose>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group col">
                            <label for="coupon_max_ea">최대 발행 갯수</label>
                            <input type="text" name="coupon_max_ea" id="coupon_max_ea" value="${dto.getCoupon_max_ea() }" maxlength="11" class="form-control text-center w-15" onkeydown="NumberInput(this);" /> 개
                        </div>
                        <div class="w-100"></div>
                    </div>



                    <h4 class="view-limit">쿠폰 할인 정보</h4>
                    <div class="row form mb-4 view-limit">
                        <div class="form-group join-form">
                            <label>할인 금액</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pb-2">
                                        <input type="text" name="coupon_price" id="coupon_price" value="${dto.getCoupon_price() }" maxlength="11" class="form-control d-inline text-center w-30" onkeydown="NumberInput(this);" required />
                                        <select id="coupon_price_type" name="coupon_price_type" class="custom-select w-25">
                                            <option value="price"<c:if test="${dto.getCoupon_price_type() == 'price'}"> checked="checked"</c:if> >금액 (원)</option>
                                            <option value="percent"<c:if test="${dto.getCoupon_price_type() == 'percent'}"> checked="checked"</c:if> >할인률 (%)</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group col mb-2">
                            <label for="coupon_price_over">최소 사용 금액</label>
                            <input type="text" name="coupon_price_over" id="coupon_price_over" value="${dto.getCoupon_price_over() }" maxlength="11" class="form-control text-center w-30" onkeydown="NumberInput(this);" /> 원
                        </div>
                        <div class="form-group col mb-2">
                            <label for="coupon_price_max">최대 할인 금액</label>
                            <input type="text" name="coupon_price_max" id="coupon_price_max" value="${dto.getCoupon_price_max() }" maxlength="11" class="form-control text-center w-30" onkeydown="NumberInput(this);" /> 원
                        </div>

                        <div class="w-100 border-bottom"></div>

                        <div class="form-group join-form">
                            <label for="coupon_date_type" class="pt-3">사용 기간</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col">
                                        <div class="btn-group" role="group" data-toggle="buttons">
                                            <label class="btn btn-outline-secondary<c:if test="${dto.getCoupon_date_type() == 'free'}"> active</c:if>" onclick="$('#after_layer, #date_layer').collapse('hide');">
                                                <input type="radio" name="coupon_date_type" value="free"<c:if test="${dto.getCoupon_date_type() == 'free'}"> checked="checked"</c:if> /> 무제한
                                            </label>
                                            <label class="btn btn-outline-secondary" onclick="$('#after_layer').collapse('show'); $('#date_layer').collapse('hide');">
                                                <input type="radio" name="coupon_date_type" value="after"<c:if test="${dto.getCoupon_date_type() == 'after'}"> checked="checked"</c:if> /> 발급후 며칠까지
                                            </label>
                                            <label class="btn btn-outline-secondary" onclick="$('#after_layer').collapse('hide'); $('#date_layer').collapse('show');">
                                                <input type="radio" name="coupon_date_type" value="date"<c:if test="${dto.getCoupon_date_type() == 'date'}"> checked="checked"</c:if> /> 기간설정
                                            </label>
                                        </div>

                                        <div class="px-0 pt-1 pb-2 collapse hide<c:if test="${dto.getCoupon_date_type() == 'after'}"> show</c:if>" id="after_layer">
                                            발급 후 <input type="text" name="coupon_date_valueCheck" value="${dto.getCoupon_date_value() }" maxlength="3" class="form-control d-inline mx-2 text-center w-15" onkeydown="NumberInput(this);" /> 일까지 사용 가능
                                        </div>

                                        <div class="px-0 pt-1 pb-2 collapse <c:if test="${dto.getCoupon_date_type() == 'date'}"> show</c:if>" id="date_layer">
                                            <div class="col-5 d-inline-block px-0">
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                    <input type="text" name="coupon_start_date" id="startDt" value="${dto.getCoupon_start_date().substring(0,10) }" class="form-control text-center eng" />
                                                </div>
                                            </div>
                                            <div class="d-inline-block pt-2 px-2">~</div>
                                            <div class="col-5 d-inline-block px-0">
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                    <input type="text" name="coupon_end_date" id="endDt" value="${dto.getCoupon_end_date().substring(0,10) }" class="form-control text-center eng" />
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
        </div>
    </div>
</div>




<div class="d-flex mt-2 input-form-button">
    <div class="col-lg text-center">
        <a href="<%=request.getContextPath()%>/admin/coupon/coupon_list.do?search_type=${param.search_type}&search_name=${param.search_name}&page=${param.page}" class="btn btn-secondary btn-lg m-2"><i class="fa fa-bars"></i> 목록보기</a>
        <button type="submit" class="btn btn-primary btn-lg m-2"><i class="fa fa-save"></i> 수정하기</button>
    </div>
</div>
</form>




<!-- 카테고리 선택 //START -->
<div class="modal fade" id="modalCategory" tabindex="-1" aria-hidden="true" type="subcoupon">
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
<!-- 카테고리 선택 //END -->




<!-- 상품 선택 //START -->
<div class="modal fade" id="modalFicnic" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="fa fa-exclamation"></i> 상품 선택</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            <div class="modal-body">
                <form  method="post" onsubmit="return popSearchFicnic(this);" class="form-inline justify-content-center border-bottom mb-4 pb-3">
                <input type="text" name="search_keyword" value="" class="form-control mx-2" />
                <button type="submit" class="btn btn-sm btn-primary"><i class="fa fa-search"></i> 검색</button>
                </form>

                <ul class="my-3 px-2" id="search-result">
                    <c:choose>
                        <c:when test="${!empty flist }">
                        <c:forEach var="list" items="${flist}">
                        <li class="d-flex my-3 align-items-center">
                            <c:choose>
                                <c:when test="${!empty list.getFicnic_photo1()}"><img src="${path}${list.getFicnic_photo1()}" alt="" width="98" height="60" /></c:when>
                                <c:otherwise><span class="noimg">no img</span></c:otherwise>
                            </c:choose>
                            <div class="ml-2">
                                <p><strong>[${list.getFicnic_no()}]</strong> ${list.getFicnic_name()}</p>
                                <button type="button" class="btn btn-sm btn-outline-primary mt-2" onclick="addFicnic(${list.getFicnic_no()}, '${list.getFicnic_name()}');">적용하기</button>
                            </div>
                        </li>
                        </c:forEach>
                        </c:when>

                        <c:otherwise>
                        <li class="py-5 text-center">No Data</li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
            <div class="modal-footer text-center" style="display: block;">
                <button type="button" class="btn btn-secondary btn-close" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
<!-- 상품 선택 //END -->




<%@ include file="../layout/layout_footer.jsp" %>