<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../layout/layout_header.jsp" %>


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

<c:set var="dto" value="${Modify}" />
<c:set var="rlist" value="${rlist }" />


<div class="pb100">
    <form method="post" action="<%=request.getContextPath() %>/admin/review/review_modify_ok.do">
  
    <input type="hidden" name="review_no" value="${dto.review_no}" />
   
    <table class="table-form mt-3">
    
        <colgroup>
            <col width="16%" />
            <col width="34%" />
            <col width="16%" />
            <col />
        </colgroup>

        <tr>
        	<th>작성자 아이디</th>
           <td>
             	<input name="member_id" value="${dto.member_id}" maxlength="30" readonly />
           </td> 
           
           <th>작성자 이름</th>            
           <td>
            	<input name="review_name" value="${dto.review_name}" maxlength="30" readonly />
           </td>                  
        </tr>
         
        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>
        
         <tr>
            <th>리뷰 평점</th>
          	<td>
		        	<select name="review_point">
	                	<c:forEach begin="1" end="10" var="i">
	                    	<option value="${i}"<c:if test="${dto.review_point == i}"> selected="selected"</c:if>>${i}</option>
	                	</c:forEach>
	                </select>
	         </td>
	      </tr>
	      
 	      <tr>
            <th>리뷰 사진1</th>
            <td> 
         <input type="file" name="review_photo1">
                <c:if test="${!empty dto.review_photo1}">
                <p class="mt-2"><img src="<%=request.getContextPath()%>${dto.review_photo1}" style="max-width: 400px;" alt="" /></p></c:if>
             </td>
        </tr>
        
        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>
        
        <tr> 
        	<th>리뷰 사진2</th>
              <td> 
         <input type="file" name="review_photo2">
                <c:if test="${!empty dto.review_photo2}">
                <p class="mt-2"><img src="<%=request.getContextPath()%>${dto.review_photo2}" style="max-width: 400px;" alt="" /></p></c:if>
             </td>
        </tr> 
      
        <tr> 
        	<th>리뷰 내용</th>										
			<td><textarea name="review_cont" cols="20" rows="4">${dto.review_cont}</textarea></td>
        </tr>
     		<tr>
               <td> <button type="button" class="btn btn-lg btn-outline-secondary mx-1" onclick="history.back();"><i class="fa fa-bars"></i> 취소하기</button>
                <button type="submit" class="btn btn-lg btn-success mx-1"><i class="fa fa-save"></i> 수정하기</button> </td>
           	</tr>
        
      		 </table>
        </form>

    </div> 
 

</div>


<%@ include file="../layout/layout_footer.jsp" %>




    

  




</body>
</html>