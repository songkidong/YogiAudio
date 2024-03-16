
window.onload = function() {
	
	const deleteBtns = document.getElementsByName('deleteButton');
	
	for(let i=0 ; i<deleteBtns.length ; i++) {
		
		deleteBtns[i].addEventListener('click', function() {
			// 사용자정의속성 불러오기
			const musicNo = deleteBtns[i].getAttribute('data-id');
			alert('musicNo : ' + musicNo);
			
			Swal.fire({
				title : '삭제하시겠습니까?',
				//text : '되돌릴 수 없습니다',
				icon : 'warning',
				showCancelButton : true,
				confirmButtonText : '확인',
				cancelButtonText : '취소'
			}).then((result) => {
				if(result.isConfirmed) {
					// 확인버튼 클릭시
					$.ajax({
						// url로 데이터 보낼땐 data key 필요없다!
						// 쿼리파라미터 방식 '/admin/music?musicNo=' + musicNo
						url : '/admin/music/' + musicNo,
						type : 'delete',
						
						success : function(data) {
							console.log('data' + data);
							if(data == true) {
								Swal.fire(
									'삭제 완료입니다'
								).then((result) => {
									// 확인버튼 클릭시
									if(result.isConfirmed) {
										location.reload();
									}
								})
							}else {
								Swal.fire(
									'삭제 실패'
								);
							}
						},
						error : function() {
							alert('에러');
						}
					}) // end of ajax
				} // end of if
			}) // end of then
		}) // end of Event
	}
}