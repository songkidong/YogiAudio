<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>a.jsp</title>
<script>
	var popup;

	function openB() {
		popup = window.open('/test3', '_blank', 'width=400,height=300');
		popup.onload = function() {
			popup.addToList('새로운 항목');
		};
	}

	function sendDataToChild() {
		if (popup && !popup.closed) {
			popup.addToList('새로운 항목');
		} else {
			console.log("이거 보임?");
			alert('자식 창이 아직 열리지 않았거나 이미 닫혔습니다. 자식 창을 다시 열었습니다.');
			popup = window.open('/test3', '_blank', 'width=400,height=300');
		}
	}
</script>
</head>
<body>
	<button onclick="openB()">b.jsp 열기</button>
	<button onclick="sendDataToChild()">자식 창에 데이터 전송</button>
</body>
</html>
