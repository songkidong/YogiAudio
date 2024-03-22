

window.onload = function() {
	
	const withdrawBtns = document.getElementsByName('withdrawButton');
	
	for(let i=0 ; i<withdrawBtns.length ; i++) {
		
		withdrawBtns[i].addEventListener('click', function() {
			const id = withdrawBtns[i].getAttribute('data-id');
			alert('id : ' + id);
			
			Swal.fire({
				title : '탈퇴하시겠습니까?',
				icon : 'warning',
				showCancelButton : true,
				confirmButtonText : '확인',
				cancelButtonText : '취소'
			}).then((result) => {
				if(result.isConfirmed) {
					$.ajax({
						url : '/admin/user/' + id,
						type : 'post',
						
						success : function(data) {
							if(data == true) {
								Swal.fire(
									'탈퇴 완료입니다'
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