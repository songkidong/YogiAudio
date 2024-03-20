<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<title>YogiAudio</title>

<!-- Google font -->
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700"
	rel="stylesheet">

		<!-- Bootstrap -->
		<link type="text/css" rel="stylesheet" href="/main/css/bootstrap.min.css"/>
		
		
		
		<link type="text/css" rel="stylesheet" href="/main/css/slick.css"/>
		<link type="text/css" rel="stylesheet" href="/main/css/slick-theme.css"/>

				

<!-- nouislider -->
<link type="text/css" rel="stylesheet"
	href="/main/css/nouislider.min.css" />

<!-- Font Awesome Icon -->
<link rel="stylesheet" href="/main/css/font-awesome.min.css">

<!-- Custom stlylesheet -->
<link type="text/css" rel="stylesheet" href="/main/css/style.css" />

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
<link rel="icon" type="image/png" sizes="72x72" href="/favicon/android-icon-72x72.png">


</head>
<body>
	<!-- HEADER -->
	<header>
		<!-- TOP HEADER -->
		<div id="top-header">
			<div class="container">
				<ul class="header-links pull-left">
					<li>
						<a href="/purchase/main">
						  <i class="fa fa-envelope-o"></i>
						  이용권구매
						</a>
				   </li>
					
				</ul>
				<ul class="header-links pull-right">
					<li><a href="#"><i class="fa fa-dollar"></i> USD</a></li>
					<li><a href="#"><i class="fa fa-user-o"></i> My Account</a></li>
				</ul>
			</div>
		</div>
		<!-- /TOP HEADER -->

		<!-- MAIN HEADER -->
		<div id="header" style="background-color: white;">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">
					<!-- LOGO -->
					<div class="col-md-3">
						<div class="header-logo">
							<a href="/product/main" class="logo"> <img
								src="/logo/logo.png"
								style="width: 236px; height: auto; margin-top: 10px;">
							</a>
						</div>
					</div>
					<!-- /LOGO -->

					<div class="row" style="display: flex; align-items: center;">
						<!-- 검색 바 -->
						<div class="col-md-12">
							<div class="header-search">
								<form action="/product/main-search" method="get">
									<select class="input-select" id="searchOption" name="searchOption" >
										<option value="국내">국내</option>
										<option value="국외">국외</option>
									</select> 
									<input class="input" placeholder="여기에 검색">
									<button class="search-btn">검색</button>
								</form>
							</div>
						</div>
						<!-- 로그인 -->
						<div class="col-md-6">
							<div class="login-container"
								style="display: flex; align-items: center; margin-top: 10px;">
								<c:choose>
									<c:when test="${empty principal}">
										<a href="/signIn">
											<p>로그인</p>
										</a>
										<a href="/signUp">
											<p style="margin-left: 10px;">회원가입</p>
										</a>
									</c:when>
									<c:otherwise>
										<a href="/logout">
											<p>로그아웃</p>
										</a>
										<a href="#">
											<p style="margin-left: 10px;">마이페이지</p>
										</a>
									</c:otherwise>
								</c:choose>
							</div>
						</div>

					</div>





				</div>
			</div>
			<!-- /ACCOUNT -->
		</div>
		<!-- row -->
		</div>
		<!-- container -->
		</div>
		<!-- /MAIN HEADER -->
	</header>
	<!-- /HEADER -->