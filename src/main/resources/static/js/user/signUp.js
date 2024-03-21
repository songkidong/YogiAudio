// 이메일 인증번호 전송 버튼 클릭 시
$("#sendVerificationButton").click(function() {
	var email = $("#email").val();

	// Ajax 요청
	$.ajax({
		type: "POST",
		url: "/sendMail/" + email,
		success: function(response) {
			console.log(response);
			alert("이메일이 전송되었습니다.");
		},
		error: function(xhr, status, error) {
			alert("이메일 전송에 실패하였습니다.");
		}
	});
});

// Verify 버튼 클릭 시
$("#verifyButton").click(function() {
	var verificationCode = $("#verificationCode").val();

	// Ajax 요청
	$.ajax({
		type: "GET",
		url: "/sendNumber",
		data: {
			number: verificationCode
		},
		success: function(response) {
			console.log(response);
			if (response == true) {
				alert("이메일이 성공적으로 인증되었습니다.");
				isValid = true;
			} else {
				alert("인증번호가 올바르지 않습니다. 다시 확인해 주세요.");
				isValid = false;
			}
		},
		error: function(xhr, status, error) {
			alert("인증 요청에 실패하였습니다.");
		}
	});
});

// 폼 전송 이벤트 핸들러
$("#signupForm").submit(function(event) {
	// 각 입력 필드의 유효성 검사를 수행
	var isValid = true;

	// Email 유효성 검사
	var email = $("#email").val();
	var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	if (!emailRegex.test(email)) {
		alert('유효한 이메일 주소를 입력하세요.');
		isValid = false;
	}

	// 닉네임 유효성 검사
	var nickname = $("#nickname").val();
	var nicknameRegex = /^[a-zA-Z가-힣]{2,}$/;
	if (!nicknameRegex.test(nickname)) {
		alert('닉네임은 영어와 한글만 가능하고 2글자 이상이어야 합니다.');
		isValid = false;
	}

	// 비밀번호 유효성 검사
	var password = $("#password").val();
	if (password.length < 8) {
		alert('비밀번호는 8글자 이상이어야 합니다.');
		isValid = false;
	}

	// 닉네임 유효성 검사
	var name = $("#name").val();
	var nameRegex = /^[a-zA-Z0-9가-힣]{2,}$/;
	if (!nameRegex.test(name)) {
		alert('이름은 영어, 숫자, 한글만 가능하고 2글자 이상이어야 합니다.');
		isValid = false;
	}

	// 이메일 인증 성공 유효성 검사
	var verificationCode = $("#verificationCode").val();
	if (!verificationCode) {
		alert('이메일을 성공적으로 인증해야 합니다.');
		isValid = false;
	}

	// 모든 유효성 검사를 통과했을 때만 폼 제출을 허용
	if (!isValid) {
		event.preventDefault();
	}
});