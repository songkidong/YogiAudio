<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Music Detail</title>
</head>
<body>

	<h2>Now Playing: Song Title</h2>

	<button onclick="sendDataToChild()">Add to Playlist</button>
	<button onclick="playMusic()">Play Music</button>

	<script>
		var playerWindow; // 변수를 전역으로 선언하여 창의 상태를 유지합니다.
		function playMusic() {
			// 이미 열려 있는 musicPlayer.jsp 창이 있는지 확인
			if (!playerWindow || playerWindow.closed) {
				// 창이 없거나 닫혀 있으면 새로 열기
				playerWindow = window.open('/musicPlayer', '_blank',
						'width=1000,height=700');
			} else {
				// 이미 열려 있는 창이 있으면 해당 창을 활용
				playerWindow.focus();
			}
		}
		function sendDataToChild() {
			if (playerWindow && !playerWindow.closed) {
				console.log("최장호");
				const dataToSend = {
					musicNo : 1,
					userId : 1,
					playlistName : "플레이어",
				};
				playerWindow.postMessage(dataToSend, '*'); // 데이터를 자식 창으로 전달
			} else {
				alert('자식 창이 아직 열리지 않았거나 이미 닫혔습니다. 자식 창을 다시 열었습니다.');
				playerWindow = window.open('/musicPlayer', '_blank',
						'width=1000,height=700');
				// setTimeout을 사용하여 자식 창이 열린 후에 postMessage 호출
				setTimeout(function() {
					const dataToSend = {
						musicNo : 1,
						userId : 1,
						playlistName : "플레이어",
					};
					playerWindow.postMessage(dataToSend, '*'); // 데이터를 자식 창으로 전달
				}, 100); // 1초 후에 호출하도록 설정 (필요에 따라 시간 조정 가능)
			}
		}
	</script>

</body>
</html>