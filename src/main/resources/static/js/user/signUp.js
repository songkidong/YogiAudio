function sendEmail() {
    var email = document.getElementById("email").value;
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "/sendEmail/" + email, true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                console.log("이메일이 성공적으로 전송되었습니다.");
            } else {
                console.error("이메일 전송에 실패했습니다.");
            }
        }
    };
    xhr.send();
}
