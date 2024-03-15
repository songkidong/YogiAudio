<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/WEB-INF/view/layout/header.jsp" %>    


  <!-- SECTION -->
		<div class="section" style="margin-left: 200px;">
			<!-- container -->
			<div class="container">
			
			
			  
					 <div style="display: flex; align-items: center; margin-bottom: 20px;">
			            <h3 class="title" style="margin-right: 20px;">📺뮤직비디오</h3> 
			         </div>
					
					
					
					
					
					
					
					
					
					
					
				<!-- row -->
				<div class="row">
					<!-- STORE -->
					<div id="store" class="col-md-9">
						<!-- store products -->
						 <div class="row">
						 
					   <!-- product -->
						
				<c:forEach var="mvlist" items="${mvlist}">
					<!-- shop -->
					<div class="col-md-4 col-xs-6">
						<div class="shop">
						  <a href="https://www.youtube.com/watch?v=kHW-UVXOcLU/">
							<div class="shop-img">
								<img src="/main/img/IU1.jpg" style="width:360px; height: 240px;">
							</div>
						  </a>	
							<div class="shop-body">
								<h3>${mvlist.videosinger}<br>${mvlist.videotitle}</h3>
								<a href="https://www.youtube.com/watch?v=kHW-UVXOcLU/" class="cta-btn">MV보기<i class="fa fa-arrow-circle-right"></i></a>
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
								  <a class="page-link" href="/mv/list?page=${pageVO.startPage - 1 }" aria-label="Previous">
								  	<i class="fa fa-angle-left"></i> 
								  </a>
								</li>
							</c:if>
							
							
							
								<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
									<li class="page-item ${isActive ? 'active' : ''}">
										<a class="page-link" href="/mv/list?page=${i}">
										   ${i}
										</a>
									</li>
								</c:forEach>			
								
								
								
							<c:if test="${pageVO.next}">	
								<li class="page-item">
									<a href="/mv/list?page=${pageVO.endPage + 1}">
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
