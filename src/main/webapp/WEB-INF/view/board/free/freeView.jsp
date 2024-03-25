<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/layout/header.jsp"%>
<link href="/css/board/view.css" rel="stylesheet">
<link href="/css/board/freeView.css" rel="stylesheet">

<section id="board">
	<div class="board-container">
		<h2>자유게시판 상세보기</h2>

		<div class="button-container d-flex justify-content-end">
			<!-- Button to Open the Modal -->
			<!-- 게시글 신고 버튼 start -->
			<button type="button"
				class="btn btn-secondary rounded-pill shadow-sm" data-toggle="modal"
				data-target="#myModal">
				<i class="bi bi-emoji-angry" style="padding-right: 5px;"></i>신고
			</button>
			<!-- 게시글 신고 버튼 end -->

			<!-- The Modal -->
			<div class="modal" id="myModal">
				<div class="modal-dialog">
					<div class="modal-content">

						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">게시글 신고하기</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>

						<!-- Modal body -->
						<div class="modal-body">
							<div class="form-group">
								<label for="comment">신고내용:</label>
								<textarea class="form-control" rows="5" id="reportFreeContent"></textarea>
							</div>
						</div>

						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary"
								data-dismiss="modal" id="reportFreeBtn">신고 완료</button>
						</div>

					</div>
				</div>
			</div>
			<!-- modal end -->
			<!-- The Modal -->
			<div class="modal" id="commentModal">
				<div class="modal-dialog">
					<div class="modal-content">

						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">댓글 신고하기</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>

						<!-- Modal body -->
						<div class="modal-body">
							<div class="form-group">
								<label for="comment">신고내용:</label>
								<textarea class="form-control" rows="5" id="comment"></textarea>
							</div>
						</div>

						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary"
								data-dismiss="modal" id="reportCommentBtn">신고 완료</button>
						</div>

					</div>
				</div>
			</div>
			<!-- modal end -->

			<button class="btn btn-info rounded-pill shadow-sm"
				onclick="goBack()">
				<i class="bi bi-arrow-return-left" style="padding-right: 5px;"></i>목록
			</button>
			<button class="btn btn-success rounded-pill shadow-sm"
				id="btn-update">
				<i class="bi bi-pencil-square" style="padding-right: 5px;"></i>수정
			</button>
			<button class="btn btn-danger rounded-pill shadow-sm" id="btn-delete">
				<i class="bi bi-trash" style="padding-right: 5px;"></i>삭제
			</button>
		</div>

		<div>
			<table class="table table-bordered table-hover">
				<tbody>
					<tr>
						<td>번호</td>
						<td id="id-display" style="text-align: left;"></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td id="writerName-display" style="text-align: left;"></td>
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

		<!-- 댓글 작성 -->
		<div class="commentWrite" style="margin-top: 30px;">
			<div style="display: flex; align-items: center;">
				<h3 style="margin-right: 10px;">댓글 등록</h3>
				<!-- Adjust margin-right for spacing -->
				<button class="btn btn-primary rounded-pill shadow-sm"
					id="btn-save-reply" style="margin-bottom: 11px;">+</button>
			</div>
			<div class="form-group" style="margin-bottom: 20px;">
				<textarea class="form-control" id="reply-content" rows="3"></textarea>
			</div>
		</div>

		<!-- 댓글 출력 -->
		<div class="commentList" style="margin-top: 30px;">
			<h3>댓글 목록</h3>
			<!-- 수정 가능한 댓글 -->
			<div class="commentCard">
				<div class="info">
					<span id="reply-writerName-display">작성자</span> <span
						id="reply-createdAt-display" style="float: right;">작성일</span>
				</div>
				<div class="comment-content" style="display: block;">댓글 내용</div>
				<!-- 삭제 버튼 -->
				<button class="btn btn-danger btn-sm" style="margin-top: 5px;"
					onclick="deleteComment(commentId)">삭제</button>
			</div>
		</div>
	</div>
</section>


