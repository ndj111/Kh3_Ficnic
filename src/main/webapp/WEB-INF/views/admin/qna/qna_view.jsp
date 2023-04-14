<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="layout_none" value="Y" />
<%@ include file="../layout/layout_header.jsp" %>

<c:if test="${empty dto}"><script type="text/javascript">alert('존재하지 않는 데이터입니다.'); window.close();</script></c:if>
<% pageContext.setAttribute("newLine", "\n"); %>



<script type="text/javascript">
$(function() {

	// 댓글 등록
	$("#replyBtn").on("click", function() {
		if(!$("#comment_content").val() || $("#comment_content").val() == ""){
			alert("댓글 내용을 입력해 주세요.");
			$("#comment_content").focus();
			return false;
		}

		let get_qna_no = $("#qna_no").val();
		let get_comment_content = $("#comment_content").val();
		let get_comment_writer_name = $("#comment_writer_name").val();
		let get_comment_writer_pw = $("#comment_writer_pw").val();
		let get_member_id = $("#member_id").val();
		let listLength = $("#mComment-list td").length; 

		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			datatype : "text",
			url : "${path}/admin/qna/qna_reply_ok.do",
			data : {
					qna_no : get_qna_no,
					comment_content : get_comment_content,
					comment_writer_name : get_comment_writer_name,
					comment_writer_pw : get_comment_writer_pw,
					member_id : get_member_id
			},

			success : function(data) {
					if(listLength == 0) {
						$("#nodata").animate({opacity: "0"}, function(){
							$(this).remove();
						});	
					}
					if(data > 0) {
						
					var today = new Date();
					var year = today.getFullYear();
					var month = ("0" + (today.getMonth() + 1)).slice(-2);
					var day = ("0" + today.getDate()).slice(-2);
					var hours = ("0" + today.getHours()).slice(-2); 
					var minutes = ("0" + today.getMinutes()).slice(-2);
					var seconds = ("0" + today.getSeconds()).slice(-2); 

					let new_comment = "<tr id=\"comment-"+data.trim()+"\">\n";
					new_comment += "\t<td>\n";
					new_comment += "\t\t<p><b>"+get_comment_writer_name+"</b></p>\n";
					new_comment += "\t\t<p class=\"eng\">("+get_member_id+")</p>\n";
					new_comment += "\t</td>\n";
					new_comment += "\t<td class=\"text-left pl-4\">"+get_comment_content.replace("\n", "<br />")+"</td>\n";
					new_comment += "\t<td>\n";
					new_comment += "\t<p class=\"eng\">"+year+"-"+month+"-"+day+"<br />"+hours+":"+minutes+":"+seconds+"</p>\n";
					new_comment += "\t<button type=\"button\" class=\"btn btn-sm btn-outline-danger mt-1 px-1 py-0 deleteBtn\" name=\"comment_no\" value=\""+data+"\"><i class=\"fa fa-trash-o\"></i> 삭제</button>\n";
					new_comment += "\t</td>\n";
					new_comment += "</tr>\n";
				$("#mComment-list").append(new_comment);
				$("#comment_content").val("");
				$("#comment_content").focus();
				}else{
					alert("댓글 등록 중 에러가 발행하였습니다.");
				}
			},

			error : function(e) {
				alert("Error : "+e.status);
            }
        });
	});


	// 댓글 삭제
		$(document).on("click", ".deleteBtn", function(){
		if(!confirm("이 댓글을 삭제하시겠습니까?")){
			return false;
		}

		let comment_no = $(this).val();

		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			datatype : "text",
			url : "${path}/admin/qna/comment_delete.do",
			data : {
					comment_no : comment_no
			},

			success : function(data) {
				if(data > 0){
					$("#comment-"+comment_no).animate({opacity: "0"}, function(){
						$(this).remove();
					});
				}else{
					alert("댓글 삭제 중 에러가 발행하였습니다.");
				}
			},

			error : function(e) {
				alert("Error : "+e.status);
            }
		});
	});

});
</script>



<h2>1:1 문의 내용 보기</h2>


