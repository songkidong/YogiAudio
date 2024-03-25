<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/layout/header.jsp"%>
<link href="/css/board/view.css" rel="stylesheet">
<link href="/css/board/freeView.css" rel="stylesheet">
<style>
/* 수정 버튼 기본 스타일 */
.commentList .edit-button {
	margin-left: 1px;
	background-color: #28a745; /* 수정 버튼의 배경 색상을 초록색으로 지정 */
	transition: background-color 0.3s ease; /* 배경색 전환 효과 추가 */
}

/* 수정 버튼에 hover 효과 추가 */
.commentList .edit-button:hover {
	background-color: #218838; /* hover 됐을 때 배경 색상을 더 진한 초록색으로 변경 */
}
</style>
<section id="board">
	<div class="board-container">
		<h2>자유게시판 상세보기</h2>

		<div class="button-container d-flex justify-content-end">
			<!-- Button to Open the Modal -->
			<!-- 게시글 신고 버튼 start -->
			<button type="button"
				class="btn btn-secondary rounded-pill shadow-sm"
				data-target="#myModal" id="reportBtn">
				<i class="bi bi-emoji-angry" style="padding-right: 5px;"></i>신고
			</button>
			<!-- 게시글 신고 버튼 end -->

			<!-- The Modal -->
			<div class="modal" id="myModal">
				<div class="modal-dialog">
					<div class="modal-content">

						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">게시글 신고하기</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>

						<!-- Modal body -->
						<div class="modal-body">
							<div class="form-group">
								<label for="comment">신고내용:</label>
								<textarea class="form-control" rows="5" id="boardReportContent"></textarea>
							</div>
						</div>

						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary"
								data-dismiss="modal" id="boardReportBtn">신고 완료</button>
						</div>

					</div>
				</div>
			</div>
			<!-- modal end -->
			<!-- The Modal -->
			<div class="modal" id="commentModal">
				<div class="modal-dialog">
					<div class="modal-content">

						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">댓글 신고하기</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>

						<!-- Modal body -->
						<div class="modal-body">
							<div class="form-group">
								<label for="comment">신고내용:</label>
								<textarea class="form-control" rows="5"
									id="commentReportContent"></textarea>
							</div>
						</div>

						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary"
								data-dismiss="modal" id="commentReportBtn">신고 완료</button>
						</div>

					</div>
				</div>
			</div>
			<!-- modal end -->

			<button class="btn btn-info rounded-pill shadow-sm"
				onclick="goBack()">
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
			<input type="hidden" id="writerId-display"></input>
			<table class="table table-bordered table-hover">
				<tbody>
					<tr>
						<td>번호</td>
						<td id="id-display" style="text-align: left;"></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td id="writerName-display" style="text-align: left;"></td>
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

		<!-- 댓글 작성 -->
		<div class="commentWrite" style="margin-top: 30px;">
			<div style="display: flex; align-items: center;">
				<h3 style="margin-right: 10px;">댓글 등록</h3>
				<!-- Adjust margin-right for spacing -->
				<button class="btn btn-primary rounded-pill shadow-sm"
					id="btn-save-reply" style="margin-bottom: 11px;">+</button>
			</div>
			<div class="form-group" style="margin-bottom: 20px;">
				<textarea class="form-control" id="reply-content" rows="3"></textarea>
			</div>
		</div>

		<!-- 댓글 출력 -->
		<div class="commentList" style="margin-top: 30px;">
			<h3>댓글 목록</h3>
			<!-- 수정 가능한 댓글 -->
			<div class="commentCard">
				<div class="info">
					<span id="reply-writerName-display">작성자</span> <span
						id="reply-createdAt-display" style="float: right;">작성일</span>
				</div>
				<div class="comment-content" style="display: block;">댓글 내용</div>
				<!-- 삭제 버튼 -->
				<button class="btn btn-danger btn-sm" style="margin-top: 5px;"
					onclick="deleteComment(commentId)">삭제</button>
			</div>
		</div>
	</div>
</section>

