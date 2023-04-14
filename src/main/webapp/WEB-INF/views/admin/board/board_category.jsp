<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="layout_none" value="Y" />
<%@ include file="../layout/layout_header.jsp" %>


<h2>게시판 카테고리</h2>


<div class="page-cont">

	<form name="bcate_form" method="post" action="board_category_modify.do">
	<input type="hidden" name="board_id" value="${param.board_id}" />
    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4 class="mb-3">등록된 카테고리</h4>

                    <ul id="sort-list">
                    	<c:if test="${!empty bcate}">
                    	<c:forEach var="cate" items="${bcate}">
                    	<li class="row my-2">
                    		<input type="hidden" name="bcate_no[]" value="${cate.getBcate_no()}" />
                    		<div class="col-2"><button type="button" class="move-handle btn btn-outline-secondary w-100"><i class="fa fa-arrows-v"></i></button></div>
                    		<div class="col-7 px-0"><input type="text" name="bcate_name[]" value="${cate.getBcate_name()}" class="form-control" required /></div>
                    		<div class="col-3"><a href="board_category_delete.do?board_id=${param.board_id}&bcate_no=${cate.getBcate_no()}" class="btn btn-sm btn-outline-danger w-100" onclick="return confirm('이 카테고리를 삭제하시겠습니까?');">삭제</a></div>
                    	</li>
                    	</c:forEach>
                    	</c:if>

                    	<c:if test="${empty bcate}">
                    	<li class="nodata">등록된 카테고리가 없습니다.</li>
                    	</c:if>
                    </ul>
                </div>
            </div>
        </div>
    </div>

	<div class="my-2 text-center">
		<button type="button" class="btn btn-secondary" onclick="window.close();"><i class="fa fa-times"></i> 창닫기</button>
		<button type="submit" class="btn btn-primary ml-2"><i class="fa fa-save"></i> 수정하기</button>
	</div>
	</form>



    <div class="row mt-5">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4 class="mb-3">카테고리 추가하기</h4>
                    <form name="bcate_write" method="post" action="board_category_write.do">
					<input type="hidden" name="board_id" value="${param.board_id}" />
					<div class="input-group mb-2">
						<input type="text" name="bcate_name" class="form-control" placeholder="카테고리 이름" required />
						<div class="input-group-append">
							<button type="submit" class="btn btn-outline-primary"><i class="fa fa-pencil"></i> 추가하기</button>
						</div>
					</div>
					</form>
                </div>
            </div>
        </div>
    </div>
</div>




<script type="text/javascript">
new Sortable(document.getElementById('sort-list'), {
	animation: 150,
	handle: '.move-handle'
});
</script>



<%@ include file="../layout/layout_footer.jsp" %>