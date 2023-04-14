<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="layout_none" value="Y" />
<%@ include file="../layout/layout_header.jsp" %>

<c:if test="${empty dto}"><script type="text/javascript">alert('존재하지 않는 데이터입니다.'); window.close();</script></c:if>


<h2>예약 상세 정보 보기</h2>


<div class="page-cont">
    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4>예약 정보</h4>
                    <div class="row form">
                        <div class="form-group join-form">
                            <label style="padding-top: 22px;">예약 상태</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2">
                                        <form name="form_status" method="post" action="${path}/admin/reserv/reserv_status_ok.do" onsubmit="return confirm('예약 상태를 변경하시겠습니까?');">
                                        <input type="hidden" name="reserv_no" value="${dto.getReserv_no()}" />
                                        <input type="hidden" name="reserv_sess" value="${dto.getReserv_sess()}" />
                                        <select name="reserv_status" class="custom-select w-auto mr-2">
                                            <option value="reserv" class="text-info"<c:if test="${dto.getReserv_status() eq 'reserv'}"> selected="selected"</c:if>>체험신청</option>
                                            <option value="confirm" class="text-primary"<c:if test="${dto.getReserv_status() eq 'confirm'}"> selected="selected"</c:if>>예약확정</option>
                                            <option value="done" class="text-secondary"<c:if test="${dto.getReserv_status() eq 'done'}"> selected="selected"</c:if>>체험완료</option>
                                            <option value="cancel" class="text-danger"<c:if test="${dto.getReserv_status() eq 'cancel'}"> selected="selected"</c:if>>예약취소</option>
                                        </select>
                                        <button type="submit" class="btn btn-outline-primary"><i class="fa fa-refresh"></i> 상태 변경</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group col-sm d-flex align-items-center">
                            <label>예약번호</label>
                            <div class="px-3 engnum">${dto.getReserv_sess()}</div>
                        </div>
                        <div class="form-group col-sm d-flex align-items-center">
                            <label>예약일자</label>
                            <div class="px-3 engnum">${dto.getReserv_date()}</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



	<!-- 회원정보 시작  -->
    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4>예약자 정보</h4>
                    <div class="row form">
                        <div class="form-group col d-flex align-items-center">
                            <label>이름</label>
                            <div class="px-3">${dto.getReserv_name()} <span class="engnum">(${dto.getMember_id()})</span></div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group col-sm d-flex align-items-center">
                            <label>전화번호</label>
                            <div class="px-3 engnum">${dto.getReserv_phone()}</div>
                        </div>
                        <div class="form-group col-sm d-flex align-items-center">
                            <label>이메일</label>
                            <div class="px-3">${dto.getReserv_email()}</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<!-- 회원정보 끝  -->



	<!-- 피크닉 정보 시작 -->
    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4>피크닉 정보</h4>
                    <div class="row form">
                        <div class="form-group join-form">
                            <label style="padding-top: 35px;">피크닉</label>
                            <div class="jf-input">
                            <div class="d-flex align-items-center px-2 pt-1 pb-2">
                                <div>
                                    <c:choose>
                                        <c:when test="${!empty dto.getReserv_ficnic_photo()}"><img src="${path}${dto.getReserv_ficnic_photo()}" onerror="this.src='${path}/resources/admin/images/noimg.gif'" alt="" width="60" /></c:when>
                                        <c:otherwise><span class="noimg" style="width: 60px;">no img</span></c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="ml-2"><b>${dto.getReserv_ficnic_name()}</b></div>
                            </div>
                            </div>
                        </div>

                        <c:if test="${!empty dto.getReserv_ficnic_option_title()}">
                        <div class="w-100"></div>

                        <div class="form-group col d-flex align-items-center">
                            <label>선택 옵션</label>
                            <div class="px-3">${dto.getReserv_ficnic_option_title()} (<span class="engnum"><fmt:formatNumber value="${dto.getReserv_ficnic_option_price()}" /></span>원)</div>
                        </div>
                        </c:if>

                        <c:if test="${!empty dto.getReserv_ficnic_select_title()}">
                        <div class="w-100"></div>

                        <div class="form-group col d-flex align-items-center">
                            <label>추가 선택</label>
                            <div class="px-3">${dto.getReserv_ficnic_select_title()} (<span class="engnum"><fmt:formatNumber value="${dto.getReserv_ficnic_select_price()}" /></span>원)</div>
                        </div>
                        </c:if>

                        <div class="w-100 border-bottom mt-2"></div>

                        <c:if test="${dto.getReserv_ficnic_date() != null}">
                        <div class="form-group col d-flex align-items-center">
                            <label>피크닉 날짜</label>
                            <div class="px-3 engnum">
                                ${dto.getReserv_ficnic_date().substring(0, 10)}
                                <button type="button" class="btn btn-sm btn-outline-info ml-2" data-toggle="modal" data-target="#modalFicnicDate"><i class="fa fa-calendar"></i> 날짜 변경</button>
                            </div>
                        </div> 

                        <div class="w-100"></div>
                        </c:if>

                        <div class="form-group col d-flex align-items-center">
                            <label>누구와 함께</label>
                            <div class="px-3">
                                <c:choose>
                                    <c:when test="${dto.getReserv_with() eq 'alone'}">혼자</c:when>
                                    <c:when test="${dto.getReserv_with() eq 'child'}">아이</c:when>
                                    <c:when test="${dto.getReserv_with() eq 'couple'}">연인</c:when>
                                    <c:when test="${dto.getReserv_with() eq 'friend'}">친구</c:when>
                                    <c:when test="${dto.getReserv_with() eq 'family'}">가족</c:when>
                                    <c:when test="${dto.getReserv_with() eq 'parent'}">부모님</c:when>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<!-- 피크닉 정보 끝 -->



	<!-- 결제 정보 시작 -->
    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4>결제 정보</h4>
                    <div class="row form">
                        <div class="form-group col d-flex align-items-center">
                            <label>결제수단</label>
                            <div class="px-3">
                                <c:choose>
                                <c:when test="${dto.getReserv_payment() eq 'naver'}">네이버페이</c:when>
                                <c:when test="${dto.getReserv_payment() eq 'kakao'}">카카오페이</c:when>
                                <c:when test="${dto.getReserv_payment() eq 'nobankbook'}">무통장 입금</c:when>
                                <c:when test="${dto.getReserv_payment() eq 'toss'}">실시간 계좌이체</c:when>
                                <c:otherwise>카드결제</c:otherwise>
                                </c:choose>                            
                            </div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group join-form">
                            <label style="padding-top: 24px;">결제 금액</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col d-flex pt-1 pb-2">
                                        <div class="text-black pl-2">피크닉<br />
                                            <c:choose>
                                                <c:when test="${dto.getReserv_ficnic_option_price() > 0}"><b class="eng">0</b>원</c:when>
                                                <c:otherwise><b class="eng"><fmt:formatNumber value="${dto.getReserv_ficnic_sale_price()}" /></b>원</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="pl-4 text-primary">선택 옵션<br /><b class="eng">+ <fmt:formatNumber value="${dto.getReserv_ficnic_option_price()}" /></b>원</div>
                                        <div class="pl-4 text-success">추가 선택<br /><b class="eng">+ <fmt:formatNumber value="${dto.getReserv_ficnic_select_price()}" /></b>원</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group col d-flex align-items-center">
                            <label>최종 결제 금액</label>
                            <div class="px-3 text-primary"><b class="engnum"><fmt:formatNumber value="${dto.getReserv_total_price()}"></fmt:formatNumber></b>원</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<!-- 결제 정보 끝 -->	
	
