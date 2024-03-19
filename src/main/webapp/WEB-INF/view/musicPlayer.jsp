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
</head>
<body>
	<main>
		<div class="ui">
			<div class="ui-toolbar">
				<i class="fas fa-chevron-down"></i>

				<div>
					<i class="fas fa-ellipsis-v"></i>
				</div>
			</div>

			<div class="ui-cover">
				<!-- Icon made by Freepik (https://www.freepik.com) -->
				<img class="ui-cover-art" src="">
				<div class="ui-cover-title">
					<p>Halsey</p>
					<p>Without Me</p>
				</div>
			</div>

			<div class="ui-actions">
				<i class="fas fa-list-ul"></i> 
				<img alt="" src="/img/music_like/unlike.png" id="heart">
				<i class="fas fa-plus"></i>
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
				<i class="fas fa-random"></i> <i class="fas fa-redo"></i> <i
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
			<div class="ui-list">
				<c:forEach var="play" items="${playList}">
					<div class="ui-list-item" data-order-index="${play.orderIndex}"
						data-playlist-name="${play.playlistName}"
						data-lyrics="${fn:escapeXml(play.lyrics)}"
						data-file-img="${play.filePath}" data-music-no="${play.musicNo}"
						data-file-music="${play.fileMusic}"
						data-music-title="${play.musicTitle}"
						data-music-singer="${play.musicSinger}">${play.musicTitle}-
						${play.musicSinger}<span class="delete-btn">❌</span>
					</div>
				</c:forEach>
			</div>
		</div>
	</main>
	<script>
		var userId = '${principal.id}';
	</script>
</body>
</html>