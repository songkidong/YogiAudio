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
							<h2 class="product-name">${detail.purchasename}</h2>
							
							<div>
								<h3 class="product-price">${detail.price}<del class="product-old-price"></del></h3>
								  <c:if test="${detail.pno eq detailcancel.pno and principal.id eq detailcancel.id}">
									   <a href="/purchase/cancel?paymentKey=${detailcancel.paymentKey}">
									       <button class="btn btn-danger" id="cancel-button" style="margin-top:30px; margin-left: 50px;">취소하기</button>
									   </a>
								</c:if>
							</div>
						
							
						    
						   
							 
							    
						    
						    
						     <!-- 주문서 영역 -->
						    <div class="wrapper">
						      <div class="box_section" style="padding: 40px 30px 50px 30px; margin-top:30px; margin-bottom:50px">
						        <!-- 결제 UI -->
						        <div id="payment-method"></div>
						        <!-- 이용약관 UI -->
						        <div id="agreement"></div>
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







						<!-- TOSS 결제 UI 창 JS -->  	
						<script>
						    const button = document.getElementById("payment-button");
						    const pno = ${detail.pno};
						    const userId = ${principal.id};
						    const generateRandomString = () => window.btoa(Math.random()).slice(0, 20);
						    var amount = ${detail.price};

						  	
						
						    // ------  결제위젯 초기화 ------
						    // @docs https://docs.tosspayments.com/reference/widget-sdk#sdk-설치-및-초기화
						    // TODO: clientKey는 개발자센터의 결제위젯 연동 키 > 클라이언트 키로 바꾸세요. 
						    // TODO: customerKey는 구매자와 1:1 관계로 무작위한 고유값을 생성하세요. 
						    const clientKey = "test_ck_oEjb0gm23PONwM6GppD48pGwBJn5"; 
						    const customerKey = generateRandomString();                 
						    const paymentWidget = PaymentWidget(clientKey, customerKey); // 회원 결제
						    // const paymentWidget = PaymentWidget(clientKey, PaymentWidget.ANONYMOUS); // 비회원 결제
						
						    // ------  결제 UI 렌더링 ------
						    // @docs https://docs.tosspayments.com/reference/widget-sdk#renderpaymentmethods선택자-결제-금액-옵션
						    paymentMethodWidget = paymentWidget.renderPaymentMethods(
						      "#payment-method",
						      { value: amount },
						      { variantKey: "DEFAULT" }
						    );
						    // ------  이용약관 UI 렌더링 ------
						    // @docs https://docs.tosspayments.com/reference/widget-sdk#renderagreement선택자-옵션
						    paymentWidget.renderAgreement(
						      "#agreement",
						      { variantKey: "AGREEMENT" }
						    );
						
							
						
						    // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
						    // @docs https://docs.tosspayments.com/reference/widget-sdk#requestpayment결제-정보
						    button.addEventListener("click", function () {
						      paymentWidget.requestPayment({
						        orderId: generateRandomString(),
						        orderName: "${detail.purchasename}",
						        successUrl: window.location.origin + "/purchase/success?id=" + userId + "&pno=" + pno,
						        failUrl: window.location.origin + "/fail",
						        customerTitle: "customer123@gmail.com",
						        customerName: "${principal.id}",
						        customerMobilePhone: "01012341234"
						      });
						    });
						
						</script>
													
				    
	































<%@include file="/WEB-INF/view/layout/footer.jsp" %>    
