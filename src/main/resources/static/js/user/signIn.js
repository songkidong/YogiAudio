document.addEventListener("DOMContentLoaded", function() {
    let signup = document.querySelector(".links li #signup");
    let signin = document.querySelector(".links li #signin");
    let reset = document.querySelector(".links li #reset");
    let first_input = document.querySelector("form .first-input");
    let hidden_input = document.querySelector("form .input__block #repeat__password");
    let signin_btn = document.querySelector("form .signin__btn");

    //----------- sign up ---------------------
    signup.addEventListener("click", function(e) {
        e.preventDefault();
        this.parentElement.parentElement.previousElementSibling.innerText = "SIGN UP";
        this.parentElement.style.opacity = "1";
        Array.from(this.parentElement.parentElement.children).forEach(function(item) {
            item.style.opacity = ".6";
        });
        first_input.classList.remove("first-input__block");
        first_input.classList.add("signup-input__block");
        hidden_input.style.opacity = "1";
        hidden_input.style.display = "block";
        signin_btn.innerText = "Sign up";
    });

    //----------- sign in ---------------------
    signin.addEventListener("click", function(e) {
        e.preventDefault();
        this.parentElement.parentElement.previousElementSibling.innerText = "SIGN IN";
        this.parentElement.style.opacity = "1";
        Array.from(this.parentElement.parentElement.children).forEach(function(item) {
            item.style.opacity = ".6";
        });
        first_input.classList.add("first-input__block");
        first_input.classList.remove("signup-input__block");
        hidden_input.style.opacity = "0";
        hidden_input.style.display = "none";
        signin_btn.innerText = "Sign in";
    });

    //----------- reset ---------------------
    reset.addEventListener("click", function(e) {
        e.preventDefault();
        Array.from(this.parentElement.parentElement.nextElementSibling.querySelectorAll(".input__block .input")).forEach(function(item) {
            item.value = "";
        });
    });
});
