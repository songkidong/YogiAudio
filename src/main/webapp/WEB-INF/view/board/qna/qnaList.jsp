<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/layout/header.jsp"%>
<link href="/css/board/list.css" rel="stylesheet">

<section id="board">
	<div class="board-container">
		<div class="title-container">
			<h2>나의 문의하기</h2>
			<!-- 리스트 : 쿼리 where 유저id  -->
			<button type="button" class="btn btn-warning" id="btnInsert">
				<i class="bi bi-pencil-square"></i>
			</button>
		</div>

		<div>
			<div class="input-group">
				<select name="searchType" class="searchType">
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="rdate">작성일</option>
				</select>
				<div class="form-outline">
					<input type="search" id="form1" class="searchInput" name="keyword"
						placeholder="Search" style="height: 40px" />
				</div>

				<button type="button" class="btn btn-warning searchButton">
					<i class="bi bi-search"></i>
				</button>
			</div>
		</div>


		<table class="table table-hover">
			<thead class="thead-light text-center">
				<tr>
					<th style="width: 10%;">No</th>
					<th style="width: 50%;">QNA Title</th>
					<th style="width: 15%;">Writer</th>
					<!-- 작성자 마스킹 처리 js-->
					<th style="width: 10%;">Date</th>
					<!-- 날짜포맷  -->
					<th style="width: 15%;">Answer</th>
					<!-- 답변여부 -->
				</tr>
			</thead>
			<tbody class="text-center">
				<tr>
					<td>1</td>
					<td>Qna1</td>
					<td>Jo*n</td>
					<td>2024-03-12</td>
					<td>답변완료</td>
				</tr>
		</table>

		<!-- 페이징 처리 -->
		<div class="notice pagination" id="noticePage">
			<c:if test="${page > 1}">
				<li class="page-item"><a href="?page=1&size=${size}"
					class="page-link">&laquo; 첫 페이지</a></li>
				<li class="page-item"><a href="?page=${page - 1}&size=${size}"
					class="page-link">&laquo; Prev</a></li>
			</c:if>
			<c:forEach begin="${startPage}" end="${endPage}" var="i">
				<c:choose>
					<c:when test="${i eq page}">
						<li class="page-item active"><a
							href="?page=${i}&size=${size}" class="page-link">${i}</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a href="?page=${i}&size=${size}"
							class="page-link">${i}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${page < totalPages}">
				<li class="page-item"><a href="?page=${page + 1}&size=${size}"
					class="page-link">Next &raquo;</a></li>
				<li class="page-item"><a
					href="?page=${totalPages}&size=${size}" class="page-link">마지막
						페이지 &raquo;</a></li>
			</c:if>
		</div>

	</div>
</section>

<script src="/js/board/qna.js"></script>
<%@include file="/WEB-INF/view/layout/footer.jsp"%>


