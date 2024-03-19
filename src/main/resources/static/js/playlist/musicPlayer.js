document.addEventListener('DOMContentLoaded', function() {
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

	// 오디오 timeupdate 이벤트 - 재생시간, 현재 가사
	audioPlayer.addEventListener('timeupdate', function() {
		// 현재 재생 시간 가져오기
		var currentPlayTime = audioPlayer.currentTime;
		// 전체 재생 시간 가져오기
		var totalDuration = audioPlayer.duration;

		// 시간 표시 업데이트
		currentTimeDisplay.textContent = formatTime(currentPlayTime);
		totalDurationDisplay.textContent = formatTime(totalDuration);
		const currentTime = Math.floor(audioPlayer.currentTime);
		// 가사 강조 함수
		highlightLyrics(currentTime);
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
		let type = event.data.type;
		// ajax사용해서 playlist에 저장하기.
		$.ajax({
			type: "POST",
			url: "/addPlayList",
			data: JSON.stringify({ musicNo: event.data.musicNo }), // JSON 형식의 데이터
			contentType: "application/json",  // 데이터 형식을 JSON으로 명시한다.
			success: function(data) {
				// 추가한 노래 playlist에 추가
				alert(data);
				addPlaylistItem(data, type);
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) {
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
			const lyrics = this.getAttribute('data-lyrics');
			const musicNo = this.getAttribute('data-music-no');
			const musicUrl = this.getAttribute('data-file-music');
			const musicTitle = this.getAttribute('data-music-title');
			const musicSinger = this.getAttribute('data-music-singer');
			const albumImg = this.getAttribute('data-file-img');

			// 현재 재생 중인 곡의 순서를 업데이트
			currentSongIndex = index;
			console.log(currentSongIndex);

			// 현재 재생 중인 곡 정보 업데이트
			setCurrentMusic(albumImg, lyrics, musicTitle, musicSinger, musicUrl, musicNo);
		});
		// 아이템의 삭제 버튼 클릭 이벤트 처리
		const deleteBtn = item.querySelector('.delete-btn');
		deleteBtn.addEventListener('click', function(event) {
			event.stopPropagation(); // 이벤트 전파 방지
			item.remove(); // 해당 아이템 삭제
			console.log('Deleted item index:', index);
			const playlistName = item.getAttribute('data-playlist-name'); // 플레이리스트 이름 가져오기
			const lyrics = this.getAttribute('data-lyrics');
			const musicNo = item.getAttribute('data-music-no'); // 음악 번호 가져오기
			const orderIndex = item.getAttribute('data-order-index');// 순서 가져오기
			//ajax로 playlistname, musicno, index 넘겨주면 playlist 조회 후 해당 id로 playlist_order 삭제하기
			$.ajax({
				type: "POST",
				url: "/deletePlayList",
				data: JSON.stringify({
					playlistName: playlistName,
					musicNo: musicNo,
					orderIndex: orderIndex
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
			playListItems.splice(index, 1);
		});
	});

	// 현재 재생 중인 곡의 인덱스를 반환하는 함수
	function getCurrentSongIndex() {
		return currentSongIndex;
	}
	
	const heartBtnImg = document.getElementById('heart');
	// 좋아요 버튼 클릭 이벤트 리스너 추가
	heartBtnImg.addEventListener('click', function() {
		// 클릭한 곡의 musicNo 가져오기
		const currentSongIndex = getCurrentSongIndex();
		const musicNo = playListItems[currentSongIndex].getAttribute('data-music-no');

		// 좋아요 버튼 클릭 이벤트 처리 함수 호출
		likeBtnHandler(musicNo, heartBtnImg);
	});

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
		const firstLyrics = this.getAttribute('data-lyrics');
		const firstMusicNo = firstSong.getAttribute('data-music-no');
		const firstMusicUrl = firstSong.getAttribute('data-file-music');
		const firstMusicTitle = firstSong.getAttribute('data-music-title');
		const firstMusicSinger = firstSong.getAttribute('data-music-singer');
		const firstAlbumImg = firstSong.getAttribute('data-file-img');

		setCurrentMusic(firstAlbumImg, firstLyrics, firstMusicTitle, firstMusicSinger, firstMusicUrl, firstMusicNo);
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
	// 가사 강조 함수
	function highlightLyrics(currentTime) {
		const lyricsContainer = document.getElementById('mCSB_1_container');
		const lyrics = lyricsContainer.querySelectorAll('#mCSB_1_container > p');

		let currentLyricIndex = -1;

		// 현재 재생 중인 가사를 찾습니다.
		for (let i = 0; i < lyrics.length; i++) {
			const lyricTime = parseInt(lyrics[i].getAttribute('time-id'));
			if (lyricTime > currentTime) {
				break; // 현재 재생 중인 가사를 찾으면 반복문을 종료합니다.
			}
			currentLyricIndex = i;
		}

		// 모든 가사에서 강조 스타일 제거
		lyrics.forEach(lyric => {
			lyric.classList.remove('highlight');
		});

		// 현재 재생 중인 가사만 강조
		if (currentLyricIndex !== -1) {
			lyrics[currentLyricIndex].classList.add('highlight');
		}
	}
	// 재생할 곡 세팅 함수
	function setCurrentMusic(albumImg, lyrics, musicTitle, musicSinger, musicUrl, musicNo) {
		likeCheck(musicNo, heartBtnImg);
		// ui-actions 요소에 추가

		// 현재 재생 중인 곡 정보 업데이트
		const albumImage = document.querySelector('.ui-cover-art');
		albumImage.src = albumImg;
		// 가사 세팅
		document.querySelector('.mCSB_container').innerHTML = lyrics;
		const lyrics1 = document.querySelectorAll('#mCSB_1_container > p');

		lyrics1.forEach(lyric1 => {
			lyric1.addEventListener('click', function() {
				const timeId = parseInt(lyric1.getAttribute('time-id'));
				audioPlayer.currentTime = timeId;
			});
		});

		// 곡 정보 세팅
		document.querySelector('.ui-cover-title').innerHTML = "<p>" + musicTitle + "</p>" + "<p>" + musicSinger + "</p>";
		audioPlayer.src = musicUrl;
		audioPlayer.play();
	}
	// 좋아요 체크
	function likeCheck(musicNo, heartBtnImg) {
		// ajax로 좋아요 확인하기
		$.ajax({
			type: 'GET',
			url: '/readLikeMusic',
			data: {
				userId: userId,
				musicNo: musicNo
			},
			success: function(response) {
				// 좋아요 되어있으면 like로 세팅
				if (response !== null && response !== "") {
					console.log("이거 있네요?");
					heartBtnImg.src = "/img/music_like/like.png";
				} else {
					heartBtnImg.src = "/img/music_like/unlike.png";
				}
			},
			error: function(error) {
				console.error('Error saving markers:', error);
			}
		});
	}
	// 좋아요 클릭 이벤트 핸들러
	function likeBtnHandler(musicNo, heartBtnImg) {
		if (userId == null || userId == '') {
			console.log("최장호 : " + userId);
			if (confirm("로그인 하시겠습니까?")) {
				window.opener.location.href = '/signIn'; // 메인 페이지 URL로 리다이렉트
				return;
			}
		} else {
			// 클릭 이벤트 처리 코드 작성
			console.log('Like 이미지를 클릭했습니다.');

			// 예시: 이미지를 클릭할 때마다 이미지 소스 변경
			if (heartBtnImg.src.includes('/img/music_like/like.png')) {
				$.ajax({
					type: 'GET',
					url: '/deleteLikeMusic',
					data: {
						userId: userId,
						musicNo: musicNo
					},
					success: function(response) {
						console.log(response);
					},
					error: function(error) {
						console.error('Error saving markers:', error);
					}
				});
				heartBtnImg.src = '/img/music_like/unlike.png';
				console.log("여기선 삭제");
			} else {
				$.ajax({
					type: 'GET',
					url: '/saveLikeMusic',
					data: {
						userId: userId,
						musicNo: musicNo
					},
					success: function(response) {
						console.log(response);
					},
					error: function(error) {
						console.error('Error saving markers:', error);
					}
				});
				heartBtnImg.src = '/img/music_like/like.png';
				console.log("여기선 추가");
			}
		}
	}

	// 플레이리스트에 노래 추가
	function addPlaylistItem(data, type) {
		// 플레이리스트 아이템 생성
		const playlistItem = document.createElement('div');
		playlistItem.classList.add('ui-list-item');
		playlistItem.setAttribute('data-lyrics', data.lyrics);
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
		});

		// 플레이리스트 아이템에 삭제 버튼 추가
		playlistItem.appendChild(deleteButton);

		// 플레이리스트에 아이템 추가
		document.querySelector('.ui-list').appendChild(playlistItem);

		// 새로 추가된 아이템에 클릭 이벤트 추가
		playlistItem.addEventListener('click', function() {
			const lyrics = this.getAttribute('data-lyrics');
			const musicNo = this.getAttribute('data-music-no');
			const musicUrl = this.getAttribute('data-file-music');
			const musicTitle = this.getAttribute('data-music-title');
			const musicSinger = this.getAttribute('data-music-singer');
			const albumImg = this.getAttribute('data-file-img');

			setCurrentMusic(albumImg, lyrics, musicTitle, musicSinger, musicUrl, musicNo);
		});
		if (type == 'play') {
			playlistItem.click();
		}
	}
});