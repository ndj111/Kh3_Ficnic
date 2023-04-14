<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인이 필요합니다.'); location.href='${path}/member/member_login.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_mypage.css" />
<script language="javascript" src="${path}/resources/site/js/js_mypage.js"></script>




<c:set var="mypage_eng" value="reserv" />
<c:set var="mypage_kor" value="피크닉 예약 목록" />
<jsp:useBean id="currentDay" class="java.util.Date" />
<fmt:formatDate value="${currentDay}" pattern="yyyy-MM-dd HH:mm:ss" var="today" />

<%@ include file="../layout/layout_mymenu.jsp" %>



<div class="contents w1100 mypage-reserv">

	<div class="mypage-reserv-topdiv">
		<ul class="mypage-reserv d-flex flex-row">
			<li class="mr-3"><a class="ali1 <c:if test="${empty getType}">text-danger</c:if> " href="<%=request.getContextPath()%>/mypage/mypage_reserv_list.do" >모두보기</a>&nbsp;&nbsp;&nbsp;&nbsp;｜</li>
			<li class="mr-3"><a class="ali1 <c:if test="${getType eq 'done'}">text-danger</c:if> " href="<%=request.getContextPath()%>/mypage/mypage_reserv_list.do?getType=done">이용완료</a>&nbsp;&nbsp;&nbsp;&nbsp;｜</li>
			<li class="mr-3"><a class="ali2 <c:if test="${getType eq 'cancel'}">text-danger</c:if>" href="<%=request.getContextPath()%>/mypage/mypage_reserv_list.do?getType=cancel">취소내역</a></li>
		</ul>
	</div>
	
			<c:choose>
				<c:when test="${!empty List }">
					<c:forEach items="${List}" var="dto">
					<div class="mypage-reserv-mainDiv d-flex flex-column w1000 ">
						<!-- 예약 리스트 출력  -->
						<div class="mypage-reserv-subDiv d-flex flex-row flex-wrap mt-1">
				    			<c:set var="move_ficnic_info" value="onclick=\"location.href='${path}/ficnic/ficnic_view.do?ficnic_no=${dto.getFicnic_no()}'\""/>
				    			<div class="mypage-wish w-20 mt-1 pb-3 d-flex justify-content-start  align-items-center">
									  	<img ${move_ficnic_info } src="${path }${dto.getReserv_ficnic_photo()}" class="card-img-top" style="width:222px;" alt="...">
									  <div class="mypage-wish d-flex flex-column  ml-3">
										  	<div ${move_ficnic_info } class="mb-2"> 
											    <p class="card-sess">${dto.getReserv_sess() }</p>
											    <p class="card-text card-title">${dto.getReserv_ficnic_name() }</p>
											 </div>
											 <div class="mt-2 mb-2">
												 <ul ${move_ficnic_info } class="mypage-wish d-flex  flex-column ">
												    <li class="card-date"> ${dto.getReserv_ficnic_date().substring(0,10)}</li>
												    <li class="card-text
												    	<c:if test="${dto.getReserv_status() eq 'reserv'}"> text-warning" >신청 대기</c:if> 
												    	<c:if test="${dto.getReserv_status() eq 'confirm'}"> text-primary" >신청 확인</c:if> 
												    	<c:if test="${dto.getReserv_status() eq 'done'}"> text-success" >체험 완료</c:if> 
												    	<c:if test="${dto.getReserv_status() eq 'cancel'}"> text-danger" >예약 취소</c:if> 							    
												    </li>
												     <li class="card-price"><fmt:setLocale value="ko_kr" /><fmt:formatNumber value="${dto.getReserv_total_price()}" type="currency" /></li>
												 </ul>
											 </div>
										<div class="mt-2 mb-2">
										    <c:if test="${!empty dto.getReserv_status()}"> <a href="${path}/mypage/mypage_reserv_view.do?reserv_no=${dto.getReserv_no()}" class="view_btn"><i class="fa fa-search"></i> 상세 내역</a></c:if>
										    <c:forEach items="${sList }" var="sdto">
										    	<c:if test="${sdto.getFicnic_no() eq dto.getFicnic_no() }">
										    		<c:set var="revSession" value="t"/>
										    	</c:if>
										    </c:forEach>
										    <c:if test="${dto.getReserv_date() < today and dto.getReserv_status() eq 'done' and empty revSession}"> <a class="modbtnreserv btn-js" data-bs-toggle="modal" data-bs-target="#exampleModal" data-name="${dto.getReserv_ficnic_name()}" data-no="${dto.getFicnic_no() }"><i class="fa fa-pencil"></i> 리뷰 작성</a></c:if>
										    <c:if test="${!empty revSession}">
										    	<c:remove var="revSession"/>
										    </c:if>
										    <c:if test="${dto.getReserv_status() eq 'cancel'}"></c:if>
										</div>
									  </div>
								</div>	
							</div>
						</div>
						</c:forEach>
					</c:when>
				<c:otherwise>
						<div class="f_rlist" align="center">
							<p><img class="f_rlistimg" src="data:image/svg+xml,%3Csvg width='56' height='56' fill='none' xmlns='http://www.w3.org/2000/svg'%3E %3Cpath d='M38 16H22M38 23H22M38 30H22M38 37H22' stroke='%23777' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'/%3E %3Crect x='8' y='5' width='39' height='44' rx='4' stroke='%23777' stroke-width='2'/%3E %3Ccircle cx='16.5' cy='16' r='1.5' fill='%23777'/%3E %3Ccircle cx='16.5' cy='23' r='1.5' fill='%23777'/%3E %3Ccircle cx='16.5' cy='30' r='1.5' fill='%23777'/%3E %3Ccircle cx='16.5' cy='37' r='1.5' fill='%23777'/%3E %3Ccircle cx='42' cy='43' r='11' fill='%23fff' stroke='%23fff' stroke-width='2'/%3E %3Ccircle cx='42' cy='43' r='9' fill='%23fff' stroke='%23777' stroke-width='2'/%3E %3Cpath d='m39 46 6-6M45 46l-6-6' stroke='%23777' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'/%3E %3C/svg%3E" width="56px" height="56px"></p>
								<p class="f_rlistf"> 해당 피크닉 내역이 없어요! </p>
							<p class="f_rlists">지금 바로 피크닉을 시작해보세요. </p>
							<p><a class="f_rlistbtn" href="${path}/main.do">홈으로 이동</a></p>
						</div>
				</c:otherwise>	
    		
    		</c:choose>
