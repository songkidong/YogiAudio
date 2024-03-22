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
			<table class="table table-bordered table-hover">
				<tbody>
					<tr>
						<td >번호</td>
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


	</div>
</section>

<script src="/js/board/notice.js"></script>

<%@include file="/WEB-INF/view/layout/footer.jsp"%>


