<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<!DOCTYPE html>
<!-- beautify ignore:start -->
<html
  lang="en"
  class="light-style layout-menu-fixed"
  dir="ltr"
  data-theme="theme-default"
  data-assets-path="/assets/"
  data-template="vertical-menu-template-free"
>
  <head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
    />

    <title>YogiAudio</title> <!-- 홈페이지 탭 이름 설정 -->

    <meta name="description" content="" />

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="/assets/img/favicon/favicon.ico" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
      rel="stylesheet"
    />

    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="/assets/vendor/fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="/assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="/assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="/assets/css/demo.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <link rel="stylesheet" href="/assets/vendor/libs/apex-charts/apex-charts.css" />

    <!-- Page CSS -->

    <!-- Helpers -->
    <script src="/assets/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="/assets/js/config.js"></script>
    
    <!-- 추가 -->
    <!-- Font Awesome 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- SweetAlert 라이브러리 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	<!-- JSTL 라이브러리 -->
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	
  </head>

  <body>
    <!-- Layout wrapper -->
    <div class="layout-wrapper layout-content-navbar">
      <div class="layout-container">
        <!-- Menu -->

        <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
          <div class="app-brand demo">
            <a href="/product/main" class="app-brand-link">
              <span class="app-brand-text demo menu-text fw-bolder ms-2">YogiAudio</span>
            </a>

            <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
              <i class="bx bx-chevron-left bx-sm align-middle"></i>
            </a>
          </div>

          <div class="menu-inner-shadow"></div>

          <ul class="menu-inner py-1">
            <!-- Dashboard -->
            <li class="menu-item">
              <a href="/admin/index" class="menu-link">
                <i class="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Analytics">관리자 메인</div>
              </a>
            </li>
            <li class="menu-item">
              <a href="/admin/userList" class="menu-link">
                <i class="menu-icon tf-icons bx bx-user-circle"></i>
                <div data-i18n="Analytics">유저 관리</div>
              </a>
            </li>
            
            <li class="menu-item" class="menu-link menu-toggle">
              <a href="#" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-music"></i>
                <div data-i18n="Analytics">음원 관리</div>
              </a>
              
              
              <ul class="menu-sub">
                <li class="menu-item">
                  <a href="/admin/musicList" class="menu-link">
                    <div data-i18n="Without menu">음원리스트</div>
                  </a>
                </li>
                <li class="menu-item">
                  <a href="/admin/musicvideoList" class="menu-link">
                    <div data-i18n="Without menu">뮤비리스트</div>
                  </a>
                </li>
                <li class="menu-item">
                  <a href="/admin/music-insert" class="menu-link">
                    <div data-i18n="Without menu">음원등록</div>
                  </a>
                </li>
                <li class="menu-item">
                  <a href="/admin/mv-insert" class="menu-link">
                    <div data-i18n="Without menu">뮤비등록</div>
                  </a>
                </li>
              </ul>
              
              
              
            </li>

            <!-- Layouts -->
            <li class="menu-item">
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-message-square-detail"></i>
                <div data-i18n="Layouts">게시판 관리</div>
              </a>

              <ul class="menu-sub">
                <li class="menu-item">
                  <a href="/admin/saveNotice" class="menu-link">
                    <div data-i18n="Without menu">공지사항 등록</div>
                  </a>
                </li>
                <li class="menu-item">
                  <a href="/admin/noticeList" class="menu-link">
                    <div data-i18n="Without menu">공지사항</div>
                  </a>
                </li>
                <li class="menu-item">
                  <a href="/admin/qnaList" class="menu-link">
                    <div data-i18n="Without navbar">QnA</div>
                  </a>
                </li>
                <li class="menu-item">
                  <a href="/admin/freeList" class="menu-link">
                    <div data-i18n="Container">자유게시판</div>
                  </a>
                </li>
                
              </ul>
              
            </li>
            <li class="menu-item">
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-credit-card"></i>
                <div data-i18n="Layouts">결제 관리</div>
              </a>

              <ul class="menu-sub">
                <li class="menu-item">
                  <a href="/admin/historyList" class="menu-link">
                    <div data-i18n="Without menu">결제 내역</div>
                  </a>
                </li>
                <li class="menu-item">
                  <a href="/admin/refundList" class="menu-link">
                    <div data-i18n="Without menu">환불 내역</div>
                  </a>
                </li>
                
                
              </ul>
            </li>
            

            
          </ul>
        </aside>
        <!-- / Menu -->

        <!-- Layout container -->
        <div class="layout-page">
          

          <!-- Content wrapper -->
          <div class="content-wrapper">
            
		
		
		