<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- header -->
<link rel="stylesheet" href="css/user/signIn.css" />
<%@include file="/WEB-INF/view/layout/header.jsp"%>
<div class="container sign--in--container">
	<!-- Heading -->
	<h1>SIGN IN</h1>

	<!-- Links -->
	<ul class="links">
		<li><a href="#" id="signin">SIGN IN</a></li>
		<li><a href="#" id="signup">SIGN UP</a></li>
		<li><a href="#" id="reset">RESET</a></li>
	</ul>

	<!-- Form -->
	<form action="/signIn" method="post">
		<!-- email input -->
		<div class="first-input input__block first-input__block">
			<input type="email" placeholder="Email" class="input" id="email" name="email"/>
		</div>
		<!-- password input -->
		<div class="input__block">
			<input type="password" placeholder="Password" class="input"
				id="password" name="password"/>
		</div>
		<!-- repeat password input -->
		<div class="input__block">
			<input type="password" placeholder="Repeat password"
				class="input repeat__password" id="repeat__password" />
		</div>
		<!-- name input -->
		<div class="input__block">
			<input type="text" placeholder="name" class="input name"
				id="name" name="name"/>
		</div>
		<!-- nickname input -->
		<div class="input__block">
			<input type="text" placeholder="nickname" class="input nickname"
				id="nickname" name="nickname"/>
		</div>
		<!-- sign in button -->
		<button class="signin__btn">Sign in</button>
	</form>
	<!-- separator -->
	<div class="separator">
		<p>OR</p>
			<!-- sns login button -->
		<div>
			<a href="#" class="kakaoLogin"> <img src="/img/kakao/kakao_login.png" alt="Kakao" id="loginBtn">
			<a href="#" class="naverLogin"> <img src="/img/naver/naver_login.png" alt="Naver" id="loginBtn">
			<a href="#" class="googleLogin"> <img src="/img/google/google_login.png" alt="Google" id="loginBtn">
		</div>
	</div>
</div>
<!-- footer -->
<script src="js/user/signIn.js"></script>
<%@include file="/WEB-INF/view/layout/footer.jsp"%>