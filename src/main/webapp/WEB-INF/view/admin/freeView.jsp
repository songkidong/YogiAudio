<%@page import="com.project3.yogiaudio.dto.admin.NoticeSaveFormDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/view/admin/layout/header.jsp" %>


<!-- cs파트 css 가져오기 -->
<link href="/css/admin/view.css" rel="stylesheet">



<%-- <%NoticeSaveFormDTO dto = new NoticeSaveFormDTO()%> --%>

<!-- Content -->
	<%-- <input type="text" value="<%=dto.getFiles()%>"> --%>
	<!-- 수평선 -->
	<hr class="my-5" />
	
	<section id="board">
	<div class="board-container">
		<h2>자유게시판 상세보기</h2>

		<div class="button-container d-flex justify-content-end">
			<!-- onclick="history.back()" -->
			<!-- 내가 직전에 보던 페이지로 이동 가능 -->
			<button class="btn btn-info rounded-pill shadow-sm" onclick="history.back()">
				<i class="bi bi-arrow-return-left" style="padding-right: 5px;"></i>목록
			</button>
			
			<button class="btn btn-danger rounded-pill shadow-sm" id="deleteButton" data-id="${free.id }">
				<i class="bi bi-trash" style="padding-right: 5px;"></i>삭제
			</button>
		</div>

		<div>
			<form class="card">
				<div class="card-header d-flex justify-content-between">
					<label for="id">번호 : ${free.id}</label> 
					<label for="createdDate" style="float: right;">${free.formatCreatedAt()}</label>
				</div>
				<div class="card-header d-flex justify-content-between">
					<label for="writer">작성자 : ${free.writerName}</label> 
					<label for="view" style="float: right;"><i class="bi bi-hand-index-thumb">&nbsp ${free.hit }</i></label>
				</div>
				<div class="card-body">
					<label for="title">제목</label> <input type="text"
						class="form-control" id="title" value="${free.title }" readonly> <br />
					<label for="content">내용</label>
					<textarea rows="7" class="form-control" id="content" readonly>${free.content }</textarea>
					<br /> 
					<label for="file">첨부파일</label> 
                    <!-- 링크 클릭하면 바로 다운로드됨 -->
                    <!-- http://localhost/filedb/get-file/f8b843fecaf34737a8aae2e2e3d935da  -->
                    <div><a href="${free.filePath}">${free.filePath}</a></div>
				</div>
			</form>
		</div>

		<!-- 반복문 -->
		
		<div class="commentList" style="margin-top: 30px;">
			<h3>댓글목록</h3>
			<c:forEach var="comment" items="${commentList }">
			<div class="commentCard">
				<div class="info">
					<span class="nick">${comment.writerName }</span> <span class="date"></span>
				</div>
				<p class="content" >댓글입니다.</p>
				<div class="actions">

					<a href="#" class="deleteComment" data-id="${comment.id }" >삭제</a> 

				</div>
			</div>
			</c:forEach>
		</div>
		
		<!-- 반복문 end-->

		

	</div>
	</section>
	
	
	
	
	
<!-- / Content -->




<script src="/js/admin/freeview.js"></script>
<%@ include file="/WEB-INF/view/admin/layout/footer.jsp" %>            
		
		
		