</div>



<div class="my-2 text-center">
    <button type="button" class="btn btn-outline-secondary" onclick="window.print();"><i class="fa fa-print"></i> 인쇄하기</button>
    <button type="button" class="btn btn-secondary ml-2" onclick="window.close();"><i class="fa fa-times"></i> 창닫기</button>
</div>



<c:if test="${dto.getReserv_ficnic_date() != null}">
<style type="text/css">#ui-datepicker-div { z-index: 1051 !important; }</style>
<!-- 피크닉 날짜 변경 //START -->
<div class="modal fade" id="modalFicnicDate" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="fa fa-exclamation"></i> 피크닉 날짜 변경</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            <div class="modal-body py-5 text-center">
                <form name="form_ficnicdate" method="post" action="${path}/admin/reserv/reserv_date_ok.do" onsubmit="return confirm('피크닉 날짜를 변경하시겠습니까?');">
                <input type="hidden" name="reserv_no" value="${dto.getReserv_no()}" />
                <input type="hidden" name="reserv_sess" value="${dto.getReserv_sess()}" />
                <div class="row justify-content-center">
                    <div class="col-sm-6 mb-4">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fa fa-calendar mr-1"></i> 변경일자</span>
                            </div>
                            <input type="text" name="ficnic_date" value="${dto.getReserv_ficnic_date().substring(0, 10)}" id="startDt" class="form-control text-center eng" />
                        </div>
                    </div>
                </div>
                <button class="btn btn-info"><i class="fa fa-save"></i> 변경하기</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- 피크닉 날짜 변경 //END -->
</c:if>



<%@ include file="../layout/layout_footer.jsp" %>