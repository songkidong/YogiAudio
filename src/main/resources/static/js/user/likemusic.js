	$(document).on('click', '.likeCancelBtn', function() {
			var userId = '${principal.id}';
			var musicNo = $(this).closest('tr').data('music-no');

			$.ajax({
				type : 'GET',
				url : '/deleteLikeMusic',
				data : {
					userId : userId,
					musicNo : musicNo
				},
				success : function(response) {
					console.log(response);
					alert("좋아요가 취소되었습니다.");
					location.reload();

				},
				error : function(error) {
					console.error('Error saving markers:', error);
				}
			});
		});