<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<!-- CSS -->
<link rel="stylesheet" href="css/user/signUp.css" />
</head>
<%@include file="/WEB-INF/view/layout/header.jsp"%>
<div class="container sign--up--container-custom">
	<h1 class="custom-heading">SIGN UP</h1>
	<ul class="links-custom">
		<li><a href="/signUp" id="signup">SIGN UP</a></li>
		<li><a href="/signIn" id="signin">SIGN IN</a></li>
		<li><a href="#" id="reset">RESET</a></li>
	</ul>
	<form id="signupForm" action="/signUp" method="post" id="email" class="custom-form">
		<div class="input__block first-input__block">
			<input type="email" placeholder="Email" class="input email"
				id="email" />
			<button type="button" id="sendVerificationButton">인증번호전송</button>
		</div>
		<div class="input__block" id="verificationForm">
			<input type="text" placeholder="Verification Code" class="input"
				id="verificationCode" name="verificationCode" />
			<button type="button" id="verifyButton">인증</button>
		</div>
		<div class="input__block">
			<input type="password" placeholder="Password" class="input password"
				id="password" name="password" />
		</div>
		<div class="input__block">
			<input type="password" placeholder="checkPassword" class="input checkpassword"
				id="checkpassword" name="checkpassword" />
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
				src="/img/kakao/kakao_login.png" alt="Kakao" id="loginBtn">
			</a> <a href="#" class="naverLogin"> <img
				src="/img/naver/naver_login.png" alt="Naver" id="loginBtn">
			</a> <a href="#" class="googleLogin"> <img
				src="/img/google/google_login.png" alt="Google" id="loginBtn">
			</a>
		</div>
	</div>
</div>
<script src="/js/user/signUp.js"></script>
</body>
<%@include file="/WEB-INF/view/layout/footer.jsp"%>
</html>
