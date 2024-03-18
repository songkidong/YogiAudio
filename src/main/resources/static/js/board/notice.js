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



// notice view에서 update를 위한 클릭 이벤트 
updateBtn.on("click", function() {
	window.location.href = "/board/notice/noticeUpdate/" + addressNum;
});
