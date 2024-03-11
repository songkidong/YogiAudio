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
	<form action="" method="post">
		<!-- email input -->
		<div class="first-input input__block first-input__block">
			<input type="email" placeholder="Email" class="input" id="email" />
		</div>
		<!-- password input -->
		<div class="input__block">
			<input type="password" placeholder="Password" class="input"
				id="password" />
		</div>
		<!-- repeat password input -->
		<div class="input__block">
			<input type="password" placeholder="Repeat password"
				class="input repeat__password" id="repeat__password" />
		</div>
		<!-- name input -->
		<div class="input__block">
			<input type="text" placeholder="name" class="input name"
				id="name" />
		</div>
		<!-- nickname input -->
		<div class="input__block">
			<input type="text" placeholder="nickname" class="input nickname"
				id="nickname" />
		</div>
		<!-- sign in button -->
		<button class="signin__btn">Sign in</button>
	</form>
	<!-- separator -->
	<div class="separator">
		<p>OR</p>
	</div>
	<!-- google button -->
	<button class="google__btn">
		<i class="fa fa-google"></i> Sign in with Google
	</button>
	<!-- google button -->
	<button class="github__btn">
		<i class="fa fa-github"></i> Sign in with GitHub
	</button>
</div>
<!-- footer -->
<script src="js/user/signIn.js"></script>
<%@include file="/WEB-INF/view/layout/footer.jsp"%>