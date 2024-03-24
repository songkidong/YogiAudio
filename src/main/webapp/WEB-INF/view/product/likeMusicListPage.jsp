<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/layout/header.jsp"%>

<title>국내음악리스트</title>

<style>
.section-tab-select {
	width: 150px; /* 원하는 너비로 설정하세요 */
}

.like-rank {
	position: absolute;
	top: 10px;
	left: 10px;
	background-color: #ff9800; /* 배경색 */
	color: #fff; /* 텍스트 색상 */
	font-size: 16px; /* 폰트 크기 */
	border-radius: 50%; /* 원형 모양으로 만들기 */
	width: 30px; /* 너비 */
	height: 30px; /* 높이 */
	text-align: center; /* 가운데 정렬 */
	line-height: 30px; /* 수직 가운데 정렬 */
}
</style>

<!-- SECTION -->
<div class="section" style="margin-left: 200px;">
	<!-- container -->
	<div class="container">

		<div style="display: flex; align-items: center; margin-bottom: 20px;">
			<h3 class="title" style="margin-right: 20px;">
				👍인기음악
				<c:if test="${not empty major}">
           			(${major})
       			 </c:if>
			</h3>

			<div class="section-nav">
				<ul class="section-tab-nav tab-nav">
					<li id="allOption"><a href="/product/like-music">전체</a></li>
					<li id="abroad"><a href="/product/like-music?major=국외">국외</a></li>
					<li id="domestic"><a href="/product/like-music?major=국내">국내</a></li>
				</ul>
			</div>


		</div>

		<!-- row -->
		<div class="row">
			<!-- STORE -->
			<div id="store" class="col-md-9">
				<!-- store products -->
				<div class="row">

					<!-- product -->

					<c:forEach var="likeList" items="${likeList}" varStatus="rank">
						<div class="col-md-4 col-xs-6">
							<div class="product">
								<div class="product-img">
									<c:choose>
										<c:when test="${not empty likeList.filepath}">
											<img src=" ${likeList.filepath}">
										</c:when>
										<c:otherwise>
											<img src="/album/default.png">
										</c:otherwise>
									</c:choose>
									<div class="product-label like-rank">${rank.index + 1}</div>
									<!-- 순위 표시 -->
								</div>


								<div class="product-body">
									<p class="product-category">${likeList.musicno}</p>
									<p class="product-category">${likeList.musicmajor}</p>
									<h3 class="product-name">
										<c:url value="/product/domestic-detail" var="detailUrl">
											<c:param name="musicno" value="${likeList.musicno}" />
											<c:param name="musicmajor" value="${likeList.musicmajor}" />
											<c:choose>
												<c:when test="${not empty principal}">
													<c:param name="id" value="${principal.id}" />
												</c:when>
												<c:otherwise>
													<c:param name="id" value="" />
												</c:otherwise>
											</c:choose>
										</c:url>

										<a href="${detailUrl}"> ${likeList.musictitle} </a>
									</h3>
									<h4 class="product-price">${likeList.musiccompany}<del
											class="product-old-price"></del>
									</h4>
								</div>


							</div>
						</div>
					</c:forEach>

					<!-- /product -->


				</div>
				<!-- /store products -->

				<!-- store bottom filter -->
				<div class="store-filter clearfix">
					<ul class="store-pagination">
						<c:if test="${pageVO.prev }">
							<li class="page-item"><a class="page-link"
								href="/product/like-music?page=${pageVO.startPage - 1 }
								&major=${not empty major ? major : ''}"
								aria-label="Previous"> <i class="fa fa-angle-left"></i>
							</a></li>
						</c:if>



						<c:forEach var="i" begin="${pageVO.startPage }"
							end="${pageVO.endPage }" step="1">
							<li class="page-item ${isActive ? 'active' : ''}"><a
								class="page-link"
								href="/product/like-music?page=${i}
								&major=${not empty major ? major : ''}">
									${i} </a></li>
						</c:forEach>



						<c:if test="${pageVO.next}">
							<li class="page-item"><a
								href="/product/like-music?page=${pageVO.endPage + 1}
								&major=${not empty major ? major : ''}">
									<i class="fa fa-angle-right"></i>
							</a></li>
						</c:if>


					</ul>
				</div>
				<!-- /store bottom filter -->



			</div>
			<!-- /STORE -->
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- /SECTION -->


<%@include file="/WEB-INF/view/layout/footer.jsp"%>