<div class="page-cont">

    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4>문의 내용</h4>
                    <div class="row form">
                        <div class="form-group col join-form">
                            <label>작성자</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2"><b>${dto.qna_name}</b> <span class="engnum">(${dto.member_id})</span></div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group col join-form mb-2">
                            <label>작성일</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2 engnum">${dto.qna_date}</div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100 border-bottom"></div>

                        <div class="form-group join-form mb-2">
                            <label>피크닉</label>
                            <div class="jf-input">
                                <div class="row align-items-center">
                                	<div class="col-auto pb-1 pr-0">
					                    <c:choose>
					                    <c:when test="${!empty fdto.getFicnic_photo1() }"><img src="${path}${fdto.getFicnic_photo1()}" alt="" width="80" /></c:when>
					                    <c:otherwise><span class="noimg">no img</span></c:otherwise>
					                    </c:choose>
                                	</div>
                                    <div class="col pb-1 pl-2">
		                            	<p><b>${fdto.getFicnic_name()}</b></p>
		                            	<p class="engnum"><fmt:formatNumber value="${fdto.getFicnic_sale_price()}" />원</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100 border-bottom"></div>

                        <div class="form-group join-form">
                            <label>제목</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2">${dto.qna_title}</div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group join-form mb-2">
                            <label>내용</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2">${dto.qna_cont.replace(newLine, "<br />")}</div>
                                </div>
                            </div>
                        </div>

                        <c:if test="${!empty dto.qna_file1 or !empty dto.qna_file2}"><div class="w-100 border-bottom"></div></c:if>
                        <c:if test="${!empty dto.qna_file1}">
                        <div class="form-group join-form">
                            <label>첨부파일 1</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2"><img src="${path}${dto.qna_file1}" style="max-width: 100%;" alt="" /></div>
                                </div>
                            </div>
                        </div>
                        </c:if>

                        <c:if test="${!empty dto.qna_file2}">
                        <div class="form-group join-form">
                            <label>첨부파일 2</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2"><img src="${path}${dto.qna_file2}" style="max-width: 100%;" alt="" /></div>
                                </div>
                            </div>
                        </div>
                        </c:if>

                    </div>
                </div>
            </div>
        </div>
    </div>



    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4>댓글 목록</h4>

                    <table class="table-list">
                        <thead>
                            <tr>
                                <th style="width: 20%; min-width: 120px;">작성자</th>
                                <th>내용</th>
                                <th style="width: 20%; min-width: 120px;">작성일</th>
                            </tr>
                        </thead>

                        <tbody id="mComment-list">
                        	<c:if test="${!empty cdto}">
                        	<c:forEach items="${cdto}" var="cdto">
                            <tr id="comment-${cdto.getComment_no()}">
                                <td>
                                	<p><b>${cdto.getComment_writer_name()}</b></p>
                                	<p>(${cdto.getMember_id()})</p>
                                </td>
                                <td class="text-left pl-4">${cdto.getComment_content().replace(newLine, "<br />")}</td>
                                <td>
                                	<p class="eng">${cdto.getComment_date().substring(0,10)}<br />${cdto.getComment_date().substring(11)}</p>
                                	<button type="button" class="btn btn-sm btn-outline-danger mt-1 px-1 py-0 deleteBtn" name="comment_no" value="${cdto.getComment_no()}"><i class="fa fa-trash-o"></i> 삭제</button>
                                </td>
                            </tr>
                            </c:forEach>
                            </c:if>

                            <c:if test="${empty cdto}">
                            <tr>
                            	<th colspan="3" id="nodata">댓글이 없습니다.</th>
                            </tr>
                            </c:if>
                        </tbody>

                        <tfoot>
                        	<tr>
                        		<td>
                        			<p><b>${sess_name }</b></p>
                        			<p class="eng">${sess_id }</p>
                        			
                        			<input type="hidden" id="qna_no" name="qna_no" value="${param.no}" />
									<input type="hidden" id="member_id" name="member_id" value="${sess_id }" />
									<input type="hidden" id="comment_writer_name" name="comment_writer_name" value="${sess_name }" />	
									<input type="hidden" id="comment_writer_pw" name="comment_writer_pw" value="${sess_pw }" />	
									
                        		</td>
                        		<td class="pl-4"><textarea name="comment_content" id="comment_content" class="form-control rounded-0" required></textarea></td>
                        		<td colspan="2"><button type="button" class="btn btn-lg btn-primary rounded-0" id="replyBtn" style="padding: .94rem 1.1rem;"><i class="fa fa-pencil"></i> 댓글 쓰기</button></td>
                        	</tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>

</div>



<div class="my-2 text-center">
    <button type="button" class="btn btn-outline-secondary" onclick="window.print();"><i class="fa fa-print"></i> 인쇄하기</button>
        <button type="button" class="btn btn-secondary ml-2" onclick="window.close();"><i class="fa fa-times"></i> 창닫기</button>
</div>



<%@ include file="../layout/layout_footer.jsp" %>