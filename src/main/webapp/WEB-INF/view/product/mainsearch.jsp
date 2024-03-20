<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/layout/header.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

    
<title>검색결과</title>


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
			            <h3 class="title" style="margin-right: 20px;">통합검색결과(${param.searchOption})</h3>       
			        </div>
					
					
					
				
					
					
					
					
					
					
					
					
				<!-- row -->
				<div class="row">
					<!-- STORE -->
					<div id="store" class="col-md-9">
						<!-- store products -->
						 <div class="row">
						 
					   <!-- product -->
						
						  <c:forEach var="searchlist" items="${searchlist}">
							 <div class="col-md-4 col-xs-6">
								<div class="product">
									<div class="product-img">
										<c:choose>
										    <c:when test="${not empty searchlist.filepath}">
										      <img src=" ${searchlist.filepath}">
										    </c:when>
										  <c:otherwise>
											  <img src="/album/default.png" >
										  </c:otherwise>
										 </c:choose>
										<div class="product-label">
									  </div>
									</div>
									<div class="product-body">
										<p class="product-category">${searchlist.musicno}</p>
										<p class="product-category">${searchlist.musicmajor}</p>
										<h3 class="product-name">
											<a href="/product/domestic-detail?musicno=${searchlist.musicno}&musicmajor=${searchlist.musicmajor}&id=${principal.id}">
												${searchlist.musictitle}
											</a>
										</h3>
										<h4 class="product-price">${searchlist.musiccompany}<del class="product-old-price"></del></h4>
										
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
								  <a class="page-link" href="/product/main-search?page=${pageVO.startPage - 1 }&searchOption=${pageVO.cri.searchOption}" aria-label="Previous">
								  	<i class="fa fa-angle-left"></i> 
								  </a>
								</li>
							</c:if>
							
							
							
								<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
									<li class="page-item ${isActive ? 'active' : ''}">
										<a class="page-link" href="/product/main-search?page=${i}&searchOption=${pageVO.cri.searchOption}">
										   ${i}
										</a>
									</li>
								</c:forEach>			
								
								
								
							<c:if test="${pageVO.next}">	
								<li class="page-item">
									<a href="/product/main-search?page=${pageVO.endPage + 1}&searchOption=${pageVO.cri.searchOption}">
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
	
	
