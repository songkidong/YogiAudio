<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/WEB-INF/view/layout/header.jsp" %>    
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<jsp:include page="popup.jsp"/>


<style>
.banner-image {
	transition: opacity 1s ease-in-out;

}
.modalmv{
  display: none;
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgb(0,0,0);
  background-color: rgba(0,0,0,0.4);
}

.shop .shop-body{
    z-index: 1;

}


.shop .shop-body{
	z-index: 1;

}


#mvmodal{
  background-color: #fefefe;
  margin: 0 auto; /* 가운데 정렬 */
  padding: 20px;
  border: 1px solid #888;
  width: 850px; /* 자동으로 YouTube 동영상의 크기에 맞추기 */
  height: 500px;
  position: absolute; /* 절대 위치 설정 */
  top: 30%; /* 화면의 상단에서 절반의 위치에 배치 */
  left: 50%; /* 화면의 왼쪽에서 절반의 위치에 배치 */
  transform: translate(-50%, -50%); /* 수직 및 수평 가운데 정렬 */
  z-index: 1000;
}

.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

.product .product-img .product-label {
	top: 0;
}

.like-rank {
 	border-radius: 5px; /* 순번의 모서리 둥글기 */
	position: absolute;
	top: 0px;
	left: 0px;
	background-color:  rgba(0, 0, 0, 0.5);  /* 배경색 */
	color: #fff; /* 텍스트 색상 */
	font-size: 16px; /* 폰트 크기 */
	width: 30px; /* 너비 */
	height: 30px; /* 높이 */
	text-align: center; /* 가운데 정렬 */
	line-height: 30px; /* 수직 가운데 정렬 */
}

