<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/user/signIn.css" />
<%@include file="/WEB-INF/view/layout/header.jsp"%>
<div class="container sign--in--container-custom">
	<h1 class="custom-heading">SIGN IN</h1>
	<ul class="links-custom">
		<li><a href="/signIn" id="signin">SIGN IN</a></li>
		<li><a href="/consent" id="signup">SIGN UP</a></li>
		<li><a href="#" id="reset">RESET</a></li>
	</ul>
	<form action="/signIn" method="post" class="custom-form">
		<div class="first-input input__block first-input__block">
			<input type="email" placeholder="Email" class="input" id="email"
				name="email" />
		</div>
		<div class="input__block">
			<input type="password" placeholder="Password" class="input"
				id="password" name="password" />
		</div>
		<button class="signin__btn">Sign in</button>
	</form>
			<div class="input__block" style="text-align: center; margin-top: 20px;">
			<a href="/forgotemail">이메일 찾기 </a>/
			<a href="/forgotpassword">비밀번호 찾기</a>
		</div>
	<div class="separator-custom">
		<p>OR</p>
		<div>
			<a
				href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=d4f846759e28d648d1c4296141742ccb&redirect_uri=http://localhost/kakao/login"
				class="kakaoLogin"> <img src="/img/kakao/kakao_login.png"
				alt="Kakao" id="loginBtn-custom"> <a
				href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=cLVvs14822OOyYydIWA1&state=STATE_STRING&redirect_uri=http://localhost:80/naver/login"
				class="naverLogin-custom"> <img src="/img/naver/naver_login.png"
					alt="Naver" id="loginBtn-custom"> <a
					href="https://accounts.google.com/o/oauth2/v2/auth?response_type=code&client_id=411584291074-u6va1riq7hp0gubh4uoe9kk6gvcgp59k.apps.googleusercontent.com&redirect_uri=http://localhost/google/login&scope=https://www.googleapis.com/auth/userinfo.profile%20https://www.googleapis.com/auth/userinfo.email
            "
					class="googleLogin-custom"> <img
						src="/img/google/google_login.png" alt="Google"
						id="loginBtn-custom">
		</div>
	</div>
</div>
<script src="js/user/signIn.js"></script>
<%@include file="/WEB-INF/view/layout/footer.jsp"%>
