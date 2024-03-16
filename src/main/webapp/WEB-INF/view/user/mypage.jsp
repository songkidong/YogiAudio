<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
/* common */
html, body {
  height: 100%;
  margin: 0;
  padding: 0;
}
body { 
  overflow-y: scroll;
}
.footercustom {
  width: 100%;
  margin: 50px 0 0 0;
}

.smallfont {
  font-size: 12px;
}

hr {
  border: 1px solid #f84646;
  margin: 0 auto;
}

.pointcolor {
  color: #f84646 !important;
}
.pointbutton {
  color: #fff !important;
  background: #f84646 !important;
  border: 1px solid #f84646;
}
.pointbutton:hover {
  background: #db3a29 !important;
}


/* Menu */
.ui.secondary.pointing.menu {
  margin-left: 5%;
  margin-right: 5%;
}
.pointing.menu, .pointing.menu a {
  border: none !important;
}
.centermenu {
  margin: 0 auto !important;
}

.activecustom {
  color: #f84646 !important;
  font-weight: bold !important;
}
.item:hover{
  color: #f84646 !important;
  background: none !important;
}


/* Responsive Menu */
.hidden.menu {
   display: none;
}

.masthead.segment {
   min-height: 100px;
   padding: .25em 0em;
}

.secondary.pointing.menu .toc.item {
   display: none;
}

@media only screen and (max-width: 700px) {
  .ui.fixed.menu {
    display: none !important;
  }
  .secondary.pointing.menu .item {
    display: none;
  }
  .secondary.pointing.menu .toc.item {
    display: block;
  }
  .masthead.segment {
    min-height: 70px;
  }
}

.item--white {
  color: white !important;
}


/* header */
.logoimg {
  /*border: 1px solid #eee;*/
  margin-bottom: 20px;
  margin-top: -25px;
}


/* Contents */
.ui.sub-container {
  /*border: 1px solid #eee;*/
  margin: 0 4% 0 4%;
}
.ui.vertical.text.menu.sidemenu .item{
  /*border: 1px solid #eee;*/
  margin-bottom: 10%;

}
.ui.items p {
  margin-top: -10px;
}
.ui.items .item.pointcolor {
  text-decoration: underline;
  font-size: 16px;  
}


/* Table */
table td, th {
  padding: 10px 0 !important;
  text-align: center !important;
  font-size: 13px;
}


</style>
<body>
<!-- Following Menu -->
<div class="ui large top fixed hidden menu">
  <div class="ui container">
    <a class="item">대시보드</a>
    <a class="active item">주문하기</a>
    <a class="item">배송하기</a>
    <a class="item">주문·배송 내역</a>
    <a class="item">마이페이지</a>
  </div>
</div>

<!-- Sidebar Menu -->
<div class="ui vertical sidebar menu">
  <a class="active item">대시보드</a>
  <a class="item">주문하기</a>
  <a class="item">배송하기</a>
  <a class="item">주문·배송 내역</a>
  <a class="item">마이페이지</a>
</div>

