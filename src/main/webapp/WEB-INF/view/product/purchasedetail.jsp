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
						<div id="product-main-img" style="margin-top: 100px;">
							<div class="product-preview">
							<c:choose>
							    <c:when test="${detail.pno == 1}">
							        <img src="/banner/p1.png" style="width:360px; height: 350px;">
							    </c:when>
							    <c:when test="${detail.pno == 2}">
							        <img src="/banner/3month.png" style="width:360px; height: 350px;">
							    </c:when>
							    <c:when test="${detail.pno == 3}">
							        <img src="/banner/6month.png" style="width:360px; height: 350px;">
							    </c:when>
							    <c:otherwise>
							        <img src="/banner/1year.png" style="width:360px; height: 350px;">
							    </c:otherwise>
							</c:choose>
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
						<div class="naming" style="margin-left: 30px; margin-top: 50px;">
							<h2 class="product-name">${detail.purchasename}</h2>
							
						  <div>
						    <h3 class="product-price">${detail.price}  ￦<del class="product-old-price"></del></h3>
						  </div>
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
						<div id="product-tab" style="margin-left: 150px; margin-bottom: 50px;">
						   <h3 class="title" style="margin-left: 30px; margin-bottom: 30px;">🔶문의</h3>
						   	<div class="sub" style="margin-left: 30px;">
								<h4>문의사항은 051-123-1234로 문의주세요</h4><br>
	         					<h4>게시판에 문의사항을 남겨주시면 담당자 24시간안에 답변드립니다.</h4>
         				  	</div>
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
