
window.onload = function() {
	
	const button = document.getElementById('button');
	const form = document.getElementById('form');
	const input = document.getElementById('title--input');
	const content = document.getElementById('content');
	
	button.addEventListener('click', function(e) {
		
		// .value 
		if(input.value == "") {
			Swal.fire('제목을 입력하세요');
			input.focus();
		}else if(content.value == "") {
			Swal.fire('내용을 입력하세요');
			input.focus();
		}
		
		
		// submit 기능 막기
		e.preventDefault();
		//alert('클릭');
		
		// 모든 항목 입력시
		if(input.value != "" && content.value != "") {
			
		Swal.fire({
				title : '등록하시겠습니까?',
				icon : 'question',
				showCancelButton : true,
				confirmButtonText : '확인',
				cancelButtonText : '취소'
			}).then((result) => {
				if(result.isConfirmed) {
					
					// 폼 전송 필요없다
					//form.submit();
					
					const formData = new FormData(form);
					
					$.ajax({
						url : '/admin/notice',
						type : 'post',
						data : formData,
						enctype : 'multipart/form-data',
						processData: false,  // 필수
                		contentType: false,  // 필수
						
						success : function(data) {
							console.log('전송 성공');
							if(data == true) {
								Swal.fire(
									'등록 완료입니다'
								).then((result) => {
									if(result.isConfirmed) {
										location.replace("/admin/noticeList");
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
		} // end of if	
	})
}