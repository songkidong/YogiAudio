// signIn.js

document.addEventListener("DOMContentLoaded", function() {
    var resetButton = document.getElementById("reset");

    // reset 버튼 클릭 시
    resetButton.addEventListener("click", function(event) {
        event.preventDefault(); // 기본 이벤트 방지

        // 입력 필드들의 값을 모두 비움
        var emailInput = document.getElementById("email");
        var passwordInput = document.getElementById("password");
        var repeatPasswordInput = document.getElementById("repeat__password");
        var nameInput = document.getElementById("name");
        var nicknameInput = document.getElementById("nickname");

        emailInput.value = "";
        passwordInput.value = "";
        repeatPasswordInput.value = "";
        nameInput.value = "";
        nicknameInput.value = "";
    });
});
