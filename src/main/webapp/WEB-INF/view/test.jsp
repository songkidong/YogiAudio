<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Music Detail</title>
</head>
<body>

<h2>Now Playing: Song Title</h2>

<button onclick="addToPlaylist()">Add to Playlist</button>
<button onclick="playMusic()">Play Music</button>

<script>
	var playerWindow; // 변수를 전역으로 선언하여 창의 상태를 유지합니다.
    function addToPlaylist() {
        // 여기에 노래를 플레이리스트에 추가하는 로직을 작성
        alert('Song added to your playlist!');
    }

    function playMusic() {
        // 이미 열려 있는 musicPlayer.jsp 창이 있는지 확인
        if (!playerWindow || playerWindow.closed) {
            // 창이 없거나 닫혀 있으면 새로 열기
            playerWindow = window.open('/musicPlayer', '_blank', 'width=1000,height=700');
        } else {
            // 이미 열려 있는 창이 있으면 해당 창을 활용
            playerWindow.focus();
        }
    }
</script>

</body>
</html>