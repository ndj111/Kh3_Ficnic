<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../layout/layout_header.jsp" %>

<c:set var="dto" value="${dto}" />

<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>게시판 목록</h2>
        <ol class="m-0 p-2">
            <li>게시판 관리</li>
            <li><b>게시판 목록</b></li>
        </ol>
    </div>
</div>


<div class="page-cont">


 <div style="width: 600px; margin: 50px auto; text-align: center;">
        <hr color="green" />
        <h3>리뷰 상세 정보</h3>
        <hr color="green" />

        <br />

        <table class="table table-bordered">
            <c:if test="${!empty dto}">
            <tr>
                <th>작성자</th>
                <td align="left">${dto.review_name}</td>
            </tr>
            <tr>
                <th>작성일</th>
                <td align="left">${dto.review_date}</td>
            </tr>
            <tr>
                <th>리뷰 평점</th>
                <td align="left">${dto.review_point}점</td>
            </tr>
            <tr>
                <th>리뷰 사진1</th>
                <td align="left">
                	${dto.review_photo1}
                </td>
            </tr>
            <tr>
                <th>리뷰 사진2</th>
                <td align="left">
                	${dto.review_photo2}
                </td>
            </tr>
            <tr>
                <th>리뷰 내용</th>
                <td align="left">
               	<textarea rows="7" cols="25">${dto.review_cont}</textarea>
                </td>
            </tr>
           
            </c:if>

            <c:if test="${empty dto}">
            <tr>
                <td colspan="2" align="center">
                    <h3>존재하지 않는 리뷰입니다...</h3>
                </td>
            </tr>
            </c:if>
        </table>


<!-- 버튼 //START -->
    <div class="d-flex justify-content-center mb-4">
        <button type="button" class="btn btn-outline-secondary" onclick="window.print();"><i class="fa fa-print"></i> 인쇄하기</button>
        <button type="button" class="btn btn-secondary ml-2" onclick="window.close();"><i class="fa fa-times"></i> 창닫기</button>
    </div>
    <!-- 버튼 //END -->
    
    </div>

</div>


<%@ include file="../layout/layout_footer.jsp" %>





</body>
</html>