<!-- Start Header -->
<div class="pusher">
  <div class="ui vertical masthead segment" style="border: none;">
    <div class="ui container">
      <div class="ui secondary menu">
        <div class="right menu smallfont">
          <a class="item">로그아웃</a>
          <a class="item">고객센터</a>
          <a class="item">공지사항</a>
          <a class="item">한국어</a>
        </div>
      </div>
      <div class="logoimg">
        <img class="ui small image" src="http://p6.zdassets.com/hc/settings_assets/835286/200184768/1SJbpYB2qmmF6H0OzmzCXQ-hs-new-pdf-logo.gif">
      </div>
      <hr></hr>
    </div>
  
    <div class="ui container">
      <div class="ui secondary pointing menu">
        <a class="toc item">
          <i class="sidebar icon"></i>
        </a>
        <a class="item centermenu"><h3>대시보드</h3></a>
        <a class="item centermenu activecustom"><h3>주문하기</h3></a>
        <a class="item centermenu"><h3>배송하기</h3></a>
        <a class="item centermenu"><h3>주문·배송 내역</h3></a>
        <a class="item centermenu"><h3>마이페이지</h3></a>
      </div>
    </div>
  </div>
  <!-- End Header -->

  <div class="ui hidden divider"></div>
  <div class="ui hidden divider"></div>

  <!-- Start Contents -->
  <div class="ui container">
    <div class="ui sub-container">
      <!-- Top Message -->
      <div class="ui stackable grid"><!-- stackable here-->
        <div class="two wide column" style="padding-top: 0 !important;">
          <h3 class="ui header pointcolor">ORDERS</h3>
        </div>
        <div class="fourteen wide column" style="padding-top: 0 !important;">
          <div class="smallfont">다양한 주문 관련 서비스를 이용하실 수 있습니다.</div>
        </div>
      </div>
      <div class="ui fitted divider"></div>
      <div class="ui hidden divider"></div>
      <div class="ui hidden divider"></div>

      <div class="ui stackable grid">
        <!-- Side Menu -->
        <div class="three wide column">
          <div class="ui vertical text menu sidemenu">
            <a class="item activecustom"><i class="angle right icon"></i>
              신규 주문 </a>
            <a class="item"><i class="angle right icon"></i>
              전체 보기 </a>
            <a class="item"><i class="angle right icon"></i>
              배송 준비 완료 </a>
            <a class="item"><i class="angle right icon"></i>
              라벨 출력 완료 </a>
            <a class="item"><i class="angle right icon"></i>
              삭제하기 </a>
          </div>
        </div>

        <!-- Main Contents-->
        <div class="thirteen wide column">
          <button class="ui small compact pointbutton button">주문 등록</button>
          <button class="ui small compact pointbutton button">주문 진행</button>
          <div class="ui items">
            <p>＊다량의 주문은 
              <a class="pointcolor"><b>CSV로 업로드</b></a> 
              할 수 있습니다. 
              <a class="item pointcolor"><b>CLICK!</b></a>
            </p>
          </div>
          
          <!-- Table -->
          <table class="ui very basic table">
            <thead>
              <tr>
                <th><input type="checkbox"></th>
                <th>주문번호</th>
                <th>주문일</th>
                <th>샵 주문번호</th>
                <th>받는사람</th>
                <th>국가</th>
                <th>상품</th>
                <th>배송서비스</th>
                <th>배송료</th>
                <th>기능</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td><input type="checkbox"></td>
                <td>339</td>
                <td>2015-09-30</td>
                <td></td>
                <td>Jone doe</td>
                <td>United kingdom</td>
                <td>Tshirt</td>
                <td>UC Express</td>
                <td>21335</td>
                <td></td>
              </tr>
              <tr>
                <td><input type="checkbox"></td>
                <td>339</td>
                <td>2015-09-30</td>
                <td></td>
                <td>Jone doe</td>
                <td>United kingdom</td>
                <td>Tshirt</td>
                <td>UC Express</td>
                <td>21335</td>
                <td></td>
              </tr>
              <tr>
                <td><input type="checkbox"></td>
                <td>339</td>
                <td>2015-09-30</td>
                <td></td>
                <td>Jone doe</td>
                <td>United kingdom</td>
                <td>Tshirt</td>
                <td>UC Express</td>
                <td>21335</td>
                <td></td>
              </tr>
              <tr>
                <td><input type="checkbox"></td>
                <td>339</td>
                <td>2015-09-30</td>
                <td></td>
                <td>Jone doe</td>
                <td>United kingdom</td>
                <td>Tshirt</td>
                <td>UC Express</td>
                <td>21335</td>
                <td></td>
              </tr>
              <tr>
                <td><input type="checkbox"></td>
                <td>339</td>
                <td>2015-09-30</td>
                <td></td>
                <td>Jone doe</td>
                <td>United kingdom</td>
                <td>Tshirt</td>
                <td>UC Express</td>
                <td>21335</td>
                <td></td>
              </tr>
            </tbody>
            <tfoot>
              <tr>
                <th colspan="10">
                  <div class="ui pagination menu">
                    <a class="icon item">
                      <i aria-hidden="true" class="left chevron icon"></i>
                    </a>
                    <a class="item">1</a>
                    <a class="item">2</a>
                    <a class="item">3</a>
                    <a class="item">4</a>
                    <a class="icon item">
                      <i aria-hidden="true" class="right chevron icon"></i>
                    </a>
                  </div>
                </th>
              </tr>
            </tfoot>
          </table>
          
          <div class="ui hidden divider"></div>
          <div class="ui divider"></div>
          <div class="smallfont">＊선택한 주문을 일괄　
            <div class="ui compact mini button">삭제하기</div>
            <div class="ui compact mini button">다운로드</div>
          </div>
        </div>
 
      </div>
      <!-- End UI grid-->
      
    </div>
  </div>
  <!-- End Contents -->

  <div class="footercustom">
    <div class="ui center aligned basic inverted bottom fixed segment">
      <div class="smallfont">
        © 2016. IMEX All Rights Reserved. </br>
      1905, 48 Centum jungang-ro, Haeundae-gu , Busan, Korea　T 051.742.7777
      </div>
    </div>
  </div>

</div>
</body>
</html>