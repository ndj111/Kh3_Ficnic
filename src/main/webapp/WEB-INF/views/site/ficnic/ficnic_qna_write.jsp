<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_qna.css?${time}" />
<script language="javascript" src="${path}/resources/site/js/js_ficnic.js?${time}"></script>



<div class="page-info w1100">
    <h2>1:1 문의하기</h2>
    <ol>
        <li><a href="${path}/"><i class="icon-home"></i> HOME</a></li>
        <li>피크닉</li>
        <li>${fdto.getFicnic_name() }</li>
        <li><b>1:1 문의하기</b></li>
    </ol>
</div>



<div class="contents w1100 ficnic-qna">

	<form name="form_input" method="post" enctype="multipart/form-data" action="${path}/ficnic/mypage_qna_writeOk.do">
	<input type="hidden" value="${fdto.getFicnic_no() }" name="ficnic_no">
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
                            <input type="text" name="qna_title" class="form-control" />
                        </td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td colspan="2">
                        	<textarea name="qna_cont" cols="80" rows="3" class="form-control"></textarea>
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
                        <td class="engnum" colspan="2">
				            <input type="file" name="qna_file_modi1" class="form-control" accept="image/jpeg, image/png, image/gif" />
                        </td>
                    </tr>
                    <tr>
                        <th>사진2</th>
                        <td class="engnum" colspan="2">
				        	<input type="file" name="qna_file_modi2" class="form-control" accept="image/jpeg, image/png, image/gif" />
                        </td>
                    </tr>
                </tbody>
            </table>
        
		<button class="btn btn-primary writeBtn" type="submit" type="submit">등록하기</button>
        
	</form>




</div>



<%@ include file="../layout/layout_footer.jsp" %>