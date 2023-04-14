<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<script type="text/javascript">$("#header .navbar .nav-item:nth-child(1)").addClass("active");</script>



<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>카테고리 관리</h2>
        <ol class="m-0 p-2">
            <li>피크닉 관리</li>
            <li><b>카테고리 관리</b></li>
        </ol>
    </div>
</div>




<div class="page-cont category-form">
    <div class="row">
        <div class="col-md-4 mb-4">
            <div class="card border input-form">
            	<form name="form_sort" method="post" action="${path}/admin/ficnic/category_rank_ok.do" onsubmit="return confirm('현재 화면에 보이는 순서대로 카테고리가 저장됩니다.\n오른쪽 입력폼에 입력된 내용은 사라집니다.\n\n카테고리 위치를 저장하시겠습니까?');">
            	<input type="hidden" name="ps_ctid" value="" />
            	<input type="hidden" name="ps_project" value="${path}" />
                <div class="card-body p-4">
					<ul id="sort-list" class="folder-tree">
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
							<button type="button" class="btn btn-sm btn-info ft-add">분류 추가</button>
							<div class="ft-title ft-title-large">
								<input type="hidden" name="category_no[]" value="${cate.getCategory_no()}" />
								<input type="hidden" name="category_id[]" value="${cate.getCategory_id()}" />
								<input type="hidden" name="category_show[]" value="${cate.getCategory_show()}" />
								<input type="hidden" name="category_depth[]" value="${cate.getCategory_depth()}" />
								<input type="hidden" name="category_name[]" value="${cate.getCategory_name()}" />
								<input type="hidden" name="category_image[]" value="${cate.getCategory_image()}" />
								<span class="name">${cate.getCategory_name()}${show_big_disshow}</span>
								${show_big_count}
							</div>


							<c:if test="${!empty cate.getSub_category()}">
							<!-- 중 카테고리 반복 -->
							<ul class="sort-list displaynone" id="sort-list-${cate.getCategory_id()}" group="${cate.getCategory_id()}">
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
									<div class="ft-title">
										<input type="hidden" name="category_no[]" value="${subc.getCategory_no()}" />
										<input type="hidden" name="category_id[]" value="${subc.getCategory_id()}" />
										<input type="hidden" name="category_show[]" value="${subc.getCategory_show()}" />
										<input type="hidden" name="category_depth[]" value="${subc.getCategory_depth()}" />
										<input type="hidden" name="category_name[]" value="${subc.getCategory_name()}" />
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


                <div class="card-footer bg-white d-flex justify-content-center">
                	<button type="button" class="btn btn-sm btn-warning" onclick="cateFormAdd();"><i class="fa fa-pencil"></i> 대분류 추가</button>
					<button type="submit" class="btn btn-sm btn-info ml-3"><i class="fa fa-thumb-tack"></i> 분류정렬 저장</button>
                </div>
            	</form>
            </div>
        </div>



        <div class="col-md-8 mb-4">
            <div class="card border input-form">
                <div class="card-body p-4">
					<div class="category-mask"></div>

					<form name="form_write" method="post" enctype="multipart/form-data" action="#">
					<input type="hidden" name="ps_ctid" value="" />
					<h4 id="form-title" class="mb-2">대분류 추가하기</h4>

					<div class="row form my-4">
						<div class="form-group col">
							<label for="category_show">카테고리 노출</label>
							<div class="form-check form-check-inline ml-1">
								<label class="form-check-label"><input type="radio" name="category_show" value="Y" class="form-check-input" checked="checked" /> 노출</label>
							</div>
							<div class="form-check form-check-inline">
								<label class="form-check-label"><input type="radio" name="category_show" value="N" class="form-check-input" /> 숨김</label>
							</div>
						</div>
						<div class="w-100"></div>
						<div class="form-group col-sm">
							<label for="category_name">카테고리 이름</label>
							<input type="text" name="category_name" id="category_name" value="" maxlength="30" class="form-control" required autocomplete="off" />
						</div>
						<div class="form-group col-sm">
							<label for="category_link">카테고리 번호</label>
							<input type="text" name="category_link" id="category_link" value="" class="form-control-plaintext" readonly="readonly" />
						</div>
						<div class="p-0 m-0 cate-img">
							<div class="w-100"></div>
	                        <div class="form-group join-form">
	                            <label for="category_image">카테고리 이미지</label>
	                            <div class="jf-input">
	                                <div class="row">
	                                    <div class="col pb-1">
	                                    	<input type="file" name="category_image" id="category_image" class="form-control" accept="image/jpeg, image/png, image/gif" />
	                                    	<input type="hidden" name="ori_category_image" value="" />
	                                    	<div></div>
	                                    </div>
	                                </div>
	                            </div>
                            </div>
                        </div>
	                </div>

					<div class="mt-4 text-center">
						<button type="submit" id="form-btn" class="btn btn-primary"><i class="fa fa-pencil"></i> 추가하기</button>
						<a href="#" class="btn btn-outline-danger ml-2 displaynone" onclick="return confirm('삭제는 복구가 불가능합니다.\n삭제시 데이터는 완전 삭제됩니다.\n\n-----------------------------------------\n※ 해당 상품분류에 속한 피크닉의 카테고리가\n[카테고리 미지정]으로 변경됩니다. ※\n-----------------------------------------\n\n(정말로 삭제하시겠습니까?)');"><i class="fa fa-trash-o"></i> 분류삭제</a>
					</div>
					</form>
                </div>
            </div>
        </div>
    </div>
</div>



<script type="text/javascript">
new Sortable(document.getElementById('sort-list'), {
	group: 'cate-big',
	animation: 150,
	fallbackOnBody: true,
	swapThreshold: 0.65
});

$(document).ready(function(){
	$(".sort-list").each(function(){
		var thisGroup = $(this).attr("group");
		new Sortable(document.getElementById('sort-list-'+thisGroup), {
			group: 'cate-'+thisGroup,
			animation: 150,
			fallbackOnBody: true,
			swapThreshold: 0.65
		});
	});
});
</script>



<%@ include file="../layout/layout_footer.jsp" %>