/* 국내, 국외, 종합 순번 */
.product-widget {
    position: relative;
}
.product-index {
    position: absolute;
    top: 0px; /* 순번의 상단 여백 */
    left: 0px; /* 순번의 좌측 여백 */
    background-color: rgba(0, 0, 0, 0.5); /* 순번의 배경색 */
    color: #fff; /* 순번의 글자색 */
    padding: 5px 10px; /* 순번의 내부 여백 */
    border-radius: 5px; /* 순번의 모서리 둥글기 */
    font-size: 12px; /* 순번의 글자 크기 */
}
</style>





	

    
	<!-- NAVIGATION -->
		<nav id="navigation">
			<!-- container -->
			<div class="container">
				<!-- responsive-nav -->
				<div id="responsive-nav" style="display: flex; justify-content: center;">
					<!-- NAV -->
					<ul class="main-nav nav navbar-nav" style="display: flex; justify-content: center;">
						<li><a href="/product/domestic-music">국내</a></li>
						<li><a href="/product/aboard-music">국외</a></li>
						<li><a href="/product/new-music">최신음악</a></li>
						<li><a href="/product/like-music">인기음악</a></li>
						<li><a href="/mv/mvlist">뮤비</a></li>
					</ul>
					<!-- /NAV -->
				</div>
				<!-- /responsive-nav -->
			</div>
			<!-- /container -->
		</nav>
		<!-- /NAVIGATION -->

		<!-- SECTION -->
		<div class="section">
			<!-- container -->
			<div class="container">
					<h3 class="title">💘에디터 추천MV</h3>
				<!-- row -->
				<div class="row">
				 
				 
				 <c:forEach var="mvlist" items="${mvlist}">
					<!-- shop -->
					<div class="col-md-4 col-xs-6">
						<div class="shop">
						     <a href="javascript:void(0)"  onclick="openModal('${mvlist.mvfile}/')" class="cta-btn">
								 <c:choose>
							         <c:when test="${not empty mvlist.filepath}">
							                <img src="${mvlist.filepath}" style="width:360px; height: 240px;">
							         </c:when>
							         <c:otherwise>
							                <img src="/album/default.png" style="width:360px; height: 240px;">
							         </c:otherwise>
							     </c:choose>
						      </a>	
							<div class="shop-body">
								<h3>${mvlist.videosinger}<br>${mvlist.videotitle}</h3>
								<a href="javascript:void(0)"  onclick="openModal('${mvlist.mvfile}/')" class="cta-btn">MV보기<i class="fa fa-arrow-circle-right"></i></a>
							</div>
						</div>
					</div>
					<!-- /shop -->
				</c:forEach>
				
					
				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /SECTION -->

		<!-- SECTION -->
		<div class="section">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">

					<!-- section title -->
					<div class="col-md-12">
						<div class="section-title">
							<h3 class="title">🔥최신곡</h3>
							<div class="section-nav">
								<ul class="section-tab-nav tab-nav">
									<li class="active"><a data-toggle="tab" href="#tab1">국내</a></li>
									<li><a data-toggle="tab" href="#tab2">국외</a></li>
								</ul>
							</div>
						</div>
					</div>
					<!-- /section title -->

					<!-- Products tab & slick -->
					<div class="col-md-12">
						<div class="row">
							<div class="products-tabs">
								<!-- tab -->
								<div id="tab1" class="tab-pane active">
									<div class="products-slick" data-nav="#slick-nav-1">
									
									
									   <!-- product -->
									  <c:forEach var="dnewlist" items="${dnewlist}">
										<div class="product">
											<div class="product-img">
												<c:choose>
												    <c:when test="${not empty dnewlist.filepath}">
												      <img src=" ${dnewlist.filepath}">
												    </c:when>
												  <c:otherwise>
													  <img src="/album/default.png" >
												  </c:otherwise>
												 </c:choose>
												<div class="product-label">
												</div>
											</div>
											<div class="product-body">
												<p class="product-category">${dnewlist.musicminor}</p>
												<h3 class="product-name">
													<a href="/product/domestic-detail?musicno=${dnewlist.musicno}&musicmajor=${dnewlist.musicmajor}&id=${principal.id}">
														${dnewlist.musictitle}
													</a>
												</h3>
												<h4 class="product-price">${dnewlist.musiccompany}</h4>
											</div>
										</div>
										</c:forEach> 
										<!-- /product -->

										
												
									</div>
									<div id="slick-nav-1" class="products-slick-nav"></div>
								</div>
								<!-- /tab -->
								
								
				  <!-- tab -->
					<div id="tab2" class="tab-pane">
					    <div class="products-slick" data-nav="#slick-nav-2">
					        <c:forEach var="anewlist" items="${anewlist}">
					            <div class="product">
					                <div class="product-img">
					                   <c:choose>
										<c:when test="${not empty anewlist.filepath}">
											<img src=" ${anewlist.filepath}">
										</c:when>
										  <c:otherwise>
											<img src="/album/default.png" >
										  </c:otherwise>
										</c:choose>
					                    <div class="product-label">
					                    </div>
					                </div>
					                <div class="product-body">
					                    <p class="product-category">${anewlist.musicminor}</p>
					                    <h3 class="product-name">
										<a href="/product/domestic-detail?musicno=${anewlist.musicno}&musicmajor=${anewlist.musicmajor}&id=${principal.id}">
					                            ${anewlist.musictitle}
					                        </a>
					                    </h3>
					                    <h4 class="product-price">${anewlist.musiccompany}</h4>
					                </div>
					            </div>
					        </c:forEach>
					    </div>
					    <div id="slick-nav-2" class="products-slick-nav"></div>
					</div>
					<!-- /tab -->
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
							</div>
						</div>
					</div>
					<!-- Products tab & slick -->
				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /SECTION -->

		<!-- HOT DEAL SECTION -->
		<div id="banner-section">
		    <div class="row" style="display: flex; justify-content: center; align-items: center; position: relative; height: 300px; overflow: hidden;">
		        <img src="/main/banner/banner1.png" class="banner-image" style="width:1150px; height: 300px; opacity: 1; position: absolute; left: 50%; top: 0; transform: translateX(-50%);">
        		<img src="/main/banner/banner2.png" class="banner-image" style="width:1150px; height: 300px; opacity: 0; position: absolute; left: 50%; top: 0; transform: translateX(-50%);">
			</div>    
		</div>
		<!-- /HOT DEAL SECTION -->

		<!-- SECTION -->
