document.addEventListener('DOMContentLoaded', function() {
	const heartBtnImg = document.getElementById('heart');
	// 좋아요 체크
	likeCheck(musicNo, heartBtnImg);
	// 좋아요 버튼 클릭 이벤트 리스너 추가
	heartBtnImg.addEventListener('click', function() {
		// 좋아요 버튼 클릭 이벤트 처리 함수 호출
		likeBtnHandler(musicNo, heartBtnImg);
	});
	//좋아요 체크
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
				window.location.href = '/signIn'; // 메인 페이지 URL로 리다이렉트
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
});