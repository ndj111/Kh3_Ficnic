<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_ficnic.css?${time}" />
<script language="javascript" src="${path}/resources/site/js/js_ficnic.js?${time}"></script>



<div class="page-info w1100">
    <h2>카테고리</h2>
    <ol>
        <li><a href="${path}/"><i class="icon-home"></i> HOME</a></li>
        <li><b>카테고리</b></li>
    </ol>
</div>



<div class="contents w1100 category-list">

	<ul>
		<c:forEach var="cate" items="${cList}">
		<li>
			<a href="${path}/ficnic/ficnic_list.do?category=${cate.getCategory_id()}" style="background-image: url('${path}/${cate.getCategory_image()}');">
				<div class="cate-overlay"></div>
				<div class="cate-gradient"></div>
				<span>${cate.getCategory_name()}</span>
			</a>
		</li>
		</c:forEach>
	</ul>

</div>



<%@ include file="../layout/layout_footer.jsp" %>