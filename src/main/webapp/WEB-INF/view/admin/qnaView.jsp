<%@page import="com.project3.yogiaudio.dto.admin.NoticeSaveFormDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/view/admin/layout/header.jsp" %>


<!-- cs파트 css 가져오기 -->
<link href="/css/admin/view.css" rel="stylesheet">

<style>
	#replyButton:hover {
		background-color: skyblue;
	}
</style>


<%-- <%NoticeSaveFormDTO dto = new NoticeSaveFormDTO()%> --%>

<!-- Content -->
	<%-- <input type="text" value="<%=dto.getFiles()%>"> --%>
	<!-- 수평선 -->
	<hr class="my-5" />
	
	<section id="board">
	<div class="board-container">
		<h2>QnA 상세보기</h2>

		<div class="button-container d-flex justify-content-end">
			<!-- onclick="history.back()" 하면 답변 등록됐을 때 view 페이지는  답변 여부가 업데이트가 되는데, list 페이지는 반영 안됨 -->
			<a href="/admin/qnaList" class="btn btn-info rounded-pill shadow-sm" style="color: white;">목록</a>
			<button class="btn btn-danger rounded-pill shadow-sm" id="deleteButton" data-id="${qna.id }">삭제</button>
		</div>

		<div>
			<form class="card">
				<div class="card-header d-flex justify-content-between">
					<label for="id">번호 : ${qna.id}</label> 
					<label for="createdDate" style="float: right;">${qna.formatCreatedAt()}</label>
				</div>
				<div class="card-header d-flex justify-content-between">
					<label for="writer">작성자 : ${qna.writerName}</label> 
					<label for="view" style="float: right;"><i class="bi bi-hand-index-thumb">답변여부 : ${qna.answerYn }</i></label>
				</div>
				<div class="card-body">
					<label for="title">제목</label> <input type="text"
						class="form-control" id="title" value="${qna.title }" readonly> <br />
					<label for="content">내용</label>
					<!-- style="white-space: pre-wrap;" db에 입력된대로 줄바꿈 -->
					<!-- data-content = "${qna.content}" 로 지정해서, 자바스크립트로 innerHTML 했는데 안됨 -->
					<!-- textarea 라서 안된 것!!! textarea는 텍스트만 출력!!! -->
					<div style="white-space: pre-wrap; min-height: 300px;" class="form-control">${qna.content}</div>
					<br /> 
					<label for="file">첨부파일</label> 
                    <!-- 링크 클릭하면 바로 다운로드됨 -->
                    <!-- http://localhost/filedb/get-file/f8b843fecaf34737a8aae2e2e3d935da  -->
                    <!-- 반복문 -->
                    <c:forEach var="boardFileDTO" items="${BoardFileDTOList }">
                    	<li>
                    		<a class="hrefButton" href="${boardFileDTO.filePath }" style="font-size: 20px;">${boardFileDTO.originFileName }</a>
                    		<a class="deleteFileButton"><i class="fas fa-times" style="margin-left: 10px; font-size: 20px;"></i></a>
                    	</li>
                    </c:forEach>
				</div>
			</form>
		</div>

		<!-- 반복문 -->
		<!-- 답변출력 -->
		<div class="commentList" style="margin-top: 30px;">
			<h3>답변 목록</h3>
			<c:forEach var="reply" items="${replyList}">
			<div class="commentCard">
				<div class="info">
					<span class="nick">${reply.writerName }</span> <span class="date">${reply.formatCreatedAt() }</span>
				</div>
				<input class="content" value="${reply.content }" readonly 
				style="background-color: #f9f9f9; border-style: none; width: 50%;"/>
				<div class="actions">

						<a href="#" class="updateReply">수정</a>
						<a href="#" class="deleteReply" data-id="${reply.id}" data-boardQnaId="${qna.id }">삭제</a>
						<a href="#" class="completeUpdate" data-id="${reply.id}" data-boardQnaId="${qna.id}" style="display:none;">수정완료</a>
						<a href="#" class="cancelUpdate" style="display:none;">취소</a>
					</div>
			</div>
			</c:forEach>
		</div>
		
		<!-- 반복문 end-->
		<br>
		<hr>
		
		<!-- 답변등록 -->
		<div class="commentForm" style="margin-top: 30px;">
			<h3>답변 등록</h3>
			<form id="replyForm">
				<textarea id="reply--textarea" name="content"></textarea>
				<div style="float:  right;">
					<!-- href 속성 빼니까 클릭할 때 스크롤이 위로 안 올라감 -->
					<a id="cancelButton" class="btn btnCancel">취소</a>
					<!-- input에 type button 하기 -->
					<input data-id="${qna.id }" id="replyButton" type="button" value="확인" class="btn btnComplete" style="border: 2px solid skyblue; color: skyblue;" />
				</div>
			</form>
		</div>

		

	</div>
	</section>
	
	
	
	
	
<!-- / Content -->




<script src="/js/admin/qnaview.js"></script>
<%@ include file="/WEB-INF/view/admin/layout/footer.jsp" %>            
		
		
		