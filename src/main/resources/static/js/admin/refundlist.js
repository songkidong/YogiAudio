
window.onload = function() {
	
	const refundBtns = document.getElementsByName('refundButton');
	
	for(let i=0 ; i<refundBtns.length ; i++) {
		
		refundBtns[i].addEventListener('click', function() {
		const id = refundBtns[i].getAttribute('data-id');
		const userId = refundBtns[i].getAttribute('data-userId');
		const pNo = refundBtns[i].getAttribute('data-pNo');
		const amount = refundBtns[i].getAttribute('data-amount');
		//alert('id : ' + id);
		
		Swal.fire({
				title : '승인하시겠습니까?',
				icon : 'question',
				showCancelButton : true,
				confirmButtonText : '확인',
				cancelButtonText : '취소'
			}).then((result) => {
				if(result.isConfirmed) {
					$.ajax({
						url : '/admin/refund/' + id,
						type : 'post',
						data : {
							userId : userId,
							pNo : pNo,
							amount : amount
							},
						
						success : function(data) {
							if(data == true) {
								Swal.fire(
									'승인 완료입니다'
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