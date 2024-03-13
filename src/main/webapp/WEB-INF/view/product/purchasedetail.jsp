<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/layout/header.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://js.tosspayments.com/v1/payment-widget"></script>




	<!-- SECTION -->
		<div class="section">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">
					<!-- Product main img -->
					<div class="col-md-5 col-md-push-2">
						<div id="product-main-img">
							<div class="product-preview">
								  <img src="/banner/p1.png" >
							</div>
						</div>
					</div>
					<!-- /Product main img -->

					<!-- Product thumb imgs -->
					<div class="col-md-2 col-md-pull-5">
					  <div id="product-imgs">
			
					 </div>
					</div>
					<!-- /Product thumb imgs -->

					<!-- Product details -->
					<div class="col-md-5">
						<div class="product-details">
							<h2 class="product-name">1개월이용권</h2>
							
							<div>
								<h3 class="product-price">1 ￦<del class="product-old-price"></del></h3>
							</div>
							<p>
							   아티스트 : 1
							</p><br>
							<p>
							   장르 / 스타일 : 1
							</p><br>
							<p>
							   발매사 / 기획사 : 1
							</p><br>
							<p>
							   발매일 : 1
							   유저상태 : 1
							</p><br>
							
						    
						   
							 
							    
						    
						    
						     <!-- 주문서 영역 -->
						    <div class="wrapper">
						      <div class="box_section" style="padding: 40px 30px 50px 30px; margin-top:30px; margin-bottom:50px">
						        <!-- 결제 UI -->
						        <div id="payment-method"></div>
						        <!-- 이용약관 UI -->
						        <div id="agreement"></div>
						        <!-- 쿠폰 체크박스 -->
						        <div style="padding-left: 25px">
						          <div class="checkable typography--p"><label for="coupon-box" class="checkable__label typography--regular"><input id="coupon-box" class="checkable__input" type="checkbox" aria-checked="true"><span class="checkable__label-text">5,000원 쿠폰 적용</span></label></div>
						        </div>
						        <!-- 결제하기 버튼 -->
						        <div class="result wrapper">
						          <button class="button" id="payment-button" style="margin-top:30px; ">결제하기</button>
						        </div>
						      </div>
						    </div>	    
						    
						</div>
					</div>
					<!-- /Product details -->

					<!-- Product tab -->
					<div class="col-md-12">
						<div id="product-tab">
							<!-- product tab nav -->
							<ul class="tab-nav">
								<li class="active"><a data-toggle="tab" href="#tab1">곡 소개</a></li>
								<li><a data-toggle="tab" href="#tab2">가사</a></li>
								<li><a data-toggle="tab" href="#tab3">뮤직비디오</a></li>
							</ul>
							<!-- /product tab nav -->

							<!-- product tab content -->
							<div class="tab-content">
								<!-- tab1  -->
								<div id="tab1" class="tab-pane fade in active">
									<div class="row">
										<div class="col-md-12">
											<p>
											 1234566
											</p>
										</div>
									</div>
								</div>
								<!-- /tab1  -->

								<!-- tab2  -->
								<div id="tab2" class="tab-pane fade in">
									<div class="row">
										<div class="col-md-12">
										    <p id ="lyrics">
										      2134567
										    </p>
										</div>
									</div>
								</div>
								<!-- /tab2  -->

								<!-- tab3  -->
								<div id="tab3" class="tab-pane fade in">
									<div class="row">
																				
											<div class="col-md-4 col-xs-6">
											  <div class="shop">
											    <a href="javascript:void(0)" onclick="openModal('https://www.youtube.com/embed/kHW-UVXOcLU')">
											      <div class="shop-img">
											      </div>
											    </a>  
											    <div class="shop-body">
											      <h3>123<br>13</h3>
											    </div>
											  </div>
											</div>
										
										<div class="col-md-4 col-xs-6">
											  <div class="shop">
											    <a href="javascript:void(0)" onclick="openModal('https://www.youtube.com/embed/kHW-UVXOcLU')">
											      <div class="shop-img">
											      </div>
											    </a>  
											    <div class="shop-body">
											      <h3>1321<br>12313</h3>
											    </div>
											  </div>
											</div>
										
										<div class="col-md-4 col-xs-6">
											  <div class="shop">
											    <a href="javascript:void(0)" onclick="openModal('https://www.youtube.com/embed/kHW-UVXOcLU')">
											      <div class="shop-img">
											      </div>
											    </a>  
											    <div class="shop-body">
											      <h3>23132<br>123213</h3>
											    </div>
											  </div>
											</div>
											
											
																
										
									</div>
								</div>
								<!-- /tab3  -->
							</div>
							<!-- /product tab content  -->
						</div>
					</div>
					<!-- /product tab -->
				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /SECTION -->







































<%@include file="/WEB-INF/view/layout/footer.jsp" %>    
