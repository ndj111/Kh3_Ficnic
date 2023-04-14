<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="layout_none" value="Y" />
<%@ include file="../layout/layout_header.jsp" %>

<c:set var="fdto" value="${fdto}" />
<c:if test="${empty fdto}"><script type="text/javascript">alert('존재하지 않는 데이터입니다.'); window.close();</script></c:if>
<% pageContext.setAttribute("newLine", "\n"); %>


<h2>피크닉 정보 보기</h2>


<div class="page-cont">

    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4>기본 정보</h4>
                    <div class="row form">
                        <div class="form-group join-form">
                            <label>피크닉 이름</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2 pl-3"><h5>${fdto.getFicnic_name()}</h5></div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group col d-flex align-items-center">
                            <label>판매 가격</label>
                            <div class="px-3">
                                <c:if test="${fdto.getFicnic_market_price() > 0}"><b class="engnum text-secondary"><fmt:formatNumber value="${fdto.getFicnic_market_price()}" />원</b> <i class="fa fa-arrow-right mx-2"></i></c:if>
                                <b class="engnum text-primary"><fmt:formatNumber value="${fdto.getFicnic_sale_price()}" />원</b>
                                <c:if test="${fdto.getFicnic_market_price() > 0}"><b class="engnum text-danger ml-1">(<fmt:formatNumber value="${fdto.getFicnic_sale_price() / fdto.getFicnic_market_price()}" type="percent" /> 할인)</b></c:if>
                            </div>
                        </div>

                        <div class="w-100 border-bottom mt-2"></div>

                        <div class="form-group join-form">
                            <label>기본 카테고리</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2 pl-3">${fdto.getFicnic_category_name()}</div>
                                </div>
                            </div>
                        </div>

                        <c:if test="${!empty fdto.getFicnic_category_sub1() or !empty fdto.getFicnic_category_sub2() or !empty fdto.getFicnic_category_sub3()}">
                        <div class="w-100"></div>

                        <div class="form-group join-form">
                            <label>다중 카테고리</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2">
                                        <ul class="list-view">
                                            <c:if test="${!empty fdto.getFicnic_category_sub1()}"><li>${fdto.getFicnic_category_sub1_name()}</li></c:if>
                                            <c:if test="${!empty fdto.getFicnic_category_sub2()}"><li>${fdto.getFicnic_category_sub2_name()}</li></c:if>
                                            <c:if test="${!empty fdto.getFicnic_category_sub3()}"><li>${fdto.getFicnic_category_sub3_name()}</li></c:if>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </c:if>

                        <div class="w-100 border-bottom mt-2"></div>

                        <div class="form-group col d-flex align-items-center">
                            <label>조회수</label>
                            <div class="px-3 engnum"><fmt:formatNumber value="${fdto.getFicnic_hit()}" /></div>
                        </div>
                        <div class="form-group col d-flex align-items-center">
                            <label>판매 갯수</label>
                            <div class="px-3 engnum"><fmt:formatNumber value="${fdto.getFicnic_sale()}" /></div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group col d-flex align-items-center">
                            <label>리뷰 총점</label>
                            <div class="px-3 engnum"><fmt:formatNumber value="${fdto.getFicnic_review_point()}" pattern="0.0" />점</div>
                        </div>
                        <div class="form-group col d-flex align-items-center">
                            <label>리뷰 갯수</label>
                            <div class="px-3 engnum"><fmt:formatNumber value="${fdto.getFicnic_review_count()}" />개</div>
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
                    <h4>옵션 정보</h4>
                    <div class="row form">
                        <c:if test="${!empty optionList}">
                        <div class="form-group join-form">
                            <label>선택 옵션</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2">
                                        <ul class="list-view">
                                            <c:forEach var="optlist" items="${optionList}">
                                            <li>${optlist.title} (<fmt:formatNumber value="${optlist.price}" />원)</li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>
                        </c:if>

                        <c:if test="${!empty selectList}">
                        <div class="form-group join-form">
                            <label>추가 선택</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2">
                                        <ul class="list-view">
                                            <c:forEach var="sellist" items="${selectList}">
                                            <li>${sellist.title} (<fmt:formatNumber value="${sellist.price}" />원)</li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>
                        </c:if>

                        <div class="form-group col d-flex align-items-center">
                            <label>날짜 선택</label>
                            <div class="px-3">
                                <c:choose>
                                    <c:when test="${fdto.getFicnic_date_use() eq 'Y'}">사용</c:when>
                                    <c:otherwise>사용안함</c:otherwise>
                                </c:choose>
                            </div>
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
                    <h4>피크닉 상세정보</h4>
                    <div class="row form">
                        <c:if test="${!empty infoList}">
                        <div class="form-group join-form">
                            <label>피크닉 정보</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2">
                                        <ul class="list-view">
                                            <c:forEach var="iflist" items="${infoList}">
                                            <li><b>${iflist.title} : </b>${iflist.cont}</li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100 border-bottom mt-2"></div>
                        </c:if>

                        <c:if test="${!empty currList}">
                        <div class="form-group join-form">
                            <label>커리큘럼</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2">
                                        <ul class="list-view">
                                            <c:forEach var="culist" items="${currList}">
                                            <li><span class="text-secondary">${culist.time}</span><br /><span class="ml-3">&nbsp;${culist.cont}</span></li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>
                        </c:if>

                        <c:if test="${!empty fdto.getFicnic_etc()}">
                        <div class="form-group join-form">
                            <label>기타사항</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2 pl-3">${fdto.getFicnic_etc().replace(newLine, "<br />")}</div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100 border-bottom mt-2"></div>
                        </c:if>

                        <div class="form-group col d-flex align-items-center">
                            <label>진행 지역</label>
                            <div class="px-3">${fdto.getFicnic_location()}</div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group join-form">
                            <label>진행 주소</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2 pl-3">${fdto.getFicnic_address()}</div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100 border-bottom mt-2"></div>

                        <c:if test="${!empty fdto.getFicnic_include()}">
                        <div class="form-group join-form">
                            <label style="padding: 20px 0 0px 0;">포함 사항</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-1 pl-3 tag">
                                        <c:forTokens items="${fdto.getFicnic_include()}" delims="," var="include"><span>${include}</span></c:forTokens>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>
                        </c:if>

                        <c:if test="${!empty fdto.getFicnic_notinclude()}">
                        <div class="form-group join-form">
                            <label style="padding: 20px 0 0px 0;">불포함 사항</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-1 pl-3 tag">
                                        <c:forTokens items="${fdto.getFicnic_notinclude()}" delims="," var="notinclude"><span>${notinclude}</span></c:forTokens>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>
                        </c:if>

                        <c:if test="${!empty fdto.getFicnic_prepare()}">
                        <div class="form-group join-form">
                            <label style="padding: 20px 0 0px 0;">준비물</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-1 pl-3 tag">
                                        <c:forTokens items="${fdto.getFicnic_prepare()}" delims="," var="prepare"><span>${prepare}</span></c:forTokens>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>
                        </c:if>

                        <div class="w-100 border-bottom mt-2"></div>

                        <c:if test="${!empty fdto.getFicnic_caution()}">
                        <div class="form-group join-form">
                            <label>유의사항</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2 pl-3">${fdto.getFicnic_caution().replace(newLine, "<br />")}</div>
                                </div>
                            </div>
                        </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <c:if test="${!empty fdto.getFicnic_photo1() or !empty fdto.getFicnic_photo2() or !empty fdto.getFicnic_photo3() or !empty fdto.getFicnic_photo4() or !empty fdto.getFicnic_photo5()}">
    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4>피크닉 사진</h4>
                    <div class="row form">
                        <c:if test="${!empty fdto.getFicnic_photo1()}">
                        <div class="form-group join-form">
                            <label>사진 1</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2 pl-3"><img src="${path}${fdto.getFicnic_photo1()}" style="max-width: 100%;" alt="" /></div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>
                        </c:if>

                        <c:if test="${!empty fdto.getFicnic_photo2()}">
                        <div class="form-group join-form">
                            <label>사진 2</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2 pl-3"><img src="${path}${fdto.getFicnic_photo2()}" style="max-width: 100%;" alt="" /></div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>
                        </c:if>

                        <c:if test="${!empty fdto.getFicnic_photo3()}">
                        <div class="form-group join-form">
                            <label>사진 3</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2 pl-3"><img src="${path}${fdto.getFicnic_photo3()}" style="max-width: 100%;" alt="" /></div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>
                        </c:if>

                        <c:if test="${!empty fdto.getFicnic_photo4()}">
                        <div class="form-group join-form">
                            <label>사진 4</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2 pl-3"><img src="${path}${fdto.getFicnic_photo4()}" style="max-width: 100%;" alt="" /></div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>
                        </c:if>

                        <c:if test="${!empty fdto.getFicnic_photo5()}">
                        <div class="form-group join-form">
                            <label>사진 5</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2 pl-3"><img src="${path}${fdto.getFicnic_photo5()}" style="max-width: 100%;" alt="" /></div>
                                </div>
                            </div>
                        </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </c:if>



    <c:if test="${!empty fdto.getFicnic_detail()}">
    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4>피크닉 소개</h4>
                    <div class="row form pt-3">
                        <div class="ficnic-detail-view">
                            ${fdto.getFicnic_detail()}
                        </div>
                    </div>
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