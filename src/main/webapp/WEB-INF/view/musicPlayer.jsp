
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
.my-music-container {
	display: none;
	position: absolute;
	top: 15%;
	left: 0;
	width: 100%; /* 부모 요소인 .container의 가로 폭을 따라갈 수 있도록 설정 */
	height: 85%; /* .ui-list와 동일한 높이로 설정 */
	background-color: #e0e0e0;
	z-index: 2;
	overflow-y: auto;
	padding: 10px;
}

.my-music-container.active {
	display: block;
}

.my-music-container-item {
	padding: 5px;
	border-bottom: 1px solid #ccc;
}

.my-music-container-item:last-child {
	border-bottom: none; /* 마지막 아이템의 하단 테두리 제거 */
}

.playing-music {
	color: blue; /* 파란색 */
	font-weight: bold; /* 굵은 글꼴 */
	margin-left: 5px; /* 아이콘과 텍스트 사이의 간격 조절 */
}

.playing-music::before {
	content: "\1F3B5"; /* 음악 노트 아이콘 */
	font-family: "Font Awesome 5 Free"; /* Font Awesome 폰트 패밀리 */
	margin-right: 5px; /* 아이콘과 텍스트 사이의 간격 조절 */
}

.highlight {
	color: white; /* 글씨 색상을 하얀색으로 지정합니다. */
}

.dropdown-content {
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	top: 100%;
	left: 0;
	width: auto; /* 너비를 자동으로 설정 */
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	padding: 8px 0px;
	z-index: 1;
	user-select: none;
}

.dropdown {
	width: 40px; /* 버튼의 가로 크기 조정 */
	height: 40px; /* 버튼의 세로 크기 조정 */
	border-radius: 50%; /* 동그라미 모양으로 만듦 */
	display: flex;
	justify-content: center;
	align-items: center;
	background-color: #ccc; /* 버튼 배경색 지정 */
	cursor: pointer; /* 마우스 커서를 포인터로 변경하여 클릭 가능성을 나타냄 */
	position: relative; /* 부모 요소로부터의 상대 위치 지정 */
}

.dropdown-content a {
	/* 기존 스타일 유지 */
	text-decoration: none; /* 기본 링크 표시 스타일 제거 */
	color: black; /* 링크 텍스트 색상 지정 */
	padding: 5px 13px; /* 각 항목의 여백 설정 */
	white-space: nowrap; /* 텍스트가 줄 바꿈되지 않도록 설정 */
}
</style>
</head>
<body>
	<main>
		<div class="ui">
			<div class="ui-toolbar">
				<div>
					<!-- 추후 다른 버튼 -->
				</div>
				<div class="dropdown">
					<i class="fas fa-ellipsis-v"></i>
					<div class="dropdown-content">
						<div>
							<a href="#">다운로드</a>
						</div>
						<div>
							<a href="#">담기</a>
						</div>
						<div>
							<a href="#">곡정보</a>
						</div>
					</div>
				</div>
			</div>

			<div class="ui-actions">
				<i class="fas fa-list-ul"></i> <img alt=""
					src="/img/music_like/unlike.png" id="heart"> <i
					class="fas fa-plus" id="add-playlist"></i>
			</div>

			<div class="ui-cover">
				<!-- Icon made by Freepik (https://www.freepik.com) -->
				<img class="ui-cover-art" src="">
				<div class="ui-cover-title">
					<p>Halsey</p>
					<p>Without Me</p>
				</div>
			</div>
			<!-- 가사 위치 -->
			<div id="lyrics-container">
				<div id="mCSB_1_container" class="mCSB_container"
					style="position: relative; top: -1px; left: 0px;" dir="ltr">
				</div>
			</div>

			<div class="ui-seekbar">
				<input type="range" class="ui-slider" min="1" max="1200" value="0">
				<span id="currentTime">0:00</span> / <span id="totalDuration">0:00</span>
			</div>
			<div class="ui-controls">
				<i class="fas fa-random disabled"></i> <img class="fas fa-redo"
					src="img/musicPlayer/repeat-all.png" /> <i
					class="fas fa-step-backward"></i> <i class="fas fa-pause"></i> <i
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
				<p>유저 정보 들어가는 곳</p>
			</div>
			<div class="ui-music-btn">
				<button type="button" class="my-music-close" id="my-music-close">MyMusic
					닫기</button>
				<button type="button" class="my-music-open" id="my-music-open">MyMusic
					열기</button>
				<br>
				<button type="button" id="deleteDuplicate">중복곡 삭제</button>
			</div>
			<div class="ui-list">
				<c:forEach var="play" items="${playList}">
					<div class="ui-list-item" data-order-index="${play.orderIndex}"
						data-playlist-name="${play.playlistName}"
						data-lyrics="${fn:escapeXml(play.lyrics)}"
						data-file-img="${play.filePath}" data-music-no="${play.musicNo}"
						data-file-music="${play.fileMusic}"
						data-music-sample="${play.musicSample}"
						data-music-title="${play.musicTitle}"
						data-music-singer="${play.musicSinger}">${play.musicTitle}-
						${play.musicSinger} <span class="delete-btn">❌</span> 
						<span class="add-btn">➕</span>
						<span class="download-music">다운로드</span>
					</div>
				</c:forEach>
			</div>
			<div class="my-music-container" id="myMusicContainer">
				<p>플레이리스트</p>
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
	<script>
		document.addEventListener("DOMContentLoaded",
				function() {
					const dropdown = document.querySelector('.dropdown');
					const dropdownContent = dropdown
							.querySelector('.dropdown-content');

					dropdownContent.style.display = 'none'; // 페이지 로드시 숨김

					dropdown.addEventListener('click', function() {
						if (dropdownContent.style.display === 'none') {
							dropdownContent.style.display = 'block';
						} else {
							dropdownContent.style.display = 'none';
						}
					});
				});
	</script>
</body>
</html>