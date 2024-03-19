<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/layout/header.jsp"%>
<link href="/css/board/list.css" rel="stylesheet">

<section id="board">
	<div class="board-container">
		<div class="title-container">
			<h2>
				<a href="/board/notice/noticeList">공지사항</a>
			</h2>
			<!-- 검색 후 페이지 고침 -->
			<button type="button" class="btn btn-warning" id="btnInsert">
				<i class="bi bi-pencil-square"></i>
			</button>
		</div>

		<form action="/board/notice/noticeList" method="get">
			<div>
				<div class="input-group">
					<select name="searchType" class="searchType">
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="createdAt">작성일</option>
					</select>
					<div class="form-outline">
						<input type="search" id="form1" class="searchInput"
							name="searchInput" placeholder="Search" style="height: 40px" />
					</div>

					<button type="submit" class="btn btn-warning searchButton">
						<i class="bi bi-search"></i>
					</button>
				</div>
			</div>
		</form>


		<table class="table table-hover">
			<thead class="thead-light text-center">
				<tr>
					<th style="width: 10%;">No</th>
					<!-- 최신글 상위3개 메가폰아이콘 처리 js???????????-->
					<th style="width: 55%;">NOTICE Title</th>
					<th style="width: 10%;">Writer</th>
					<th style="width: 10%;">File</th>
					<!-- 첨부됐으면 파일아이콘 처리 -->
					<th style="width: 15%;">Date</th>
				</tr>
			</thead>
			<tbody class="text-center">
				<c:forEach var="list" items="${noticeList}">
					<tr class="page-click" id="${list.id}">
						<td>${list.id}</td>
						<td class="text-left">
							<div class="panel-board-container">
								<p class="panel-board-title">${list.title}</p>
							</div>
						</td>
						<td><span class="mask-writer">${list.writerName}</span></td>
						<c:choose>
							<c:when test="${not empty list.filePath}">
								<td><i class="bi bi-file-earmark-minus-fill"></i></td>
							</c:when>
							<c:otherwise>
								<td></td>
							</c:otherwise>
						</c:choose>
						<td>${list.formatCreatedAt()}</td> <!--날짜포맷-->
					</tr>
				</c:forEach>
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

<script src="/js/board/notice.js"></script>
<%@include file="/WEB-INF/view/layout/footer.jsp"%>


