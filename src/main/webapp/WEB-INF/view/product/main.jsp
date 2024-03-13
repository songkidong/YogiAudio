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
						<li><a href="#">최신음악</a></li>
						<li><a href="#">인기음악</a></li>
						<li><a href="#">뮤비</a></li>
						<li><a href="#">게시판</a></li>
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
				
					<!-- shop -->
					<div class="col-md-4 col-xs-6">
						<div class="shop">
						  <a href="https://www.youtube.com/watch?v=kHW-UVXOcLU/">
							<div class="shop-img">
								<img src="/main/img/IU1.jpg" style="width:360px; height: 240px;">
							</div>
						  </a>	
							<div class="shop-body">
								<h3>아이유<br>Shoppers</h3>
								<a href="https://www.youtube.com/watch?v=kHW-UVXOcLU/" class="cta-btn">MV보기<i class="fa fa-arrow-circle-right"></i></a>
							</div>
						</div>
					</div>
					<!-- /shop -->

					<!-- shop -->
					<div class="col-md-4 col-xs-6">
						<div class="shop">
						  <a href="https://www.youtube.com/watch?v=gdZLi9oWNZg/">
							<div class="shop-img">
								<img src="/main/img/bts1.jpg" style="width:360px; height: 240px;">
							</div>
						  </a>	
							<div class="shop-body">
								<h3>BTS(방탄소년단)<br>Dynamite</h3>
								<a href="https://www.youtube.com/watch?v=gdZLi9oWNZg/" class="cta-btn">MV보기<i class="fa fa-arrow-circle-right"></i></a>
							</div>
						</div>
					</div>
					<!-- /shop -->

					<!-- shop -->
					<div class="col-md-4 col-xs-6">
						<div class="shop">
						  <a href="https://www.youtube.com/watch?v=smdmEhkIRVc/"">
							<div class="shop-img">
								<img src="/main/img/bibi1.jpg" style="width:360px; height: 240px;">
							</div>
						   </a>	
							<div class="shop-body">
								<h3>비비<br>밤양갱</h3>
								<a href="https://www.youtube.com/watch?v=smdmEhkIRVc/" class="cta-btn">MV보기<i class="fa fa-arrow-circle-right"></i></a>
							</div>
						</div>
					</div>
					<!-- /shop -->
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
								<div id="tab2" class="tab-pane fade in active">
									<div class="products-slick" data-nav="#slick-nav-2">
									
										<!-- product -->
									 <c:forEach var="dlikelist" items="${dlikelist}">
										<div class="product">
											<div class="product-img">
												<c:choose>
												    <c:when test="${not empty dlikelist.filepath}">
												      <img src=" ${dlikelist.filepath}">
												    </c:when>
												  <c:otherwise>
													  <img src="/album/default.png" >
												  </c:otherwise>
												 </c:choose>
												<div class="product-label">
												</div>
											</div>
											<div class="product-body">
												<p class="product-category">${dlikelist.musicminor}</p>
												<h3 class="product-name">
													<a href="/product/domestic-detail?musicno=${dlikelist.musicno}&musicmajor=${dlikelist.musicmajor}&id=${principal.id}">
													  ${dlikelist.musictitle}
													</a>
												</h3>
												<h4 class="product-price">${dlikelist.musiccompany}</h4>
										   </div>
										  </div>
										 </c:forEach>
										<!-- /product -->

										
									</div>
									<div id="slick-nav-2" class="products-slick-nav"></div>
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
								<div id="slick-nav-3" class="products-slick-nav"></div>
							</div>
						</div>

						<div class="products-widget-slick" data-nav="#slick-nav-3">
						
							<div>

								<!-- product widget -->
							<c:forEach var="dlikelist" items="${dlikelist}" begin="0" end="2">
								<div class="product-widget">
									<div class="product-img">
										<c:choose>
											<c:when test="${not empty dlikelist.filepath}">
												  <img src=" ${dlikelist.filepath}">
										    </c:when>
										    <c:otherwise>
												   <img src="/album/default.png" >
											</c:otherwise>
										 </c:choose>
									</div>
									<div class="product-body">
										<p class="product-category">${dlikelist.musicminor}</p>
										<h3 class="product-name">
											<a href="/product/domestic-detail?musicno=${dlikelist.musicno}&musicmajor=${dlikelist.musicmajor}&id=${principal.id}">
												${dlikelist.musictitle}
											</a>
										</h3>
										<h4 class="product-price">${dlikelist.musiccompany}</h4>
									</div>
								</div>
							  </c:forEach>	
								<!-- product widget -->
								
								
								
							</div>



							<div>
								
								
								
								<!-- product widget -->
							<c:forEach var="dlikelist" items="${dlikelist}" begin="3" end="5">
								<div class="product-widget">
									<div class="product-img">
										<c:choose>
											<c:when test="${not empty dlikelist.filepath}">
												  <img src=" ${dlikelist.filepath}">
										    </c:when>
										    <c:otherwise>
												   <img src="/album/default.png" >
											</c:otherwise>
										 </c:choose>
									</div>
									<div class="product-body">
										<p class="product-category">${dlikelist.musicminor}</p>
										<h3 class="product-name">
											<a href="/product/domestic-detail?musicno=${dlikelist.musicno}&musicmajor=${dlikelist.musicmajor}&id=${principal.id}">
											   ${dlikelist.musictitle}
											</a>
										</h3>
										<h4 class="product-price">${dlikelist.musiccompany}</h4>
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
								<div id="slick-nav-4" class="products-slick-nav"></div>
							</div>
						</div>

						<div class="products-widget-slick" data-nav="#slick-nav-4">
							<div>
								<!-- product widget -->
								<div class="product-widget">
									<div class="product-img">
										<img src="/main/img/new3.jpg" >
									</div>
									<div class="product-body">
										<p class="product-category">Category</p>
										<h3 class="product-name"><a href="#">product name goes here</a></h3>
										<h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
									</div>
								</div>
								<!-- /product widget -->

								<!-- product widget -->
								<div class="product-widget">
									<div class="product-img">
										<img src="/main/img/new3.jpg" >
									</div>
									<div class="product-body">
										<p class="product-category">Category</p>
										<h3 class="product-name"><a href="#">product name goes here</a></h3>
										<h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
									</div>
								</div>
								<!-- /product widget -->

								<!-- product widget -->
								<div class="product-widget">
									<div class="product-img">
										<img src="/main/img/new3.jpg" >
									</div>
									<div class="product-body">
										<p class="product-category">Category</p>
										<h3 class="product-name"><a href="#">product name goes here</a></h3>
										<h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
									</div>
								</div>
								<!-- product widget -->
							</div>

							<div>
								<!-- product widget -->
								<div class="product-widget">
									<div class="product-img">
										<img src="/main/img/new3.jpg" >
									</div>
									<div class="product-body">
										<p class="product-category">Category</p>
										<h3 class="product-name"><a href="#">product name goes here</a></h3>
										<h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
									</div>
								</div>
								<!-- /product widget -->

								<!-- product widget -->
								<div class="product-widget">
									<div class="product-img">
										<img src="/main/img/new3.jpg" >
									</div>
									<div class="product-body">
										<p class="product-category">Category</p>
										<h3 class="product-name"><a href="#">product name goes here</a></h3>
										<h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
									</div>
								</div>
								<!-- /product widget -->

								<!-- product widget -->
								<div class="product-widget">
									<div class="product-img">
										<img src="/main/img/new3.jpg">
									</div>
									<div class="product-body">
										<p class="product-category">Category</p>
										<h3 class="product-name"><a href="#">product name goes here</a></h3>
										<h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
									</div>
								</div>
								<!-- product widget -->
							</div>
						</div>
					</div>

					<div class="clearfix visible-sm visible-xs"></div>

					<div class="col-md-4 col-xs-6">
						<div class="section-title">
							<h4 class="title">종합인기순위</h4>
							<div class="section-nav">
								<div id="slick-nav-5" class="products-slick-nav"></div>
							</div>
						</div>

						<div class="products-widget-slick" data-nav="#slick-nav-5">
							<div>
								<!-- product widget -->
								<div class="product-widget">
									<div class="product-img">
										<img src="/main/img/new3.jpg">
									</div>
									<div class="product-body">
										<p class="product-category">Category</p>
										<h3 class="product-name"><a href="#">product name goes here</a></h3>
										<h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
									</div>
								</div>
								<!-- /product widget -->

								<!-- product widget -->
								<div class="product-widget">
									<div class="product-img">
										<img src="/main/img/new3.jpg" alt="">
									</div>
									<div class="product-body">
										<p class="product-category">Category</p>
										<h3 class="product-name"><a href="#">product name goes here</a></h3>
										<h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
									</div>
								</div>
								<!-- /product widget -->

								<!-- product widget -->
								<div class="product-widget">
									<div class="product-img">
										<img src="/main/img/new3.jpg" alt="">
									</div>
									<div class="product-body">
										<p class="product-category">Category</p>
										<h3 class="product-name"><a href="#">product name goes here</a></h3>
										<h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
									</div>
								</div>
								<!-- product widget -->
							</div>

							<div>
								<!-- product widget -->
								<div class="product-widget">
									<div class="product-img">
										<img src="/main/img/new3.jpg" alt="">
									</div>
									<div class="product-body">
										<p class="product-category">Category</p>
										<h3 class="product-name"><a href="#">product name goes here</a></h3>
										<h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
									</div>
								</div>
								<!-- /product widget -->

								<!-- product widget -->
								<div class="product-widget">
									<div class="product-img">
										<img src="/main/img/new3.jpg" alt="">
									</div>
									<div class="product-body">
										<p class="product-category">Category</p>
										<h3 class="product-name"><a href="#">product name goes here</a></h3>
										<h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
									</div>
								</div>
								<!-- /product widget -->

								<!-- product widget -->
								<div class="product-widget">
									<div class="product-img">
										<img src="/main/img/new3.jpg" alt="">
									</div>
									<div class="product-body">
										<p class="product-category">Category</p>
										<h3 class="product-name"><a href="#">product name goes here</a></h3>
										<h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
									</div>
								</div>
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
		
		
		
<%@include file="/WEB-INF/view/layout/footer.jsp" %>    
		
		
		