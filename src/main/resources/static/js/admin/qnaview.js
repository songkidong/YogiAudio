
window.onload = function() {
	
	// 답변 등록
	const replyBtn = document.getElementById('replyButton');
	// 유효성 검사하기 위함
	const replyTxt = document.getElementById('reply--textarea');
	
	replyBtn.addEventListener('click', function() {
		
		if(replyTxt.value == "") {
			Swal.fire('내용을 입력하세요');
			replyTxt.focus();
		}
		
		const boardQnaId = replyBtn.getAttribute('data-id');
		const replyForm = document.getElementById('replyForm');
		
		alert('boardQnaId : ' + boardQnaId);
		
		if(replyTxt.value != "") {
			Swal.fire({
				title : '등록하시겠습니까?',
				icon : 'question',
				showCancelButton : true,
				confirmButtonText : '확인',
				cancelButtonText : '취소'
			}).then((result) => {
				if(result.isConfirmed) {
					
					const formData = new FormData(replyForm);
					console.log('formData : ' + formData);
					
					$.ajax({
						url : '/admin/reply/' + boardQnaId, // pathVariable 방식으로 보내기
						type : 'post',
						data : formData,
						processData: false,  // 필수
	            		contentType: false,  // 필수 / 이 코드 두 줄 없으면 폼 전송 안됨!!!
						
						success : function(data) {
							if(data == true) {
								Swal.fire(
									'등록 완료입니다'
								).then((result) => {
									if(result.isConfirmed) {
										location.reload();
									}
								})
							}else {
								alert('실패');
							}
						},
						error : function() {
							alert('에러');
						}
					}) // end of ajax
				} // end of if
			}) // end of then
		}
	}) // end of replyBtn
	
	// 답변 등록 취소버튼
	const cancelBtn = document.getElementById('cancelButton');
	
	cancelBtn.addEventListener('click', function() {
		// 입력 초기화
		replyTxt.value = '';
	})
	
	// 답변 삭제
	const deleteReplyBtns = document.getElementsByClassName('deleteReply');
	
	for(let i=0 ; i<deleteReplyBtns.length ; i++) {
			
			deleteReplyBtns[i].addEventListener('click', function() {
				const id = deleteReplyBtns[i].getAttribute('data-id');
				const boardQnaId = deleteReplyBtns[i].getAttribute('data-boardQnaId');
				
				alert('id, boardQnaId : ' + id +','+ boardQnaId);
				
				Swal.fire({
					title : '삭제하시겠습니까?',
					icon : 'warning',
					showCancelButton : true,
					confirmButtonText : '확인',
					cancelButtonText : '취소'
				}).then((result) => {
					if(result.isConfirmed) {
						$.ajax({
							url : '/admin/reply/' + id,
							type : 'delete',
							data : {boardQnaId : boardQnaId}, // boardQnaId로 답변목록 하나도 없는지 확인하기 위함
							
							success : function(data) {
								if(data == true) {
									Swal.fire(
										'삭제 완료입니다'
									).then((result) => {
										if(result.isConfirmed) {
											location.reload();
										}
									})
								}else {
									alert('실패');
								}
							}, 
							error : function() {
								alert('에러');
							}
						}) // end of ajax
					}
				})
			})
		}
		
		// 글 삭제
		const deleteBtn = document.getElementById('deleteButton');
		
		deleteBtn.addEventListener('click', function() {
			const id = deleteBtn.getAttribute('data-id');
			alert('id : ' + id);
			
			Swal.fire({
				title : '삭제하시겠습니까?',
				icon : 'warning',
				showCancelButton : true,
				confirmButtonText : '확인',
				cancelButtonText : '취소'
			}).then((result) => {
				if(result.isConfirmed) {
					$.ajax({
						url : '/admin/qna/' + id,
						type : 'delete',
						
						success : function(data) {
							if(data == true) {
								Swal.fire(
									'삭제 완료입니다'
								).then((result) => {
									if(result.isConfirmed) {
										// 목록페이지로 이동 / history.back()은 새로고침 안되서 목록에 남아있음
										location.replace("/admin/qnaList");
									}
								})
			       				}else {
								alert('실패');
							}
						}, 
						error : function() {
							alert('에러');
						}
					})
				}
			})
		})
	
}