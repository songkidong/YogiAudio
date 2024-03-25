<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/layout/header.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>


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


<script>
    function likeMusic() {
        var musicno = ${detail.musicno};
        var musicmajor = "${detail.musicmajor}";
        var id = ${principal.id};

        $.ajax({
            type: "POST",
            url: "/product/likeit?musicno=" + musicno + "&musicmajor=" + musicmajor + "&id=" + id,
            success: function(response) {
                console.log("서버 응답: " + response);
                if (response === "success") {
                    alert("좋아요 클릭 완료!");
                    document.getElementById("likeButton").innerText = "Liked";
                    document.getElementById("likeButton").disabled = true;
                } else if (response === "already_liked") {
                    alert("이미 좋아요를 클릭하셨습니다.");
                } else {
                	console.log("좋아요클릭실패!");
                }
            },
            error: function(xhr, status, error) {
                console.error("좋아요 요청에 실패하였습니다.");
                alert("좋아요 클릭 실패!");
            }
        });
    }
</script>






		<!-- SECTION -->
		<div class="section">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">
					<!-- Product main img -->
					<div class="col-md-5 col-md-push-2">
						<div id="product-main-img">
							<div class="product-preview">
							 <c:choose>
							    <c:when test="${not empty detail.filepath}">
							      <img src=" ${detail.filepath}" >
							    </c:when>
							  <c:otherwise>
								  <img src="/album/default.png" >
							  </c:otherwise>
							 </c:choose>
							</div>
						</div>
					</div>
					<!-- /Product main img -->

					<!-- Product thumb imgs -->
					<div class="col-md-2 col-md-pull-5">
					  <div id="product-imgs">
					    <c:if test="${principal.role eq 'ADMIN'}">
						   <a href="/product/aalbum-update" data-toggle="modal" data-target="#photoModal" >
								<p>사진변경</p>
						   </a>
						   <a href="/product/amusic-update" data-toggle="modal" data-target="#musicModal" >
								<p>음원등록</p>
						   </a>
						 </c:if>  
					 </div>
					</div>
					<!-- /Product thumb imgs -->

					<!-- Product details -->
					<div class="col-md-5">
						<div class="product-details">
							<h2 class="product-price">${detail.musictitle}&nbsp;&nbsp;&nbsp;
								<a href="/product/domestic-detail?musicno=${detail.musicno}&musicmajor=${detail.musicmajor}&id=${principal.id}">
								   <span style="color: black; font-size: medium;" id="likeButton" onclick="likeMusic()">💗like</span></h2>
								</a>
							<div>
								<h3 class="product-name">${detail.musiccompany}<del class="product-old-price"></del></h3>						
							</div><br>
							<p>
							   아티스트 : ${detail.musicsinger}
							</p><br>
							<p>
							   장르 / 스타일 : ${detail.musicminor}
							</p><br>
							<p>
							   발매사 / 기획사 : ${detail.musiccompany}
							</p><br>
							<p>
							   발매일 : ${detail.startdate}
							</p><br>
							<p>샘플듣기</p>
						    <audio id="audioPlayer" controls>
						        <source src="/music/${detail.musicsample}" type="audio/wav">
						    </audio><br>
						    
						       <p>					    
						         <c:choose>
							         	<c:when test="${udetail.status eq 'Y'}">
						        			<button id="downloadButton" type="button" class="btn btn-primary">파일 다운로드</button>
									    </c:when>
							        <c:otherwise>
							            <button id="paymentcheck" type="button" class="btn btn-danger" >다운로드불가능</button>
							        </c:otherwise>
							    </c:choose>
						      </p>
							 
							    
						    
			    
						    
						</div>
					</div>
					<!-- /Product details -->

					<!-- Product tab -->
					<div class="col-md-12">
						<div id="product-tab">
							<!-- product tab nav -->
							<ul class="tab-nav">
								<li class="active"><a data-toggle="tab" href="#tab1">곡 소개</a></li>
								<li><a data-toggle="tab" href="#tab2">가사</a></li>
								<li><a data-toggle="tab" href="#tab3">뮤직비디오</a></li>
							</ul>
							<!-- /product tab nav -->

							<!-- product tab content -->
							<div class="tab-content">
								<!-- tab1  -->
								<div id="tab1" class="tab-pane fade in active">
									<div class="row">
										<div class="col-md-12">
											<p>
											  ${detail.musiccontent}
											</p>
										</div>
									</div>
								</div>
								<!-- /tab1  -->

								<!-- tab2  -->
								<div id="tab2" class="tab-pane fade in">
									<div class="row">
										<div class="col-md-12">
										    <p id ="lyrics">
										      ${detail.lyrics}
										    </p>
										</div>
									</div>
								</div>
								<!-- /tab2  -->

								<!-- tab3  -->
								<div id="tab3" class="tab-pane fade in">
									<div class="row">
																				
											<div class="col-md-4 col-xs-6">
											  <div class="shop">
											    <a href="javascript:void(0)" onclick="openModal('${detail.mvfile}/')">
											      <div class="shop-img">
											        <img src="${detail.filepath}" style="width:360px; height: 240px;">
											      </div>
											    </a>  
											    <div class="shop-body">
											      <h3>${detail.musicsinger}<br>${detail.musictitle}</h3>
											      <a href="javascript:void(0)" onclick="openModal('${detail.mvfile}/')" class="cta-btn">MV보기<i class="fa fa-arrow-circle-right"></i></a>
											    </div>
											  </div>
											</div>
										
											<div class="col-md-4 col-xs-6">
												<p>${detail.videocontent}</p>
											</div>
										
										
											
											
																
										
									</div>
								</div>
								<!-- /tab3  -->
							</div>
							<!-- /product tab content  -->
						</div>
					</div>
					<!-- /product tab -->
				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /SECTION -->

		

	<!-- Modal 사진 -->
	<div class="modal fade" id="photoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	        </div>
	    </div>
	</div>
	
	<!-- Modal 음원 -->
	<div class="modal fade" id="musicModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	        </div>
	    </div>
	</div>
	
	<!-- 추가한 모달 창 -->
	<div id="myModal" class="modalmv">
	  <div class="modal-content"  id="mvmodal">
	    <span class="close">&times;</span>
	    <iframe id="videoFrame" width="800" height="400" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	  </div>
	</div>
	
	

	<!-- 가사줄바꿈 JS -->
	<script>
		function splitTextIntoLines(text, maxLength) {
		    var lines = [];
		    var currentLine = '';
	
		    for (var i = 0; i < text.length; i++) {
		        currentLine += text[i];
		        if ((i + 1) % maxLength === 0 || i === text.length - 1) {
		            lines.push(currentLine);
		            currentLine = '';
		        }
		    }
	
		    return lines.join('<br>');
		}
	
		var lyrics = "${detail.lyrics}";
		var maxLength = 20;
		var formattedLyrics = splitTextIntoLines(lyrics, maxLength);
		document.getElementById('lyrics').innerHTML = formattedLyrics;
	</script>

	
	
	<!-- 음원재생 JS -->
	<script>
        function playAudio() {
            var audio = document.getElementById("audioPlayer");
            audio.play();
        }
    </script>

	<!-- 음원다운로드 JS -->
	<script>
        document.getElementById("downloadButton").addEventListener("click", function(event) {
            event.preventDefault(); // 기본 동작(버튼 이벤트)을 막음
            
            var url = "${detail.filemusic}"; // 다운로드할 파일의 URL
            var filename = "file.wav"; // 다운로드할 파일의 이름
            
            var anchor = document.createElement("a");
            anchor.href = url;
            anchor.download = filename;
            document.body.appendChild(anchor);
            anchor.click();
            document.body.removeChild(anchor);
        });
    </script>



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
	


































<%@include file="/WEB-INF/view/layout/footer.jsp" %>    
    