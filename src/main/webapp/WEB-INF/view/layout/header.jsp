<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>YogiAudio</title>

<!-- Google font -->
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700"
	rel="stylesheet">

<!-- Bootstrap -->
<link type="text/css" rel="stylesheet"
	href="/main/css/bootstrap.min.css" />
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
	integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
	integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<!-- Slick -->
<link type="text/css" rel="stylesheet" href="/main/css/slick.css" />
<link type="text/css" rel="stylesheet" href="/main/css/slick-theme.css" />

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




<!-- j쿼리 -->
<script src="https://code.jquery.com/jquery-latest.min.js"></script>

</head>
<body>
	<!-- HEADER -->
	<header>
		<!-- TOP HEADER -->
		<div id="top-header">
			<div class="container">
				<ul class="header-links pull-left">
					<li><a href="#"><i class="fa fa-phone"></i> +021-95-51-84</a></li>
					<li><a href="#"><i class="fa fa-envelope-o"></i>
							email@email.com</a></li>
					<li><a href="#"><i class="fa fa-map-marker"></i> 1734
							Stonecoal Road</a></li>
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
									<input class="input" placeholder="여기에 검색" name="searchKeyword">
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
										<a href="/consent">
											<p style="margin-left: 10px;">회원가입</p>
										</a>
									</c:when>
									<c:otherwise>
										<a href="/logout">
											<p>로그아웃</p>
										</a>

										<a href="/account/${principal.id}">

											<p style="margin-left: 10px;">마이페이지</p>
										</a>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${principal.role == 'ADMIN'}">
										<a href="/admin/index">

											<p style="margin-left: 10px;">관리자</p>
										</a>
									</c:when>
								</c:choose>
								<div class="dropdown" style="margin-left: 90px;">
									<button class="btn btn-warning btn-sm dropdown-toggle"
										type="button" data-bs-toggle="dropdown" aria-expanded="false">
										게시판</button>
									<ul class="dropdown-menu">
										<li><a class="dropdown-item"
											href="/board/notice/noticeList">공지사항</a></li>
										<li><a class="dropdown-item" href="/board/qna/qnaList">나의
												문의하기</a></li>
										<li><a class="dropdown-item" href="/board/free/freeList">자유게시판</a></li>
									</ul>
								</div>
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
</body>
</html>