  // 폼 제출을 위한 함수
  function validateForm() {	  
	  
    // 프로필 파일 업로드 확인
    var profileFile = document.getElementById("upload").value;
    var profileFilePattern = /^[a-zA-Z0-9가-힣\s\._-]+$/;
    if(!profileFilePattern.test(profileFile)) {
        return true;
    }
    
    // 이름 유효성 검사: 영어 또는 한글만 허용
    var nameInput = document.getElementById("name").value;
    var namePattern = /^[A-Za-z가-힣]+$/;
    if (!namePattern.test(nameInput)) {
      alert("이름은 영어 또는 한글만 입력 가능합니다.");
      return false;
    }

    // 닉네임 유효성 검사: 영어, 숫자, 한글만 허용
    var nicknameInput = document.getElementById("nickname").value;
    var nicknamePattern = /^[A-Za-z0-9가-힣]+$/;
    if (!nicknamePattern.test(nicknameInput)) {
      alert("닉네임은 영어, 숫자, 한글만 입력 가능합니다.");
      return false;
    }

    // 비밀번호 일치 여부 확인
    var passwordInput = document.getElementById("password").value;
    var checkPasswordInput = document.getElementById("checkpassword").value;
    if (passwordInput !== checkPasswordInput) {
      alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
      return false;
    }

    // 모든 조건 충족 시 폼 제출
    return true;
  }
  
    function confirmUpdate() {
    // 사용자에게 수정 여부를 묻는 확인 대화상자 표시
    var isConfirmed = confirm("수정하시겠습니까?");
    if (isConfirmed) {
alert("수정이 완료되었습니다.");
      return true; // 확인을 선택한 경우 폼 제출
    } else {
      return false; // 취소를 선택한 경우 폼 제출 중지
    }
  }
  
    function confirmAccountDeletion() {
    // 계정 삭제 확인 체크박스의 상태 확인
    var isChecked = document.getElementById("accountActivation").checked;
    if (!isChecked) {
      alert("체크박스를 확인해주세요.");
      return false; // 체크박스가 확인되지 않은 경우 폼 제출 중지
    }

    // 사용자에게 탈퇴 여부를 묻는 확인 대화상자 표시
    var isConfirmed = confirm("정말로 계정을 탈퇴하시겠습니까?");
    if (isConfirmed) {
      return true; // 확인을 선택한 경우 폼 제출
    } else {
      return false; // 취소를 선택한 경우 폼 제출 중지
    }
  }