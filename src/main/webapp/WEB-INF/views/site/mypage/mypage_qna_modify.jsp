<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인이 필요합니다.'); location.href='${path}/member/member_login.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_qna.css" />
<script language="javascript" src="${path}/resources/site/js/js_qna.js"></script>


<c:set var="mypage_eng" value="qna" />
<c:set var="mypage_kor" value="내 1:1 문의 내역" />


<%@ include file="../layout/layout_mymenu.jsp" %>



<div class="contents w1100 mypage-qna-modify">

    <!-- 피크닉 정보 //START -->
    		<h4>피크닉 정보</h4>
            <table class="table-form mb-5">
                <colgroup>
                    <col width="10%" />
                    <col width="32%" />
                    <col width="17%" />
                    <col />
                </colgroup>

                <tbody>
                    <tr>
                        <th>피크닉 이름</th>
                        <td colspan="2" class="tdImg">
						    <c:choose>
						    <c:when test="${!empty fdto.getFicnic_photo1() }"><img src="${path}${fdto.getFicnic_photo1()}" alt="" class="qnaImg"/></c:when>
						    <c:otherwise><span class="noimg">no img</span></c:otherwise>
						    </c:choose>                        
			                <p><b>${fdto.getFicnic_name() }</b><span class="engnum"><fmt:formatNumber value="${fdto.getFicnic_sale_price() }" />원</span></p>
                        </td>
                    </tr>
                    <tr>
                        <th>작성일자</th>
                        <td class="engnum" colspan="2">${dto.getQna_date() }</td>
                    </tr>
                </tbody>
            </table>
    <!-- 피크닉 정보 //END -->

    <!-- 1:1문의 내용 정보 //START -->
		<form name="form_input" method="post" enctype="multipart/form-data" action="${path}/mypage/mypage_qna_modifyOk.do">
		<input type="hidden"  name="qna_no" value="${dto.getQna_no()}">
	    	
	    <h4>1:1 문의 내용</h4>	
            <table class="table-form mb-5">
                <colgroup>
                    <col width="10%" />
                    <col width="32%" />
                    <col width="17%" />
                    <col />
                </colgroup>
                <tbody>
                    <tr>
                        <th>제목</th>
                        <td colspan="2">
                            <input type="text" name="qna_title" class="form-control" value="${dto.getQna_title() }"/>
                        </td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td colspan="2">
                        	<textarea name="qna_cont" cols="80" rows="3" class="form-control">${dto.getQna_cont() }</textarea>
                        </td>
                    </tr>
                </tbody>
            </table>
		
		<h4>1:1 문의 사진</h4>
            <table class="table-form mb-5">
                <colgroup>
                    <col width="10%" />
                    <col width="32%" />
                    <col width="17%" />
                    <col />
                </colgroup>
                <tbody>
                    <tr>
                        <th>사진1</th>
                        <td class="tdImg" colspan="2">
                        <c:if test="${!empty dto.getQna_file1()}">
                        	<a href="${path}${dto.getQna_file1()}" target="_blank"><img src="${path}${dto.getQna_file1()}" alt="" class="qnaImg"/></a>
                        </c:if>
                        <p><input type="file" name="qna_file_modi1" class="form-control" accept="image/jpeg, image/png, image/gif" />
                        <c:if test="${!empty dto.getQna_file1()}">
	                        <span class="fileSpan"><button type="button" class="btn btn-sm btn-outline-danger" onclick="delQnaPhoto(this, '${dto.getQna_no()}', 1);"><i class="fa fa-trash-o"></i> 등록된 이미지 삭제</button></span>
	                        <input type="hidden" name="ori_qna_file1" value="${dto.getQna_file1()}" />
                        </c:if>
                        </p>
                        </td>
                    </tr>
                    <tr>
                        <th>사진2</th>
                        <td class="tdImg" colspan="2">
                        <c:if test="${!empty dto.getQna_file2()}">
                        	<a href="${path}${dto.getQna_file2()}" target="_blank"><img src="${path}${dto.getQna_file2()}" alt="" class="qnaImg"/></a>
                        </c:if>
                        <p><input type="file" name="qna_file_modi2" class="form-control" accept="image/jpeg, image/png, image/gif" />
                        <c:if test="${!empty dto.getQna_file2()}">
	                        <span class="fileSpan"><button type="button" class="btn btn-sm btn-outline-danger" onclick="delQnaPhoto(this, '${dto.getQna_no()}', 2);"><i class="fa fa-trash-o"></i> 등록된 이미지 삭제</button></span>
	                        <input type="hidden" name="ori_qna_file2" value="${dto.getQna_file2()}" />
                        </c:if>
                        </p>
                        </td>
                    </tr>
                </tbody>
            </table>
    <!-- 1:1문의 내용 정보 // END -->
		<button class="btn btn-primary writeBtn" type="submit" type="submit">수정하기</button>
		
		</form>

</div>



<%@ include file="../layout/layout_footer.jsp" %>