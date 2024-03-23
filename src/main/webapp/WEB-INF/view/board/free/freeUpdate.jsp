<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/layout/header.jsp"%>
<link href="/css/board/update.css" rel="stylesheet">

<!-- 서머노트 -->
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<section id="board">
	<div class="board-container">
		<h2>자유게시판 수정하기</h2>

		<form>
			<div class="mb-3" style="padding-bottom: 30px;">
				<label for="title">제목:</label> <input type="text"
					class="form-control" id="updated-title" name="title" value="${freeDTO.title}">
			</div>
			<div class="mb-3" style="padding-bottom: 30px;">
				<label for="content">내용:</label>
				<textarea id="updated-content" name="content"><p>${freeDTO.content}</p></textarea>
			</div>
			
			<div class="file_list">
				<!-- 기존 업로드된 파일 출력  -->
				<div class="mb-3" style="padding-bottom: 30px;">
				<label for="insertFile">첨부된 파일: </label>
					<ul id="fileListContainer">
						<c:forEach var="fileList" items="${freeDTO.boardFileDTOList}">
							<li>
							<a class="uploadedFilePath" href="${fileList.filePath}">${fileList.originFileName}</a>
							<button button type="button" class="btn btn-secondary" id="btnDeleteFile">X</button>
							</li>
						</c:forEach>
					</ul>
				</div>
			
			<!-- 새로 업로드 할 파일 추가 -->
				<div class="mb-3" style="padding-bottom: 30px;">
					<div class="file_input" style="display: inline-block;" id="pathpath">
						<label for="formFileMultiple" class="form-label">파일첨부: </label> <input
							class="form-control files" type="file" id="updated-file" multiple
							name="filepath" onchange="selectFile(this);"
							style="background-color: white;" />
					</div>
					<button type="button" onclick="removeFile(this);"
						class="btn btn-danger">
						<span>삭제</span>
					</button>
					<button type="button" onclick="addFile();"
						class="btn btn-primary">
						<span>파일 추가</span>
					</button>
				</div>
			</div>
		</form>

		<div>
			<button class="btn btn-info" onclick="history.back()" style="margin-right: 10px;"><i class="bi bi-arrow-return-left" style="padding-right: 5px;"></i>목록</button>
			<button class="btn btn-success" id="btn-update-complete"><i class="bi bi-pencil-square" style="padding-right: 5px;"></i>수정완료</button>
		</div>




	</div>
</section>
<script type="text/javascript">
// 파일 선택
function selectFile(element) {

    const file = element.files[0];
    const filename = element.closest('.file_input').firstElementChild;

    // 1. 파일 선택 창에서 취소 버튼이 클릭된 경우
    if ( !file ) {
        filename.value = '';
        return false;
    }

    // 2. 파일 크기가 10MB를 초과하는 경우
    const fileSize = Math.floor(file.size / 1024 / 1024);
    if (fileSize > 10) {
        alert('10MB 이하의 파일로 업로드해 주세요.');
        filename.value = '';
        element.value = '';
        return false;
    }

    // 3. 파일명 지정
    filename.value = file.name;
}

let fileCount = 0;

// 파일 추가
function addFile() {
    if (fileCount < 1) {
        const fileDiv = document.createElement('div');
        fileDiv.classList.add('file_input');

        fileDiv.innerHTML = `
        	<div class="file_input" style="display: inline-block; ">
			<label for="formFileMultiple" class="form-label">파일첨부: </label> <input
			class="form-control files" type="file" id="updated-file" multiple
			name="filepath" onchange="selectFile(this);" style="background-color: white;" />
		</div>
        <button type="button" onclick="removeFile(this);" class="btn btn-danger"><span>삭제</span></button>
        `;

        document.querySelector('.file_list').appendChild(fileDiv);
        fileCount++;
    } else {
        alert('최대 1개의 파일만 추가 가능합니다.');
    }
}


// 파일 삭제
function removeFile(element) {
    const fileAddBtn = element.nextElementSibling;
    if (fileAddBtn) {
        const inputs = element.previousElementSibling.querySelectorAll('input');
        inputs.forEach(input => input.value = '')
        return false;
    }
    element.parentElement.remove();
}

</script>

<script>
	$('#updated-content').summernote(
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

<script src="/js/board/free.js"></script>

<%@include file="/WEB-INF/view/layout/footer.jsp"%>


