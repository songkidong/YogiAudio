<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/layout/header.jsp"%>
<link href="/css/board/list.css" rel="stylesheet">

<section id="board">
	<div class="board-container">
		<div class="title-container">
			<h2>
				<a href="/board/free/freeList" style="font-weight: bold;">자유게시판</a>
			</h2>
			<button type="button" class="btn btn-warning" id="btnInsert">
				<i class="bi bi-pencil-square"></i>
			</button>
		</div>


		<div>
			<div class="btn-group dropend" style="float: left; margin-top: 20px;">
				<button type="button" class="btn btn-warning dropdown-toggle"
					data-bs-toggle="dropdown" aria-expanded="false">
					정렬 기준<i class="bi bi-caret-right-fill" style="padding-left: 5px;"></i>
				</button>
				<ul class="dropdown-menu">
					<li><a class="dropdown-item" href="javascript:void(0)"
						onclick="sortBoard('오래된순')">오래된순</a></li>
					<li><a class="dropdown-item" href="javascript:void(0)"
						onclick="sortBoard('조회순')">조회순</a></li>
				</ul>
			</div>

			<form action="/board/free/freeList" method="get">
				<div class="input-group">
					<select name="searchType" class="searchType">
						<option value="titleAndContent">제목+내용</option>
						<option value="writerName">작성자</option>
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
			</form>

		</div>


		<table class="table table-hover">
			<thead class="thead-light text-center">
				<tr>
					<th style="width: 10%;">No</th>
					<th style="width: 50%;">FREE Title</th>
					<th style="width: 15%;">Writer</th>
					<!-- 작성자 마스킹 처리 -->
					<th style="width: 10%;">Hit</th>
					<th style="width: 15%;">Date</th>
				</tr>
			</thead>
			<tbody class="text-center">
				<c:forEach var="list" items="${freeList}">
					<tr class="page-click" id="${list.id}">
						<td>${list.id}</td>
						<td class="text-left">
							<div class="panel-board-container">
								<p class="panel-board-title">${list.title}</p>
							</div>
						</td>
						<td><span class="mask-writer">${list.writerName}</span></td>
						<td>${list.hit}</td>
						<td>${list.formatCreatedAt()}</td>
						<!--날짜포맷-->
					</tr>
				</c:forEach>
		</table>

		<!-- 페이징 처리 -->
		<div class="free pagination" id="freePage">
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
<script>
	//페이징 및 정렬된 데이터를 가져와서 테이블을 업데이트하는 함수
	function updateTable(data) {
		var tableBody = $('.table tbody');
		tableBody.empty();

		data.content
				.forEach(function(item, index) {
					var row = '<tr>'
							+ '<td>'
							+ item.id
							+ '</td>'
							+ '<td class="text-left"><div class="panel-board-container"><p class="panel-board-title">'
							+ item.title + '</p></div></td>'
							+ '<td><span class="mask-writer">'
							+ item.writerName + '</span></td>' + '<td>'
							+ item.hit + '</td>' + '<td>' + item.createdAt
							+ '</td>' + '</tr>';
					tableBody.append(row);
				});

		updatePagination(data); // 페이징 업데이트
	}

	var sortType; // 전역 변수로 sortType 선언

	// 페이징 업데이트 함수
	function updatePagination(data) {
	    var pagination = $('.pagination');
	    pagination.empty();

	    // 현재 정렬 기준 가져오기
	    var sortTypeParam = new URLSearchParams(window.location.search).get('sortType');
	    var sortType = sortTypeParam ? sortTypeParam : ''; // 정렬 기준이 없으면 빈 문자열로 설정

	    // 페이지 번호 생성
	    for (var i = data.startPage; i <= data.endPage; i++) {
	        var pageLink = '<li class="page-item ' + (i === data.number ? 'active' : '') + '">' +
	            '<a class="page-link" href="?sortType=' + sortType + '&page=' + i + '&size=' + data.size + '">' + i + '</a>' +
	            '</li>';
	        pagination.append(pageLink);
	    }

	    // 이전 페이지 및 다음 페이지 링크 생성
	    var prevPageLink = '<li class="page-item">' +
	        '<a class="page-link" href="?sortType=' + sortType + '&page=' + (data.number - 1) + '&size=' + data.size + '">&laquo; Prev</a>' +
	        '</li>';
	    var nextPageLink = '<li class="page-item">' +
	        '<a class="page-link" href="?sortType=' + sortType + '&page=' + (data.number + 1) + '&size=' + data.size + '">Next &raquo;</a>' +
	        '</li>';

	    pagination.append(prevPageLink);
	    pagination.append(nextPageLink);
	}

	//정렬된 데이터를 요청하는 함수
	function sortBoard(type) {
		sortType = type; // 전역 변수 sortType 업데이트

		var currentPage = parseInt($('.pagination .active .page-link').text()); // 현재 페이지 번호 가져오기
		var pageSize = parseInt($('.pagination .page-link').not('.disabled')
				.last().text()); // 페이지 크기 가져오기

		$.ajax({
			url : '/board/free/sort',
			type : 'GET',
			data : {
				sortType : sortType,
				page : currentPage, // 현재 페이지 번호 전달
				size : pageSize
			// 페이지 크기 전달
			},
			success : function(response) {
				updateTable(response);
				updatePagination(response);
			},
			error : function(xhr, status, error) {
				console.error('Error:', error);
			}
		});
	}
	
	
</script>
<script src="/js/board/free.js"></script>
<%@include file="/WEB-INF/view/layout/footer.jsp"%>


