<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/layout/header.jsp"%>
<link href="/css/board/view.css" rel="stylesheet">

<section id="board">
	<div class="board-container">
		<h2>나의 문의하기 상세보기</h2>

		<div class="button-container d-flex justify-content-end">
			<button class="btn btn-info rounded-pill shadow-sm"
				onclick="history.back()">
				<i class="bi bi-arrow-return-left" style="padding-right: 5px;"></i>목록
			</button>
			<button class="btn btn-success rounded-pill shadow-sm"
				id="btn-update">
				<i class="bi bi-pencil-square" style="padding-right: 5px;"></i>수정
			</button>
			<button class="btn btn-danger rounded-pill shadow-sm" id="btn-delete">
				<i class="bi bi-trash" style="padding-right: 5px;"></i>삭제
			</button>
		</div>

		<div>
			<table class="table table-bordered table-hover">
				<tbody>
					<tr>
						<td>번호</td>
						<td id="id-display" style="text-align: left;"></td>
					</tr>
					<tr>
						<td>작성일</td>
						<td id="createdAt-display" style="text-align: left;"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td id="title-display" style="text-align: left;"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td id="content-display" style="text-align: left;"></td>
					</tr>
					<tr>
						<td>첨부파일</td>
						<td style="text-align: left;"><a id="file-display"></a></td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="commentList" style="margin-top: 30px;">
			<h3>답변</h3>

			<div class="commentCard">
				<div class="info">
					<span class="nick">nick</span> <span class="date">2024-03-23</span>
				</div>
					<textarea class="form-control" id="reply-display" rows="3" readonly>sdf</textarea>
				</div>
			</div>

		</div>

	</div>
</section>

<script src="/js/board/qna.js"></script>
<script>
	function loadViewId() {

		console.log(typeof addressNum);

		$
				.ajax({
					type : "post",
					url : "/board/qna/qnaView/" + addressNum,
					data : {},
					success : function(data) {

						// id-display 엘리먼트에 데이터 출력
						$("#id-display").html(data.id);

						// 받은 날짜 문자열을 Date 객체로 파싱
						var createdAtDate = new Date(data.createdAt);

						// 날짜를 원하는 형식으로 포맷팅
						var formattedDate = formatDate(createdAtDate);

						// createdAt-display 엘리먼트에 포맷팅된 날짜 출력
						$("#createdAt-display").html(formattedDate);

						// title-display 엘리먼트에 데이터 출력
						$("#title-display").html(data.title);

						// content-display 엘리먼트에 데이터 출력
						$("#content-display").html(data.content);

						// 파일 경로를 쉼표로 분할하여 배열로 만듭니다
						var filePaths = data.filePath.split(',');

						// file-display 엘리먼트에 데이터 출력
						if (filePaths.length > 0) {
							var fileDisplayHTML = ""; // 파일을 보여줄 HTML

							for (var i = 0; i < filePaths.length; i++) {
								if (data.originFileName
										&& data.originFileName[i]) { // originFileName이 정의되어 있을 때만 출력
									fileDisplayHTML += "<a href='" + filePaths[i] + "' download>"
											+ data.originFileName[i]
											+ " <i class='bi bi-file-earmark-arrow-down-fill'></i></a><br>";
									console.log("originFileName:",
											data.originFileName[i]);
								}
							}

							$("#file-display").html(fileDisplayHTML);
						} else {
							$("#file-display").html("첨부 파일이 없습니다.");
						}

					},
					error : function() {
						alert("Error!!!");
					}
				});
		
		

	}

	// 날짜를 원하는 형식으로 포맷팅하는 함수
	function formatDate(date) {
		var year = date.getFullYear();
		var month = (date.getMonth() + 1).toString().padStart(2, '0');
		var day = date.getDate().toString().padStart(2, '0');

		return year + '년 ' + month + '월 ' + day + '일';
	}

	//페이지 로드 시 데이터 로딩 함수 호출
	$(document).ready(function() {
		loadViewId();
	});

	
</script>



<%@include file="/WEB-INF/view/layout/footer.jsp"%>


