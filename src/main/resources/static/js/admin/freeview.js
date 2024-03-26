
window.onload = function() {
	
	// 글 삭제
	const deleteBtn = document.getElementById('deleteButton');
	
		deleteBtn.addEventListener('click', function() {
			const id = deleteBtn.getAttribute('data-id');
			//alert('id : ' + id);
			
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
										// 목록페이지로 이동 / history.back()은 새로고침 안되서 목록에 남아있음
										location.replace("/admin/freeList");
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
		
		// 댓글 삭제
		const deleteCommentBtns = document.getElementsByClassName('deleteComment');
	
		for(let i=0 ; i<deleteCommentBtns.length ; i++) {
			
			deleteCommentBtns[i].addEventListener('click', function() {
				const id = deleteCommentBtns[i].getAttribute('data-id');
				//alert('id : ' + id);
				
				Swal.fire({
					title : '삭제하시겠습니까?',
					icon : 'warning',
					showCancelButton : true,
					confirmButtonText : '확인',
					cancelButtonText : '취소'
				}).then((result) => {
					if(result.isConfirmed) {
						$.ajax({
							url : '/admin/comment/' + id,
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