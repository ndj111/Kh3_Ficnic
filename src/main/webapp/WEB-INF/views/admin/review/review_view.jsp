<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="layout_none" value="Y" />
<%@ include file="../layout/layout_header.jsp" %>

<c:set var="dto" value="${dto}" />
<c:if test="${empty dto}"><script type="text/javascript">alert('존재하지 않는 데이터입니다.'); window.close();</script></c:if>
<% pageContext.setAttribute("newLine", "\n"); %>


<h2>리뷰 내용 보기</h2>


<div class="page-cont">

    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <div class="row form">
                        <div class="form-group join-form">
                            <label>작성자</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2"><b>${dto.review_name}</b> <span class="engnum">(${dto.member_id})</span></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group join-form mb-2">
                            <label>작성일</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2">${dto.review_date}</div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100 border-bottom"></div>

                        <div class="form-group join-form">
                            <label>피크닉</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2">${dto.getFicnic_name()}</div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col d-flex align-items-center">
                            <label>리뷰 평점</label>
                            <div class="px-3">${dto.review_point}점</div>
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group join-form mb-2">
                            <label>리뷰 내용</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2">${dto.review_cont.replace(newLine, "<br />")}</div>
                                </div>
                            </div>
                        </div>

                        <c:if test="${!empty dto.review_photo1 or !empty dto.review_photo2}"><div class="w-100 border-bottom"></div></c:if>
                        <c:if test="${!empty dto.review_photo1}">
                        <div class="form-group join-form">
                            <label>리뷰 사진 1</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2"><img src="${path}${dto.review_photo1}" style="max-width: 100%;" alt="" /></div>
                                </div>
                            </div>
                        </div>
                        </c:if>

                        <c:if test="${!empty dto.review_photo2}">
                        <div class="form-group join-form">
                            <label>리뷰 사진 2</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2"><img src="${path}${dto.review_photo2}" style="max-width: 100%;" alt="" /></div>
                                </div>
                            </div>
                        </div>
                        </c:if>
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