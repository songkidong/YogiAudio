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
#volumeContainer {
    position: relative;
}

#volumeSlider {
    position: absolute;
    top: 0; /* 아이콘 위에 위치 */
    left: 0;
    width: 70px;
    display: none; /* 초기에는 볼륨 슬라이더 숨김 */
}

#volumeContainer:hover #volumeSlider {
    display: inline-block; /* 볼륨 아이콘에 마우스를 가져다 대면 볼륨 슬라이더 표시 */
}
/* 추가된 부분 끝 */
</style>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function () {
	
	const audioPlayer = new Audio();
	
    // 슬라이더 요소 가져오기
    const seekbar = document.querySelector('.ui-slider');
    
    // 슬라이더의 최대값 설정
    const seekbarMax = seekbar.max;
    
    // 오디오가 로드될 때마다 슬라이더 최대값 설정
    audioPlayer.onloadedmetadata = function() {
        seekbar.max = parseInt(audioPlayer.duration); // 노래의 길이를 초 단위로 설정
    };
    
	// 볼륨 조절
	var volumeSlider = document.getElementById("volumeSlider");
	var previousVolume; // 음소거 이전 볼륨값
    volumeSlider.addEventListener("input", function() {
        // 볼륨 슬라이더의 현재 값 가져오기
        var volume = volumeSlider.value;
        // 음소거 해제
        if (volume > 0 && isMuted) {
            volumeIcon.classList.remove("fa-volume-mute");
            volumeIcon.classList.add("fa-volume-up");
            isMuted = false;
        } 
        // 음원의 볼륨 설정
        audioPlayer.volume = volume;
        previousVolume = volume;
        // 볼륨이 0인 경우 음소거
        if (volume == 0) {
            volumeIcon.classList.remove("fa-volume-up");
            volumeIcon.classList.add("fa-volume-mute");
            isMuted = true;
        }
    });
    const volumeIcon = document.getElementById("volumeIcon");
    let isMuted = false;
    volumeIcon.addEventListener('click', function() {
    	// 음소거
    	if (isMuted == false) {
    		volumeIcon.classList.remove("fa-volume-up");
    		volumeIcon.classList.add("fa-volume-mute");
            audioPlayer.volume = 0;
            previousVolume = volumeSlider.value;
            volumeSlider.value = 0;
            isMuted = true;
        } else {
            // 음소거 해제
         	volumeIcon.classList.remove("fa-volume-mute");
         	volumeIcon.classList.add("fa-volume-up");
            audioPlayer.volume = previousVolume; // 현재 볼륨으로 설정
            volumeSlider.value = previousVolume;
            isMuted = false;
        }
    });
    
    var currentTimeDisplay = document.getElementById("currentTime");
    var totalDurationDisplay = document.getElementById("totalDuration");
    audioPlayer.addEventListener('timeupdate', function() {
        // 현재 재생 시간 가져오기
        var currentPlayTime = audioPlayer.currentTime;
        // 전체 재생 시간 가져오기
        var totalDuration = audioPlayer.duration;

        // 시간 표시 업데이트
        currentTimeDisplay.textContent = formatTime(currentPlayTime);
        totalDurationDisplay.textContent = formatTime(totalDuration);
    });

    // 시간 형식을 변환하는 함수
    function formatTime(time) {
        var minutes = Math.floor(time / 60);
        var seconds = Math.floor(time % 60);
        // 시간을 "분:초" 형식으로 반환
        return minutes + ':' + (seconds < 10 ? '0' : '') + seconds;
    }
    
    // 슬라이더 변경 이벤트 리스너 추가 -> 재생시간 변경될때마다 이벤트 발생
    seekbar.addEventListener('input', function() {
        const newPosition = parseInt(seekbar.value); // 변경된 위치 가져오기
        audioPlayer.currentTime = newPosition; // 오디오의 재생 위치 변경
    });
    
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
    
    // 노래 끝나면 다음 곡으로 넘어가는 이벤트리스너
    audioPlayer.addEventListener('ended', function() {
    	playNextSong();
    });
	
	// audioPlayer.autoplay = true;
   const playListItems = Array.from(document.querySelectorAll('.ui-list-item'));
    
    window.addEventListener('message', function(event) {
    	console.log(event.data);
    	console.log(event.data.type);
    	let type = event.data.type;
    	// ajax사용해서 playlist에 저장하기.
    	  $.ajax({
                type : "POST",           
                url : "/addPlayList",  
                data: JSON.stringify({ musicNo: event.data.musicNo }), // JSON 형식의 데이터
                contentType: "application/json",  // 데이터 형식을 JSON으로 명시한다.
                success : function(data){
                	// 추가한 노래 playlist에 추가
                    alert(data);
                    addPlaylistItem(data, type);
                },
                error : function(XMLHttpRequest, textStatus, errorThrown){
                    alert("통신 실패.")
                }
            });
    });
    
 	// 현재 재생 중인 곡의 인덱스를 저장하는 변수
    let currentSongIndex = 0;

    // forEach를 사용하여 각 곡 요소에 이벤트 리스너를 추가합니다.
    playListItems.forEach((item, index) => {
        item.addEventListener('click', function() {
            console.log("클릭됨");
            // 클릭한 곡의 정보 가져오기
            const orderIndex = this.getAttribute('data-order-index');
            const playlistName = this.getAttribute('data-playlist-name');
            const musinNo = this.getAttribute('data-music-no');
            const musicUrl = this.getAttribute('data-file-music');
            const musicTitle = this.getAttribute('data-music-title');
            const musicSinger = this.getAttribute('data-music-singer');
            const albumImg = this.getAttribute('data-file-img');

            // 현재 재생 중인 곡의 순서를 업데이트
            currentSongIndex = index;
            console.log(currentSongIndex);

            // 현재 재생 중인 곡 정보 업데이트
			    // 앨범 사진
		    const albumImage = document.querySelector('.ui-cover-art');
		    albumImage.src = albumImg;
			// 가수 세팅
            document.querySelector('.ui-cover-title').innerHTML = "<p>" + musicTitle + "</p>" + "<p>" + musicSinger + "</p>";
            // 오디오 소스 변경 및 재생
            audioPlayer.src = musicUrl;
            audioPlayer.play();
            console.log(audioPlayer.duration);
        });
        // 아이템의 삭제 버튼 클릭 이벤트 처리
        const deleteBtn = item.querySelector('.delete-btn');
        deleteBtn.addEventListener('click', function(event) {
            event.stopPropagation(); // 이벤트 전파 방지
            item.remove(); // 해당 아이템 삭제
    	    console.log('Deleted item index:', index);
    	    const playlistName = item.getAttribute('data-playlist-name'); // 플레이리스트 이름 가져오기
    	    const musicNo = item.getAttribute('data-music-no'); // 음악 번호 가져오기
    	    const orderIndex = item.getAttribute('data-order-index');// 순서 가져오기
	    	//ajax로 playlistname, musicno, index 넘겨주면 playlist 조회 후 해당 id로 playlist_order 삭제하기
	    	$.ajax({
                type : "POST",           
                url : "/deletePlayList",  
                data: JSON.stringify({ 
                	playlistName: playlistName, 
                	musicNo: musicNo, 
                	orderIndex: orderIndex
                		}), // JSON 형식의 데이터
                contentType: "application/json",  // 데이터 형식을 JSON으로 명시한다.
                success : function(data){
                	// 추가한 노래 playlist에 추가
                	console.log(data);
                    alert(data);
                },
                error : function(XMLHttpRequest, textStatus, errorThrown){
                    alert("통신 실패.")
                }
            });
    	    playListItems.splice(index, 1);
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
    setFirstSong();

	// 플레이리스트 처음곡 재생하는 함수
	function setFirstSong() {
		const firstSong = playListItems[0];
		const firstPlaylistName = firstSong.getAttribute('data-playlist-name');
		const firstMusicNo = firstSong.getAttribute('data-music-no');
		const firstMusicUrl = firstSong.getAttribute('data-file-music');
	    const firstMusicTitle = firstSong.getAttribute('data-music-title');
	    const firstMusicSinger = firstSong.getAttribute('data-music-singer');
	    const firstAlbumImg = firstSong.getAttribute('data-file-img');
	    // 앨범 사진
	    const albumImage = document.querySelector('.ui-cover-art');
	    albumImage.src = firstAlbumImg;
		// 가수 세팅
		document.querySelector('.ui-cover-title').innerHTML = "<p>" + firstMusicTitle + "</p>" + "<p>" + firstMusicSinger + "</p>"; 
	    audioPlayer.src = firstMusicUrl;
	    audioPlayer.play();
	}
	 // 다음 곡으로 넘어가는 함수
	function playNextSong() {
	    // 현재 재생 중인 곡의 인덱스를 증가시킴
	    currentSongIndex++;
	    // 재생 목록의 끝에 도달하면 처음 곡으로 돌아감
	    if (currentSongIndex >= playListItems.length) {
	        currentSongIndex = 0;
	    }
	    // 현재 곡의 인덱스를 기반으로 해당 곡을 재생
	    console.log(currentSongIndex);
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

	// 플레이리스트에 노래 추가
	function addPlaylistItem(data, type) {
	    // 플레이리스트 아이템 생성
	    const playlistItem = document.createElement('div');
	    playlistItem.classList.add('ui-list-item');
	    playlistItem.setAttribute('data-order-index', data.orderIndex);
	    playlistItem.setAttribute('data-playlist-name', data.playlistName);
	    playlistItem.setAttribute('data-music-no', data.musicNo);
	    playlistItem.setAttribute('data-file-img', data.filepath);
	    playlistItem.setAttribute('data-file-music', data.filemusic);
	    playlistItem.setAttribute('data-music-title', data.musictitle);
	    playlistItem.setAttribute('data-music-singer', data.musicsinger);
	    playlistItem.textContent = data.musictitle + '- ' + data.musicsinger;
		// playlist배열에 추가
		playListItems.push(playlistItem);
		console.log(data.playlistName);
		console.log(data.musicNo);
		// 삭제 버튼 생성
	    const deleteButton = document.createElement('span');
	    deleteButton.classList.add('delete-btn');
	    deleteButton.textContent = '❌';
	    deleteButton.addEventListener('click', function() {
	    	 const index = playListItems.indexOf(playlistItem);
	    	    console.log('Deleted item index:', index);
	    	//ajax로 playlistname, musicno, index 넘겨주면 playlist 조회 후 해당 id로 playlist_order 삭제하기
	    	$.ajax({
                type : "POST",           
                url : "/deletePlayList",  
                data: JSON.stringify({ 
                	playlistName: data.playlistName, 
                	musicNo: data.musicNo, 
                	orderIndex: data.orderIndex
                		}), // JSON 형식의 데이터
                contentType: "application/json",  // 데이터 형식을 JSON으로 명시한다.
                success : function(data){
                	// 추가한 노래 playlist에 추가
                	console.log(data);
                    alert(data);
                },
                error : function(XMLHttpRequest, textStatus, errorThrown){
                    alert("통신 실패.")
                }
            });
	        playlistItem.remove();
	        playListItems.splice(index, 1);
	    });
	
	    // 플레이리스트 아이템에 삭제 버튼 추가
	    playlistItem.appendChild(deleteButton);
	
	    // 플레이리스트에 아이템 추가
	    document.querySelector('.ui-list').appendChild(playlistItem);
	
	    // 새로 추가된 아이템에 클릭 이벤트 추가
	    playlistItem.addEventListener('click', function() {
	        const musicNo = this.getAttribute('data-music-no');
	        const musicUrl = this.getAttribute('data-file-music');
	        const musicTitle = this.getAttribute('data-music-title');
	        const musicSinger = this.getAttribute('data-music-singer');
	        const albumImg = this.getAttribute('data-file-img');
	
	        // 현재 재생 중인 곡 정보 업데이트
	        const albumImage = document.querySelector('.ui-cover-art');
	        albumImage.src = albumImg;
	        document.querySelector('.ui-cover-title').innerHTML = "<p>" + musicTitle + "</p>" + "<p>" + musicSinger + "</p>";
	        audioPlayer.src = musicUrl;
	        audioPlayer.play();
	    });
	    if(type == 'play'){
	    	playlistItem.click();
	    }
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
				<i class="fas fa-list-ul"></i> <i class="fas fa-heart"></i> <i
					class="fas fa-plus"></i>
			</div>

			<div class="ui-seekbar">
				<input type="range" class="ui-slider" min="1" max="1200" value="0">
				<span id="currentTime">0:00</span> / <span id="totalDuration">0:00</span>
			</div>

			<div class="ui-controls">
				<i class="fas fa-random"></i> 
				 <i class="fas fa-redo"></i>
				<i class="fas fa-step-backward"></i> <i
					class="fas fa-pause"></i> <i class="fas fa-step-forward"></i>
					<div id="volumeContainer">
						<i class="fas fa-volume-up" id="volumeIcon"> </i> 
						<input type="range" id="volumeSlider" min="0" max="1" step="0.01" value="0.3">
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
</body>
</html>