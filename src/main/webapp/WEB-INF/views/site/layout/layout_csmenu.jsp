<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="page-info w1100">
    <h2>
    	<ul>
    		<li<c:if test="${conf.getBoard_id() eq 'notice'}"> class="now"</c:if>><a href="${path}/board/board_list.do?bbs_id=notice">공지사항</a></li>
    		<li<c:if test="${conf.getBoard_id() eq 'faq'}"> class="now"</c:if>><a href="${path}/board/board_list.do?bbs_id=faq">자주묻는 질문</a></li>
            <li<c:if test="${conf.getBoard_id() eq 'event'}"> class="now"</c:if>><a href="${path}/board/board_list.do?bbs_id=event">이벤트</a></li>
    	</ul>
    </h2>
    <ol>
        <li><a href="${path}/"><i class="icon-home"></i> HOME</a></li>
        <li>고객센터</li>
        <li><b>${conf.getBoard_name()}</b></li>
    </ol>
</div>