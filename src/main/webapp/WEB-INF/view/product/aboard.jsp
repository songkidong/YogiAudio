<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/layout/header.jsp" %>

    
<title>국외음악리스트</title>
	
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
			            <h3 class="title" style="margin-right: 20px;">🛫국외음악</h3>
			            <div class="section-nav" style="margin-left: 550px;">
			                <select class="section-tab-select tab-select form-control">
			                    <option value="#tab1">전체</option>
			                    <option value="#tab2">발라드</option>
			                    <option value="#tab3">트로트</option>
			                    <option value="#tab4">힙합</option>
			                </select>
			            </div>
			        </div>
				
				
				
				
				
				
				
				
				
				<!-- row -->
				<div class="row">
					<!-- STORE -->
					<div id="store" class="col-md-9">
						<!-- store products -->
						 <div class="row">
						 
						 
						 
							<!-- product -->
						  <c:forEach var="aboardlist" items="${aboardlist}">
							 <div class="col-md-4 col-xs-6">
								<div class="product">
									<div class="product-img">
										<img src="/album/default.png" alt="">
										<div class="product-label">
										</div>
									</div>
									<div class="product-body">
										<p class="product-category">${aboardlist.musicmajor}</p>
										<h3 class="product-name">
											<a href="/product/aboard-detail?musicno=${aboardlist.musicno}&musicmajor=${aboardlist.musicmajor}">
											  ${aboardlist.musictitle}
											</a>
										</h3>
										<h4 class="product-price">${aboardlist.musiccompany}<del class="product-old-price"></del></h4>
										
										
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
							
								<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
									<li class="page-item ${isActive ? 'active' : ''}">
										<a class="page-link" href="/product/aboard-music?page=${i}">
										   ${i}
										</a>
									</li>
								</c:forEach>			
								
							<c:if test="${pageVO.next}">	
								<li class="page-item">
									<a href="/product/aboard-music?page=${pageVO.endPage + 1}">
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
	
	
