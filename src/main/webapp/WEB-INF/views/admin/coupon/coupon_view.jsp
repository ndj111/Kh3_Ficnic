<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="layout_none" value="Y" />
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty dto}"><script type="text/javascript">alert('존재하지 않는 데이터입니다.'); window.close();</script></c:if>


<h2>쿠폰 정보 보기</h2>


<div class="page-cont">

    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4>쿠폰 기본 정보</h4>
                    <div class="row form">
                        <div class="form-group col d-flex align-items-center mb-2">
                            <label>쿠폰 이름</label>
                            <div class="px-3">${dto.getCoupon_name()}</div>
                        </div>

                        <div class="w-100 border-bottom"></div>

                        <div class="form-group col d-flex align-items-center">
                            <label>사용 구분</label>
                            <div class="px-3">                                    
                            <c:choose>
                            	<c:when test="${dto.getCoupon_use_type() eq 'cart'}">장바구니</c:when>
                            	<c:when test="${dto.getCoupon_use_type() eq 'category'}">카테고리</c:when>
                           		<c:otherwise>상품</c:otherwise>
                            </c:choose>
							</div>
                        </div>

                        <c:if test="${dto.getCoupon_use_type() ne 'cart'}">
                        <div class="w-100"></div>

                        <div class="form-group join-form">
                            <label>사용 <c:choose><c:when test="${dto.getCoupon_use_type() eq 'category'}">카테고리</c:when><c:otherwise>상품</c:otherwise></c:choose></label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pb-2">
                                        <ul class="list-view">
                                            <c:choose>
                                            <c:when test="${dto.getCoupon_use_type() eq 'category'}">
                                                <c:forEach var="cate" items="${cateList}">
                                                <li>${cate.cate_path}</li>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="goods" items="${goodsList}">
                                                <li>${goods.ficnic_name}</li>
                                                </c:forEach>
                                            </c:otherwise>
                                            </c:choose>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </c:if>

                        <div class="w-100"></div>

                        <div class="form-group col d-flex align-items-center">
                            <label>최대 발행 갯수</label>
                            <div class="px-3 engnum"><fmt:formatNumber value="${dto.getCoupon_max_ea()}" /></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>




    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4>쿠폰 할인 정보</h4>

                    <div class="row form">
                        <div class="form-group col d-flex align-items-center">
                            <label>할인 금액</label>
                            <div class="px-3 engnum">
                            <c:choose>
	                            <c:when test="${dto.getCoupon_price_type() eq 'price'}"><fmt:formatNumber value="${dto.getCoupon_price()}" />원</c:when>
	                            <c:otherwise><fmt:formatNumber value="${dto.getCoupon_price()}" />%</c:otherwise>
                            </c:choose>
                            </div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group col d-flex align-items-center mb-2">
                            <label>최소 사용 금액</label>
                            <div class="px-3 engnum"><fmt:formatNumber value="${dto.getCoupon_price_over()}" />원</div>
                        </div>
                        <div class="form-group col d-flex align-items-center mb-2">
                            <label>최대 할인 금액</label>
                            <div class="px-3 engnum"><fmt:formatNumber value="${dto.getCoupon_price_max()}" />원</div>
                        </div>

                        <div class="w-100 border-bottom"></div>

                        <div class="form-group col d-flex align-items-center">
                            <label>사용 기간</label>
                            <div class="px-3 engnum">
                            	<c:choose>
                            	<c:when test="${dto.getCoupon_date_type() eq 'free'}">제한없음</c:when>
                           		<c:when test="${dto.getCoupon_date_type() eq 'after'}">발급 후 ${dto.getCoupon_date_value() }일</c:when>
                           		<c:otherwise>${dto.getCoupon_start_date()} ~ ${dto.getCoupon_end_date()}</c:otherwise>
                             	</c:choose>
                            </div>
                        </div>
                    </div>
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