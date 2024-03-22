
window.onload = function() {
	
	// 파일명 표시하기
    const filePathsContainer = document.getElementById('filePaths');

	const filePathTxt = filePathsContainer.getAttribute('data-filePaths');
	
	// filePath에 있는 여러 파일 경로를 ','를 기준으로 나누기 -> filePaths는 배열로 나옴
    const filePaths = filePathTxt.split(','); 

	//alert('filePaths : ' + filePaths );
	
	// 첨부된 파일이 있으면
	if(filePaths != "") {
		
		for(let i=0 ; i<filePaths.length ; i++) {
			
			// 주소 '/'를 기준으로 나누기 참고 : let addressNum = window.location.pathname.split("/")[4];
			const uuid = filePaths[i].split("/")[5]; //  http://를 /를 기준으로 쪼개면 3개 나옴(// 사이의 공백도 한 덩어리) 
			console.log('uuid : ' + uuid);
			
			$.ajax({
				url : '/admin/file',
				type : 'get',
				data : {uuid : uuid},
				
				success : function(data) {
						// 서버단에서 조회한 데이터가 있으면
						if(data != "") {
							console.log("data : " + data.originalFileName);
							
							const originalFileName = data.originalFileName; 	
							const div = document.createElement('div');
							const link = document.createElement('a');
							const button = document.createElement('button');
							
							// 순서는 클래스 추가후, div에 추가해야함
							// 버튼에 클래스 추가 'btn btn-primary' 이렇게 추가하는 것 아님!
							button.classList.add('btn', 'btn-primary'); 
							button.innerText = '삭제';
							
							link.href = filePaths[i].trim(); // 파일 경로 양 끝의 공백 제거
							link.textContent = originalFileName.trim(); 
							div.appendChild(link);
							div.appendChild(button);
							filePathsContainer.appendChild(div);
						// 서버단에서 조회한 데이터가 없으면	
						} else {
							alret('실패');
						}
						
				},
				error : function() {
					alert('에러');
				}
			})
		}
	} // end of if
	
	// 글 수정하기
	const button = document.getElementById('updateButton');
	const form = document.getElementById('form');
	
	const id = button.getAttribute('data-id');
	
	button.addEventListener('click', function(e) {
		// 유효성 검사
		
		e.preventDefault();
		alert('id : ' + id);
		
		Swal.fire({
				title : '수정하시겠습니까?',
				icon : 'question',
				showCancelButton : true,
				confirmButtonText : '확인',
				cancelButtonText : '취소'
			}).then((result) => {
				if(result.isConfirmed) {
					
					const formData = new FormData(form);
					
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
		
	})
	
}