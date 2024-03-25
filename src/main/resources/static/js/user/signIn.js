$(document).ready(function() {
    $('.signin__btn').click(function(event) {
        event.preventDefault(); // 기본 동작 방지

        var email = $('#email').val();
        var password = $('#password').val();

        $.ajax({
            type: 'POST',
            url: '/signIn', // 로그인 처리를 담당하는 URL로 설정해주세요.
            data: {
                email: email,
                password: password
            },
            success: function(response) {
                window.location.href = '/product/main'; 
            },
            error: function(xhr, status, error) {
                   if (xhr.status === 400) {
            var errorMessage = xhr.responseText; // 서버에서 받은 오류 메시지
            alert(errorMessage); // 오류 메시지를 알림창으로 표시
        }
            }
        });
    });
});
/* reset 버튼 */
$(document).ready(function() {
    // Reset 버튼 클릭 이벤트 처리
    $('#reset').click(function(e) {
        e.preventDefault(); // 버튼 클릭 시 기본 동작 방지

        // 폼 안의 내용들을 모두 초기화
        $('#email').val('');
        $('#password').val('');
    });
});
