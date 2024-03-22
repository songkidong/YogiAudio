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
			            
			             
			            <div class="section-nav">
						    <ul class="section-tab-nav tab-nav">
						        <li id="allOption"><a href="/product/aboard-music">전체</a></li>
						        <li id="balladOption"><a href="/product/aboard-search?searchOption=발라드">발라드</a></li>
						        <li id="classicOption"><a href="/product/aboard-search?searchOption=클래식">클래식</a></li>
						        <li id="hiphopOption"><a href="/product/aboard-search?searchOption=힙합">힙합</a></li>
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
						  <c:forEach var="aboardlist" items="${aboardlist}">
							 <div class="col-md-4 col-xs-6">
								<div class="product">
									<div class="product-img">
									 	 <c:choose>
										    <c:when test="${not empty aboardlist.filepath}">
										      <img src=" ${aboardlist.filepath}">
										    </c:when>
										  <c:otherwise>
											  <img src="/album/default.png" >
										  </c:otherwise>
										 </c:choose>
									 <div class="product-label">
								   </div>
								 </div>
								 
								 
									<div class="product-body">
										<p class="product-category">${aboardlist.musicmajor}</p>
										<p class="product-category">${aboardlist.musicminor}</p>
										<h3 class="product-name">
											<c:url value="/product/aboard-detail" var="detailUrl">
											    <c:param name="musicno" value="${aboardlist.musicno}" />
											    <c:param name="musicmajor" value="${aboardlist.musicmajor}" />
											    <c:choose>
											        <c:when test="${not empty principal}">
											            <c:param name="id" value="${principal.id}" />
											        </c:when>
											        <c:otherwise>
											            <c:param name="id" value="" />
											        </c:otherwise>
											    </c:choose>
											</c:url>
											
											<a href="${detailUrl}">
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
								
							 <c:if test="${pageVO.prev }">
									<li class="page-item">
										<a class="page-link" href="/product/aboard-music?page=${pageVO.startPage - 1 }" aria-label="Previous">
											 <i class="fa fa-angle-left"></i> 
										</a>
									</li>
							  </c:if>
								
								
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
	
	