<script>
	function loadViewId() {

		console.log(typeof addressNum);

		$
				.ajax({
					type : "post",
					url : "/board/free/freeView/" + addressNum,
					data : {},
					success : function(data) {

						// id-display 엘리먼트에 데이터 출력
						$("#id-display").html(data.id);

						// writerName-display 엘리먼트에 데이터 출력
						$("#writerName-display").html(data.writerName);

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
	// 댓글 목록 불러오기
	function loadCommentList() {
		let addressNum = window.location.pathname.split("/")[4]; // 게시글 번호 가져오기

		$.ajax({
			type : "GET",
			url : "/board/free/freeCommentList/" + addressNum, // 댓글 목록을 가져오는 API 엔드포인트 URL
			success : function(response) {
				// 댓글 목록을 받아서 화면에 출력
				displayCommentList(response);
			},
			error : function(xhr, status, error) {
				console.error("Error fetching comment list:", error);
			}
		});
	}

	// 댓글 목록을 화면에 출력하는 함수
	function displayCommentList(comments) {
		var commentListHTML = ""; // 댓글 목록을 담을 HTML 문자열

		// 각 댓글에 대해 HTML 생성
		for (var i = 0; i < comments.length; i++) {
			var comment = comments[i];

			// 받은 날짜 문자열을 Date 객체로 파싱
			var createdAtDate = new Date(comment.createdAt);

			// 날짜를 원하는 형식으로 포맷팅
			var formattedDate = formatDate(createdAtDate);

			commentListHTML += "<div class='commentCard' style='overflow: auto;'>"; // 스타일 추가
			commentListHTML += "<div class='info'>";
			commentListHTML += "<span>" + comment.writerName + "</span>"; // 작성자 이름
			commentListHTML += "<span style='float: right;'>" + formattedDate
					+ "</span>"; // 작성일
			commentListHTML += "</div>";
			commentListHTML += "<div style='display: flex;'>"; // 댓글 내용과 수정 버튼을 담을 컨테이너
			commentListHTML += "<textarea class='form-control' id='comment-content-" + comment.id + "' rows='3' readonly>"
					+ comment.content + "</textarea>"; // 댓글 내용
			commentListHTML += "<button style='float: right;' class='btn btn-danger' onclick='deleteComment("
					+ comment.id + ")'>삭제</button>"; // 삭제 버튼
			commentListHTML += "<button type='button' class='btn btn-secondary rounded-pill shadow-sm report-button' data-toggle='modal' data-target='#commentModal' data-comment-id='" + comment.id + "'>";
			commentListHTML += "<i class='bi bi-emoji-angry' style='padding-right: 5px;'></i>신고";
			commentListHTML += "</button>";
			commentListHTML += "</div>";
			commentListHTML += "</div>";
		}

		// 댓글 목록을 출력할 엘리먼트에 HTML 삽입
		$(".commentList").html(commentListHTML);
	}

	// 페이지 로드 시 댓글 목록을 가져오는 함수 호출
	$(document).ready(function() {
		loadCommentList();
	});

	// 댓글 삭제 함수
	function deleteComment(id) {
		// 사용자에게 확인 메시지 표시
		if (confirm("정말로 삭제하시겠습니까?")) {
			// 확인을 누르면 AJAX 요청으로 댓글 삭제 처리
			$.ajax({
				type : "DELETE",
				url : "/board/free/freeComment/" + id, // 댓글 삭제 엔드포인트 URL
				success : function(response) {
					// 성공적으로 삭제되면 페이지 새로고침 또는 댓글 목록 갱신
					// 여기서는 페이지 새로고침을 예시로 했습니다.
					location.reload();
				},
				error : function(xhr, status, error) {
					console.error("Error deleting comment:", error);
				}
			});
		} else {
			// 취소를 누르면 아무 동작도 하지 않음
			return false;
		}
	}
</script>
<script>
let reportObject = {
		init: function() {
			$("#reportFreeBtn").on("click", () => {
				this.reportFree();
			});
		},

		reportFree: function() {

			alert("게시글 신고 요청");

			const reportFreeContent = $("#reportFreeContent").val();

			if (reportFreeContent === "") {
	            // If empty, show an alert and return early to prevent further execution
	            alert("신고 이유를 적어주세요.");
	            return;
	        }
			// AJAX 요청을 보냅니다.
			$.ajax({
				type: "POST",
				url: "/board/free/freeComment/" + addressNum,
				contentType: "application/json",  // Content-Type을 JSON으로 설정
				data: JSON.stringify({
					boardFreeId: addressNum,
					content: commentContent
				}),
				success: function(data) {
					console.log(data);
					if (data === true) {
						// 성공적으로 데이터가 저장되었을 때.
						location.reload();
					} else {
						// 실패했을 때 처리할 내용을 작성하세요.
						alert("데이터 저장에 실패했습니다.");
					}
				},
				error: function() {
					// 에러가 발생했을 때 처리할 내용을 작성하세요.
					alert("서버와의 통신 중 에러가 발생했습니다.");
				}
			});
		}
	};

reportObject.init();

</script>

<script>
	// 뒤로가기 버튼 조회수 반영 새로고침
	function goBack() {
		// 이전 페이지의 URL 가져오기
		var previousPageUrl = "/board/free/freeList";

		// 이전 페이지로 이동
		window.location.href = previousPageUrl;
	}
</script>

<script src="/js/board/free.js"></script>

<%@include file="/WEB-INF/view/layout/footer.jsp"%>