<div class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">

			<!-- section title -->
			<div class="col-md-12">
				<div class="section-title">
					<h3 class="title">👍인기곡</h3>
					<div class="section-nav">
						<ul class="section-tab-nav tab-nav">
							<li class="active"><a data-toggle="tab" href="#tab3">국내</a></li>
							<li><a data-toggle="tab" href="#tab4">국외</a></li>
						</ul>
					</div>
				</div>
			</div>
			<!-- /section title -->

			<!-- Products tab & slick -->
			<div class="col-md-12">
				<div class="row">
					<div class="products-tabs">
						<!-- tab -->
						<div id="tab3" class="tab-pane fade in active">
							<div class="products-slick" data-nav="#slick-nav-3">

								<!-- product -->
								<c:forEach var="dlikelist" items="${dlikelist}" varStatus="rank">
									<div class="product">
										<div class="product-img">
											<c:choose>
												<c:when test="${not empty dlikelist.filepath}">
													<img src=" ${dlikelist.filepath}">
												</c:when>
												<c:otherwise>
													<img src="/album/default.png">
												</c:otherwise>
											</c:choose>
											<div class="product-label like-rank">${rank.index + 1}</div>
											<!-- 순위 표시 -->
										</div>
										<div class="product-body">
											<p class="product-category">${dlikelist.musicminor}</p>
											<h3 class="product-name">
												<a
													href="/product/domestic-detail?musicno=${dlikelist.musicno}&musicmajor=${dlikelist.musicmajor}&id=${principal.id}">
													${dlikelist.musictitle} </a>
											</h3>
											<h4 class="product-price">${dlikelist.musiccompany}</h4>
										</div>
									</div>
								</c:forEach>
								<!-- /product -->


							</div>
							<div id="slick-nav-3" class="products-slick-nav"></div>
						</div>
						<!-- /tab -->
						<!-- tab -->
						<div id="tab4" class="tab-pane">
							<div class="products-slick" data-nav="#slick-nav-4">

								<!-- product -->
								<c:forEach var="alikelist" items="${alikelist}" varStatus="rank">
									<div class="product">
										<div class="product-img">
											<c:choose>
												<c:when test="${not empty alikelist.filepath}">
													<img src=" ${alikelist.filepath}">
												</c:when>
												<c:otherwise>
													<img src="/album/default.png">
												</c:otherwise>
											</c:choose>
											<div class="product-label like-rank">${rank.index + 1}</div>
											<!-- 순위 표시 -->
										</div>
										<div class="product-body">
											<p class="product-category">${alikelist.musicminor}</p>
											<h3 class="product-name">
												<a
													href="/product/domestic-detail?musicno=${alikelist.musicno}&musicmajor=${alikelist.musicmajor}&id=${principal.id}">
													${alikelist.musictitle} </a>
											</h3>
											<h4 class="product-price">${alikelist.musiccompany}</h4>
										</div>
									</div>
								</c:forEach>
								<!-- /product -->


							</div>
							<div id="slick-nav-4" class="products-slick-nav"></div>
						</div>
						<!-- /tab -->
					</div>
				</div>
			</div>
			<!-- /Products tab & slick -->
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- /SECTION -->

