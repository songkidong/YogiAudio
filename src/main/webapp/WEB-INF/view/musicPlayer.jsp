<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@import
	url('https://fonts.googleapis.com/css?family=Prompt&display=swap');

@import url('https://use.fontawesome.com/releases/v5.6.3/css/solid.css')
	;

@import
	url('https://use.fontawesome.com/releases/v5.6.3/css/fontawesome.css');

* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	background: #001133;
	font-family: 'Prompt', sans-serif;
	-webkit-tap-highlight-color: transparent;
}

main {
	display: flex;
	align-items: center;
	justify-content: center; /* 수정된 부분 */
	width: 100vw;
	height: 100vh;
	flex-direction: column; /* 수정된 부분 */
}

@media ( min-width : 600px) {
	main {
		flex-direction: row; /* 가로 방향으로 정렬 */
	}
}

.ui {
	width: 280px;
	height: 500px;
	padding: 5px 15px;
	border-radius: 4px;
	background: linear-gradient(45deg, #d2dfed 0%, #c8d7eb 26%, #bed0ea 51%, #a6c0e3 51%
		, #afc7e8 62%, #bad0ef 75%, #99b5db 88%, #799bc8 100%);
}

.ui-toolbar {
	height: 10%;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.ui-cover {
	height: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
}

.ui-cover-art {
	width: 120px;
}

.ui-cover-title {
	text-align: center;
}

.ui-actions {
	height: 15%;
	display: flex;
	align-items: center;
	justify-content: space-evenly;
}

.ui-seekbar {
	height: 10%;
	text-align: center;
}

.ui-seekbar .ui-slider {
	width: 100%;
	height: 6px;
	border-radius: 8px;
	-webkit-appearance: none;
	appearance: none;
	outline: none;
	box-shadow: 0 0 3px rgba(0, 0, 0, .6);
	background: #FFF;
}

.ui-seekbar .ui-slider::-webkit-slider-thumb {
	-webkit-appearance: none;
	appearance: none;
	width: 14px;
	height: 14px;
	border-radius: 50%;
	background: #09F;
	cursor: pointer;
}

.ui-controls {
	height: 15%;
	display: flex;
	align-items: center;
	justify-content: space-evenly;
}
/* 추가된 부분 시작 */
.ui-list {
	background-color: #e0e0e0;
	padding: 10px;
	height: 90%;
	overflow-y: auto;
}

.ui-list-item {
	padding: 5px;
	border-bottom: 1px solid #ccc;
}

.ui-list-item:last-child {
	border-bottom: none; /* 마지막 아이템의 하단 테두리 제거 */
}

.ui-user {
	background-color: #ffffff;
	height: 10%;
}

.container {
	width: 50%;
	height: 500px;
}
/* 추가된 부분 끝 */
</style>
<script>
document.addEventListener('DOMContentLoaded', function () {
/* 	var AudioContext;
	var audioContext;

	window.onload = function() {
	    navigator.mediaDevices.getUserMedia({ audio: true }).then(() => {
	        AudioContext = window.AudioContext || window.webkitAudioContext;
	        audioContext = new AudioContext();
	    }).catch(e => {
	        console.error(`Audio permissions denied: ${e}`);
	    });
	} */
	
	const audioPlayer = new Audio();
	 // 슬라이더 요소 가져오기
    const seekbar = document.querySelector('.ui-slider');
    
    // 슬라이더의 최대값 설정
    const seekbarMax = seekbar.max;
    
    // 오디오가 로드될 때마다 슬라이더 최대값 설정
    audioPlayer.onloadedmetadata = function() {
        seekbar.max = parseInt(audioPlayer.duration); // 노래의 길이를 초 단위로 설정
    };
    
    // 1초마다 슬라이더 위치 변경
    setInterval(() => {
        // 현재 슬라이더 위치 가져오기
        let position = parseInt(audioPlayer.currentTime);
        
        if (position <= seekbarMax) {
            seekbar.value = position;
        } else {
            // 최대값에 도달하면 위치를 0으로 초기화
            seekbar.value = 0;
        }
    }, 100);
	
	
	// audioPlayer.autoplay = true;
    const playListItems = document.querySelectorAll('.ui-list-item');
    
 // 현재 재생 중인 곡의 인덱스를 저장하는 변수
    let currentSongIndex = 0;

    // forEach를 사용하여 각 곡 요소에 이벤트 리스너를 추가합니다.
    playListItems.forEach((item, index) => {
        item.addEventListener('click', function() {
            console.log("클릭됨");
            // 클릭한 곡의 정보 가져오기
            const musicUrl = this.getAttribute('data-file-music');
            const musicTitle = this.getAttribute('data-music-title');
            const musicSinger = this.getAttribute('data-music-singer');
            const albumImg = this.getAttribute('data-file-img');

            // 현재 재생 중인 곡의 순서를 업데이트
            currentSongIndex = index;
            console.log(currentSongIndex);

            // 현재 재생 중인 곡 정보 업데이트
            document.querySelector('.ui-cover-title').innerHTML = "<p>" + musicTitle + "</p>" + "<p>" + musicSinger + "</p>" + "<img alt='' src='" + albumImg + "'>";
            // 오디오 소스 변경 및 재생
            audioPlayer.src = musicUrl;
            audioPlayer.play();
            console.log(audioPlayer.duration);
        });
    });

    // 현재 재생 중인 곡의 인덱스를 반환하는 함수
    function getCurrentSongIndex() {
        return currentSongIndex;
    }
    
    const playController = document.querySelector('.ui-controls');
    playController.addEventListener('click', function(e) {
        if (e.target.classList.contains('fa-pause')) {
            console.log("정지됨");
            e.target.classList.remove('fa-pause');
            e.target.classList.add('fa-play');
            audioPlayer.pause();
        }
        else if (e.target.classList.contains('fa-play')) {
            console.log("재생됨");
            e.target.classList.remove('fa-play');
            e.target.classList.add('fa-pause');
            audioPlayer.play();
        }
        if (e.target.classList.contains('fa-step-forward')) {
            console.log("앞으로");
            playNextSong(); // 다음 곡으로 넘어감
        }
        if (e.target.classList.contains('fa-step-backward')) {
            console.log("뒤로");
            playPreviousSong();
        }
    });
    
    const firstMusicUrl = playListItems[0].getAttribute('data-file-music');
    const firstMusicTitle = playListItems[0].getAttribute('data-music-title');
    const firstMusicSinger = playListItems[0].getAttribute('data-music-singer');
    const firstAlbumImg = playListItems[0].getAttribute('data-file-img');
    document.querySelector('.ui-cover-title').innerHTML = "<p>" + firstMusicTitle + "</p>" + "<p>" + firstMusicSinger + "</p>" + "<img alt='' src='" + firstAlbumImg + "'>";
    audioPlayer.src = firstMusicUrl;
    audioPlayer.play();
    console.log(audioPlayer.duration);
    
 // 다음 곡으로 넘어가는 함수
function playNextSong() {
    // 현재 재생 중인 곡의 인덱스를 증가시킴
    currentSongIndex++;
    // 재생 목록의 끝에 도달하면 처음 곡으로 돌아감
    if (currentSongIndex >= playListItems.length) {
        currentSongIndex = 0;
    }
    // 현재 곡의 인덱스를 기반으로 해당 곡을 재생
    playListItems[currentSongIndex].click();
}

// 이전 곡으로 돌아가는 함수
function playPreviousSong() {
    // 현재 재생 중인 곡의 인덱스를 감소시킴
    currentSongIndex--;
    // 재생 목록의 처음에 도달하면 마지막 곡으로 이동
    if (currentSongIndex < 0) {
        currentSongIndex = playListItems.length - 1;
    }
    // 현재 곡의 인덱스를 기반으로 해당 곡을 재생
    playListItems[currentSongIndex].click();
}
});
</script>
</head>
<body>
	<main>
		<div class="ui">
			<div class="ui-toolbar">
				<i class="fas fa-chevron-down"></i>

				<div>
					<i class="fas fa-volume-up"></i> <i class="fas fa-ellipsis-v"></i>
				</div>
			</div>

			<div class="ui-cover">
				<!-- Icon made by Freepik (https://www.freepik.com) -->
				<svg class="ui-cover-art" height="511pt"
					viewBox="1 -12 511.99976 511" width="511pt"
					xmlns="http://www.w3.org/2000/svg">
					<path
						d="m481.472656 256.59375-225.378906 225.378906c-7.027344 7.027344-18.417969 7.027344-25.445312 0l-225.378907-225.378906c-7.027343-7.027344-7.027343-18.417969 0-25.445312l225.378907-225.378907c7.027343-7.027343 18.417968-7.027343 25.445312 0l225.378906 225.378907c7.027344 7.027343 7.027344 18.417968 0 25.445312zm0 0"
						fill="#fab700" />
					<path
						d="m230.277344 6.140625-33.238282 33.238281 226.527344 226.527344c3.714844 3.714844 3.714844 9.738281 0 13.453125l-197.765625 197.765625 4.476563 4.476562c7.230468 7.230469 18.957031 7.230469 26.1875 0l224.636718-224.636718c7.234376-7.230469 7.234376-18.957032 0-26.1875l-224.636718-224.636719c-7.230469-7.230469-18.957032-7.230469-26.1875 0zm0 0"
						fill="#faa200" />
					<path
						d="m512 252.789062c0 102.949219-83.457031 186.402344-186.40625 186.402344-102.945312 0-186.402344-83.453125-186.402344-186.402344 0-102.949218 83.457032-186.40625 186.402344-186.40625 102.949219 0 186.40625 83.457032 186.40625 186.40625zm0 0"
						fill="#682c54" />
					<path
						d="m325.59375 66.382812c-7.027344 0-13.957031.40625-20.785156 1.160157 93.164062 10.339843 165.617187 89.324219 165.617187 185.246093 0 95.921876-72.453125 174.90625-165.617187 185.246094 6.828125.757813 13.757812 1.160156 20.785156 1.160156 102.949219 0 186.40625-83.457031 186.40625-186.40625 0-102.945312-83.457031-186.40625-186.40625-186.40625zm0 0"
						fill="#542a48" />
					<path
						d="m325.59375 66.382812c-102.945312 0-186.402344 83.457032-186.402344 186.40625 0 34.3125 9.28125 66.453126 25.457032 94.070313l255.015624-255.019531c-27.613281-16.171875-59.753906-25.457032-94.070312-25.457032zm0 0"
						fill="#723661" />
					<path
						d="m402.570312 108.933594 17.09375-17.09375c-27.613281-16.171875-59.753906-25.453125-94.070312-25.453125-7.027344 0-13.957031.402343-20.785156 1.160156 36.910156 4.09375 70.574218 18.953125 97.761718 41.386719zm0 0"
						fill="#682c54" />
					<path
						d="m418.285156 252.789062c0 51.191407-41.5 92.6875-92.691406 92.6875-51.1875 0-92.6875-41.496093-92.6875-92.6875 0-51.191406 41.5-92.691406 92.6875-92.691406 51.191406 0 92.691406 41.5 92.691406 92.691406zm0 0"
						fill="#542a48" />
					<path
						d="m389.765625 252.789062c0 35.441407-28.730469 64.167969-64.171875 64.167969-35.4375 0-64.167969-28.726562-64.167969-64.167969 0-35.441406 28.730469-64.171874 64.167969-64.171874 35.441406 0 64.171875 28.730468 64.171875 64.171874zm0 0"
						fill="#ff6914" />
					<path
						d="m338.429688 252.789062c0 7.089844-5.746094 12.835938-12.835938 12.835938-7.085938 0-12.832031-5.746094-12.832031-12.835938 0-7.089843 5.746093-12.835937 12.832031-12.835937 7.089844 0 12.835938 5.746094 12.835938 12.835937zm0 0"
						fill="#005ca0" /></svg>
				<div class="ui-cover-title">
					<p>Halsey</p>
					<p>Without Me</p>
				</div>
			</div>

			<div class="ui-actions">
				<i class="fas fa-list-ul"></i> <i class="fas fa-heart"></i> <i
					class="fas fa-plus"></i>
			</div>

			<div class="ui-seekbar">
				<input type="range" class="ui-slider" min="1" max="1200" value="0">
			</div>

			<div class="ui-controls">
				<i class="fas fa-random"></i> <i class="fas fa-step-backward"></i> 
				<i class="fas fa-pause"></i> <i class="fas fa-step-forward"></i> <i
					class="fas fa-redo"></i>
			</div>
		</div>
		<div class="container">
			<div class="ui-user">
				<p>유저 정보 들어가는 곳</p>
			</div>
			<div class="ui-list">
				<c:forEach var="play" items="${playList}">
					<div class="ui-list-item" data-file-img="${play.filePath}"
						data-file-music="${play.fileMusic}"
						data-music-title="${play.musicTitle}"
						data-music-singer="${play.musicSinger}">${play.musicTitle} -
						${play.musicSinger}</div>
				</c:forEach>
			</div>
		</div>
	</main>
</body>
</html>