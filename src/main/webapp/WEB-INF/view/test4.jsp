<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Lyrics Player</title>
<style>
.highlight {
	background-color: yellow;
}
</style>
</head>
<body>
	<div id="lyrics-container">
		<div id="mCSB_1_container" class="mCSB_container"
			style="position: relative; top: -1px; left: 0px;" dir="ltr">
		<p time-id="7" class="this">
				<a href="#7">오늘도 아침엔 입에 빵을 물고</a>
			</p>
			<p time-id="11">
				<a href="#11">똑같이 하루를 시작하고</a>
			</p>
			<p time-id="15">
				<a href="#15">온종일 한 손엔 아이스 아메리카노</a>
			</p>
			<p time-id="20">
				<a href="#20">피곤해 죽겠네</a>
			</p>
			<p time-id="23">
				<a href="#23">지하철 속 이 장면 어제 꿈에서 봤나</a>
			</p>
			<p time-id="28">
				<a href="#28">아참 매일이지 지나치고</a>
			</p>
			<p time-id="32">
				<a href="#32">바쁜 이 삶에 그냥 흔한 날에</a>
			</p>
			<p time-id="36">
				<a href="#36">그 애를 보고 말야</a>
			</p>
			<p time-id="39">
				<a href="#39">평온했던 하늘이 무너지고</a>
			</p>
			<p time-id="44">
				<a href="#44">어둡던 눈앞이 붉어지며</a>
			</p>
			<p time-id="49">
				<a href="#49">뭔가 잊고 온 게 있는 것 같아</a>
			</p>
			<p time-id="53">
				<a href="#53">괜히 이상하게 막 울 것만 같고</a>
			</p>
			<p time-id="57">
				<a href="#57">그냥 지나치는 게 나을 것 같아</a>
			</p>
			<p time-id="61">
				<a href="#61">나는 생각은 딱 질색이니까</a>
			</p>
			<p time-id="67">
				<a href="#67">카페인으로 잡은 정신은 빠졌고</a>
			</p>
			<p time-id="69">
				<a href="#69">하루 종일 신경 쓰여 토할 것 같아</a>
			</p>
			<p time-id="72">
				<a href="#72">저녁이 돼도 배고픔까지 까먹고</a>
			</p>
			<p time-id="74">
				<a href="#74">그치 이상하지 근데 말야 있잖아</a>
			</p>
			<p time-id="76">
				<a href="#76">처음 본 순간 뭐라 할까 그립달까</a>
			</p>
			<p time-id="81">
				<a href="#81">나도 웃긴데 말야</a>
			</p>
			<p time-id="83">
				<a href="#83">평온했던 하늘이 무너지고</a>
			</p>
			<p time-id="88">
				<a href="#88">어둡던 눈앞이 붉어지며</a>
			</p>
			<p time-id="93">
				<a href="#93">뭔가 잊고 온 게 있는 것 같아</a>
			</p>
			<p time-id="97">
				<a href="#97">괜히 이상하게 막 울 것만 같고</a>
			</p>
			<p time-id="101">
				<a href="#101">그냥 지나치는 게 나을 것 같아</a>
			</p>
			<p time-id="105">
				<a href="#105">나는 생각은 딱 질색이니까</a>
			</p>
			<p time-id="110">
				<a href="#110">오랫동안 나를 아는</a>
			</p>
			<p time-id="114">
				<a href="#114">슬픈 표정을 하고 Oh</a>
			</p>
			<p time-id="118">
				<a href="#118">흔적 없는 기억 밖</a>
			</p>
			<p time-id="121">
				<a href="#121">혹 과거에 미래에 딴 차원에 세계에</a>
			</p>
			<p time-id="124">
				<a href="#124">1 2 3 4 5 6 7 8</a>
			</p>
			<p time-id="125">
				<a href="#125">평온했던 하늘이 무너지고</a>
			</p>
			<p time-id="130">
				<a href="#130">어둡던 눈앞이 붉어져도</a>
			</p>
			<p time-id="134">
				<a href="#134">다시 놓쳐버리는 것만 같아</a>
			</p>
			<p time-id="138">
				<a href="#138">괜히 이상하게 막 울 것만 같고</a>
			</p>
			<p time-id="142">
				<a href="#142">그냥 지나치는 게 나을 것 같아</a>
			</p>
			<p time-id="147">
				<a href="#147">나는 생각은 딱 질색이니까</a>
			</p>
			<p time-id="151">
				<a href="#151">아냐 지나치는 게 나을 것 같아</a>
			</p>
			<p time-id="155">
				<a href="#155">나는 아픈 건 딱 질색이니까</a>
		</div>
	</div>

	<audio id="audio-player"
		src="http://localhost/filedb/get-file/8106ae72f9304203a5d02c2e95e1be3e"
		controls></audio>

	<script>
	const audioPlayer = document.getElementById('audio-player');
	const lyricsContainer = document.getElementById('mCSB_1_container');
	let currentLyricIndex = -1; // 현재 가사 인덱스 변수 초기화

	audioPlayer.addEventListener('timeupdate', function() {
	    const currentTime = Math.floor(audioPlayer.currentTime);
	    highlightLyrics(currentTime);
	});

	function highlightLyrics(currentTime) {
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
    window.addEventListener('DOMContentLoaded',e=>console.log('DOM 요소 로드 완료 이벤트 발생!'));
    window.addEventListener('load',e=>console.log('모든 요소 로드 완료 이벤트 발생!'));
    window.addEventListener('beforeunload',e=>document.querySelector('.beforeunload').innerHTML = '브라우저 종료 전 이벤트 발생!');
    window.addEventListener('unload',e=>document.querySelector('.unload').innerHTML = '브라우저 종료 이벤트 발생!');
	</script>
</body>
</html>
