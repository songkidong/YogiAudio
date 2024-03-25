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
	let searchInput = url.searchParams.get('searchInput');

	// pagination 클래스를 가진 요소 찾기
	let paginationLinks = document.querySelectorAll('#noticePage a');

	// 각 링크에 추가 파라미터 추가
	paginationLinks.forEach(function(link) {
		let linkUrl = new URL(link.href);

		// 파라미터 추가
		if (searchType && searchInput) {
			linkUrl.searchParams.append('searchType', searchType);
			linkUrl.searchParams.append('searchInput', searchInput);
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

//////////////////////////////////////////////////////////

// deletedHref와 href 값을 담아둘 변수 선언
var deletedHrefVList = [];
var hrefValueList = [];

// 첨부된 파일 삭제하기
document.addEventListener('click', function(event) {
	// 이벤트가 발생한 요소가 버튼인지 확인합니다.
	if (event.target.matches('#fileListContainer #btnDeleteFile')) {
		// 이벤트가 발생한 버튼의 부모 요소인 <li>를 찾습니다.
		var listItem = event.target.closest('li');

		// 삭제될 <a> 태그의 href 속성 값을 가져옵니다.
		var deletedHref = listItem.querySelector('a.uploadedFilePath').getAttribute('href');
		console.log(deletedHref)

		deletedHrefVList.push(deletedHref);

		// 부모 요소인 <ul>을 찾습니다.
		var fileListContainer = listItem.parentElement;

		// <li>를 <ul>에서 제거합니다.
		fileListContainer.removeChild(listItem);
	}
});
// 수정하기
$("#btn-update-complete").on("click", function() {
	alert("수정");
	// 수정된 데이터 가져오기
	const updatedTitle = $("#updated-title").val(); // 수정된 제목
	const updatedContent = $("#updated-content").val(); // 수정된 내용
	const fileInputs = document.querySelectorAll('.files');

	// 부모 요소를 찾습니다.
	var fileListContainer = document.getElementById('fileListContainer');

	// 부모 요소 하위의 모든 a 태그를 선택합니다.
	var anchorTags = fileListContainer.querySelectorAll('a.uploadedFilePath');

	// 각 a 태그의 href 속성을 가져와서 출력합니다.
	anchorTags.forEach(function(anchorTag) {
		href = anchorTag.getAttribute('href');
		console.log('콘솔href:', href);

		hrefValueList.push(href);
	});

	// FormData 객체 생성
	const formData = new FormData();
	formData.append("title", updatedTitle);
	console.log(updatedTitle);
	formData.append("content", updatedContent);
	console.log(updatedContent);
	// file 추가
	// 파일 입력 요소에서 파일 목록을 가져와 FormData에 추가
	fileInputs.forEach(function(input) {
		const selectedFiles = input.files;
		for (let i = 0; i < selectedFiles.length; i++) {
			const file = selectedFiles[i];
			formData.append("files", file); // 각 파일을 FormData에 추가
		}
	});

	if (deletedHrefVList && deletedHrefVList.length > 0) { //1개라도 있으면
		formData.append("deletedHref", deletedHrefVList);
	}

	if (hrefValueList && hrefValueList.length > 0) {
		formData.append("href", hrefValueList);
	}
	console.log(deletedHrefVList);
	console.log(hrefValueList);
	console.log(formData);

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



// loadViewId() 실행함수 --> noticeView.jsp 


// notice view에서 update를 위한 클릭 이벤트 
updateBtn.on("click", function() {
	window.location.href = "/board/notice/noticeUpdate/" + addressNum;
});

// 상위 3개 글(최신글) id대신 메가폰 아이콘 처리
document.addEventListener("DOMContentLoaded", function() {
	// 상위 3개의 행을 가져옵니다.
	var topRows = document.querySelectorAll(".page-click:nth-child(-n+3)");

	// 각 상위 3개의 행에 대해 아이콘을 변경합니다.
	topRows.forEach(function(row) {
		var idCell = row.querySelector("td:first-child"); // 첫 번째 td 셀을 가져옵니다.
		var id = idCell.textContent.trim(); // 텍스트 내용을 가져옵니다.

		// id 값이 있다면
		if (id !== "") {
			// 아이콘으로 대체합니다.
			idCell.innerHTML = '<i class="bi bi-megaphone-fill text-danger"></i>';
		}
	});
});
