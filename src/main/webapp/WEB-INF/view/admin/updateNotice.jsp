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
		<h2>공지사항 수정하기</h2>

		<div class="button-container d-flex justify-content-end">
			<!-- onclick="history.back()" 하면 답변 등록됐을 때 view 페이지는  답변 여부가 업데이트가 되는데, list 페이지는 반영 안됨 -->
			<a onclick="history.back()" class="btn btn-info rounded-pill shadow-sm" style="color: white;">취소</a>
		</div>

		<div>
			<!-- enctype="multipart/form-data" 빠트리지 않기 -->
			<form id="form" class="card" enctype="multipart/form-data">
				<div class="card-header d-flex justify-content-between">
					<label for="id">번호 : ${notice.id}</label> 
					<label for="createdDate" style="float: right;">${notice.formatCreatedAt()}</label>
				</div>
				<div class="card-header d-flex justify-content-between">
					<label for="writer">작성자 : ${notice.writerName}</label> 
				</div>
				<div class="card-body">
					<label for="title">제목</label> 
					<input type="text" class="form-control" id="title" value="${notice.title }" name="title">
					<br />
					<label for="content">내용</label>
					<!--textarea는 rows 로 크기 조절 -->
					<textarea id="content" style="white-space: pre-wrap;" class="form-control" name="content">${notice.content}</textarea>
					<br /> 
					<label for="file">첨부파일</label> 
                    <!-- 링크 클릭하면 바로 다운로드됨 -->
                    <!-- http://localhost/filedb/get-file/f8b843fecaf34737a8aae2e2e3d935da  -->
                    <!-- 파일 원본이름으로 출력하는 방법은?? -->
                   	<!-- 반복문 -->
                    <c:forEach var="boardFileDTO" items="${BoardFileDTOList }">
                    	<li>
                    		<a class="hrefButton" href="${boardFileDTO.filePath }" style="font-size: 20px;">${boardFileDTO.originFileName }</a>
                    		<a class="deleteFileButton"><i class="fas fa-times" style="margin-left: 10px; font-size: 20px;"></i></a>
                    	</li>
                    </c:forEach>
				</div>
				
				<br>
				<div class="mb-3">
	                 <label for="formFileMultiple" class="form-label">파일 첨부</label>
	                 <!-- multiple 속성으로 여러개 첨부 가능 -->
	                 <!-- name 속성 빠트리지 말기 -->
	                 <input name="files" class="form-control" type="file" id="formFileMultiple" multiple="">
	                 
	                 <br>
	                 <button id="updateButton" data-id="${notice.id }" class="btn btn-primary" style="width: 95%; margin-left: 40px;">수정</button>
          		</div>
	               
	            
			</form>
		</div>

		
		
		
		

		

	</div>
	</section>
	
	
	
	
	
<!-- / Content -->

<!-- 서머노트 라이브러리 -->
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<script>
	$('#content').summernote(
			{
				tabsize : 2,
				height : 200,
				toolbar : [ [ 'style', [ 'style' ] ],
						[ 'font', [ 'bold', 'underline', 'clear' ] ],
						[ 'color', [ 'color' ] ],
						[ 'para', [ 'ul', 'ol', 'paragraph' ] ],
						[ 'table', [ 'table' ] ],
						[ 'insert', [ 'link', 'picture', 'video' ] ],
						[ 'view', [ 'fullscreen', 'codeview', 'help' ] ] ],
				
			});
</script>

<script src="/js/admin/updatenotice.js"></script>
<%@ include file="/WEB-INF/view/admin/layout/footer.jsp" %>            
		
		
		