document.addEventListener('DOMContentLoaded', function() {
	// 반복재생 상태를 나타내는 변수 0. 반복x 1. 전체 반복, 2. 1곡 반복
	let isRepeatMode = 0;
	// 랜덤 버튼
	const repeatModeBtn = document.querySelector('.fa-redo');
	// 기존 업데이트 모드
	updateRepeatModeUI(repeatModeBtn);
	//
	let isExpanded = false;
	// 셔플 상태를 나타내는 변수
	let isShuffled = false;

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
		scrollToHighlightedElement();
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
		if (isRepeatMode === 2) {
			audioPlayer.play();
		} else {
			playNextSong();
		}
	});

	// audioPlayer.autoplay = true;
	let playListItems = Array.from(document.querySelectorAll('.ui-list-item'));

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
			const musicUrl = (payment_yn == null || payment_yn == '') ? this.getAttribute('data-music-sample') : this.getAttribute('data-file-music');
			const musicTitle = this.getAttribute('data-music-title');
			const musicSinger = this.getAttribute('data-music-singer');
			const albumImg = this.getAttribute('data-file-img');

			// 현재 재생 중인 곡의 순서를 업데이트
			currentSongIndex = index;
			console.log(currentSongIndex);

			// 현재 재생 중인 곡 정보 업데이트
			setCurrentMusic(albumImg, lyrics, musicTitle, musicSinger, musicUrl, musicNo);
		});
		// 추가 버튼 생성
		const addButton = item.querySelector('.add-btn');
		addButton.addEventListener('click', function(event) {
			event.stopPropagation(); // 이벤트 버블링 막기
			if (userId == null || userId == '') {
				if (confirm("로그인 하시겠습니까?")) {
					window.opener.location.href = '/signIn'; // 메인 페이지 URL로 리다이렉트
					return;
				}
			} else {
				event.stopPropagation(); // 이벤트 전파 방지
				const musicNo = item.getAttribute('data-music-no'); // 음악 번호 가져오기
				// AJAX 요청을 보냅니다.
				$.ajax({
					type: 'POST',
					url: '/addPlayList',
					data: JSON.stringify({
						userId: userId,
						playlistName: "playlist",
						musicNo: musicNo,
					}),
					contentType: 'application/json',
					success: function(response) {
						alert(response);
						alert("플레이리스트에 추가 되었습니다");
					},
					error: function(error) {
						console.error('Error adding music to playlist:', error);
						// 실패한 경우 사용자에게 알립니다.
						alert('Failed to add music to playlist.');
					}
				});
			}
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
			console.log('Deleted playlistName:', playlistName);
			console.log('Deleted musicNo:', musicNo);
			console.log('Deleted orderIndex:', orderIndex);
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
	// 중복곡 제거
	const deleteDuplicateBtn = document.getElementById('deleteDuplicate');
	deleteDuplicateBtn.addEventListener('click', function() {
		const musicNoSet = new Set();
		const deleteList = [];
		const playlistContainer = document.querySelector('.ui-list');
		let filteredList = [];
		playListItems.forEach((item) => {
			const musicNo = item.getAttribute('data-music-no');
			const orderIndex = item.getAttribute('data-order-index');
			const playlistName = item.getAttribute('data-playlist-name');

			// musicNo가 이미 Set에 있는지 확인하여 중복된 경우 처리
			if (musicNoSet.has(musicNo)) {
				// 삭제 리스트에 해당 정보 추가
				deleteList.push({ userId: Number(userId), musicNo, orderIndex, playlistName });
				// DOM에서 중복된 아이템 제거
				playlistContainer.removeChild(item);
			} else {
				// Set에 musicNo 추가하여 중복 여부 체크
				musicNoSet.add(musicNo);
				// 중복되지 않은 경우 필터링된 목록에 추가
				filteredList.push(item);
			}
		});

		// Update playListItems with filtered list
		playListItems = filteredList;

		// Send deleteList to server for further processing
		$.ajax({
			type: "POST",
			url: "/deletePlayListBatch",
			data: JSON.stringify({ deleteList }),
			contentType: "application/json",
			success: function(data) {
				console.log(data);
				alert(data);
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) {
				alert("통신 실패.")
			}
		});

	});

	const myMusicOpenBtn = document.getElementById('my-music-open');
	const myMusicCloseBtn = document.getElementById('my-music-close');
	// myMusic 창 닫기
	myMusicCloseBtn.addEventListener("click", function() {
		console.log("이거 크크크크릭리됨");
		var myMusicContainer = document.getElementById("myMusicContainer");

		// myMusicContainer의 자식 요소 중에서 p 태그를 제외한 모든 요소를 삭제합니다.
		var children = myMusicContainer.children;
		for (var i = children.length - 1; i >= 0; i--) {
			if (children[i].tagName.toLowerCase() !== 'p') {
				children[i].remove();
			}
		}

		// 'active' 클래스를 제거하여 숨깁니다.
		myMusicContainer.classList.remove("active");
	});

	// myMusic 창 열기
	myMusicOpenBtn.addEventListener(
		"click",
		function() {
			if (userId == null || userId == '') {
				if (confirm("로그인 하시겠습니까?")) {
					window.opener.location.href = '/signIn'; // 메인 페이지 URL로 리다이렉트
					return;
				}
			} else {
				var myMusicContainer = document.getElementById("myMusicContainer");
				// 플레이리스트가 비어 있는지 확인
				if (!myMusicContainer.querySelector('.my-music-container-item')) {
					myMusicContainer.classList.add("active");
					// 1. ajax로 playlist 조회 - data 나온 값으로 플레이리스트에 추가.
					$.ajax({
						type: "POST",
						url: "/readPlaylist",
						data: JSON.stringify({
							playlistName: "playlist",
							userId: userId
						}),
						contentType: "application/json",
						success: function(data) {
							console.log(data);
							alert(data);
							// 2. 클릭 이벤트 시 addPlaylistItem에 추가하기
							if (data.length === 0) {
								alert("플레이리스트가 비어 있습니다.");
							} else {
								data.forEach(function(childData) {
									addPlaylistItemToPlaylist(childData);
								});
							}
						},
						error: function(XMLHttpRequest, textStatus,
							errorThrown) {
							alert("통신 실패.")
						}
					});
				}
			}


		});

	const heartBtnImg = document.getElementById('heart');
	// 좋아요 버튼 클릭 이벤트 리스너 추가
	heartBtnImg.addEventListener('click', function() {
		if (currentMusicNo == null || currentMusicNo == '') {
			alert("재생된 노래가 없습니다");
		} else {
			// 클릭한 곡의 musicNo 가져오기
			const currentSongIndex = getCurrentSongIndex();
			const musicNo = playListItems[currentSongIndex].getAttribute('data-music-no');

			// 좋아요 버튼 클릭 이벤트 처리 함수 호출
			likeBtnHandler(musicNo, heartBtnImg);
		}
	});
	const addCurrentMusicToPlaylist = document.getElementById('add-playlist');
	let currentMusicNo;
	addCurrentMusicToPlaylist.addEventListener('click', function(event) {
		if (userId == null || userId == '') {
			if (confirm("로그인 하시겠습니까?")) {
				window.opener.location.href = '/signIn'; // 메인 페이지 URL로 리다이렉트
				return;
			}
		} else {
			// AJAX 요청을 보냅니다.
			if (currentMusicNo == null || currentMusicNo == '') {
				alert("재생된 노래가 없습니다");
			} else {
				$.ajax({
					type: 'POST',
					url: '/addPlayList',
					data: JSON.stringify({
						userId: userId,
						playlistName: "playlist",
						musicNo: currentMusicNo
					}),
					contentType: 'application/json',
					success: function(response) {
						alert(response);
						alert("플레이리스트에 추가 되었습니다");
					},
					error: function(error) {
						console.error('Error adding music to playlist:', error);
						// 실패한 경우 사용자에게 알립니다.
						alert('Failed to add music to playlist.');
					}
				});
			}
		}
	});

	const lyricsContainer = document.getElementById('lyrics-container');
	const uiCover = document.querySelector('.ui-cover');

	let isCoverVisible = true; // UI 커버의 표시 여부를 추적하는 변수

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
		if (e.target.classList.contains('fa-random')) {
			console.log("랜덤");
			shuffleMusic(e);
		}
		if (e.target.classList.contains('fa-redo')) {
			// 반복 모드 변경: 0 -> 1 -> 2 -> 0 (반복 없음 -> 한 곡 반복 -> 전체 반복 -> 반복 없음)
			isRepeatMode = (isRepeatMode + 1) % 3;
			// UI 업데이트
			updateRepeatModeUI(e.target);
		}
		if (e.target.classList.contains('fa-align-right')) {
			const coverHeight = parseInt(window.getComputedStyle(uiCover).height);
			const lyricsContainerHeight = parseInt(window.getComputedStyle(lyricsContainer).height);
			let expandHeight = coverHeight + lyricsContainerHeight;
			let expandHeightPx = expandHeight + 'px';
			if (isCoverVisible) {
				isExpanded = true;
				// UI 커버를 숨기고 가사 컨테이너를 확장
				if (lyricsContainerHeight > 0) {
					uiCover.style.display = 'none';
				} else {
					uiCover.style.visibility = 'hidden';
				}
				lyricsContainer.style.maxHeight = expandHeightPx;
				isCoverVisible = false; // UI 커버가 숨겨졌으므로 상태 변경
			} else {
				// 확장되면 center에 스크롤
				isExpanded = false;
				// UI 커버를 표시하고 가사 컨테이너를 축소
				uiCover.style.display = 'flex';
				uiCover.style.visibility = 'visible';
				lyricsContainer.style.maxHeight = '44px'; // 가사 컨테이너의 기본 높이
				isCoverVisible = true; // UI 커버가 표시되었으므로 상태 변경
			}
		}
	});

	setFirstSong();

	// 플레이리스트 처음곡 재생하는 함수
	function setFirstSong() {
		const firstSong = playListItems[0];
		const firstPlaylistName = firstSong.getAttribute('data-playlist-name');
		const firstLyrics = this.getAttribute('data-lyrics');
		const firstMusicNo = firstSong.getAttribute('data-music-no');
		const firstMusicUrl = (payment_yn == null || payment_yn == '') ? firstSong.getAttribute('data-music-sample') : firstSong.getAttribute('data-file-music');
		const firstMusicTitle = firstSong.getAttribute('data-music-title');
		const firstMusicSinger = firstSong.getAttribute('data-music-singer');
		const firstAlbumImg = firstSong.getAttribute('data-file-img');

		setCurrentMusic(firstAlbumImg, firstLyrics, firstMusicTitle, firstMusicSinger, firstMusicUrl, firstMusicNo);
	}

	// 반복 모드 세팅
	function updateRepeatModeUI(repeatModeBtn) {

		if (isRepeatMode === 0) {
			repeatModeBtn.classList.remove('repeat-one-icon', 'repeat-all-icon');
			repeatModeBtn.classList.add('repeat-none-icon');
			repeatModeBtn.title = '반복 없음';
		} else if (isRepeatMode === 1) {
			repeatModeBtn.classList.remove('repeat-none-icon', 'repeat-one-icon');
			repeatModeBtn.classList.add('repeat-all-icon');
			repeatModeBtn.title = '전체 반복';
		} else if (isRepeatMode === 2) {
			repeatModeBtn.classList.remove('repeat-none-icon', 'repeat-all-icon');
			repeatModeBtn.classList.add('repeat-one-icon');
			repeatModeBtn.title = '한 곡 반복';
		}
	}
	// 다음 곡으로 넘어가는 함수
	function playNextSong() {
		// 현재 재생 중인 곡의 인덱스를 증가시킴
		currentSongIndex++;

		let reset = false;

		// 재생 목록의 끝에 도달하면 처음 곡으로 돌아감
		if (currentSongIndex >= playListItems.length) {
			currentSongIndex = 0;
			reset = true;
		}

		// 현재 곡의 인덱스를 기반으로 해당 곡을 재생
		console.log(currentSongIndex);
		playListItems[currentSongIndex].click();
		// 반복 모드가 0, 기본일땐 처음으로 간 뒤 정지
		if (isRepeatMode === 0 && reset) {
			// 재생/일시정지 아이콘을 재생 아이콘으로 변경
			audioPlayer.pause();
			alert("재생할 다음 곡이 없습니다.");
		}
		updatePlayPauseIcon();
	}

	// 이전 곡으로 돌아가는 함수
	function playPreviousSong() {
		// 현재 재생 중인 곡의 인덱스를 감소시킴
		currentSongIndex--;
		let reset = false;
		// 재생 목록의 처음에 도달하면 마지막 곡으로 이동
		if (currentSongIndex < 0) {
			if (isRepeatMode === 1) {
				currentSongIndex = playListItems.length - 1;
			} else {
				currentSongIndex = 0;
			}
			reset = true;
		}
		// 현재 곡의 인덱스를 기반으로 해당 곡을 재생
		playListItems[currentSongIndex].click();
		if (isRepeatMode === 0 && reset) {
			// 재생/일시정지 아이콘을 재생 아이콘으로 변경
			audioPlayer.pause();
			alert("재생할 이전 곡이 없습니다.");
		}
		updatePlayPauseIcon();
	}
	// 현재 재생 중인 곡 리스트에서 강조하는 함수
	function highlightCurrentSong() {
		// 모든 리스트 아이템에서 강조 클래스를 제거
		playListItems.forEach(item => {
			item.classList.remove('playing-music');
		});
		// 현재 재생 중인 곡에 강조 클래스를 추가
		console.log(currentSongIndex);
		playListItems[currentSongIndex].classList.add('playing-music');
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
	// 강조 된 가사로 스크롤 되는 함수
	function scrollToHighlightedElement() {
		const highlightedElement = document.querySelector('.highlight');
		if (highlightedElement) {
			if (isExpanded) {
				console.log("확장되었어요");
				highlightedElement.scrollIntoView({ behavior: "smooth", block: "center", inline: "nearest" });
			} else {
				console.log("확장 안됨");
				highlightedElement.scrollIntoView({ behavior: "smooth", block: "start", inline: "nearest" });
			}
		}
	}
	// 재생할 곡 세팅 함수
	function setCurrentMusic(albumImg, lyrics, musicTitle, musicSinger, musicUrl, musicNo) {
		currentMusicNo = musicNo;
		// 좋아요 체크
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
		updatePlayPauseIcon();
		//현재 곡 리스트에서 강조
		highlightCurrentSong();
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
	// 셔플 토글 버튼 클릭 이벤트 리스너 추가
	function shuffleMusic(e) {
		console.log("이거 클릭 됐나요???????");
		// 셔플 상태를 토글
		isShuffled = !isShuffled;

		// 셔플 상태에 따라 동작 수행
		if (isShuffled) {
			// 플레이리스트 섞기
			shufflePlaylist();
			// 버튼 아이콘 변경: 활성화 상태로 변경
			e.target.classList.remove('disabled');
			console.log("활성화 하기");
		} else {
			// 플레이리스트 원래 순서로 정렬
			playListItems.sort((a, b) => a.getAttribute('data-order-index') - b.getAttribute('data-order-index'));
			// 버튼 아이콘 변경: 비활성화 상태로 변경
			e.target.classList.add('disabled');
			console.log("비활성화 하기");
		}
	}

	// 플레이리스트를 섞는 함수
	function shufflePlaylist() {
		playListItems.sort(() => Math.random() - 0.5);
	}

	// 재생/일시정지 아이콘 변경 함수
	function updatePlayPauseIcon() {
		const playPauseIcon = document.querySelector('.ui-controls .fa-play, .ui-controls .fa-pause');
		if (playPauseIcon) {
			if (audioPlayer.paused) {
				playPauseIcon.classList.remove('fa-pause');
				playPauseIcon.classList.add('fa-play');
			} else {
				playPauseIcon.classList.remove('fa-play');
				playPauseIcon.classList.add('fa-pause');
			}
		}
	}
	// 플레이리스트에 노래 추가
	function addPlaylistItemToPlaylist(data) {
		// 플레이리스트 아이템 생성
		const playlistItem = document.createElement('div');
		playlistItem.classList.add('my-music-container-item');
		playlistItem.setAttribute('data-order-index', data.orderIndex);
		playlistItem.setAttribute('data-playlist-name', data.playlistName);
		playlistItem.setAttribute('data-music-no', data.musicNo);
		playlistItem.setAttribute('data-music-title', data.musicTitle);
		playlistItem.setAttribute('data-music-singer', data.musicSinger);
		playlistItem.textContent = data.musicTitle + '- '
			+ data.musicSinger;
		// playlist배열에 추가
		// 삭제 버튼 생성
		const deleteButton = document.createElement('span');
		deleteButton.classList.add('delete-btn');
		deleteButton.textContent = '❌';
		deleteButton.addEventListener('click', function() {
			$.ajax({
				type: "POST",
				url: "/deletePlayList",
				data: JSON.stringify({
					playlistName: data.playlistName,
					musicNo: data.musicNo,
					orderIndex: data.orderIndex
				}),
				contentType: "application/json",
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
		});

		// 플레이리스트 아이템에 삭제 버튼 추가
		playlistItem.appendChild(deleteButton);

		// 플레이리스트에 아이템 추가
		document.querySelector('.my-music-container').appendChild(
			playlistItem);

		// 새로 추가된 아이템에 클릭 이벤트 추가
		playlistItem.addEventListener('click', function() {
			addPlaylistItem(data, "add");
			console.log("클릭됨 ");
		});
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
		playlistItem.setAttribute('data-music-sample', data.musicsample);
		playlistItem.setAttribute('data-music-title', data.musictitle);
		playlistItem.setAttribute('data-music-singer', data.musicsinger);
		playlistItem.textContent = data.musictitle + '- ' + data.musicsinger;
		// playlist배열에 추가
		playListItems.push(playlistItem);
		console.log(data.playlistName);
		console.log(data.musicNo);
		// 추가 버튼 생성
		const addButton = document.createElement('span');
		addButton.classList.add('add-btn');
		addButton.textContent = '➕';
		addButton.addEventListener('click', function(event) {
			event.stopPropagation(); // 이벤트 버블링 막기
			if (userId == null || userId == '') {
				if (confirm("로그인 하시겠습니까?")) {
					window.opener.location.href = '/signIn'; // 메인 페이지 URL로 리다이렉트
					return;
				}
			} else {
				// AJAX 요청을 보냅니다.
				$.ajax({
					type: 'POST',
					url: '/addPlayList',
					data: JSON.stringify({
						userId: userId,
						playlistName: "playlist",
						musicNo: data.musicNo
					}),
					contentType: 'application/json',
					success: function(response) {
						alert(response);
						alert("플레이리스트에 추가 되었습니다");
					},
					error: function(error) {
						console.error('Error adding music to playlist:', error);
						// 실패한 경우 사용자에게 알립니다.
						alert('Failed to add music to playlist.');
					}
				});
			}
		});

		// 플레이리스트 아이템에 추가 버튼 추가
		playlistItem.appendChild(addButton);

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
			const musicUrl = (payment_yn == null || payment_yn == '') ? this.getAttribute('data-music-sample') : this.getAttribute('data-file-music');
			const musicTitle = this.getAttribute('data-music-title');
			const musicSinger = this.getAttribute('data-music-singer');
			const albumImg = this.getAttribute('data-file-img');

			// 현재 클릭된 플레이리스트 아이템의 인덱스를 확인합니다.
			const index = playListItems.indexOf(playlistItem);
			console.log(index);
			// 현재 재생 중인 곡의 인덱스를 업데이트합니다.
			currentSongIndex = index;

			setCurrentMusic(albumImg, lyrics, musicTitle, musicSinger, musicUrl, musicNo);
		});
		if (type == 'play') {
			playlistItem.click();
		}
	}
});