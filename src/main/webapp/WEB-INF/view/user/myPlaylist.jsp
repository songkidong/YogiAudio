<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플레이리스트</title>
<!-- CSS -->
<!--     <link href="/css/user/mypage.css" rel="stylesheet"> ->   

    <!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
	rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">

<link rel="stylesheet" href="/assets/vendor/fonts/boxicons.css" />

<!-- Core CSS -->
<link rel="stylesheet" href="/assets/vendor/css/core.css"
	class="template-customizer-core-css" />
<link rel="stylesheet" href="/assets/vendor/css/theme-default.css"
	class="template-customizer-theme-css" />
<link rel="stylesheet" href="/assets/css/demo.css" />

<!-- Vendors CSS -->
<link rel="stylesheet"
	href="/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

<!-- Page CSS -->

<!-- Helpers -->
<script src="/assets/vendor/js/helpers.js"></script>
<script src="/assets/js/config.js"></script>
</head>
<body>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">

			<!-- Layout container -->
			<div class="layout-page">

				<!-- Content wrapper -->
				<div class="content-wrapper">
					<!-- Content -->

					<div class="container-xxl flex-grow-1 container-p-y">
						<h4 class="py-3 mb-4">
							<span class="text-muted fw-light">마이페이지 /</span> 플리
						</h4>

						<div class="row">
							<div class="col-md-12">
								<ul class="nav nav-pills flex-column flex-md-row mb-3">
									<li class="nav-item"><a class="nav-link"
										href="/account/${principal.id}"><i class="bx bx-user me-1"></i>
											계정</a></li>
									<li class="nav-item"><a class="nav-link"
										href="/payment/${principal.id}"><i
											class="bx bx-table me-1"></i> 결제 내역</a></li>
									<li class="nav-item"><a class="nav-link active"
										href="/myPlaylist"><i class="bx bx-music me-1"></i> 플리</a></li>
								</ul>

								<div class="table-responsive text-nowrap">
									<table class="table card-table">
										<thead>
											<tr>
												<th>번호</th>
												<th>앨범</th>
												<th>제목</th>
												<th>가수</th>
												<th>뮤비</th>
											</tr>
										</thead>
										<tbody class="table-border-bottom-0">
											<c:forEach items="${playlist}" var="play" varStatus="loop">
												<tr>
													<td>${loop.index + 1}</td>
													<td><img src="${play.filePath}" width="75" height="75">
													<td>${play.musicTitle}</td>
													<td>${play.musicSinger}</td>
													<td><a href="${play.mvFile}"> <span
															class="bi bi-youtube "></span>
													</a></td>
												</tr>
											</c:forEach>


										</tbody>
									</table>
								</div>
								<button id="addBtn" type="button"><i class="bi bi-plus-circle"></i></button>
								<button id="playBtn" type="button"><i class="bi bi-play"></i></button>
								<button id="musicBtn" type="button">Music Player</button>
							</div>
						</div>
					</div>
				</div>
				<!-- / Content -->

				<div class="content-backdrop fade"></div>
			</div>
			<!-- Content wrapper -->
		</div>
		<!-- / Layout page -->
	</div>

	<!-- Overlay -->
	<div class="layout-overlay layout-menu-toggle"></div>
	</div>
	<!-- / Layout wrapper -->

	<!-- Core JS -->
	<!-- build:js assets/vendor/js/core.js -->
	<!--  playlist 스크립트 시작 -->
	<script>
		var userId = '${principal.id}';
	</script>
	<!-- 	<script src="/js/playlist/playlist.js"></script> -->
	<!--  playlist 스크립트 종료 -->

	<script src="/assets/vendor/libs/jquery/jquery.js"></script>
	<script src="/assets/vendor/libs/popper/popper.js"></script>
	<script src="/assets/vendor/js/bootstrap.js"></script>
	<script
		src="/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
	<script src="/assets/vendor/js/menu.js"></script>

	<!-- endbuild -->

	<!-- Vendors JS -->

	<!-- Main JS -->
	<script src="/assets/js/main.js"></script>

	<!-- Page JS -->
	<script src="/assets/js/pages-account-settings-account.js"></script>

	<!-- Place this tag in your head or just before your close body tag. -->
	<script async defer src="https://buttons.github.io/buttons.js"></script>
</body>
</html>
