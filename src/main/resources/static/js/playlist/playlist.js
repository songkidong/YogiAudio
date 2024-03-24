document.addEventListener('DOMContentLoaded', function() {
	var playerWindow;

	function playMusic() {
		// 이미 열려 있는 musicPlayer.jsp 창이 있는지 확인
		if (!playerWindow || playerWindow.closed) {
			// 창이 없거나 닫혀 있으면 새로 열기
			playerWindow = window.open('/musicPlayer', 'musicPlayerWindow', 'width=1000,height=700');
		} else {
			// 이미 열려 있는 창이 있으면 해당 창을 활용
			playerWindow.focus();
		}
	}

	function sendDataToChild(type) {
		if (playerWindow && !playerWindow.closed) {
			console.log("최장호");
			const dataToSend = {
				musicNo: musicNo,
				type: type
				// playlistName : "플레이리스트 이름 들어갈 예정",
			};
			playerWindow.postMessage(dataToSend, '*'); // 데이터를 자식 창으로 전달
		} else {
			playerWindow = window.open('/musicPlayer', 'musicPlayerWindow', 'width=1000,height=700');

			// 자식 창이 준비된 후에 postMessage 함수를 호출합니다.
			playerWindow.addEventListener('load', function() {
				const dataToSend = {
					musicNo: musicNo,
					type: type
				};
				playerWindow.postMessage(dataToSend, '*'); // 데이터를 자식 창으로 전달
			});
		}
	}

	// 이하 이벤트 리스너 등록
	const addButtons = document.querySelectorAll('.addPlayerBtn');
	addButtons.forEach(button => {
		button.addEventListener('click', function() {
			sendDataToChild('add');
		});
	});
	// playBtn을 클래스로 변경하여 모든 버튼에 적용
	const playButtons = document.querySelectorAll('.playBtn');
	playButtons.forEach(button => {
		button.addEventListener('click', function() {
			sendDataToChild('play');
		});
	});

	document.getElementById('musicBtn').addEventListener('click', function() {
		playMusic();
	});

});