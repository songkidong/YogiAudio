<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/layout/header.jsp"%>
<link href="/css/board/view.css" rel="stylesheet">
<style>
.qnaReply {
	margin-top: 30px;
	border: 1px solid #ccc; /* 예시로 테두리 추가 */
	padding: 20px; /* 예시로 내부 여백 추가 */
	background-color: #f9f9f9; /* 예시로 배경색 추가 */
}

.qnaReply h3 {
	font-size: 20px; /* 예시로 제목 폰트 크기 변경 */
	color: #333; /* 예시로 제목 색상 변경 */
}

.qnaCard {
	border: 1px solid #ddd; /* 예시로 카드 테두리 추가 */
	padding: 10px; /* 예시로 카드 내부 여백 추가 */
	background-color: #fff; /* 예시로 카드 배경색 추가 */
}

.info {
	margin-bottom: 10px; /* 예시로 정보 부분과 내용 사이 간격 추가 */
}

.reply-content {
	font-size: 16px; /* 예시로 내용 폰트 크기 변경 */
	color: #555; /* 예시로 내용 색상 변경 */
}
</style>

<section id="board">
	<div class="board-container">
		<h2>나의 문의하기 상세보기</h2>

		<c:choose>
			<c:when test="${principal.role == 'USER'}">
				<div class="button-container d-flex justify-content-end">
					<button class="btn btn-info rounded-pill shadow-sm"
						onclick="history.back()">
						<i class="bi bi-arrow-return-left" style="padding-right: 5px;"></i>목록
					</button>
					<button class="btn btn-success rounded-pill shadow-sm"
						id="btn-update">
						<i class="bi bi-pencil-square" style="padding-right: 5px;"></i>수정
					</button>
					<button class="btn btn-danger rounded-pill shadow-sm"
						id="btn-delete">
						<i class="bi bi-trash" style="padding-right: 5px;"></i>삭제
					</button>
				</div>
			</c:when>
			<c:otherwise>
				<div class="button-container d-flex justify-content-end">
					<button class="btn btn-info rounded-pill shadow-sm"
						onclick="history.back()">
						<i class="bi bi-arrow-return-left" style="padding-right: 5px;"></i>목록
					</button>
					<button class="btn btn-danger rounded-pill shadow-sm"
						id="btn-delete">
						<i class="bi bi-trash" style="padding-right: 5px;"></i>삭제
					</button>
				</div>
			</c:otherwise>
		</c:choose>

		<div>
			<table class="table table-bordered table-hover">
				<tbody>
					<tr>
						<td>번호</td>
						<td id="id-display" style="text-align: left;"></td>
					</tr>
					<tr>
						<td>작성일</td>
						<td id="createdAt-display" style="text-align: left;"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td id="title-display" style="text-align: left;"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td id="content-display" style="text-align: left;"></td>
					</tr>
					<tr>
						<td>첨부파일</td>
						<td style="text-align: left;"><a id="file-display"></a></td>
					</tr>
				</tbody>
			</table>
		</div>

		<!-- 답변 출력 -->
		<div class="qnaReply" style="margin-top: 30px;"></div>
	</div>
</section>
<script src="/js/board/qna.js"></script>

