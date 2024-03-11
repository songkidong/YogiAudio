/*document.addEventListener("DOMContentLoaded", function() {
    let signup = document.querySelector(".links li #signup");
    let signin = document.querySelector(".links li #signin");
    let reset = document.querySelector(".links li #reset");
    let form = document.querySelector("form");
    let hiddenInput = document.querySelector("form .input__block #repeat__password");
    let nameInput = document.getElementById("name");
    let nicknameInput = document.getElementById("nickname");
    let signinBtn = document.querySelector("form .signin__btn");
    let h1 = document.querySelector(".sign--in--container h1");

    // 초기화: signIn 상태로 설정
    function setSignInState() {
        h1.innerText = "SIGN IN";
        signin.style.opacity = "1";
        Array.from(signin.parentElement.parentElement.children).forEach(function(item) {
            item.style.opacity = (item === signin.parentElement) ? "1" : ".6";
        });
        form.reset(); // Form 초기화
        hiddenInput.style.opacity = "0";
        hiddenInput.style.display = "none";
        nameInput.style.display = "none"; // name 입력 폼 숨기기
        nicknameInput.style.display = "none"; // nickname 입력 폼 숨기기
        signinBtn.innerText = "Sign in";
    }

    // signIn 버튼 클릭 시 동작
    signin.addEventListener("click", function(e) {
        e.preventDefault();
        setSignInState();
    });

    // signUp 버튼 클릭 시 동작
    signup.addEventListener("click", function(e) {
        e.preventDefault();
        h1.innerText = "SIGN UP";
        signin.style.opacity = "1";
        Array.from(signin.parentElement.parentElement.children).forEach(function(item) {
            item.style.opacity = ".6";
        });
        form.reset(); // Form 초기화
        hiddenInput.style.opacity = "1";
        hiddenInput.style.display = "block";
        nameInput.style.display = "block"; // name 입력 폼 보이게 설정
        nicknameInput.style.display = "block"; // nickname 입력 폼 보이게 설정
        signinBtn.innerText = "Sign up";
    });

    // reset 버튼 클릭 시 동작
    reset.addEventListener("click", function(e) {
        e.preventDefault();
        form.reset(); // Form 초기화
        setSignInState(); // signIn 상태로 설정
    });

    // 페이지 로드 시 signIn 상태로 설정
    setSignInState();
});
*/