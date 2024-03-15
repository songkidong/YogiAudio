<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8" />
    <link rel="icon" href="https://static.toss.im/icons/png/4x/icon-toss-logo.png" />
    <link rel="stylesheet" type="text/css" href="./public/style.css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>토스페이먼츠 샘플 프로젝트</title>
    <!-- 결제위젯 SDK 추가 -->
    <script src="https://js.tosspayments.com/v1/payment-widget"></script>
  </head>

  <body>
    <!-- 주문서 영역 -->
    <div class="wrapper">
      <div class="box_section"
      style="padding: 40px 30px 50px 30px; margin-top:30px; margin-bottom:50px">
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
  </body>

  <script>
    const button = document.getElementById("payment-button");
    const coupon = document.getElementById("coupon-box");
    const generateRandomString = () => window.btoa(Math.random()).slice(0, 20);
    let currentURL = window.location.protocol + "//" + window.location.host + "/" + window.location.pathname.split('/')[1];
    var amount = 50000;

    // ------  결제위젯 초기화 ------
    // @docs https://docs.tosspayments.com/reference/widget-sdk#sdk-설치-및-초기화
    // TODO: clientKey는 개발자센터의 결제위젯 연동 키 > 클라이언트 키로 바꾸세요. 
    // TODO: customerKey는 구매자와 1:1 관계로 무작위한 고유값을 생성하세요. 
    const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm"; 
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

    // ------  결제 금액 업데이트 ------
    // @docs https://docs.tosspayments.com/reference/widget-sdk#updateamount결제-금액
    coupon.addEventListener("change", function () {
      if (coupon.checked) {
        paymentMethodWidget.updateAmount(amount - 5000);
      } else {
        paymentMethodWidget.updateAmount(amount);
      }
    });

    // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
    // @docs https://docs.tosspayments.com/reference/widget-sdk#requestpayment결제-정보
    button.addEventListener("click", function () {
      paymentWidget.requestPayment({
        orderId: generateRandomString(),
        orderName: "토스 티셔츠 외 2건",
        successUrl: currentURL + "/success.jsp",
        failUrl: currentURL + "/fail.jsp",
        customerEmail: "customer123@gmail.com",
        customerName: "김토스",
        customerMobilePhone: "01012341234"
      });
    });

  </script>
</html>