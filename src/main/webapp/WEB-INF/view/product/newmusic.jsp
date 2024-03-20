<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/layout/header.jsp" %>

    
<title>최신음악리스트</title>
	
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
			            <h3 class="title" style="margin-right: 20px;">🔥최신곡</h3>
			            
			             
			            <!-- 검색옵션창 -->
			            
			        </div>
				
				
					
				
				
				
				
				
				
				<!-- row -->
				<div class="row">
					<!-- STORE -->
					<div id="store" class="col-md-9">
						<!-- store products -->
						 <div class="row">
						 
						 
						 
							<!-- product -->
						  <c:forEach var="newlist" items="${newlist}">
							 <div class="col-md-4 col-xs-6">
								<div class="product">
									<div class="product-img">
									 	 <c:choose>
										    <c:when test="${not empty newlist.filepath}">
										      <img src=" ${newlist.filepath}">
										    </c:when>
										  <c:otherwise>
											  <img src="/album/default.png" >
										  </c:otherwise>
										 </c:choose>
									 <div class="product-label">
								   </div>
								 </div>
								 
								 
									<div class="product-body">
										<p class="product-category">${newlist.musicmajor}</p>
										<p class="product-category">${newlist.musicminor}</p>
										<h3 class="product-name">
											<c:url value="#" var="detailUrl">
											    <c:param name="musicno" value="${newlist.musicno}" />
											    <c:param name="musicmajor" value="${newlist.musicmajor}" />
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
											    ${newlist.musictitle}
											</a>
										</h3>
										<h4 class="product-price">${newlist.musiccompany}<del class="product-old-price"></del></h4>
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
	
	
