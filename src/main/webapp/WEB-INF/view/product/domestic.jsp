<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/layout/header.jsp" %>

    
<title>국내음악리스트</title>


<style>
  .section-tab-select {
    width: 150px; /* 원하는 너비로 설정하세요 */
  }
</style>


	   <!-- SECTION -->
		<div class="section" style="margin-left: 200px;">
			<!-- container -->
			<div class="container">
			
			
			  
					 <div style="display: flex; align-items: center; margin-bottom: 20px;">
			            <h3 class="title" style="margin-right: 20px;">🌏국내음악</h3>
			            
			          <form action="/product/domestic-search" method="get" id="searchForm" onchange="submitForm()">
			            <div class="section-nav" style="margin-left: 550px;">
			                <select class="section-tab-select tab-select form-control" name="searchOption">
			                    <option value="선택">선택</option>
			                    <option value="발라드">발라드</option>
			                    <option value="트로트">트로트</option>
			                    <option value="힙합">힙합</option>
			                </select>
			            </div>
			          </form>  
			        </div>
					
					
					<script>
					    // select 요소의 값이 변경될 때마다 호출되는 함수
					    function submitForm() {
					        document.getElementById('searchForm').submit();
					    }
	
					</script>
					
					
					
					
					
				<!-- row -->
				<div class="row">
					<!-- STORE -->
					<div id="store" class="col-md-9">
						<!-- store products -->
						 <div class="row">
						 
					   <!-- product -->
						
						  <c:forEach var="domesticlist" items="${domesticlist}">
							 <div class="col-md-4 col-xs-6">
								<div class="product">
									<div class="product-img">
										<c:choose>
										    <c:when test="${not empty domesticlist.filepath}">
										      <img src=" ${domesticlist.filepath}">
										    </c:when>
										  <c:otherwise>
											  <img src="/album/default.png" >
										  </c:otherwise>
										 </c:choose>
										<div class="product-label">
									  </div>
									</div>
									<div class="product-body">
										<p class="product-category">${domesticlist.musicno}</p>
										<p class="product-category">${domesticlist.musicmajor}</p>
										<h3 class="product-name">
											<a href="/product/domestic-detail?musicno=${domesticlist.musicno}&musicmajor=${domesticlist.musicmajor}&id=${principal.id}">
												${domesticlist.musictitle}
											</a>
										</h3>
										<h4 class="product-price">${domesticlist.musiccompany}<del class="product-old-price"></del></h4>
										
									</div>
								
								</div>
							</div>
						 </c:forEach>
						
							<!-- /product -->						


					</div>
						<!-- /store products -->

						<!-- store bottom filter -->
						<div class="store-filter clearfix">
							<ul class="store-pagination">
							
							
							
						    <c:if test="${pageVO.prev }">
								<li class="page-item">
								  <a class="page-link" href="/product/domestic-music?page=${pageVO.startPage - 1 }" aria-label="Previous">
								  	<i class="fa fa-angle-left"></i> 
								  </a>
								</li>
							</c:if>
							
							
							
								<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
									<li class="page-item ${isActive ? 'active' : ''}">
										<a class="page-link" href="/product/domestic-music?page=${i}">
										   ${i}
										</a>
									</li>
								</c:forEach>			
								
								
								
							<c:if test="${pageVO.next}">	
								<li class="page-item">
									<a href="/product/domestic-music?page=${pageVO.endPage + 1}">
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
<%@include file="/WEB-INF/view/layout/footer.jsp" %>    
	
	
