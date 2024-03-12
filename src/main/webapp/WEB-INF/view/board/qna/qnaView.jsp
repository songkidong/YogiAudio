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
			<form class="card">
				<div class="card-header d-flex justify-content-between">
					<label for="id">번호 : 1</label> <input type="hidden" id="id"
						value="${posts.id}">
				</div>
				<div class="card-header d-flex justify-content-between">
					<label for="writer">작성자 : user</label>
				</div>
				<div class="card-body">
					<label for="title">제목</label> <input type="text"
						class="form-control" id="title" value="${posts.title}" readonly>
					<br /> <label for="content">내용</label>
					<textarea rows="5" class="form-control" id="content" readonly>${posts.content}</textarea>
				</div>
			</form>
		</div>
		
		<div class="card">
			<div class="card-header bi bi-chat-dots">
				<label for="writer">&nbsp;user</label>
			</div>
			<a type="button" data-toggle="collapse"
				data-target=".multi-collapse-${comment.id}"
				class="bi bi-pencil-square"></a>
			<!-- 댓글 수정 버튼 -->
			<a type="button"
				onclick="main.commentDelete(${comment.postsId},${comment.id},${comment.userId},${user.id})"
				class="bi bi-x-square"></a>
			<!-- 댓글 삭제 버튼 -->
			<!-- 댓글 내용 보기 -->
			<p class="collapse multi-collapse-${comment.id} show">${comment.comment}</p>

			<!-- 댓글 내용 수정 -->
			<form class="collapse multi-collapse-${comment.id}">
				<input type="hidden" id="id" value="${comment.id}"> <input
					type="hidden" id="postsId" value="${comment.postsId}"> <input
					type="hidden" id="writerUserId" value="${comment.userId}">
				<input type="hidden" id="sessionUserId" value="${user.id}">
				<div class="form-group">
					<textarea class="form-control" id="comment-content" rows="3">${comment.comment}</textarea>
				</div>
				<button type="button" id="btn-comment-update"
					class="btn btn-outline-primary bi bi-pencil-square">수정</button>
			</form>
			</li>
		</div>

	</div>
</section>

<%@include file="/WEB-INF/view/layout/footer.jsp"%>