<!-- SECTION -->
<div class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<div class="col-md-4 col-xs-6">
				<div class="section-title">
					<h4 class="title">국내인기순위</h4>
					<div class="section-nav">
						<div id="slick-nav-5" class="products-slick-nav"></div>
					</div>
				</div>

				<div class="products-widget-slick" data-nav="#slick-nav-5">

					<div>

						<!-- product widget -->
						<c:forEach var="dlikelist" items="${dlikelist}" begin="0" end="4" varStatus="status">
							<div class="product-widget">
								<div class="product-img">
									<c:choose>
										<c:when test="${not empty dlikelist.filepath}">
											<img src=" ${dlikelist.filepath}">
										</c:when>
										<c:otherwise>
											<img src="/album/default.png">
										</c:otherwise>
									</c:choose>
								</div>
								<div class="product-body">
									<p class="product-category">${dlikelist.musicminor}</p>
									<h3 class="product-name">
										<a
											href="/product/domestic-detail?musicno=${dlikelist.musicno}&musicmajor=${dlikelist.musicmajor}&id=${principal.id}">
											${dlikelist.musictitle} </a>
									</h3>
									<h4 class="product-price">${dlikelist.musiccompany}</h4>
									  <p class="product-index">${status.count + 5}</p>
								</div>
							</div>
						</c:forEach>
						<!-- product widget -->
					</div>
					<div>
						<!-- product widget -->
						<c:forEach var="dlikelist" items="${dlikelist}" begin="5" end="9" varStatus="status">
							<div class="product-widget">
								<div class="product-img">
									<c:choose>
										<c:when test="${not empty dlikelist.filepath}">
											<img src=" ${dlikelist.filepath}">
										</c:when>
										<c:otherwise>
											<img src="/album/default.png">
										</c:otherwise>
									</c:choose>
								</div>
								<div class="product-body">
									<p class="product-category">${dlikelist.musicminor}</p>
									<h3 class="product-name">
										<a
											href="/product/domestic-detail?musicno=${dlikelist.musicno}&musicmajor=${dlikelist.musicmajor}&id=${principal.id}">
											${dlikelist.musictitle} </a>
									</h3>
									<h4 class="product-price">${dlikelist.musiccompany}</h4>
									<p class="product-index">${status.count}</p>
								</div>
							</div>
						</c:forEach>
						<!-- product widget -->
					</div>
				</div>
			</div>

			<div class="col-md-4 col-xs-6">
				<div class="section-title">
					<h4 class="title">국외인기순위</h4>
					<div class="section-nav">
						<div id="slick-nav-6" class="products-slick-nav"></div>
					</div>
				</div>

				<div class="products-widget-slick" data-nav="#slick-nav-6">
					<div>
						<!-- product widget -->
						<c:forEach var="alikelist" items="${alikelist}" begin="0" end="4" varStatus="status">
							<div class="product-widget">
								<div class="product-img">
									<c:choose>
										<c:when test="${not empty alikelist.filepath}">
											<img src=" ${alikelist.filepath}">
										</c:when>
										<c:otherwise>
											<img src="/album/default.png">
										</c:otherwise>
									</c:choose>
								</div>
								<div class="product-body">
									<p class="product-category">${alikelist.musicminor}</p>
									<h3 class="product-name">
										<a
											href="/product/aboard-detail?musicno=${alikelist.musicno}&musicmajor=${alikelist.musicmajor}&id=${principal.id}">
											${alikelist.musictitle} </a>
									</h3>
									<h4 class="product-price">${alikelist.musiccompany}</h4>
									<p class="product-index">${status.count}</p>
								</div>
							</div>
						</c:forEach>
						<!-- product widget -->
					</div>
					<div>
						<!-- product widget -->
						<c:forEach var="alikelist" items="${alikelist}" begin="5" end="9" varStatus="status">
							<div class="product-widget">
								<div class="product-img">
									<c:choose>
										<c:when test="${not empty alikelist.filepath}">
											<img src=" ${alikelist.filepath}">
										</c:when>
										<c:otherwise>
											<img src="/album/default.png">
										</c:otherwise>
									</c:choose>
								</div>
								<div class="product-body">
									<p class="product-category">${alikelist.musicminor}</p>
									<h3 class="product-name">
										<a
											href="/product/aboard-detail?musicno=${alikelist.musicno}&musicmajor=${alikelist.musicmajor}&id=${principal.id}">
											${alikelist.musictitle} </a>
									</h3>
									<h4 class="product-price">${alikelist.musiccompany}</h4>
									<p class="product-index">${status.count}</p>
								</div>
							</div>
						</c:forEach>
						<!-- product widget -->


					</div>
				</div>
			</div>

			<div class="clearfix visible-sm visible-xs"></div>

			<div class="col-md-4 col-xs-6">
				<div class="section-title">
					<h4 class="title">종합인기순위</h4>
					<div class="section-nav">
						<div id="slick-nav-7" class="products-slick-nav"></div>
					</div>
				</div>

				<div class="products-widget-slick" data-nav="#slick-nav-7">
					<div>
						<!-- product widget -->
						<c:forEach var="alllikelist" items="${alllikelist}" begin="0" end="4" varStatus="status">
							<div class="product-widget">
								<div class="product-img">
									<c:choose>
										<c:when test="${not empty alllikelist.filepath}">
											<img src=" ${alllikelist.filepath}">
										</c:when>
										<c:otherwise>
											<img src="/album/default.png">
										</c:otherwise>
									</c:choose>
								</div>
								<div class="product-body">
									<p class="product-category">${alllikelist.musicminor}</p>
									<h3 class="product-name">
										<a href="/product/domestic-detail?musicno=${alllikelist.musicno}&musicmajor=${alllikelist.musicmajor}&id=${principal.id}">
											${alllikelist.musictitle} </a>
									</h3>
									<h4 class="product-price">${alllikelist.musiccompany}</h4>
									<p class="product-index">${status.count}</p>
								</div>
							</div>
						</c:forEach>
						<!-- product widget -->
					</div>
					<div>
						<!-- product widget -->
						<c:forEach var="alllikelist" items="${alllikelist}" begin="5" end="9" varStatus="status">
							<div class="product-widget">
								<div class="product-img">
									<c:choose>
										<c:when test="${not empty alllikelist.filepath}">
											<img src=" ${alllikelist.filepath}">
										</c:when>
										<c:otherwise>
											<img src="/album/default.png">
										</c:otherwise>
									</c:choose>
								</div>
								<div class="product-body">
									<p class="product-category">${alllikelist.musicminor}</p>
									<h3 class="product-name">
										<a
											href="/product/aboard-detail?musicno=${alllikelist.musicno}&musicmajor=${alllikelist.musicmajor}&id=${principal.id}">
											${alllikelist.musictitle} </a>
									</h3>
									<h4 class="product-price">${alllikelist.musiccompany}</h4>
									<p class="product-index">${status.count}</p>
								</div>
							</div>
						</c:forEach>
						<!-- product widget -->

					</div>
				</div>
			</div>

		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- /SECTION -->

		
	
	
	<script>
	$(document).ready(function(){
	    var currentIndex = 0,
	        images = $('.banner-image');

	    setInterval(function() {
	        var currentImage = images.eq(currentIndex);
	        var nextIndex = (currentIndex + 1) % images.length;
	        var nextImage = images.eq(nextIndex);

	        currentImage.animate({opacity: 0}, 1000);
	        nextImage.css('opacity', 0).css('display', 'block').animate({opacity: 1}, 1000);

	        currentIndex = nextIndex;
	    }, 3000); // Change image every 3 seconds
	});
	</script>
	
	
	
	<script>
	    function playAudio() {
	      var audio = document.getElementById("audioPlayer");
	      audio.play();
	      }
	</script>		
		


	<!-- 추가한 모달 창 -->
	<div id="myModal" class="modalmv">
	  <div class="modal-content"  id="mvmodal">
	    <span class="close">&times;</span>
	    <iframe id="videoFrame" width="800" height="400" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	  </div>
	</div>

		
	<!-- 뮤비열기 JS -->
	<script>
		// 모달 창 열기
		function openModal(videoUrl) {
		  var modal = document.getElementById("myModal");
		  var videoFrame = document.getElementById("videoFrame");
		  
		  // 모달 창 안에 YouTube 동영상 URL 설정
		  videoFrame.src = videoUrl;
		  
		  // 모달 창 열기
		  modal.style.display = "block";
		}
		
		// 모달 창 닫기
		document.getElementsByClassName("close")[0].addEventListener("click", function() {
			var modal = document.getElementById("myModal");
			var videoFrame = document.getElementById("videoFrame");
			
			// 모달 창 닫기
			modal.style.display = "none";
			
			// 동영상 정지
			videoFrame.src = "";
		});
		
		// 모달 외부 클릭 시 닫기
		window.addEventListener("click", function(event) {
		  if (event.target == document.getElementById("myModal")) {
		    document.getElementById("myModal").style.display = "none";
		  }
		});
  </script>



		
		
<%@include file="/WEB-INF/view/layout/footer.jsp" %>    
		
		
		