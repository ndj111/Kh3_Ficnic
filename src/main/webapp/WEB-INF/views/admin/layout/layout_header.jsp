<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="time" value="<%=System.currentTimeMillis()%>" />
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 모드 :: Ficnic (Friend & Picnic)</title>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1.0, maximum-scale=1.0, shrink-to-fit=no, user-scalable=no">

    <meta name="robots" content="noindex">

    <link rel="shortcut icon" href="${path}/resources/admin/images/favicon.ico" type="image/x-icon" />
    <link rel="icon" href="${path}/resources/admin/images/favicon.ico" type="image/x-icon" />
 
    <link rel="shortcut icon" type="image/x-icon" href="${path}/resources/admin/images/favicon_72x72.png" />
    <link rel="apple-touch-icon-precomposed" sizes="57x57" href="${path}/resources/admin/images/favicon_57x57.png" />
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="${path}/resources/admin/images/favicon_72x72.png" />
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="${path}/resources/admin/images/favicon_114x114.png" />
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="${path}/resources/admin/images/favicon_144x144.png" />

    <c:if test="${sess_type ne 'admin'}"><script>alert('관리자만 접근 할 수 있습니다.'); history.back();</script></c:if>

    <link type="text/css" rel="stylesheet" href="${path}/resources/admin/css/jquery-ui.min.css" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/admin/css/bootstrap-reboot.min.css" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/admin/css/bootstrap.min.css" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/admin/css/bootstrap-utilities.min.css" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/admin/css/bootstrap-grid.min.css" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/admin/css/font_awesome.css" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/admin/css/simple-line-icons.css" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/admin/css/bootstrap-tagsinput.css" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/admin/css/css_common.css?${time}" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/admin/css/css_layout.css?${time}" />


    <script language="javascript" src="${path}/resources/admin/js/jquery-3.5.1.min.js"></script>
    <script language="javascript" src="${path}/resources/admin/js/jquery-ui.min.js"></script>
    <script language="javascript" src="${path}/resources/admin/js/bootstrap.min.js"></script>
    <script language="javascript" src="${path}/resources/admin/js/bootstrap.bundle.min.js"></script>
    <script language="javascript" src="${path}/resources/admin/js/bootstrap-tagsinput.min.js"></script>
    <script language="javascript" src="${path}/resources/admin/js/Sortable.min.js"></script>
    <script src="https://cdn.ckeditor.com/4.16.0/standard-all/ckeditor.js"></script>
    <script language="javascript" src="${path}/resources/admin/js/js_common.js?${time}"></script>
