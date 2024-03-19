
window.onload = function() {
	
	const deleteBtns = document.getElementsByName('deleteButton');
	
	for(let i=0 ; i<deleteBtns.length ; i++) {
		
		deleteBtns[i].addEventListener('click', function() {
			const id = deleteBtns[i].getAttribute('data-id');
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
						url : '/admin/free/' + id,
						type : 'delete',
						
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
					})
				}
			})
		})
	}
}