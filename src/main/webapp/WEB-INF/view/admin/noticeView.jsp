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
		<h2>공지사항 상세보기</h2>

		<div class="button-container d-flex justify-content-end">
			<!-- onclick="history.back()" 하면 답변 등록됐을 때 view 페이지는  답변 여부가 업데이트가 되는데, list 페이지는 반영 안됨 -->
			<a href="/admin/noticeList" class="btn btn-info rounded-pill shadow-sm" style="color: white;">목록</a>
			<a href="/admin/updateNotice/${notice.id}" class="btn btn-danger rounded-pill shadow-sm" id="" data-id="${notice.id }">수정</a>
			<button class="btn btn-danger rounded-pill shadow-sm" id="deleteButton" data-id="${notice.id }">삭제</button>
		</div>

		<div>
			<form class="card">
				<div class="card-header d-flex justify-content-between">
					<label for="id">번호 : ${notice.id}</label> 
					<label for="createdDate" style="float: right;">${notice.formatCreatedAt()}</label>
				</div>
				<div class="card-header d-flex justify-content-between">
					<label for="writer">작성자 : ${notice.writerName}</label> 
				</div>
				<div class="card-body">
					<label for="title">제목</label> <input type="text"
						class="form-control" id="title" value="${notice.title }" readonly> <br />
					<label for="content">내용</label>
					<!-- textarea라서 태그가 그대로 텍스트로 출력됐던 것! -->
					<div style="white-space: pre-wrap; min-height: 500px;" class="form-control">${notice.content}</div>
					<br /> 
					<label for="file">첨부파일</label> 
                    <!-- 링크 클릭하면 바로 다운로드됨 -->
                    <!-- http://localhost/filedb/get-file/f8b843fecaf34737a8aae2e2e3d935da  -->
                    <!-- 파일 원본이름으로 출력하는 방법은?? -->
                    <div id="filePaths" data-filePaths="${notice.filePath }"></div>
				</div>
			</form>
		</div>

		
		
		
		

		

	</div>
	</section>
	
	
	
	
	
<!-- / Content -->



<script src="/js/admin/noticeview.js"></script>
<%@ include file="/WEB-INF/view/admin/layout/footer.jsp" %>            
		
		
		