</head>
<body>
    <!-- #preloader //START -->
    <div id="preloader">
        <div class="loader"></div>
    </div>
    <!-- #preloader //END -->


    <c:if test="${layout_none != 'Y'}">
    <!-- 로그아웃 Modal // START -->
    <div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body text-center py-5">
                    <p>로그아웃 하시겠습니까?</p>
                    <p>&nbsp;</p>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">창닫기</button>
                    <a href="${path}/member/member_logout.do" class="btn btn-primary ml-2">로그아웃</a>
                </div>
            </div>
        </div>
    </div>
    <!-- 로그아웃 Modal // END -->



    <!-- #header // START -->
    <header id="header">
        <div class="navbar-header w1150">
            <div class="d-flex">
                <h1 class="h-logo"><a href="${path}/admin/main.do"><img src="${path}/resources/admin/images/admin_logo.png" alt="Ficnic" /> <span>Ficnic</span></a></h1>
                <button type="button" class="btn btn-lg px-3 font-size-16 d-lg-none header-item waves-effect waves-light" data-toggle="collapse" data-target="#topnav-menu-content"><i class="fa fa-fw fa-bars"></i></button>
            </div>

            <div class="d-name text-center"><c:if test="${!empty sess_name}"><b>${sess_name}</b>님 안녕하세요 😊</c:if></div>

            <ul class="d-flex">
                <!-- 예약 알림창//START -->
                <li>
                    <button type="button" id="alarm-btn-reserv" class="h-ico" title="예약 알림창"><span class="badge bg-primary">0</span><i class="fa fa-clipboard"></i></button>
                    <div class="new-pop reserv">
                        <div class="np-title">신규 예약 <button type="button"><i class="fa fa-times"></i></button></div>
                        <ul class="np-list">
                        </ul>
                    </div>
                </li>
                <!-- 예약 알림창//END -->


                <!-- 문의 알림창//START -->
                <li>
                    <button type="button" id="alarm-btn-qna" class="h-ico" title="문의 알림창"><span class="badge bg-danger">0</span><i class="fa fa-comments-o"></i></button>
                    <div class="new-pop qna">
                        <div class="np-title">신규 1:1 문의 <button type="button"><i class="fa fa-times"></i></button></div>
                        <ul class="np-list">
                        </ul>
                    </div>
                </li>
                <!-- 문의 알림창//END -->


                <!-- 신규 회원가입 알림창//START -->
                <li>
                    <button type="button" id="alarm-btn-member" class="h-ico" title="신규 회원가입 알림창"><span class="badge bg-success">0</span><i class="fa fa-user"></i></button>
                    <div class="new-pop member">
                        <div class="np-title">회원 알림 <button type="button"><i class="fa fa-times"></i></button></div>
                        <ul class="np-list">
                        </ul>
                    </div>
                </li>
                <!-- 신규 회원가입 알림창//END -->

                <li><a href="${path}/" class="h-ico" target="_blank"><i class="fa fa-desktop"></i></a></li>

                <li><button type="button" class="h-ico" title="로그아웃" data-toggle="modal" data-target="#logoutModal"><i class="fa fa-power-off"></i></button></li>
            </ul>
        </div>



        <nav class="navbar navbar-expand-lg w1150">
            <div id="topnav-menu-content" class="navbar-collapse collapse">
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a href="${path}/admin/ficnic/ficnic_list.do" class="nav-link" id="ficnic_menu" data-toggle="dropdown"><i class="fa fa-gift"></i> 피크닉 관리<span class="line-now"></span></a>
                        <div class="dropdown-menu" aria-labelledby="ficnic_menu">
                            <a href="${path}/admin/ficnic/ficnic_list.do" class="dropdown-item"><div class="arrow-right"></div> 피크닉 목록</a>
                            <a href="${path}/admin/ficnic/ficnic_write.do" class="dropdown-item"><div class="arrow-right"></div> 피크닉 등록</a>
                            <a href="${path}/admin/ficnic/category_list.do" class="dropdown-item"><div class="arrow-right"></div> 카테고리 관리</a>
                        </div>
                    </li>

                    <li class="nav-item dropdown">
                        <a href="${path}/admin/reserv/reserv_list.do" class="nav-link" aria-haspopup="true" aria-expanded="false"><i class="fa fa-laptop"></i> 예약 관리<span class="line-now"></span></a>
                    </li>

                    <li class="nav-item dropdown">
                        <a href="${path}/admin/member/member_list.do" class="nav-link" id="member_menu" data-toggle="dropdown"><i class="fa fa-user"></i> 회원 관리<span class="line-now"></span></a>
                        <div class="dropdown-menu" aria-labelledby="member_menu">
                            <a href="${path}/admin/member/member_list.do" class="dropdown-item"><div class="arrow-right"></div> 회원 목록</a>
                            <a href="${path}/admin/member/member_write.do" class="dropdown-item"><div class="arrow-right"></div> 회원 등록</a>
                        </div>
                    </li>

                    <li class="nav-item dropdown">
                        <a href="${path}/admin/coupon/coupon_list.do" class="nav-link" id="coupon_menu" data-toggle="dropdown"><i class="fa fa-ticket"></i> 쿠폰 관리<span class="line-now"></span></a>
                        <div class="dropdown-menu" aria-labelledby="coupon_menu">
                            <a href="${path}/admin/coupon/coupon_list.do" class="dropdown-item"><div class="arrow-right"></div> 쿠폰 목록</a>
                            <a href="${path}/admin/coupon/coupon_write.do" class="dropdown-item"><div class="arrow-right"></div> 쿠폰 등록</a>
                        </div>
                    </li>

                    <li class="nav-item dropdown">
                        <a href="${path}/admin/qna/qna_list.do" class="nav-link" aria-haspopup="true" aria-expanded="false"><i class="fa fa-comment-o"></i> 문의 관리<span class="line-now"></span></a>
                    </li>

                    <li class="nav-item dropdown">
                        <a href="${path}/admin/review/review_list.do" class="nav-link" aria-haspopup="true" aria-expanded="false"><i class="fa fa-star-o"></i> 리뷰 관리<span class="line-now"></span></a>
                    </li>

                    <li class="nav-item dropdown">
                        <a href="${path}/admin/board/board_list.do" class="nav-link" id="board_menu" data-toggle="dropdown"><i class="fa fa-pencil-square-o"></i> 게시판 관리<span class="line-now"></span></a>
                        <div class="dropdown-menu" aria-labelledby="board_menu">
                            <a href="${path}/admin/board/board_list.do" class="dropdown-item"><div class="arrow-right"></div> 게시판 목록</a>
                            <a href="${path}/admin/board/board_write.do" class="dropdown-item"><div class="arrow-right"></div> 게시판 등록</a>
                        </div>
                    </li>
                </ul>
            </div>
        </nav>
    </header>
    <!-- #header // END -->
    </c:if>



    <!-- #container // START -->
    <main id="container"<c:if test="${layout_none eq 'Y'}"> class="view-popup"</c:if>>
        <div class="w1150">
