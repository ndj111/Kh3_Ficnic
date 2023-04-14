<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="layout_none" value="Y" />
<%@ include file="../layout/layout_header.jsp" %>

<c:set var="dto" value="${dto}" />
<c:set var="cdto" value="${cdto}" />
<c:set var="pdto" value="${pdto}" />
<c:if test="${empty dto}"><script type="text/javascript">alert('존재하지 않는 데이터입니다.'); window.close();</script></c:if>


<h2>회원 정보 보기</h2>


<div class="page-cont">

    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4>회원 정보</h4>
                    <div class="row form">
                        <div class="form-group col d-flex align-items-center mb-2">
                            <label>회원 유형</label>
                            <div class="px-3">
                                <c:choose>
                                <c:when test="${dto.getMember_type() eq 'admin'}">관리자</c:when>
                                <c:when test="${dto.getMember_type() eq 'exit'}">탈퇴회원</c:when>
                                <c:otherwise>회원</c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="w-100 border-bottom"></div>

                        <div class="form-group col d-flex align-items-center">
                            <label>아이디</label>
                            <div class="px-3 engnum">${dto.getMember_id()}</div>
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col d-flex align-items-center">
                            <label>이름</label>
                            <div class="px-3">${dto.getMember_name()}</div>
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col d-flex align-items-center">
                            <label>이메일</label>
                            <div class="px-3 engnum">${dto.getMember_email()}</div>
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col d-flex align-items-center">
                            <label>연락처</label>
                            <div class="px-3 engnum">${dto.getMember_phone()}</div>
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col d-flex align-items-center">
                            <label>적립금</label>
                            <div class="px-3 engnum"><fmt:formatNumber value="${dto.getMember_point()}" /></div>
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col d-flex align-items-center">
                            <label>가입일자</label>
                            <div class="px-3 engnum">${dto.getMember_joindate()}</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <c:set var="cdto" value="${cdto}" />
    <c:if test="${!empty cdto}">
    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4>보유 쿠폰</h4>

                    <table class="table-list">
                        <thead>
                            <tr>
                                <th style="width: 7%;">No.</th>
                                <th>쿠폰 이름</th>
                                <th style="width: 17%;">사용여부/사용날짜</th>
                                <th style="width: 20%;">사용 가능 기간</th>
                                <th style="width: 17%;">쿠폰 금액</th>
                                <th style="width: 15%;">쿠폰 발급 일자</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach items="${cdto}" var="cdto">
                            <tr>
                                <td class="eng">${cdto.getCoupon_no()}</td>
                                <td>
                                	<c:forEach items="${cdto.getCoupon_list()}" var="dto">
                                		<c:if test="${cdto.getCoupon_no() eq dto.getCoupon_no() }">
                                			${dto.getCoupon_name() }
                                		</c:if>
                                	</c:forEach>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${cdto.getMcoupon_use_date() == null}"><p class="text-primary">미사용</p></c:when>
                                        <c:otherwise><p class="text-danger">사용</p><p class="eng">${cdto.getMcoupon_use_date().substring(0,10)}</p></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="eng">
                                    <p>${cdto.getMcoupon_start_date().substring(0,10)}</p>
                                    <p> ~ ${cdto.getMcoupon_end_date().substring(0,10)}</p>
                                </td>
                                <td class="eng"><fmt:formatNumber value="${cdto.getMcoupon_use_price()}" />원</td>
                                <td class="eng">${cdto.getMcoupon_date().substring(0,10)}</td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    </c:if>



    <c:set var="pdto" value="${pdto}" />
    <c:if test="${!empty pdto}">
    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4>적립금 내역</h4>

                    <table class="table-list sub-list">
                        <thead>
                            <tr>
                                <th style="width: 10%;">No.</th>
                                <th style="width: 14%;">구분</th>
                                <th style="width: 18%;">적립 금액</th>
                                <th>적립 이유</th>
                                <th style="width: 20%;">적립 일자</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach items="${pdto}" var="pdto">
                            <tr>
                                <td class="eng">${pdto.getPoint_no()}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${pdto.getPoint_kind() eq 'join'}">회원가입</c:when>
                                        <c:when test="${pdto.getPoint_kind() eq 'reviewWrite'}">리뷰작성</c:when>
                                        <c:when test="${pdto.getPoint_kind() eq 'admin'}">관리자</c:when>
                                        <c:when test="${pdto.getPoint_kind() eq 'reserv'}">예약하기</c:when>
                                        <c:when test="${pdto.getPoint_kind() eq 'consume'}">사용금액</c:when>
                                        
                                    </c:choose>
                                </td>
                                <td class="eng">
                                    <c:choose>
                                        <c:when test="${pdto.getPoint_type() eq 'plus'}"><span class="text-primary">+<fmt:formatNumber value="${pdto.getPoint_add()}" /></span></c:when>
                                        <c:when test="${pdto.getPoint_type() eq 'minus'}"><span class="text-danger">-<fmt:formatNumber value="${pdto.getPoint_add()}" /></span></c:when>
                                    </c:choose>
                                </td>
                                <td>${pdto.getPoint_reason()}</td>
                                <td class="eng">${pdto.getPoint_date().substring(0,10)}</td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    </c:if>

</div>



<div class="my-2 text-center">
    <button type="button" class="btn btn-outline-secondary" onclick="window.print();"><i class="fa fa-print"></i> 인쇄하기</button>
        <button type="button" class="btn btn-secondary ml-2" onclick="window.close();"><i class="fa fa-times"></i> 창닫기</button>
</div>



<%@ include file="../layout/layout_footer.jsp" %>