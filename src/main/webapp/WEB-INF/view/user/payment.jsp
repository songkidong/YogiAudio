<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 내역</title>
<!-- CSS -->

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
							<a class="nav-link" href="/product/main"><i
								class="bx bx-home me-1"></i> Home</a>
						</h4>

						<div class="row">
							<div class="col-md-12">
								<ul class="nav nav-pills flex-column flex-md-row mb-3">
									<li class="nav-item"><a class="nav-link"
										href="/account/${principal.id}"><i class="bx bx-user me-1"></i>
											계정</a></li>
									<li class="nav-item"><a class="nav-link active"
										href="/payment"><i class="bx bx-credit-card me-1"></i> 결제 내역</a></li>
									<li class="nav-item"><a class="nav-link"
										href="/myPlaylist"><i class="bx bx-music me-1"></i> 플리</a></li>
									<li class="nav-item"><a class="nav-link" href="/likemusic"><i
											class="bx bxs-heart me-1"></i> 좋아요</a></li>

								</ul>

							</div>
						</div>
						<c:if test="${empty paymentList}">
							<h1 style="display: flex; justify-content: center;">결제 내역이
								존재하지 않습니다</h1>
						</c:if>

						<!-- Basic Bootstrap Table -->
						<c:if test="${not empty paymentList}">
							<div class="card">
								<h5 class="card-header">결제 내역</h5>
								<div class="table-responsive text-nowrap">
									<table class="table">
										<thead>
											<tr>
												<th>결제번호</th>
												<th>상품</th>
												<th>가격</th>
												<th>구매일시</th>
												<th></th>
											</tr>
										</thead>
										<tbody class="table-border-bottom-0">
											<c:forEach items="${paymentList}" var="pay">
												<tr>
													<td>${pay.hno}</td>
													<td>${pay.purchaseName}</td>
													<td>${pay.amount}</td>
													<td>${pay.date}</td>
													<td><input type="hidden" class="payment-id"
														value="${pay.id}"> <c:if
															test="${pay.refundYn == null}">
															<button class="btn btn-primary refund-btn"
																onclick="requestRefund(this)">환불 요청</button>
														</c:if> <c:if test="${pay.refundYn == 'N'}">
															<button class="btn btn-primary refund-btn" disabled>환불
																요청 완료</button>
														</c:if> <c:if test="${pay.refundYn == 'Y'}">
															<button class="btn btn-primary refund-btn" disabled>환불
																완료</button>
														</c:if></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</c:if>
						<!--/ Basic Bootstrap Table -->
					</div>
					<!-- / Content -->

					<div class="content-backdrop fade"></div>
				</div>
				<!-- flex 속성으로 가운데정렬하기 -->
				<ul class="pagination"
					style="display: flex; justify-content: center; padding-right: 10%; margin-top: 10px;">

					<!-- pageVO.prev가 참(시작페이지가 1이 아닐 때)이면 이전버튼 li태그 생성 -->
					<c:if test="${pageVO.prev }">
						<li class="page-item"><a class="page-link"
							href="/payment?page=${pageVO.startPage - 1 }"><i
								class="fas fa-chevron-left"></i></a></li>
					</c:if>

					<!-- 반복문 -->
					<c:forEach var="i" begin="${pageVO.startPage }"
						end="${pageVO.endPage }" step="1">
						<!-- 페이지 번호 클릭했을 때 Controller에서 pageVO.setCri(cri) 메서드를 통해, 현재 페이지 값 가져올 수 있음 -->
						<li class="page-item ${pageVO.cri.page eq i ? 'active' : ''}">
							<!-- Controller에서 Criteria가 매개변수로 있어서, 여기서 page값 파라미터로 보낼때 받을 수 있음 -->
							<a class="page-link" href="/payment?page=${i }">${i }</a>
						</li>
					</c:forEach>
					<!-- 반복문 끝 -->

					<!-- pageVO.nexr가 참(끝페이지 * 페이지당 게시글 수가 총 갯수보다 작으면)이면 다음버튼 li태그 생성 -->
					<c:if test="${pageVO.next }">
						<li class="page-item"><a class="page-link"
							href="/payment?page=${pageVO.endPage + 1 }"><i
								class="fas fa-chevron-right"></i></a></li>
					</c:if>

				</ul>
				<!-- Content wrapper -->

			</div>
			<!-- / Layout page -->
		</div>

		<!-- Overlay -->
		<div class="layout-overlay layout-menu-toggle"></div>
	</div>
	<!-- / Layout wrapper -->
	<script>
		// 결제 항목의 환불 요청을 처리하는 함수
		function requestRefund(button) {
			var row = $(button).closest('tr');
			var hno = row.find('td:first').text();
			var id = row.find('.payment-id').val();
			$.ajax({
				type : 'POST',
				url : '/refund',
				contentType : 'application/json',
				data : JSON.stringify({
					hno : hno,
					id : id
				}),
				success : function(response) {
					alert('환불 요청이 성공적으로 전송되었습니다.');
					$(button).text('환불 요청 완료');
					$(button).prop('disabled', true);
				},
				error : function(xhr, status, error) {
					console.error(xhr.responseText);
					alert('환불 요청 전송 중 오류가 발생했습니다.');
				}
			});
		}
	</script>


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
