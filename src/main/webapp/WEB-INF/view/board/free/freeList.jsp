<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/layout/header.jsp"%>
<link href="/css/board/list.css" rel="stylesheet">

<section id="board">
	<div class="board-container">
		<div class="title-container">
			<h2>자유게시판</h2>
			<button type="button" class="btn btn-warning" id="btnInsert">
				<i class="bi bi-pencil-square"></i>
			</button>
		</div>

		<div>
			<div class="btn-group dropend" style="float: left; margin-top: 20px;">
				<button type="button" class="btn btn-warning dropdown-toggle"
					data-bs-toggle="dropdown" aria-expanded="false">정렬 기준<i class="bi bi-caret-right-fill" style="padding-left: 5px;"></i></button>
				<ul class="dropdown-menu">
					<li><a class="dropdown-item" href="#">최신순</a></li>
					<li><a class="dropdown-item" href="#">조회순</a></li>
				</ul>
			</div>

			<div class="input-group">
				<select name="searchType" class="searchType">
					<option value="title">제목+내용</option>
					<option value="content">작성자</option>
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
					<th>FREE Title</th>
					<th>Writer</th>
					<!-- 작성자 마스킹 처리 -->
					<th>Hit</th>
					<th>Date</th>
				</tr>
			</thead>
			<tbody class="text-center">
				<tr>
					<td>1</td>
					<td>Free1</td>
					<td>Jo*n</td>
					<td>55</td>
					<td>2024-03-12</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Free1</td>
					<td>Jo*n</td>
					<td>55</td>
					<td>2024-03-12</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Free1</td>
					<td>Jo*n</td>
					<td>55</td>
					<td>2024-03-12</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Free1</td>
					<td>Jo*n</td>
					<td>55</td>
					<td>2024-03-12</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Free1</td>
					<td>Jo*n</td>
					<td>55</td>
					<td>2024-03-12</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Free1</td>
					<td>Jo*n</td>
					<td>55</td>
					<td>2024-03-12</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Free1</td>
					<td>Jo*n</td>
					<td>55</td>
					<td>2024-03-12</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Free1</td>
					<td>Jo*n</td>
					<td>55</td>
					<td>2024-03-12</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Free1</td>
					<td>Jo*n</td>
					<td>55</td>
					<td>2024-03-12</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Free1</td>
					<td>Jo*n</td>
					<td>55</td>
					<td>2024-03-12</td>
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


