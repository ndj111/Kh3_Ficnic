<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="time" value="<%=System.currentTimeMillis()%>" />
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ficnic (Friend & Picnic)</title>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1.0, maximum-scale=1.0, shrink-to-fit=no, user-scalable=no">

    <meta name="robots" content="noindex">

    <link rel="shortcut icon" href="${path}/resources/site/images/favicon.ico" type="image/x-icon" />
    <link rel="icon" href="${path}/resources/site/images/favicon.ico" type="image/x-icon" />
 
    <link rel="shortcut icon" type="image/x-icon" href="${path}/resources/site/images/favicon_72x72.png" />
    <link rel="apple-touch-icon-precomposed" sizes="57x57" href="${path}/resources/site/images/favicon_57x57.png" />
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="${path}/resources/site/images/favicon_72x72.png" />
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="${path}/resources/site/images/favicon_114x114.png" />
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="${path}/resources/site/images/favicon_144x144.png" />

    <link type="text/css" rel="stylesheet" href="${path}/resources/site/css/jquery-ui.min.css" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/site/css/bootstrap-reboot.min.css" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/site/css/bootstrap.min.css" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/site/css/bootstrap-utilities.min.css" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/site/css/bootstrap-grid.min.css" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/site/css/font_awesome.css" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/site/css/simple-line-icons.css" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_common.css?${time}" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_layout.css?${time}" />

    <script language="javascript" src="${path}/resources/site/js/jquery-3.5.1.min.js"></script>
    <script language="javascript" src="${path}/resources/site/js/jquery-ui.min.js"></script>
    <script language="javascript" src="${path}/resources/site/js/bootstrap.min.js"></script>
    <script language="javascript" src="${path}/resources/site/js/bootstrap.bundle.min.js"></script>
    <script language="javascript" src="${path}/resources/site/js/js_common.js?${time}"></script>
</head>
<body>
    <!-- #preloader //START -->
    <div id="preloader">
        <div class="loader"></div>
    </div>
    <!-- #preloader //END -->



    <c:if test="${!empty sess_id}">
    <!-- 로그아웃 Modal // START -->
    <div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body text-center py-5">
                    <p>로그아웃 하시겠습니까?</p>
                    <p>&nbsp;</p>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal"><i class="icon-close mr-1"></i>창닫기</button>
                    <a href="${path}/member/member_logout.do" class="btn btn-primary ml-2"><i class="icon-logout mr-1"></i>로그아웃</a>
                </div>
            </div>
        </div>
    </div>
    <!-- 로그아웃 Modal // END -->
    </c:if>



    <!-- #header // START -->
    <header id="header" class="fixed-top">
        <nav class="navbar navbar-expand-lg w1100">
            <h1 class="navbar-brand"><a href="${path}/main.do"><img src="${path}/resources/site/images/site_logo.png" alt="Ficnic" /> <span>Ficnic</span></a></h1>

            <div class="navbar-collapse">
                <form name="search" class="navbar-search mr-auto" action="${path}/ficnic/ficnic_list.do">
                <fieldset>
                    <legend class="displaynone">통합검색</legend>
                    <input type="text" name="search" value="" autocomplete="off" placeholder="배우고 싶은 재능을 찾아보세요." />
                    <button type="submit"><span class="displaynone">검색</span></button>
                </fieldset>
                </form>

                <ul class="navmenu">
                    <li><a href="${path}/ficnic/ficnic_category.do"><i class="icon-list"></i><p>카테고리</p></a></li>
                    <c:choose>
                        <c:when test="${!empty sess_id}">
                            <li><a href="${path}/mypage/mypage_wish_list.do"><i class="icon-heart"></i><p>위시리스트</p></a></li>
                            <li><a href="${path}/mypage/mypage_reserv_list.do"><i class="icon-user"></i><p>마이페이지</p></a></li>
                            <li><button type="button" data-toggle="modal" data-target="#logoutModal"><i class="icon-logout"></i><p>로그아웃</p></button></li>
                            <c:if test="${sess_type eq 'admin'}"><li class="ml-5"><a href="${path}/admin/main.do" target="_blank"><i class="icon-rocket"></i><p>관리자</p></a></li></c:if>
                        </c:when>

                        <c:otherwise>
                            <li><a href="${path}/member/member_login.do"><i class="icon-login"></i><p>로그인</p></a></li>
                            <li><a href="${path}/member/member_join.do"><i class="icon-emotsmile"></i><p>회원가입</p></a></li>
                            <li><a href="${path}/mypage/mypage_reserv_list.do"><i class="icon-user"></i><p>마이페이지</p></a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </nav>
    </header>
    <!-- #header // END -->




    <!-- #container // START -->
    <main id="container">