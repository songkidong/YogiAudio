<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/view/admin/layout/header.jsp" %>
            
<!-- Content -->
	
	<hr class="my-5" />
	<!-- Hoverable Table rows -->
              <div class="card">
                <h5 class="card-header">유저 관리</h5>
                <div class="table-responsive text-nowrap">
                  <table class="table table-hover">
                    <thead>
                      <tr>
                        <th>번호</th>
                        <th>이름</th>
                        <th>닉네임</th>
                        <th>이메일</th>
                        <th>등급</th>
                        <th>가입일</th>
                        <th>수정/삭제</th>
                      </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                    <!-- 반복문 -->
	               		<c:forEach var="user" items="${userList }">
		                 	<tr>
		            		  <td>${user.id}</td>
		            		  <td>${user.name}</td>
		            		  <td>${user.nickname}</td>
		            		  <td>${user.email}</td>
		            		  <td>${user.role}</td>
		            		  <td>${user.createdAt}</td>
		            		  <td>
		            		  	<a class="btn border" href="" style="">수정</a>
		            		  	<a class="btn border" href="/admin/deleteUser/${user.id}" >삭제</a>
		            		  </td>
		                   	</tr>
	                  	</c:forEach>
               		<!-- 반복문 끝-->
                    </tbody>
                  </table>
                </div>
              </div>
              <!--/ Hoverable Table rows -->
              
              <!-- flex 속성으로 가운데정렬하기 -->
              <ul class="pagination" style="display: flex; justify-content: center; padding-right: 10%;">
				  
				  <!-- pageVO.prev가 참(시작페이지가 1이 아닐 때)이면 이전버튼 li태그 생성 -->
				  <c:if test="${pageVO.prev }">
				  	<li class="page-item">
				  		<a class="page-link" href="/admin/userList?page=${pageVO.startPage - 1 }"><i class="fas fa-chevron-left"></i></a>
				  	</li>
				  </c:if>
				  
				  <!-- 반복문 -->
				  <c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
				  <!-- 페이지 번호 클릭했을 때 Controller에서 pageVO.setCri(cri) 메서드를 통해, 현재 페이지 값 가져올 수 있음 -->
				  <li class="page-item ${pageVO.cri.page eq i ? 'active' : ''}">
				  	<!-- Controller에서 Criteria가 매개변수로 있어서, 여기서 page값 파라미터로 보낼때 받을 수 있음 -->
				  	<a class="page-link" href="/admin/userList?page=${i }">${i }</a>
				  </li>
				  </c:forEach>
				  <!-- 반복문 끝 -->
				  
				  <!-- pageVO.nexr가 참(끝페이지 * 페이지당 게시글 수가 총 갯수보다 작으면)이면 다음버튼 li태그 생성 -->
				  <c:if test="${pageVO.next }">
				  	<li class="page-item">
				  		<a class="page-link" href="/admin/userList?page=${pageVO.endPage + 1 }"><i class="fas fa-chevron-right"></i></a>
				  	</li>
				  </c:if>
				  
			  </ul>
              
              


<!-- / Content -->

<%@ include file="/WEB-INF/view/admin/layout/footer.jsp" %>            
		
		
		