<script>
	function loadViewId() {

		console.log(typeof addressNum);

		$
				.ajax({
					type : "post",
					url : "/board/free/freeView/" + addressNum,
					data : {},
					success : function(data) {

						// id-display 엘리먼트에 데이터 출력
						$("#id-display").html(data.id);

						// writerName-display 엘리먼트에 데이터 출력
						$("#writerName-display").html(data.writerName);
						
						// hidden - 게시글 신고하기 기능 넣어주려고
						$("#writerId-display").val(data.writerId);

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
<script>
	// 댓글 목록 불러오기
	function loadCommentList() {
		let addressNum = window.location.pathname.split("/")[4]; // 게시글 번호 가져오기

		$.ajax({
			type : "GET",
			url : "/board/free/freeCommentList/" + addressNum, // 댓글 목록을 가져오는 API 엔드포인트 URL
			success : function(response) {
				// 댓글 목록을 받아서 화면에 출력
				displayCommentList(response);
			},
			error : function(xhr, status, error) {
				console.error("Error fetching comment list:", error);
			}
		});
	}

	// 현재 로그인한 사용자의 아이디
	let currentUserID = Number("${principal.id}");

	function displayCommentList(comments) {
	    var commentListHTML = ""; // 댓글 목록을 담을 HTML 문자열

	    // 각 댓글에 대해 HTML 생성
	    for (var i = 0; i < comments.length; i++) {
	        var comment = comments[i];

	        // 받은 날짜 문자열을 Date 객체로 파싱
	        var createdAtDate = new Date(comment.createdAt);

	        // 날짜를 원하는 형식으로 포맷팅
	        var formattedDate = formatDate(createdAtDate);

	        commentListHTML += "<div class='commentCard' style='overflow: auto;'>"; // 스타일 추가
	        commentListHTML += "<div class='info'>";
	        commentListHTML += "<span>" + comment.writerName + "</span>"; // 작성자 이름
	        commentListHTML += "<span style='float: right;'>" + formattedDate
	                + "</span>"; // 작성일
	        commentListHTML += "</div>";
	        commentListHTML += "<div style='display: flex;'>"; // 댓글 내용과 버튼을 수평으로 정렬
	        if (comment.writerId === currentUserID) {
	            commentListHTML += "<div>"; // 수정 및 삭제 버튼을 담을 컨테이너
	            commentListHTML += "<button class='btn btn-danger btn-sm' onclick='deleteComment(" + comment.id + ")'>삭제</button>"; // 삭제 버튼
	            commentListHTML += "<button class='btn btn-success btn-sm edit-button' id='edit-button-" + comment.id + "' onclick='updateComment(" + comment.id + ")'>수정</button>"; // 수정 버튼
	            commentListHTML += "<button class='btn btn-primary btn-sm save-button edit-button' id='save-button-" + comment.id + "' style='display: none;'>수정 완료</button>"; // 수정 완료 버튼
	            commentListHTML += "</div>";
	        }
	        commentListHTML += "<button type='button' class='btn btn-secondary rounded-pill shadow-sm report-button' style='margin-left: auto;' data-target='#commentModal' data-comment-id='" + comment.id 
	        + "' onclick='reportComment(" + comment.id + "," + comment.writerId + ")'>";
	        commentListHTML += "<i class='bi bi-emoji-angry' style='padding-right: 5px;'></i>신고";
	        commentListHTML += "</button>";
	        commentListHTML += "</div>";
	        commentListHTML += "<textarea class='form-control' id='comment-content-" + comment.id + "' rows='3' readonly>"
	                + comment.content + "</textarea>"; // 댓글 내용
	        commentListHTML += "</div>";
	    }


		// 댓글 목록을 출력할 엘리먼트에 HTML 삽입
		$(".commentList").html(commentListHTML);
	}

	// 페이지 로드 시 댓글 목록을 가져오는 함수 호출
	$(document).ready(function() {
		loadCommentList();
	});

	// 댓글 삭제 함수
	function deleteComment(id) {
		// 사용자에게 확인 메시지 표시
		if (confirm("정말로 삭제하시겠습니까?")) {
			// 확인을 누르면 AJAX 요청으로 댓글 삭제 처리
			$.ajax({
				type : "DELETE",
				url : "/board/free/freeComment/" + id, // 댓글 삭제 엔드포인트 URL
				success : function(response) {
					// 성공적으로 삭제되면 페이지 새로고침 또는 댓글 목록 갱신
					// 여기서는 페이지 새로고침을 예시로 했습니다.
					location.reload();
				},
				error : function(xhr, status, error) {
					console.error("Error deleting comment:", error);
				}
			});
		} else {
			// 취소를 누르면 아무 동작도 하지 않음
			return false;
		}
	}
	// 댓글 수정 함수
	function updateComment(id) {
	    // 해당 댓글의 textarea를 수정 가능하도록 변경
	    var commentTextarea = document.getElementById(`comment-content-` + id);
	    commentTextarea.removeAttribute('readonly');
		
	    // 커서를 내용 맨 뒤로 이동
	    commentTextarea.selectionStart = commentTextarea.selectionEnd = commentTextarea.value.length;
	    commentTextarea.focus();
	    
	    // 해당 댓글의 수정 버튼을 숨기고 수정 완료 버튼을 생성
	   var editButton = document.getElementById(`edit-button-` + id);
	    editButton.style.display = 'none';

	    // 해당 댓글의 수정 완료 버튼을 표시
	    var saveButton = document.getElementById(`save-button-` + id);
	    saveButton.style.display = 'inline-block';
	    saveButton.onclick = function() {
	    	  var updatedComment = commentTextarea.value;
	          saveComment(id, updatedComment); // 수정된 댓글을 저장하는 함수 호출
	    };

	    var parentDiv = editButton.parentNode;
	    parentDiv.insertBefore(saveButton, editButton.nextSibling);
	}
	
	function saveComment(id, comment) {
	    $.ajax({
	        type: "POST",
	        url: "/board/free/freeComment/update",
	        data: {
	            id: id,
	            comment: comment
	        },
	        success: function(response) {
	            // 서버에서 응답을 받았을 때의 처리
	            var commentTextarea = document.getElementById(`comment-content-` + id);
	            commentTextarea.setAttribute('readonly', 'readonly'); // 수정 완료 후 textarea를 읽기 전용으로 변경
	            var editButton = document.getElementById(`edit-button-` + id);
	            editButton.style.display = 'inline-block'; // 수정 버튼 다시 표시
	            var saveButton = document.getElementById(`save-button-` + id);
	            saveButton.style.display = 'none'; // 수정 완료 버튼 숨기기
	            alert("수정 되었습니다");
	        },
	        error: function(xhr, status, error) {
	            // 에러 발생 시의 처리
	            console.error("Error updating comment:", error);
	            alert("수정 중 오류가 발생했습니다.");
	        }
	    });
	}
	
	let commentId = "";
	let writeUserId = "";
	
	// 댓글 수정 함수
	function reportComment(id, writerId) {
		
		// 모달을 열 때 닫기 버튼 동작 추가
	    $('#commentModal').on('show.bs.modal', function (e) {
	        // 모달이 열릴 때 동작할 코드
	        // 닫기 버튼을 눌렀을 때 모달 닫기
	        $(this).find('.close').click(function() {
	            $('#commentModal').modal('hide');
	        });
	    });
		
		if(currentUserID == null || currentUserID == ""){
			if (confirm("로그인 하시겠습니까?")) {
	            window.location.href = '/signIn'; // 메인 페이지 URL로 리다이렉트
	            return;
	        }
		}else{
			$.ajax({
			       type: "POST",
			       url: "/board/free/checkReport", 
			       data: {
			           targetType: "comment",
			           targetId: id,
			           userId: currentUserID
			       },
			       success: function(data) {
			           // 성공적으로 신고 여부를 확인한 경우에만 모달 창을 엽니다.
			           if (data !== "success") { // 여기서 "success"는 서버에서 성공적으로 처리했을 때의 응답을 가정한 것입니다.
			        	   commentId = Number(id);
			        	   writeUserId = Number(writerId);
			               $('#commentModal').modal('show');
			           } else {
			               alert("이미 신고한 댓글입니다");
			           }
			       },
			       error: function() {
			           // 에러가 발생했을 때 처리할 내용을 작성합니다.
			           alert("서버와의 통신 중 에러가 발생했습니다.");
			       }
			   });
		}
	}
	 var commentReportBtn = document.getElementById("commentReportBtn");
	commentReportBtn.addEventListener("click", function(){
		let addressNum = commentId; // 게시글 번호 가져오기
		alert("댓글 신고 요청");

		const commentReportContent = $("#commentReportContent").val();
		
		console.log("댓글신고내용 : "+commentReportContent);

		if (commentReportContent === "") {
            // If empty, show an alert and return early to prevent further execution
            alert("신고 이유를 적어주세요.");
            return;
        }
		
		const targetUserId = Number(writeUserId);
		console.log("신고대상id : "+targetUserId);
		// AJAX 요청을 보냅니다.
		$.ajax({
			type: "POST",
			url: "/board/free/boardFreeReport", 
			data: {
				targetType: "comment",
				targetId: addressNum,
				targetUserId: targetUserId, // 게시글 작성자
				reportReason: commentReportContent
			},
			success: function(data) {
				console.log(data);
 				if (data === 1) {
					// 성공적으로 데이터가 저장되었을 때.
					location.reload();
				} else {
					// 실패했을 때 처리할 내용을 작성하세요.
					alert("데이터 저장에 실패했습니다.");
				} 
			},
			error: function() {
				// 에러가 발생했을 때 처리할 내용을 작성하세요.
				alert("서버와의 통신 중 에러가 발생했습니다.");
			}
		});
	});
</script>
<script>

let userId = Number("${principal.id}");
let typeBoard = "board";
let typeComment = "comment";

$("#reportBtn").on("click", () => {
	
	// 모달을 열 때 닫기 버튼 동작 추가
    $('#myModal').on('show.bs.modal', function (e) {
        // 모달이 열릴 때 동작할 코드
        // 닫기 버튼을 눌렀을 때 모달 닫기
        $(this).find('.close').click(function() {
            $('#myModal').modal('hide');
        });
    });
	
	if(userId == null || userId == ""){
		if (confirm("로그인 하시겠습니까?")) {
            window.location.href = '/signIn'; // 메인 페이지 URL로 리다이렉트
            return;
        }
	}else{
    // 서버에 신고 여부를 확인하는 AJAX 요청을 보냅니다.
	    $.ajax({
	        type: "POST",
	        url: "/board/free/checkReport", 
	        data: {
	            targetType: typeBoard,
	            targetId: addressNum,
	            userId: userId
	        },
	        success: function(data) {
	            // 성공적으로 신고 여부를 확인한 경우에만 모달 창을 엽니다.
	            if (data !== "success") { // 여기서 "success"는 서버에서 성공적으로 처리했을 때의 응답을 가정한 것입니다.
	                $('#myModal').modal('show');
	            } else {
	                alert("이미 신고한 게시글입니다");
	            }
	        },
	        error: function() {
	            // 에러가 발생했을 때 처리할 내용을 작성합니다.
	            alert("서버와의 통신 중 에러가 발생했습니다.");
	        }
	    });
	}
});


let boardReportObject = {
		init: function() {
			$("#boardReportBtn").on("click", () => {
				alert(addressNum);
				this.boardReport();
			});
		},

		boardReport: function() {
			let addressNum = window.location.pathname.split("/")[4]; // 게시글 번호 가져오기
			alert("게시글 신고 요청");

			const boardReportContent = $("#boardReportContent").val();
			
			console.log("게시글신고내용 : "+boardReportContent);

			if (boardReportContent === "") {
	            // If empty, show an alert and return early to prevent further execution
	            alert("신고 이유를 적어주세요.");
	            return;
	        }
			
			const targetUserId = $("#writerId-display").val();
			console.log("신고대상id : "+targetUserId);
			// AJAX 요청을 보냅니다.
			$.ajax({
				type: "POST",
				url: "/board/free/boardFreeReport", 
				data: {
					targetType: typeBoard,
					targetId: addressNum,
					targetUserId: targetUserId, // 게시글 작성자
					reportReason: boardReportContent
				},
				success: function(data) {
					console.log(data);
					if (data === 1) {
						// 성공적으로 데이터가 저장되었을 때.
						location.reload();
					} else {
						// 실패했을 때 처리할 내용을 작성하세요.
						alert("데이터 저장에 실패했습니다.");
					}
				},
				error: function() {
					// 에러가 발생했을 때 처리할 내용을 작성하세요.
					alert("서버와의 통신 중 에러가 발생했습니다.");
				}
			});
		}
	};

boardReportObject.init();

</script>

<script>
	// 뒤로가기 버튼 조회수 반영 새로고침
	function goBack() {
		// 이전 페이지의 URL 가져오기
		var previousPageUrl = "/board/free/freeList";

		// 이전 페이지로 이동
		window.location.href = previousPageUrl;
	}
</script>

<script src="/js/board/free.js"></script>

<%@include file="/WEB-INF/view/layout/footer.jsp"%>


