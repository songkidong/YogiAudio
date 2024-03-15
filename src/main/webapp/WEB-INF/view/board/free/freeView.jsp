<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/layout/header.jsp"%>
<link href="/css/board/view.css" rel="stylesheet">

<section id="board">
	<div class="board-container">
		<h2>자유게시판 상세보기</h2>

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
						value="${posts.id}"> <label for="createdDate"
						style="float: right;">2024-03-13</label>
				</div>
				<div class="card-header d-flex justify-content-between">
					<label for="writer">작성자 : user</label> <label for="view"
						style="float: right;"><i class="bi bi-hand-index-thumb">&nbsp55</i></label>
					<!-- 조회수 -->
				</div>
				<div class="card-body">
					<label for="title">제목</label> <input type="text"
						class="form-control" id="title" value="" readonly> <br />
					<label for="content">내용</label>
					<textarea rows="7" class="form-control" id="content" readonly></textarea>
					<br /> <label for="file">첨부파일</label> <input type="text"
						class="form-control" id="file" value="" readonly>
				</div>
			</form>
		</div>

		<div class="commentList" style="margin-top: 30px;">
			<h3>댓글목록</h3>
			<div class="commentCard">
				<div class="info">
					<span class="nick">user</span> <span class="date">2024-03-13</span>
				</div>
				<p class="content" >댓글입니다.</p>
				<div class="actions">

					<!--내가쓴댓글만 수정삭제  -->
					<a href="#" class="remove" data-no="${comment.no}">삭제</a> <input
						type="hidden" name="commentParent" value="${comment.parent}" /> <a
						href="#" class="modify">수정</a>

				</div>
			</div>
		</div>

		<div class="commentForm" style="margin-top: 30px;">
			<h3>댓글쓰기</h3>
			<form id="formComment" action="#" method="post">
				<input type="hidden" name="parent" value="${no}" /> <input
					type="hidden" name="writer" value="${sessUser.uid}" />
				<textarea name="content"></textarea>
				<div style="float:  right;">
					<a href="#" class="btn btnCancel">취소</a> 
					<input type="submit" id="btnComment" value="작성" class="btn btnComplete" />
				</div>
			</form>
		</div>

	</div>
</section>

<%@include file="/WEB-INF/view/layout/footer.jsp"%>


