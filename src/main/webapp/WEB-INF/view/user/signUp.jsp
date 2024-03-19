<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/user/signUp.css" />
<%@include file="/WEB-INF/view/layout/header.jsp"%>
<div class="container sign--up--container">
	<h1>SIGN UP</h1>
	<ul class="links">
		<li><a href="#" id="signup">SIGN UP</a></li>
		<li><a href="/signIn" id="signin">SIGN IN</a></li>
		<li><a href="#" id="reset">RESET</a></li>
	</ul>
	<form action="/signUp" method="post">
		<div class="first-input input__block first-input__block">
			<input type="email" placeholder="Email" class="input" id="email"
				name="email" />
				<button type="button" class="btn-email" onclick="sendEmail()">인증번호전송</button>
		</div>


		<div class="input__block">
			<input type="password" placeholder="Password" class="input"
				id="password" name="password" />
		</div>
		<div class="input__block">
			<input type="password" placeholder="Repeat password"
				class="input repeat__password" id="repeat__password" />
		</div>
		<div class="input__block">
			<input type="text" placeholder="name" class="input name" id="name"
				name="name" />
		</div>
		<div class="input__block">
			<input type="text" placeholder="nickname" class="input nickname"
				id="nickname" name="nickname" />
		</div>
		<button type="submit" class="signin__btn">Sign up</button>
	</form>
	<div class="separator">
		<p>OR</p>
		<div>
			<a href="#" class="kakaoLogin"> <img
				src="/img/kakao/kakao_login.png" alt="Kakao" id="loginBtn"> <a
				href="#" class="naverLogin"> <img
					src="/img/naver/naver_login.png" alt="Naver" id="loginBtn"> <a
					href="#" class="googleLogin"> <img
						src="/img/google/google_login.png" alt="Google" id="loginBtn">
		</div>
	</div>
</div>
<script src="js/user/signUp.js"></script>
<%@include file="/WEB-INF/view/layout/footer.jsp"%>
