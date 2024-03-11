<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- header -->
<link rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />
<div class="container">
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
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
