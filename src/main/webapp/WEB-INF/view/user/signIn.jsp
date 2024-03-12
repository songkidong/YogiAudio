<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/user/signIn.css" />
<%@include file="/WEB-INF/view/layout/header.jsp"%>
<div class="container sign--in--container">
    <h1>SIGN IN</h1>
    <ul class="links">
        <li><a href="#" id="signin">SIGN IN</a></li>
        <li><a href="/signUp" id="signup">SIGN UP</a></li>
        <li><a href="#" id="reset">RESET</a></li>
    </ul>
    <form action="/signIn" method="post">
        <div class="first-input input__block first-input__block">
            <input type="email" placeholder="Email" class="input" id="email" name="email"/>
        </div>
        <div class="input__block">
            <input type="password" placeholder="Password" class="input" id="password" name="password"/>
        </div>
        <button class="signin__btn">Sign in</button>
    </form>
    <div class="separator">
        <p>OR</p>
        <div>
            <a href="#" class="kakaoLogin"> <img src="/img/kakao/kakao_login.png" alt="Kakao" id="loginBtn">
            <a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=cLVvs14822OOyYydIWA1&state=STATE_STRING&redirect_uri=http://localhost:80/naver/login" class="naverLogin"> <img src="/img/naver/naver_login.png" alt="Naver" id="loginBtn">
            <a href="#" class="googleLogin"> <img src="/img/google/google_login.png" alt="Google" id="loginBtn">
        </div>
    </div>
</div>
<script src="js/user/signIn.js"></script>
<%@include file="/WEB-INF/view/layout/footer.jsp"%>