<script>
	function loadViewId() {

		console.log(typeof addressNum);

		$
				.ajax({
					type : "post",
					url : "/board/qna/qnaView/" + addressNum,
					data : {},
					success : function(data) {

						// id-display 엘리먼트에 데이터 출력
						$("#id-display").html(data.id);

						// 받은 날짜 문자열을 Date 객체로 파싱
						var createdAtDate = new Date(data.createdAt);

						// 날짜를 원하는 형식으로 포맷팅
						var formattedDate = formatDate(createdAtDate);

						// createdAt-display 엘리먼트에 포맷팅된 날짜 출력
						$("#createdAt-display").html(formattedDate);

						// title-display 엘리먼트에 데이터 출력
						$("#title-display").html(data.title);

						// content-display 엘리먼트에 데이터 출력
						$("#content-display").html(data.content);

						// 파일 경로를 쉼표로 분할하여 배열로 만듭니다
						var filePaths = data.filePath.split(',');

						// file-display 엘리먼트에 데이터 출력
						if (filePaths.length > 0) {
							var fileDisplayHTML = ""; // 파일을 보여줄 HTML

							for (var i = 0; i < filePaths.length; i++) {
								if (data.originFileName
										&& data.originFileName[i]) { // originFileName이 정의되어 있을 때만 출력
									fileDisplayHTML += "<a href='" + filePaths[i] + "' download>"
											+ data.originFileName[i]
											+ " <i class='bi bi-file-earmark-arrow-down-fill'></i></a><br>";
									console.log("originFileName:",
											data.originFileName[i]);
								}
							}

							$("#file-display").html(fileDisplayHTML);
						} else {
							$("#file-display").html("첨부 파일이 없습니다.");
						}

					},
					error : function() {
						alert("Error!!!");
					}
				});

	}

	// 날짜를 원하는 형식으로 포맷팅하는 함수
	function formatDate(date) {
		var year = date.getFullYear();
		var month = (date.getMonth() + 1).toString().padStart(2, '0');
		var day = date.getDate().toString().padStart(2, '0');

		return year + '년 ' + month + '월 ' + day + '일';
	}

	//페이지 로드 시 데이터 로딩 함수 호출
	$(document).ready(function() {
		loadViewId();
	});
</script>
<script>
	//답변 불러오기
	function loadQnaReply() {
		let boardQnaId = window.location.pathname.split("/")[4]; // 게시글 번호 가져오기
		console.log(boardQnaId);

		$.ajax({
			type : "POST",
			url : "/board/qna/qnaReply/" + boardQnaId, // 댓글 목록을 가져오는 API 엔드포인트 URL
			success : function(response) {
				console.log("되냐?")
				// 댓글 목록을 받아서 화면에 출력
				if (response) {
					displayQnaReply(response); // 답변이 있는 경우 답변을 출력
				} else {
					displayNoReplyMessage(); // 답변이 없는 경우 메시지 출력
				}
			},
			error : function(xhr, status, error) {
				console.error("Error fetching qna reply:", error);
			}
		});
	}

	// 댓글을 화면에 출력하는 함수
	function displayQnaReply(reply) {
		// 댓글을 출력할 영역의 ID를 가져옴
		let replyContainer = $(".qnaReply");

		// createdAt을 포맷팅
		let formattedDate = formatDate(reply.createdAt);

		// 댓글을 보여줄 HTML 생성

		let replyHTML = "<span id='reply-createdAt-display' style='float: right;'>"
				+ formattedDate
				+ "</span>"
				+ "<h3>답변</h3>"
				+ "<div class='qnaCard'>"
				+ "<div class='info'>"
				+ "</div>"
				+ "<div class='reply-content' style='display: block;'>"
				+ reply.content + "</div>" + "</div>";

		// 댓글을 출력할 영역에 HTML 추가
		replyContainer.append(replyHTML);
	}

	// 답변이 없는 경우 메시지를 출력하는 함수
	function displayNoReplyMessage() {
		let replyContainer = $(".qnaReply");
		replyContainer.append("<p>답변 중입니다.</p>");
	}

	// 날짜 포맷팅 함수 (년-월-일)
	function formatDate(dateString) {
		let date = new Date(dateString);
		let year = date.getFullYear();
		let month = (1 + date.getMonth()).toString().padStart(2, '0');
		let day = date.getDate().toString().padStart(2, '0');

		return year + '-' + month + '-' + day;
	}

	// 페이지 로드 시 댓글 목록을 가져오는 함수 호출
	$(document).ready(function() {
		loadQnaReply();
	});
</script>

<%@include file="/WEB-INF/view/layout/footer.jsp"%>


