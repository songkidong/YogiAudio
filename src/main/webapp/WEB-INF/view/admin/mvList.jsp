<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/view/admin/layout/header.jsp" %>

<style>

.modalmv{
  display: none;
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgb(0,0,0);
  background-color: rgba(0,0,0,0.4);
}


#mvmodal{
  background-color: #fefefe;
  margin: 0 auto; /* 가운데 정렬 */
  padding: 20px;
  border: 1px solid #888;
  width: 850px; /* 자동으로 YouTube 동영상의 크기에 맞추기 */
  height: 500px;
  position: absolute; /* 절대 위치 설정 */
  top: 50%; /* 화면의 상단에서 절반의 위치에 배치 */
  left: 50%; /* 화면의 왼쪽에서 절반의 위치에 배치 */
  transform: translate(-50%, -50%); /* 수직 및 수평 가운데 정렬 */
}

.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

</style>
<!-- Content -->
	
	<hr class="my-5" />
	<!-- empty 키워드는 변수가 null이거나 비어있는 경우를 확인 -->
	<c:if test="${empty musicvideoList}">
		<h1 style="display: flex; justify-content: center;"> 노래가 존재하지 않습니다</h1>
	</c:if>
	
	<div class="row g-4">
	<h2 style="margin-left: 100px">뮤비 리스트</h2>
	<!-- 반복문 -->
	
 <c:forEach var="musicvideo" items= "${musicvideoList}">
	
	<div class="col-md-3 col-lg-3 col-xl-3" style="text-align: center; padding-left: 120px">
	<div class="card" style="width:20rem; margin:20px 0 24px 0">
	  <!-- img 경로 가져오기 -->	
	<a href="javascript:void(0)"  onclick="openModal('${musicvideo.mvfile}/')" class="cta-btn">
	  <img class="card-img-top" src="${musicvideo.filepath}" alt="image" style="width:100%">
	</a>
	  <div class="card-body">
	    <h4 class="card-title">${musicvideo.videotitle}</h4>
	    <h5 class="card-title">${musicvideo.videosinger}</h5>
	    <p class="card-text">음원번호 ${musicvideo.musicno}</p>
	    <a data-id="${musicvideo.videono}" name="deleteButton" href="#" class="btn btn-primary">삭제</a>
	  </div>
	</div>
	</div>
	
	</c:forEach>
	<!-- 반복문 끝--> 
	</div>
	
    <!-- 반복문 시작 -->
    <%-- <div class="row g-4">
                                   <c:forEach var="music" items= "${musicvideoList}">
                                   <!-- 한줄에 4개씩 차지해서 col-xl-3을 수정 -->
                       			   <div class="col-md-6 col-lg-4 col-xl-3">
                                           <div class="rounded position-relative fruite-item">
                                               <div class="fruite-img">
                                               		<!-- 첨부 파일에 따라 이미지 크기가 달라져서 height 값 고정함 -->
                                               		<!-- img src는 WebMvcConfig 활용하기 -->
                                                   <img src="${music.filePath }" class="img-fluid w-100 rounded-top" style="height: 380px;" alt="">
                                               </div>
                                               <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                               	   <!-- clubName 길이에 따라 카드 크기 달라져서 height 고정값 줌 --> 	
                                                   <h4 style="height: 50px;">제목 ${music.musicTitle}</h4>
                                                   <h6>가수</h6>
                                                   <!-- descript 길이에 따라 카드 크기 달라져서 height 고정값 줌 -->
                                                   <p style="height: 60px;">가수 ${music.musicSinger}</p>
                                                   <p style="height: 60px;">발매일 ${music.startdate}</p>
                                                   <p style="height: 60px;">등록일 ${music.formatRegDate()}</p>
                                                   <div class="d-flex justify-content-between flex-lg-wrap">
					                                    <a class="btn border" href="">수정</a>
					                                    <a class="btn border" href="">삭제</a>
					                                    
                                                   </div>
                                               </div>
                                           </div>
                           		   </div>
                                   </c:forEach>
                                   
    </div> --%>
	<!-- 반복문 끝 -->

	
	
              
	<!-- flex 속성으로 가운데정렬하기 -->
	<ul class="pagination" style="display: flex; justify-content: center; padding-right: 10%;">
	
	<!-- pageVO.prev가 참(시작페이지가 1이 아닐 때)이면 이전버튼 li태그 생성 -->
	<c:if test="${pageVO.prev }">
		<li class="page-item">
			<a class="page-link" href="/admin/musicvideoList?page=${pageVO.startPage - 1 }"><i class="fas fa-chevron-left"></i></a>
		</li>
	</c:if>
	
	<!-- 반복문 -->
	<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
		<!-- 페이지 번호 클릭했을 때 Controller에서 pageVO.setCri(cri) 메서드를 통해, 현재 페이지 값 가져올 수 있음 -->
		<li class="page-item ${pageVO.cri.page eq i ? 'active' : ''}">
			<!-- Controller에서 Criteria가 매개변수로 있어서, 여기서 page값 파라미터로 보낼때 받을 수 있음 -->
			<a class="page-link" href="/admin/musicvideoList?page=${i }">${i }</a>
		</li>
	</c:forEach>
	<!-- 반복문 끝 -->
	
	<!-- pageVO.nexr가 참(끝페이지 * 페이지당 게시글 수가 총 갯수보다 작으면)이면 다음버튼 li태그 생성 -->
	<c:if test="${pageVO.next }">
		<li class="page-item">
			<a class="page-link" href="/admin/musicvideoList?page=${pageVO.endPage + 1 }"><i class="fas fa-chevron-right"></i></a>
		</li>
	</c:if>
	 
	</ul>
              
              


<!-- / Content -->

<script src="/js/admin/musicvideolist.js"></script>


<!-- 추가한 모달 창 -->
	<div id="myModal" class="modalmv">
	  <div class="modal-content"  id="mvmodal">
	    <span class="close">&times;</span>
	    <iframe id="videoFrame" width="800" height="400" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	  </div>
	</div>

		
	<!-- 뮤비열기 JS -->
	<script>
		// 모달 창 열기
		function openModal(videoUrl) {
		  var modal = document.getElementById("myModal");
		  var videoFrame = document.getElementById("videoFrame");
		  
		  // 모달 창 안에 YouTube 동영상 URL 설정
		  videoFrame.src = videoUrl;
		  
		  // 모달 창 열기
		  modal.style.display = "block";
		}
		
		// 모달 창 닫기
		document.getElementsByClassName("close")[0].addEventListener("click", function() {
		  document.getElementById("myModal").style.display = "none";
		});
		
		// 모달 외부 클릭 시 닫기
		window.addEventListener("click", function(event) {
		  if (event.target == document.getElementById("myModal")) {
		    document.getElementById("myModal").style.display = "none";
		  }
		});
  </script>










<%@ include file="/WEB-INF/view/admin/layout/footer.jsp" %>            
		
		
		