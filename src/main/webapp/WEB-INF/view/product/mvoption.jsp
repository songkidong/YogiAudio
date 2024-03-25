<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/layout/header.jsp" %>

    
<title>국내음악리스트</title>


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


	
  <!-- SECTION -->
		<div class="section" style="margin-left: 200px;">
			<!-- container -->
			<div class="container">
			
			
			  
					 <div style="display: flex; align-items: center; margin-bottom: 20px;">
			            <h3 class="title" style="margin-right: 20px;">📺뮤직비디오(${param.searchOption})</h3> 
			            
			            
			             <div class="section-nav">
						    <ul class="section-tab-nav tab-nav">
						        <li id="allOption"><a href="/mv/mvoptionlist">전체</a></li>
						        <li id="balladOption"><a href="/mv/mvoptionlist-option?searchOption=발라드">발라드</a></li>
						        <li id="trotOption"><a href="/mv/mvoptionlist-option?searchOption=트로트">트로트</a></li>
						        <li id="hiphopOption"><a href="/mv/mvoptionlist-option?searchOption=힙합">힙합</a></li>
						        <li id="hiphopOption"><a href="/mv/mvoptionlist-option?searchOption=클래식">클래식</a></li>
						    </ul>
						 </div>  
			          
			            
			         </div>
					
					
					
					
					
					
					
					
					
					
					
				<!-- row -->
				<div class="row">
					<!-- STORE -->
					<div id="store" class="col-md-9">
						<!-- store products -->
						 <div class="row">
						 
			<!-- product -->		
				<c:forEach var="mvoptionlist" items="${mvoptionlist}">
					<!-- shop -->
					<div class="col-md-4 col-xs-6">
						<div class="shop">
							   <c:choose>
							    <c:when test="${principal.role eq 'ADMIN'}">
							        <a href="/mv/mv-update" data-toggle="modal" data-target="#mvModal" class="cta-btn">
							            <div class="shop-img">
							                <c:choose>
							                    <c:when test="${not empty mvoptionlist.filepath}">
							                        <img src="${mvoptionlist.filepath}" style="width:360px; height: 240px;">
							                    </c:when>
							                    <c:otherwise>
							                        <img src="/album/default.png" style="width:360px; height: 240px;">
							                    </c:otherwise>
							                </c:choose>
							            </div>
							        </a>
							    </c:when>
							    <c:otherwise>
							        <a href="javascript:void(0)" onclick="openModal('${mvoptionlist.mvfile}/')" class="cta-btn">
							            <div class="shop-img">
							                <c:choose>
							                    <c:when test="${not empty mvoptionlist.filepath}">
							                        <img src="${mvoptionlist.filepath}" style="width:360px; height: 240px;">
							                    </c:when>
							                    <c:otherwise>
							                        <img src="/album/default.png" style="width:360px; height: 240px;">
							                    </c:otherwise>
							                </c:choose>
							            </div>
							        </a>
							    </c:otherwise>
							</c:choose>
							<div class="shop-body" id="mvInfo">
								<h3>${mvoptionlist.videosinger}<br>${mvoptionlist.videotitle}</h3>
								<a href="javascript:void(0)"  onclick="openModal('${mvoptionlist.mvfile}/')" class="cta-btn">MV보기<i class="fa fa-arrow-circle-right"></i></a>
							</div>
						</div>
					</div>
					<!-- /shop -->
				</c:forEach>
			  <!-- /product -->						


					</div>
						<!-- /store products -->

					<!-- store bottom filter -->
						<div class="store-filter clearfix">
							<ul class="store-pagination">
							
							
							
						    <c:if test="${pageVO.prev }">
								<li class="page-item">
								  <a class="page-link" href="/mv/mvlist-option?page=${pageVO.startPage - 1 }&searchOption=${pageVO.cri.searchOption}" aria-label="Previous">
								  	<i class="fa fa-angle-left"></i> 
								  </a>
								</li>
							</c:if>
							
							
							
								<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
									<li class="page-item ${isActive ? 'active' : ''}">
										<a class="page-link" href="/mv/mvlist-option?page=${i}&searchOption=${pageVO.cri.searchOption}">
										   ${i}
										</a>
									</li>
								</c:forEach>			
								
								
								
							<c:if test="${pageVO.next}">	
								<li class="page-item">
									<a href="/mv/mvlist-option?page=${pageVO.endPage + 1}&searchOption=${pageVO.cri.searchOption}">
										<i class="fa fa-angle-right"></i>
									</a>
								</li>
							</c:if>
								
								
						  </ul>
						</div>
						<!-- /store bottom filter -->
						
						
						
					</div>
					<!-- /STORE -->
				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /SECTION -->
	

	
	<!-- 추가한 모달 창 -->
	<div id="myModal" class="modalmv">
	  <div class="modal-content"  id="mvmodal">
	    <span class="close">&times;</span>
	    <iframe id="videoFrame" width="800" height="400" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	  </div>
	</div>
	
	
	<!-- Modal 뮤비업뎃 -->
	<div class="modal fade" id="mvModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content"></div>
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

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
<%@include file="/WEB-INF/view/layout/footer.jsp" %>    
	
	
