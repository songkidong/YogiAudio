<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<!-- CSS -->
<!--     <link href="/css/user/mypage.css" rel="stylesheet"> ->   

    <!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
	rel="stylesheet" />

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
							<span class="text-muted fw-light">마이페이지 /</span> 계정
						</h4>

						<div class="row">
							<div class="col-md-12">
								<ul class="nav nav-pills flex-column flex-md-row mb-3">
									<li class="nav-item"><a class="nav-link active"
										href="/account/${principal.id}"><i class="bx bx-user me-1"></i>
											계정</a></li>
									<li class="nav-item"><a class="nav-link"
										href="/payment"><i
											class="bx bx-table me-1"></i> 결제 내역</a></li>
									<li class="nav-item"><a class="nav-link"
										href="/myPlaylist"><i class="bx bx-music me-1"></i> 플리</a></li>
								</ul>
								<div class="card mb-4">
									<h5 class="card-header">나의 정보</h5>
									<!-- Account -->
									<form action="/updateUser/${principal.id}" method="POST"
										onsubmit="return validateForm()" enctype="multipart/form-data">
										<div class="card-body">
											<div
												class="d-flex align-items-start align-items-sm-center gap-4">
												<img src="${principal.filePath}" alt="이미지가 없습니다."
													class="d-block rounded" height="130" width="130"
													id="uploadedAvatar" />
												<div class="button-wrapper">
													<label for="upload" class="btn btn-primary me-2 mb-4"
														tabindex="0"> <span class="d-none d-sm-block">Upload
															new photo</span> <i class="bx bx-upload d-block d-sm-none"></i>
														<input type="file" id="upload" class="account-file-input"
														name="profileFile" hidden accept="image/png, image/jpeg" />
													</label>


													<p class="text-muted mb-0">Allowed JPG, GIF or PNG. Max
														size of 800K</p>
												</div>
											</div>
										</div>
										<hr class="my-0" />
										<div class="card-body">
											<div class="row">
												<div class="mb-3 col-md-6">
													<label for="name" class="form-label">이름</label> <input
														class="form-control" type="text" id="name" name="name"
														value="${principal.name}" />
												</div>
												<div class="mb-3 col-md-6">
													<label for="nickname" class="form-label">닉네임</label> <input
														class="form-control" type="text" name="nickname"
														id="nickname" value="${principal.nickname}" />
												</div>
												<div class="mb-3 col-md-6">
													<label for="email" class="form-label">이메일</label> <input
														class="form-control" type="email" id="email" name="email"
														value="${principal.email}" readonly />
												</div>
												<div class="mb-3 col-md-6">
													<label for="status" class="form-label">구독</label> <input
														type="text" class="form-control" id="status" name="status"
														value="${principal.status == 'Y' ? '구독중' : '구독안함'}"
														readonly />
												</div>
												<div class="mb-3 col-md-6">
													<label for="password" class="form-label">비밀번호</label> <input
														type="password" class="form-control" id="password"
														name="password" value="${principal.password}" />
												</div>
												<div class="mb-3 col-md-6">
													<label for="checkpassword" class="form-label">비밀번호
														확인</label> <input type="password" class="form-control"
														id="checkpassword" name="checkpassword"
														value="${principal.password}" />
												</div>

											</div>
											<div class="mt-2">
												<button type="submit" class="btn btn-primary me-2"
													onclick="return confirmUpdate()">수정</button>
											</div>
									</form>
								</div>
								<!-- /Account -->
							</div>
							<div class="card">
								<h5 class="card-header">계정 삭제</h5>
								<div class="card-body">
									<div class="mb-3 col-12 mb-0">
										<div class="alert alert-warning">
											<h6 class="alert-heading mb-1">계정을 삭제 하시겠습니까?</h6>
											<p class="mb-0">계정을 한 번 삭제하면 되돌릴 수 없습니다.</p>
										</div>
									</div>
									<form action="/deleteUser/${principal.id}" method="POST"
										onsubmit="return confirmAccountDeletion()">
										<div class="form-check mb-3">
											<input class="form-check-input" type="checkbox"
												name="accountActivation" id="accountActivation" /> <label
												class="form-check-label" for="accountActivation">계정
												삭제를 확인합니다</label>
										</div>
										<button type="submit"
											class="btn btn-danger deactivate-account">계정 삭제</button>
									</form>
								</div>
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

	<script src="/js/user/account.js"></script>

	<!-- Core JS -->
	<!-- build:js assets/vendor/js/core.js -->

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
