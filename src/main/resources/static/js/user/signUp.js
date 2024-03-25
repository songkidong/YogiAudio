// 이메일 인증 성공 여부를 저장할 변수
var isEmailVerified = false;

// 이메일 인증 성공 여부 확인
function checkEmailVerification() {
    return isEmailVerified;
}

// 이메일 인증 성공 여부를 저장하는 함수
function setEmailVerification(status) {
    isEmailVerified = status;
}

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
            // 이메일 전송 성공 시 이메일 인증 성공 변수를 true로 변경
            setEmailVerification(true);
        },
        error: function(xhr, status, error) {
            alert("이메일 전송에 실패하였습니다.");
            // 이메일 전송 실패 시 이메일 인증 성공 변수를 false로 유지
            setEmailVerification(false);
        }
    });
});

// 인증 버튼 클릭 시
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
            if (response == true) {
                alert("이메일이 성공적으로 인증되었습니다.");
                // 이메일 인증 성공 시 이메일 인증 성공 변수를 true로 변경
                setEmailVerification(true);
            } else {
                alert("인증번호가 올바르지 않습니다. 다시 확인해 주세요.");
                // 인증번호가 올바르지 않을 경우 이메일 인증 성공 변수를 false로 유지
                setEmailVerification(false);
            }
        },
        error: function(xhr, status, error) {
            alert("인증 요청에 실패하였습니다.");
            // 인증 요청 실패 시 이메일 인증 성공 변수를 false로 유지
            setEmailVerification(false);
        }
    });
});

// 중복검사 버튼 클릭 이벤트
$("#emailDuplicateCheckButton").click(function() {
    var email = $("#email").val();
    
    $.ajax({
        type: "GET",
        url: "duplication/" + email,
        success: function(response) {
            if (response === "이메일 중복") {
                alert("중복된 이메일입니다.");
            setEmailVerification(false);   
            } else {
                alert("사용 가능한 이메일입니다.");

             setEmailVerification(true);

            }
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
    
    // 비밀번호 확인 유효성 검사 및 비밀번호 일치 여부 확인
    var confirmPassword = $("#checkpassword").val();
    if (password !== confirmPassword) {
        alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
        isValid = false;
    }

    // 이름 유효성 검사
    var name = $("#name").val();
    var nameRegex = /^[a-zA-Z0-9가-힣]{2,}$/;
    if (!nameRegex.test(name)) {
        alert('이름은 영어, 숫자, 한글만 가능하고 2글자 이상이어야 합니다.');
        isValid = false;
    }

    // 이메일 인증 성공 여부 확인
    if (!checkEmailVerification()) {
        alert('이메일을 성공적으로 인증해야 합니다.');
        isValid = false;
    }

    // 모든 유효성 검사를 통과했을 때만 폼 제출을 허용
    if (!isValid) {
        event.preventDefault();
    }
});

/* reset 버튼 */
$(document).ready(function() {
    // Reset 버튼 클릭 이벤트 처리
    $('#reset').click(function(e) {
        e.preventDefault(); // 버튼 클릭 시 기본 동작 방지

        // 폼 안의 내용들을 모두 초기화
        $('#email').val('');
        $('#verificationCode').val('');
        $('#password').val('');
        $('#checkpassword').val('');
        $('#name').val('');
        $('#nickname').val('');
    });
});