<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Popup Unblock Example</title>
</head>
<body>

<button onclick="openPopup()">팝업 열기</button>

<script>
function openPopup() {
    // 팝업 차단 해제 여부를 확인
    if (window.confirm("팝업 차단을 해제하고 팝업을 열까요?")) {
        // 사용자가 확인을 클릭하면 팝업 창 열기
        var popupWindow = window.open("/test", "popupWindow", "width=400,height=300");
        if (!popupWindow || popupWindow.closed || typeof popupWindow.closed === 'undefined') {
            // 팝업 차단이 되었거나 사용자가 팝업 차단을 취소한 경우
            alert("팝업 차단이 활성화되어 있습니다.");
        }
    }
}
</script>

</body>
</html>

