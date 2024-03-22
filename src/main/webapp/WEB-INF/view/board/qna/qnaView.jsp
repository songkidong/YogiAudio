<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/layout/header.jsp"%>
<link href="/css/board/view.css" rel="stylesheet">

<section id="board">
	<div class="board-container">
		<h2>나의 문의하기 상세보기</h2>

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
						<td id="file-display" style="text-align: left;"></td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="commentList" style="margin-top: 30px;">
			<h3>답변</h3>
			<div class="commentCard">
				<div class="info">
					<span class="nick">admin</span> <span class="date">2024-03-13</span>
				</div>
				<p class="content">답변입니다.</p>
				<div class="actions">

					<!-- 관리자만 수정삭제  -->
					<a href="#" class="remove" data-no="${comment.no}">삭제</a> <input
						type="hidden" name="commentParent" value="${comment.parent}" /> <a
						href="#" class="modify">수정</a>

				</div>
			</div>
		</div>

		<div class="commentForm" style="margin-top: 30px;">
			<h3>답변쓰기</h3>
			<form id="formComment" action="#" method="post">
				<input type="hidden" name="parent" value="${no}" /> <input
					type="hidden" name="writer" value="${sessUser.uid}" />
				<textarea name="content"></textarea>
				<div style="float: right;">
					<a href="#" class="btn btnCancel">취소</a> <input type="submit"
						id="btnComment" value="작성" class="btn btnComplete" />
				</div>
			</form>
		</div>

	</div>
</section>

<script>
	function loadViewId() {

		console.log(typeof addressNum);

		$.ajax({
			type : "post",
			url : "/board/qna/qnaView/" + addressNum,
			data : {},
			success : function(data) {

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
			error : function() {
				alert("Error!!!");
			}
		});
	}

	//페이지 로드 시 데이터 로딩 함수 호출
	$(document).ready(function() {
		loadViewId();
	});
</script>

<script src="/js/board/qna.js"></script>

<%@include file="/WEB-INF/view/layout/footer.jsp"%>


