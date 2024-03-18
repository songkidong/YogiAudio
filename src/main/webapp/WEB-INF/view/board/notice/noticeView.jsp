<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/layout/header.jsp"%>
<link href="/css/board/view.css" rel="stylesheet">

<section id="board">
	<div class="board-container">
		<h2>공지사항 상세보기</h2>

		<div class="button-container d-flex justify-content-end">
			<button class="btn btn-info rounded-pill shadow-sm"
				onclick="history.back()">
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
			<form class="card">
				<div class="card-header d-flex justify-content-between">
					<label for="id">번호</label> <input type="text" id="id-display"
						readonly>
					<%-- <input type="hidden" id="id-display" value="${posts.id}"> --%>
				</div>
				<div class="card-header d-flex justify-content-between">
					<label for="writer">작성일</label> <input type="text"
						id="writer-display" readonly>
				</div>
				<div class="card-body">
					<label for="title">제목</label> <input type="text"
						class="form-control" id="title-display" readonly> <br />
					<label for="content">내용</label>
					<textarea rows="10" class="form-control" id="content-display"
						readonly></textarea>
					<br /> <label for="file">첨부파일</label> <input type="text"
						class="form-control" id="file-display" readonly>
				</div>
			</form>
		</div>

	</div>
</section>

<script>
	//notice view 출력
	function loadViewId() {

		console.log(51);

		$.ajax({
			type : "post",
			url : "/board/notice/noticeView",
			data : JSON.stringify({
				id : 51
			}),
			contentType : "application/json",
			success : function(data) {

				alert("성공!!!!");

				// id-display 엘리먼트에 데이터 출력
				$("#id-display").html(data.id);

				// title-display 엘리먼트에 데이터 출력
				$("#writer-display").html(data.writerId);

				// title-display 엘리먼트에 데이터 출력
				$("#title-display").html(data.title);

				// content-display 엘리먼트에 데이터 출력
				$("#content-display").html(data.content);

				// file-display 엘리먼트에 데이터 출력
				$("#file-display").html(data.filePath);

			},
			error : function() {
				alert("Error!!!");
			}
		});

	}
	// 페이지 로드 시 데이터 로딩 함수 호출
	loadViewId();
</script>

<!-- <script src="/js/board/notice.js"></script> -->
<%@include file="/WEB-INF/view/layout/footer.jsp"%>


