const updateBtn = $("#btn-update");
const deleteBtn = $("#btn-delete");


let addressNum = window.location.pathname.split("/")[4];

// 페이지가 로드된 후 실행됨
window.onload = function() {

	// 현재 URL 가져오기
	let currentUrl = window.location.href;

	let url = new URL(currentUrl);

	// 추가할 파라미터
	let searchType = url.searchParams.get('searchType');
	let search = url.searchParams.get('searchInput');

	// pagination 클래스를 가진 요소 찾기
	let paginationLinks = document.querySelectorAll('#noticePage a');

	// 각 링크에 추가 파라미터 추가
	paginationLinks.forEach(function(link) {
		let linkUrl = new URL(link.href);

		// 파라미터 추가
		if (searchType && search) {
			linkUrl.searchParams.append('searchType', searchType);
			linkUrl.searchParams.append('search', search);
		}

		// 변경된 URL을 href 속성에 설정
		link.href = linkUrl.href;
	});
};


// notice list에서 insert 위한 클릭 이벤트
function loadInsert() {
	const insertClick = $("#btnInsert");
	insertClick.on("click", function() {
		window.location.href = "/board/notice/noticeWrite";
	});
}
loadInsert();


// notice list에서 View 위한 클릭 이벤트
function loadView() {
	const pageClick = $(".page-click");
	pageClick.on("click", function() {
		window.location.href = "/board/notice/noticeView/" + $(this).attr("id");

	});
}
loadView();

// notice view 출력
function loadViewId() {

	console.log(typeof addressNum);

	$.ajax({
		type: "post",
		url: "/board/notice/noticeView/" + addressNum,
		data: {},
		success: function(data) {

			// id-display 엘리먼트에 데이터 출력
			$("#id-display").html(data.id);

			// title-display 엘리먼트에 데이터 출력
			$("#createdAt-display").html(data.createdAt);

			// title-display 엘리먼트에 데이터 출력
			$("#title-display").html(data.title);

			// content-display 엘리먼트에 데이터 출력
			$("#content-display").html(data.content);

			// file-display 엘리먼트에 데이터 출력
			$("#file-display").html(data.filePath);

		},
		error: function() {
			alert("Error!!!");
		}
	});

	// 수정하기
	$("#btn-update-complete").on("click", function() {
		alert("수정");
		// 수정된 데이터 가져오기
		const updatedTitle = $("#updated-title").val(); // 수정된 제목
		const updatedContent = $("#updated-content").val(); // 수정된 내용
		const updatedFilePath = $("#updated-file")[0].files[0];// 수정된 파일
		const updatedFilePath2 = $("#updated-file")[0].files[0];// 수정된 파일

		// FormData 객체 생성
		const formData = new FormData();
		formData.append("title", updatedTitle);
		formData.append("content", updatedContent);
		formData.append("files", updatedFilePath);
		formData.append("files", updatedFilePath2);

		// AJAX를 사용하여 서버로 수정된 데이터 전송
		$.ajax({
			type: "post",
			url: "/board/notice/noticeUpdate/" + addressNum,
			data: formData,
			contentType: false,
			processData: false,
			success: function(data) {
				if (data === true) {
					// 수정이 성공했을 때, 목록 페이지로 이동
					window.location.href = "/board/notice/noticeList";
				} else {
					// 수정이 실패했을 때의 처리
					alert("데이터 수정에 실패했습니다.");
				}
			},
			error: function() {
				// 통신 에러 시의 처리
				alert("서버와의 통신 중 에러가 발생했습니다.");
			}
		});
	});



	// 삭제하기
	deleteBtn.on("click", function() {
		console.log("타나여?");
		console.log(addressNum);

		$.ajax({
			type: "post",
			url: "/board/notice/noticeDelete/" + addressNum,
			success: function(data) {
				if (data == true) {
					window.location.href = "/board/notice/noticeList";
				} else {
					alert("데이터 삭제에 실패했습니다.");
				}
			},
			error: function() {
				alert("서버와의 통신 중 에러가 발생했습니다.");
			}
		});
	});

}
// 페이지 로드 시 데이터 로딩 함수 호출
$(document).ready(function() {
	loadViewId();
});


// notice view에서 update를 위한 클릭 이벤트 
updateBtn.on("click", function() {
	window.location.href = "/board/notice/noticeUpdate/" + addressNum;
});
