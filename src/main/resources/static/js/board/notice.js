const select = document.querySelector(".searchType");
const options = select.querySelectorAll("option");
const searchButton = document.querySelector(".searchButton");
const searchInput = document.querySelector(".searchInput");


let searchType = "";
searchButton.onclick = () => { //검색 버튼이 클릭되었을 때 실행될 함수
	
	
	for(let i = 0; i < options.length; i++){
	if(options[i].selected){
		searchType = options[i].value;
		
	}
}//드롭다운에서 선택된 옵션의 값을 검색 유형 변수 searchType에 할당


console.log("검색어:" + searchInput.value);

	$.ajax({
		type : "get",
		url : "board/notice/noticeList", 
		data : {
			searchType: searchType,
			searchInput: searchInput.value
		}, 
		success : function(data){
				innerFun(data);
			if(data != ""){
			}
		},
		error : function(){
			alert("error!!!!");
		}
	});

}