</div>
		<!-- 페이징 처리  -->
		<c:if test="${!empty paging}">
	        <div class="d-flex flex-row  justify-content-center  align-items-center w1000 ">
	            	<div class="d-flex flex-row ">
	                    ${pagingWrite}
	               </div>
	        </div>
	    </c:if>
	    <!-- 페이징 처리 end -->

	

	


<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <form id="mypage-form-div" action="${path}/mypage/mypage_review_write.do" method="post" enctype="multipart/form-data">
  		<input type="hidden" name="member_id" value="${sess_id}">
  		<input type="hidden" name="review_name" value="${sess_name}">
  		<input type="hidden" name="review_pw" value="1111">
  		<input type="hidden" name="review_date" value="${today}" class="form-control w-100" required />
  		<input type="hidden" name="ficnic_no" class="form-control w-100" required />
  		<input type="hidden" name="rno" class="form-control w-100" id="mypage-reserv-rno"/>
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel"></h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body p-3 m-1 ">
	      	<label>리뷰 평점</label>
            <div class="jf-input">
                <div class="row">
                    <div class="col py-1 text-nowrap">
                        <c:forEach begin="1" end="10" var="i">
                        <div class="form-check form-check-inline mx-2">
                            <input class="form-check-input" type="radio" name="review_point" id="review_point" value="${i}" <c:if test="${i == 10}"> checked="checked"</c:if>/>
                            <label class="form-check-label" for="review_point${i}">${i}</label>
                        </div>
                        </c:forEach>
                    </div>
                </div>
           	</div>
	      	<label>리뷰 내용</label>
	        <textarea class="form-control form-control-lg" rows="5" name="review_cont" id="review_con"></textarea>      		
	        <div class="mypage-reserv-img">
	        	<c:if test="${!empty m}"><img alt="이미지 없음" src="" name="ori_review_photo1"  id="ori_review_photo1" style="width: 200px; height: 200px; "></c:if>
	        </div>
	        <input type="file" name="file1" class="form-control" accept="image/jpeg, image/png, image/gif">
	        <div class="mypage-reserv-img">
	        	<c:if test="${!empty m}"><img alt="이미지 없음" src="" name="ori_review_photo2"  id="ori_review_photo2" style="width: 200px; height: 200px; "></c:if>
	        </div>
	        <input type="file" name="file2" class="form-control" accept="image/jpeg, image/png, image/gif">
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	        <input type="submit" class="btn btn-primary" id="mypage-reserv-subtn" value="작성하기"/>
	      </div>
	    </div>
	  </div>
  </form>
</div>



<%@ include file="../layout/layout_footer.jsp" %>