
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
</style>
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

			<div class="ui-actions">
				<i class="fas fa-list-ul"></i> <img alt=""
					src="/img/music_like/unlike.png" id="heart"> <i
					class="fas fa-plus"></i>
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
				<button type="button" class="my-music-close">MyMusic 닫기</button>
				<button type="button" class="my-music-open">MyMusic 열기</button>
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
						data-music-title="${play.musicTitle}"
						data-music-singer="${play.musicSinger}">${play.musicTitle}-
						${play.musicSinger}<span class="delete-btn">❌</span>
					</div>
				</c:forEach>
			</div>
			<div class="my-music-container" id="myMusicContainer">
				<p>여기에는 플레이리스트가 들어갑니다.</p>
			</div>
		</div>
	</main>
	<script>
		var userId = '${principal.id}';
	</script>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			document.querySelector(".my-music-close").addEventListener(
					"click",
					function() {
						document.getElementById("myMusicContainer").classList
								.remove("active");
					});

			document.querySelector(".my-music-open").addEventListener(
					"click",
					function() {
						document.getElementById("myMusicContainer").classList
								.add("active");
						// 1. ajax로 playlist 조회 - data 나온 값으로 플레이리스트에 추가.
						// 2. 클릭 이벤트 시 addPlaylistItem에 추가하기
						// addPlaylistItem(data, type)
						addPlaylistItem();
					});
		});
		
		
		// 플레이리스트에 노래 추가
//		function addPlaylistItem(data, type) {
		function addPlaylistItem() {
			// ajax로 플레이리스트 추가함
			
			// 플레이리스트 아이템 생성
			const playlistItem = document.createElement('div');
			playlistItem.classList.add('my-music-container-item');
/* 			playlistItem.setAttribute('data-lyrics', data.lyrics);
			playlistItem.setAttribute('data-order-index', data.orderIndex);
			playlistItem.setAttribute('data-playlist-name', data.playlistName);
			playlistItem.setAttribute('data-music-no', data.musicNo);
			playlistItem.setAttribute('data-file-img', data.filepath);
			playlistItem.setAttribute('data-file-music', data.filemusic);
			playlistItem.setAttribute('data-music-title', data.musictitle);
			playlistItem.setAttribute('data-music-singer', data.musicsinger);
			playlistItem.textContent = data.musictitle + '- ' + data.musicsinger; */
			playlistItem.textContent = '안녕하세요 - 여기입니다';
			// playlist배열에 추가
			// 삭제 버튼 생성
			const deleteButton = document.createElement('span');
			deleteButton.classList.add('delete-btn');
			deleteButton.textContent = '❌';
/*			deleteButton.addEventListener('click', function() {
				const index = playListItems.indexOf(playlistItem);
				console.log('Deleted item index:', index);
				//ajax로 playlistname, musicno, index 넘겨주면 playlist 조회 후 해당 id로 playlist_order 삭제하기
 				$.ajax({
					type: "POST",
					url: "/deletePlayList",
					data: JSON.stringify({
						playlistName: data.playlistName,
						musicNo: data.musicNo,
						orderIndex: data.orderIndex
					}), // JSON 형식의 데이터
					contentType: "application/json",  // 데이터 형식을 JSON으로 명시한다.
					success: function(data) {
						// 추가한 노래 playlist에 추가
						console.log(data);
						alert(data);
					},
					error: function(XMLHttpRequest, textStatus, errorThrown) {
						alert("통신 실패.")
					}
				});
				playlistItem.remove();
				playListItems.splice(index, 1);
			}); */

			// 플레이리스트 아이템에 삭제 버튼 추가
			playlistItem.appendChild(deleteButton);

			// 플레이리스트에 아이템 추가
			document.querySelector('.my-music-container').appendChild(playlistItem);

/* 			// 새로 추가된 아이템에 클릭 이벤트 추가
			playlistItem.addEventListener('click', function() {
				const lyrics = this.getAttribute('data-lyrics');
				const musicNo = this.getAttribute('data-music-no');
				const musicUrl = this.getAttribute('data-file-music');
				const musicTitle = this.getAttribute('data-music-title');
				const musicSinger = this.getAttribute('data-music-singer');
				const albumImg = this.getAttribute('data-file-img');

				setCurrentMusic(albumImg, lyrics, musicTitle, musicSinger, musicUrl, musicNo);
			}); */
		}
	</script>
</body>
</html>