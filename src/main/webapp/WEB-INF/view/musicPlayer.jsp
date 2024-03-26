<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/playlist/musicPlayer.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="/js/playlist/musicPlayer.js"></script>
<style>
#logo {
	width: 120px;
	height: auto;
	cursor: pointer;
	margin-top: 5px;
}
</style>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
	<main>
		<div class="ui">
			<div class="ui-toolbar">
				<div>
					<img alt="" src="/logo/logo1.png" id="logo">
				</div>
			</div>

			<div class="ui-actions">
				<img alt="" src="/img/music_like/unlike_white.png" id="heart">
				<div class="dropdown">
					<i class="fas fa-ellipsis-v"></i>
					<div class="dropdown-content">
						<div>
							<a href="#" id=download>다운로드</a>
						</div>
						<div>
							<a href="#" id=musicInfo>곡정보</a>
						</div>
						<div>
							<a href="#" id=addPlaylist>플레이리스트에 추가</a>
						</div>
					</div>
				</div>
			</div>

			<div class="ui-cover">
				<!-- Icon made by Freepik (https://www.freepik.com) -->
				<div class="ui-cover-title">
					<p>Halsey</p>
					<p>Without Me</p>
				</div>
				<img class="ui-cover-art" src="">
			</div>
			<!-- 가사 위치 -->
			<div id="lyrics-container">
				<div id="mCSB_1_container" class="mCSB_container"
					style="position: relative; top: -1px; left: 0px;" dir="ltr">
				</div>
			</div>

			<div class="ui-seekbar">
				<input type="range" class="ui-slider" min="1" max="1200" value="0">
				<span id="currentTime">0:00</span><span id="totalDuration">0:00</span>
			</div>
			<div class="ui-controls">
				<i class="fas fa-random disabled"></i>
				<div class="redo"></div>
				<i class="fas fa-step-backward"></i> <i class="fas fa-pause"></i> <i
					class="fas fa-step-forward"></i>
				<div id="volumeContainer">
					<i class="fas fa-volume-up" id="volumeIcon"> </i> <input
						type="range" id="volumeSlider" min="0" max="1" step="0.01"
						value="0.3">
				</div>
				<i class="fas fa-align-right"></i>
			</div>
		</div>
		<div class="container">
			<div class="ui-user">
				<c:if test="${not empty principal.nickname}">
					<p>${principal.nickname}님</p>
				</c:if>
			</div>
			<div class="ui-music-btn">
				<button type="button" class="my-music-close" id="my-music-close">MyMusic
					닫기</button>
				<button type="button" class="my-music-open" id="my-music-open">MyMusic
					열기</button>
			</div>
			<div class="ui-list">
				<button type="button" id="deleteDuplicate">중복곡 삭제</button>
				<hr>
				<c:forEach var="play" items="${playList}">
					<div class="ui-list-item" data-order-index="${play.orderIndex}"
						data-playlist-name="${play.playlistName}"
						data-lyrics="${fn:escapeXml(play.lyrics)}"
						data-file-img="${play.filePath}" data-music-no="${play.musicNo}"
						data-file-music="${play.fileMusic}"
						data-music-sample="${play.musicSample}"
						data-music-title="${play.musicTitle}"
						data-music-major="${play.musicMajor}"
						data-music-singer="${play.musicSinger}">
						${play.musicTitle}- ${play.musicSinger} <span class="add-btn">
							<img alt="" src="/img/musicPlayer/add-playlist.png"
							class="add-playlist">
						</span> <span class="download-music"> <img alt=""
							src="/img/musicPlayer/download.png" class="download-icon">
						</span> <span class="delete-btn"> <img alt=""
							src="/img/musicPlayer/close.png" class="close-icon">
						</span>
					</div>
				</c:forEach>
			</div>
			<div class="my-music-container" id="myMusicContainer">
				<div class="playlistName">
					<img alt="" src="/img/musicPlayer/playlist-icon.png"
						class="playlist-icon">
					<p>플레이리스트</p>
					<hr>
				</div>
			</div>
		</div>
	</main>
	<script>
		var userId = '${principal.id}';
		var payment_yn = '${principal.status}';
		if (payment_yn !== null) {
			if (payment_yn === 'N') {
				payment_yn = null;
			}
		}
	</script>
</body>
</html>