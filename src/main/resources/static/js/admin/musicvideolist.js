
window.onload = function() {
	
	const deleteBtns = document.getElementsByName('deleteButton');
	
	for(let i=0 ; i<deleteBtns.length ; i++) {
		
		deleteBtns[i].addEventListener('click', function() {
			// 사용자정의속성 불러오기
			const videono = deleteBtns[i].getAttribute('data-id');
			//alert('videono : ' + videono);
			
			Swal.fire({
				title : '삭제하시겠습니까?',
				icon : 'warning',
				showCancelButton : true,
				confirmButtonText : '확인',
				cancelButtonText : '취소'
			}).then((result) => {
				if(result.isConfirmed) {
					// 확인버튼 클릭시
					$.ajax({
						// 쿼리파라미터 방식 '/admin/music?videono=' + videono
						// 음원, 뮤비 1대1 이라 뮤비 삭제하면 음원 삭제와 같다 no 값도 같음
						url : '/admin/music/' + videono, 
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