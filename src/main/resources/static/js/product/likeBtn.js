document.addEventListener('DOMContentLoaded', function() {
	const heartBtn = document.getElementById('heart');
	const fillHeartBtn = document.getElementById('fillHeart');

	// 좋아요 체크
	likeCheck(musicNo, heartBtn, fillHeartBtn);

	// Heart 버튼 클릭 이벤트 리스너 추가
	heartBtn.addEventListener('click', function() {
		likeBtnHandler(musicNo, userId, heartBtn, fillHeartBtn);
	});

	// Fill Heart 버튼 클릭 이벤트 리스너 추가
	fillHeartBtn.addEventListener('click', function() {
		likeBtnHandler(musicNo, userId, heartBtn, fillHeartBtn);
	});

	// 좋아요 체크 함수
	function likeCheck(musicNo, heartBtn, fillHeartBtn) {
		// ajax로 좋아요 확인하기
		$.ajax({
			type: 'GET',
			url: '/readLikeMusic',
			data: {
				userId: userId,
				musicNo: musicNo
			},
			success: function(response) {
				// 좋아요 되어있으면 fillHeart 아이콘으로 변경
				if (response !== null && response !== "") {
					heartBtn.style.display = 'none'; // 숨기기
					fillHeartBtn.style.display = 'inline'; // 보이기
				} else {
					heartBtn.style.display = 'inline'; // 보이기
					fillHeartBtn.style.display = 'none'; // 숨기기
				}
			},
			error: function(error) {
				console.error('Error checking like:', error);
			}
		});
	}

	// 좋아요 버튼 클릭 이벤트 핸들러
	function likeBtnHandler(musicNo, userId, heartBtn, fillHeartBtn) {
		if (userId == null || userId == '') {
			if (confirm("로그인 하시겠습니까?")) {
				window.location.href = '/signIn'; // 로그인 페이지로 이동
				return;
			}
		} else {
			// 클릭 이벤트 처리 코드 작성
			if (heartBtn.style.display === 'none') {
				// 이미 좋아요 상태일 때, 좋아요 취소
				$.ajax({
					type: 'GET',
					url: '/deleteLikeMusic',
					data: {
						userId: userId,
						musicNo: musicNo
					},
					success: function(response) {
						console.log(response);
						heartBtn.style.display = 'inline'; // Heart 아이콘 보이기
						fillHeartBtn.style.display = 'none'; // Fill Heart 아이콘 숨기기
					},
					error: function(error) {
						console.error('Error deleting like:', error);
					}
				});
			} else {
				// 좋아요 추가
				$.ajax({
					type: 'GET',
					url: '/saveLikeMusic',
					data: {
						userId: userId,
						musicNo: musicNo
					},
					success: function(response) {
						console.log(response);
						heartBtn.style.display = 'none'; // Heart 아이콘 숨기기
						fillHeartBtn.style.display = 'inline'; // Fill Heart 아이콘 보이기
					},
					error: function(error) {
						console.error('Error saving like:', error);
					}
				});
			}
		}
	}
});
