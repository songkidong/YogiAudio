const select = document.querySelector(".searchType");
const options = select.querySelectorAll("option");
const searchButton = document.querySelector(".searchButton");
const searchInput = document.querySelector(".searchInput");


let searchType = "";
searchButton.onclick = () => {
	
	
	for(let i = 0; i < options.length; i++){
	if(options[i].selected){
		searchType = options[i].value;
		
	}
}

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