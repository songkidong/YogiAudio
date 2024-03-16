<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/layout/header.jsp"%>
<link href="/css/board/list.css" rel="stylesheet">

<section id="board">
	<div class="board-container">
		<div class="title-container">
			<h2>나의 문의하기</h2> <!-- 리스트 : 쿼리 where 유저id  -->
			<button type="button" class="btn btn-warning" id="btnInsert" >
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
					<th>No</th>
					<th>QNA Title</th>
					<th>Writer</th>
					<!-- 작성자 마스킹 처리 -->
					<th>Date</th>
					<th>Answer</th>
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
				<tr>
					<td>1</td>
					<td>Qna1</td>
					<td>Jo*n</td>
					<td>2024-03-12</td>
					<td>답변완료</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Qna1</td>
					<td>Jo*n</td>
					<td>2024-03-12</td>
					<td>답변완료</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Qna1</td>
					<td>Jo*n</td>
					<td>2024-03-12</td>
					<td>답변완료</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Qna1</td>
					<td>Jo*n</td>
					<td>2024-03-12</td>
					<td>답변완료</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Qna1</td>
					<td>Jo*n</td>
					<td>2024-03-12</td>
					<td>답변완료</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Qna1</td>
					<td>Jo*n</td>
					<td>2024-03-12</td>
					<td>답변완료</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Qna1</td>
					<td>Jo*n</td>
					<td>2024-03-12</td>
					<td>답변완료</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Qna1</td>
					<td>Jo*n</td>
					<td>2024-03-12</td>
					<td>답변완료</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Qna1</td>
					<td>Jo*n</td>
					<td>2024-03-12</td>
					<td>답변완료</td>
				</tr>
		</table>

		<div>
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">
					<li class="page-item disabled"><a class="page-link">Previous</a>
					</li>
					<li class="page-item"><a class="page-link" href="#">1</a></li>
					<li class="page-item"><a class="page-link" href="#">2</a></li>
					<li class="page-item"><a class="page-link" href="#">3</a></li>
					<li class="page-item"><a class="page-link" href="#">Next</a></li>
				</ul>
			</nav>
		</div>

	</div>
</section>



<%@include file="/WEB-INF/view/layout/footer.jsp"%>


