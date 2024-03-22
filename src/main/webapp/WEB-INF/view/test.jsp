<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Music Detail</title>
</head>
<body>

	<h2>Now Playing: Song Title</h2>


	<button id="addBtn" type="button"  class="addPlayerBtn">Add to Playlist</button>
	<button id="playBtn" type="button"  class="playBtn">Play Music</button>
	<button id="musicBtn" type="button">Music Player</button>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // 세션 스토리지에서 창이 열렸는지 확인
    var isPlayerWindowOpen = sessionStorage.getItem("isPlayerWindowOpen");
    if (!isPlayerWindowOpen) {
        // 창이 열리지 않은 경우, 부모 창에서 다시 열기
        var parentWindow = window.opener;
        parentWindow.document.getElementById('openChildBtn').click();
    }
});
</script>
	<script src="js/playlist/playlist.js"></script>
</body>
</html>