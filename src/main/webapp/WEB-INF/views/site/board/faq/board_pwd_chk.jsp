<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../layout/layout_header.jsp" %>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_board.css" />
<script language="javascript" src="${path}/resources/site/js/js_board.js"></script>


<%@ include file="../../layout/layout_csmenu.jsp" %>


<div class="contents w1100 board-pwcheck board-faq">

    <div class="row justify-content-lg-center">
        <div class="col-lg-auto">
            <div class="card p-5">
                <form name="form_input" method="post" action="${path}/board/board_view_ok.do" class="form-validate">
		        <input type="hidden" name="bbs_id" value="${bbs_id}" />
		        <input type="hidden" name="bdata_no" value="${bdata_no}" />
		        <input type="hidden" name="bdata_writer_id" value="${bdata_writer_id}" />
                <input type="hidden" name="field" value="${field}" />
                <input type="hidden" name="keyword" value="${keyword}" />
                <input type="hidden" name="category" value="${category}" />
                <input type="hidden" name="page" value="${page}" />
                <div class="card-body">

                    <h4 class="display-1 text-secondary text-center my-3"><i class="icon-lock"></i></h4>
				    <h5 class="text-center mb-4">글 작성시 입력한 비밀번호를 입력하세요.</h5>
				    <p><input type="password" name="pwd" class="form-control text-center my-2" autofocus required /></p>
				    <button type="submit" class="btn btn-info btn-lg btn-block"><i class="icon-check"></i> 비밀번호 확인</button>

                </div>
                </form>
            </div>
        </div>
    </div>

</div>



<%@ include file="../../layout/layout_footer.jsp" %>