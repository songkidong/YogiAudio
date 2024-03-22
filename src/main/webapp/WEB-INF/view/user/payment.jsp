<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 내역</title>
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
							<span class="text-muted fw-light">마이페이지 /</span> 결제 내역
						</h4>

						<div class="row">
							<div class="col-md-12">
								<ul class="nav nav-pills flex-column flex-md-row mb-3">
									<li class="nav-item"><a class="nav-link"
										href="/account/${principal.id}"><i class="bx bx-user me-1"></i>
											계정</a></li>
									<li class="nav-item"><a class="nav-link active"
										href="/payment/${principal.id}"><i
											class="bx bx-table me-1"></i> 결제 내역</a></li>
									<li class="nav-item"><a class="nav-link"
										href="/myPlaylist"><i class="bx bx-music me-1"></i> 플리</a></li>
								</ul>

							</div>
						</div>

						<!-- Basic Bootstrap Table -->
						<div class="card">
							<h5 class="card-header">결제 내역</h5>
							<div class="table-responsive text-nowrap">
								<table class="table">
									<thead>
										<tr>
											<th>Project</th>
											<th>Client</th>
											<th>Users</th>
											<th>Status</th>
											<th>Actions</th>
										</tr>
									</thead>
									<tbody class="table-border-bottom-0">
										<tr>
											<td><i class="bx bxl-angular bx-sm text-danger me-3"></i>
												<span class="fw-medium">Angular Project</span></td>
											<td>Albert Cook</td>
											<td>
												<ul
													class="list-unstyled users-list m-0 avatar-group d-flex align-items-center">
													<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
														data-bs-placement="top" class="avatar avatar-xs pull-up"
														title="Lilian Fuller"><img
														src="../assets/img/avatars/5.png" alt="Avatar"
														class="rounded-circle" /></li>
													<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
														data-bs-placement="top" class="avatar avatar-xs pull-up"
														title="Sophia Wilkerson"><img
														src="../assets/img/avatars/6.png" alt="Avatar"
														class="rounded-circle" /></li>
													<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
														data-bs-placement="top" class="avatar avatar-xs pull-up"
														title="Christina Parker"><img
														src="../assets/img/avatars/7.png" alt="Avatar"
														class="rounded-circle" /></li>
												</ul>
											</td>
											<td><span class="badge bg-label-primary me-1">Active</span></td>
											<td>
												<div class="dropdown">
													<button type="button"
														class="btn p-0 dropdown-toggle hide-arrow"
														data-bs-toggle="dropdown">
														<i class="bx bx-dots-vertical-rounded"></i>
													</button>
													<div class="dropdown-menu">
														<a class="dropdown-item" href="javascript:void(0);"><i
															class="bx bx-edit-alt me-1"></i> Edit</a> <a
															class="dropdown-item" href="javascript:void(0);"><i
															class="bx bx-trash me-1"></i> Delete</a>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td><i class="bx bxl-react bx-sm text-info me-3"></i> <span
												class="fw-medium">React Project</span></td>
											<td>Barry Hunter</td>
											<td>
												<ul
													class="list-unstyled users-list m-0 avatar-group d-flex align-items-center">
													<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
														data-bs-placement="top" class="avatar avatar-xs pull-up"
														title="Lilian Fuller"><img
														src="../assets/img/avatars/5.png" alt="Avatar"
														class="rounded-circle" /></li>
													<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
														data-bs-placement="top" class="avatar avatar-xs pull-up"
														title="Sophia Wilkerson"><img
														src="../assets/img/avatars/6.png" alt="Avatar"
														class="rounded-circle" /></li>
													<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
														data-bs-placement="top" class="avatar avatar-xs pull-up"
														title="Christina Parker"><img
														src="../assets/img/avatars/7.png" alt="Avatar"
														class="rounded-circle" /></li>
												</ul>
											</td>
											<td><span class="badge bg-label-success me-1">Completed</span></td>
											<td>
												<div class="dropdown">
													<button type="button"
														class="btn p-0 dropdown-toggle hide-arrow"
														data-bs-toggle="dropdown">
														<i class="bx bx-dots-vertical-rounded"></i>
													</button>
													<div class="dropdown-menu">
														<a class="dropdown-item" href="javascript:void(0);"><i
															class="bx bx-edit-alt me-2"></i> Edit</a> <a
															class="dropdown-item" href="javascript:void(0);"><i
															class="bx bx-trash me-2"></i> Delete</a>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td><i class="bx bxl-vuejs bx-sm text-success me-3"></i>
												<span class="fw-medium">VueJs Project</span></td>
											<td>Trevor Baker</td>
											<td>
												<ul
													class="list-unstyled users-list m-0 avatar-group d-flex align-items-center">
													<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
														data-bs-placement="top" class="avatar avatar-xs pull-up"
														title="Lilian Fuller"><img
														src="../assets/img/avatars/5.png" alt="Avatar"
														class="rounded-circle" /></li>
													<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
														data-bs-placement="top" class="avatar avatar-xs pull-up"
														title="Sophia Wilkerson"><img
														src="../assets/img/avatars/6.png" alt="Avatar"
														class="rounded-circle" /></li>
													<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
														data-bs-placement="top" class="avatar avatar-xs pull-up"
														title="Christina Parker"><img
														src="../assets/img/avatars/7.png" alt="Avatar"
														class="rounded-circle" /></li>
												</ul>
											</td>
											<td><span class="badge bg-label-info me-1">Scheduled</span></td>
											<td>
												<div class="dropdown">
													<button type="button"
														class="btn p-0 dropdown-toggle hide-arrow"
														data-bs-toggle="dropdown">
														<i class="bx bx-dots-vertical-rounded"></i>
													</button>
													<div class="dropdown-menu">
														<a class="dropdown-item" href="javascript:void(0);"><i
															class="bx bx-edit-alt me-2"></i> Edit</a> <a
															class="dropdown-item" href="javascript:void(0);"><i
															class="bx bx-trash me-2"></i> Delete</a>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td><i class="bx bxl-bootstrap bx-sm text-primary me-3"></i>
												<span class="fw-medium">Bootstrap Project</span></td>
											<td>Jerry Milton</td>
											<td>
												<ul
													class="list-unstyled users-list m-0 avatar-group d-flex align-items-center">
													<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
														data-bs-placement="top" class="avatar avatar-xs pull-up"
														title="Lilian Fuller"><img
														src="../assets/img/avatars/5.png" alt="Avatar"
														class="rounded-circle" /></li>
													<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
														data-bs-placement="top" class="avatar avatar-xs pull-up"
														title="Sophia Wilkerson"><img
														src="../assets/img/avatars/6.png" alt="Avatar"
														class="rounded-circle" /></li>
													<li data-bs-toggle="tooltip" data-popup="tooltip-custom"
														data-bs-placement="top" class="avatar avatar-xs pull-up"
														title="Christina Parker"><img
														src="../assets/img/avatars/7.png" alt="Avatar"
														class="rounded-circle" /></li>
												</ul>
											</td>
											<td><span class="badge bg-label-warning me-1">Pending</span></td>
											<td>
												<div class="dropdown">
													<button type="button"
														class="btn p-0 dropdown-toggle hide-arrow"
														data-bs-toggle="dropdown">
														<i class="bx bx-dots-vertical-rounded"></i>
													</button>
													<div class="dropdown-menu">
														<a class="dropdown-item" href="javascript:void(0);"><i
															class="bx bx-edit-alt me-2"></i> Edit</a> <a
															class="dropdown-item" href="javascript:void(0);"><i
															class="bx bx-trash me-2"></i> Delete</a>
													</div>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<!--/ Basic Bootstrap Table -->
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
