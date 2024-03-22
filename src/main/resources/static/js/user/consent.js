    document.addEventListener("DOMContentLoaded", function() {
        // 체크박스 요소들과 회원가입 버튼 요소를 가져옴
        var checkAllCheckbox = document.getElementById("checkAll");
        var agreementCheckboxes = document.querySelectorAll("input[name='agreement']");
        var signUpButton = document.querySelector(".next-button__custom");

        // 요기오디오 이용약관에 모두 동의합니다 체크박스를 클릭했을 때
        checkAllCheckbox.addEventListener("change", function() {
            if (this.checked) {
                // 모든 (필수)인 체크박스를 선택 상태로 변경
                agreementCheckboxes.forEach(function(checkbox) {
                    checkbox.checked = true;
                });
            } else {
                // 모든 체크박스를 선택 해제
                agreementCheckboxes.forEach(function(checkbox) {
                    checkbox.checked = false;
                });
            }
            // 회원가입 버튼 상태 업데이트
            updateSignUpButtonState();
        });

        // (필수)인 체크박스를 클릭했을 때
        agreementCheckboxes.forEach(function(checkbox) {
            checkbox.addEventListener("change", function() {
                // 회원가입 버튼 상태 업데이트
                updateSignUpButtonState();
            });
        });

        // 회원가입 버튼 상태 업데이트 함수
        function updateSignUpButtonState() {
            var termsOfServiceChecked = document.getElementById("termsOfService").checked;
            var privacyPolicyChecked = document.getElementById("privacyPolicy").checked;

            // 요기오디오 이용약관 동의와 개인정보 수집 및 이용 동의가 모두 체크되어 있으면 버튼 활성화
            signUpButton.disabled = !(termsOfServiceChecked && privacyPolicyChecked);
        }
    });
   