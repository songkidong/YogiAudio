
window.onload = function() {
	
	// 첨부파일 삭제하기
	const deleteFileBtns = document.getElementsByClassName('deleteFileButton');
	
	for(let i=0 ; i<deleteFileBtns.length ; i++ ) {
		
		deleteFileBtns[i].addEventListener('click', function() {
			
			//alert('클릭');
			
			// deleteFileBtns[i]로 하니까, 첫번째요소 먼저 삭제하면
			// 두번째 요소 삭제 안됨 
			this.closest('li').remove();
		})
		
	}
	
	// 글 수정하기
	const button = document.getElementById('updateButton');
	const form = document.getElementById('form');
	const id = button.getAttribute('data-id');
	
	const title = document.getElementById('title');
	const content = document.getElementById('content');
	
	button.addEventListener('click', function(e) {
		e.preventDefault();
		alert('id : ' + id);
		
		// 유효성 검사
		if(title.value == "") {
			Swal.fire('제목을 입력하세요');
			input.focus();
		} else if(content.value == "") {
			Swal.fire('내용을 입력하세요');
			input.focus();
		}
		
		if(title.value != "" && content.value != "") {
			Swal.fire({
				title : '수정하시겠습니까?',
				icon : 'question',
				showCancelButton : true,
				confirmButtonText : '확인',
				cancelButtonText : '취소'
			}).then((result) => {
				if(result.isConfirmed) {
					
					// 파일 href 목록 
					const hrefBtns = document.getElementsByClassName('hrefButton');
					var hrefList = [];
					
					for(let i=0 ; i < hrefBtns.length ; i++) {
						
						const href = hrefBtns[i].getAttribute('href');
						hrefList.push(href);
					}
					
					const formData = new FormData(form);
					formData.append('hrefs', hrefList); // key, value
					
					$.ajax({
						url : '/admin/notice/' + id,
						type : 'post',
						data : formData,
						enctype : 'multipart/form-data',
						processData: false,  // 필수
                		contentType: false,  // 필수
						
						success : function(data) {
							console.log('전송 성공');
							if(data == true) {
								Swal.fire(
									'수정 완료입니다'
								).then((result) => {
									if(result.isConfirmed) {
										location.replace("/admin/noticeView/" + id);
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
			}) // end of then
		}
	}) // end of button
	
}