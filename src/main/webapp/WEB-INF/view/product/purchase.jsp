<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@include file="/WEB-INF/view/layout/header.jsp" %>    
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>


<!-- Banner Section -->
<div class="section">
    <div class="container">
      <h3 class="title" style="margin-left: 10px; margin-bottom: 30px; margin-top: 10px;">📀YogiAudio 이용권구매</h3>	
        <div class="row">
            <div class="col-md-12">
                <div style="display: flex; justify-content: center; align-items: center;">
                    <img src="/banner/purchase2.gif" style="width: 1200px; height: 300px; margin-bottom: 50px;" alt="Purchase Banner">
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div style="display: flex; justify-content: center; align-items: center;">
                    <img src="/banner/purchase.png" style="width: 1200px; height: 200px;" alt="Purchase Banner">
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End of Banner Section -->



<!-- Card Section -->
<div class="section">
    <div class="container" style="margin-bottom: 50px;">
	<h3 class="title" style="margin-left: 30px; margin-bottom: 30px; margin-top: 30px;">👉이용권 리스트</h3>
    
        <div class="row">
         	
         	
           <c:forEach var="purchaselist" items="${purchaselist}">
            <div class="col-md-3">
                <!-- Card 1 -->
                <div class="card">
                    <img src="/banner/${purchaselist.filepath}" class="card-img-top" alt="Card 1 Image" style="width:200px; height: 200px; margin-left: 30px;">
                    <div class="card-body" style="margin-left: 30px;">
                        <h5 class="card-title" style="margin-top: 5px;">${purchaselist.purchasename}</h5>
                        <p class="card-text">${purchaselist.price}</p>
                      
                      <c:if test="${udetail.status eq 'N' && udetail.cancel eq 'N'}">
		                 <a href="/purchase/detail?pno=${purchaselist.pno}" class="btn btn-primary">
		                    구매하기
		                 </a>
		              </c:if>  
		              <c:if test="${udetail.status eq 'N' && udetail.cancel eq 'Y'}">
		                 <a href="/purchase/detail?pno=${purchaselist.pno}" class="btn btn-primary">
		                    구매하기
		                 </a>
		              </c:if> 
 		              <c:if test="${udetail.status eq 'Y' && udetail.cancel eq 'N'}">
	                	   <p>
		                  	  이미이용권구매를완료했습니다!
 		                   </p> 
		              </c:if>   
		              
		                
                    </div>
                 </div>
                <!-- End of Card 1 -->
            </div>
          </c:forEach>
            
          
    
          
          
          
        </div>
    </div>
</div>
<!-- End of Card Section -->



<!-- Card Section -->
<div class="section">
    <div class="container" style="margin-bottom: 70px;">
	<h3 class="title" style="margin-left: 30px; margin-bottom: 30px;">🔷이용약관</h3>
    
        <div class="row">
        	<div class="col-md-6">
         		<h4>문의사항은 051-123-1234로 문의주세요</h4><br>
         		<h4>게시판에 문의사항을 남겨주시면 담당자 24시간안에 답변드립니다.</h4>
      		</div>
                
                
                
                
            </div>
        </div>
    </div>
<!-- End of Card Section -->












































<%@include file="/WEB-INF/view/layout/footer.jsp" %>    
