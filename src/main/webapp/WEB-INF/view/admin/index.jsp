<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/view/admin/layout/header.jsp" %>

            <!-- Content -->

            <div class="container-xxl flex-grow-1 container-p-y">
              <div class="row">
                <div class="col-lg-8 mb-4 order-0"  style="width: 100%;">
                  <div class="card">
                    <div class="d-flex align-items-end row">
                      <div class="col-sm-7">
                        <div class="card-body">
                          <h5 class="card-title text-primary" style="font-size: 30px">ADMIN ${principal.name}님 반갑습니다 🎉</h5>

                        </div>
                      </div>
                      <div class="col-sm-5 text-center text-sm-left">
                        <div class="card-body pb-0 px-0 px-md-4">
                          <img
                            src="/assets/img/illustrations/관리자.png"
                            height="140"
                            alt="View Badge User"
                            data-app-dark-img="illustrations/man-with-laptop-dark.png"
                            data-app-light-img="illustrations/man-with-laptop-light.png"
                          />
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-4 col-md-4 order-1" style="text-align: center; font-size: 30px;">
                  <div class="row">
                    <div class="col-lg-6 col-md-12 col-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <i class="fas fa-user" style="font-size: 30px; color: skyblue;"></i>
                          <span class="fw-semibold d-block mb-1" style="margin-top: 20px">회원</span>
                          <h3 class="card-title mb-2">${userCountByUserRole}</h3>
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-6 col-md-12 col-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <i class="fas fa-music" style="font-size: 30px; color: skyblue;"></i>
                          <span class="fw-semibold d-block mb-1" style="margin-top: 20px">음악</span>
                          <h3 class="card-title text-nowrap mb-1">${musicCount }</h3>
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-6 col-md-12 col-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <i class="fas fa-video" style="font-size: 30px; color: skyblue;"></i>
                          <span class="fw-semibold d-block mb-1" style="margin-top: 20px">뮤직비디오</span>
                          <h3 class="card-title text-nowrap mb-2">${musicvideoCount }</h3>
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-6 col-md-12 col-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                       	  <i class="fas fa-credit-card" style="font-size: 30px; color: skyblue;"></i>
                          <span class="fw-semibold d-block mb-1" style="margin-top: 20px">환불 미승인</span>
                          <h3 class="card-title mb-2">${incompletedRefundCount }</h3>
                        </div>
                      </div>
                    </div>
                    
                    
                    
                  </div>
                </div>
                <!-- Total Revenue -->
                <div class="col-12 col-lg-8 order-2 order-md-3 order-lg-2 mb-4">
                  
					<!-- empty 키워드는 변수가 null이거나 비어있는 경우를 확인 -->
					<c:if test="${empty qnaList }">
						<h1 style="display: flex; justify-content: center;">QnA가 존재하지 않습니다</h1>
					</c:if>
					
					<!-- qnaList가 비어있으면 테이블 자체가 보이지 않도록 함 -->
					<c:if test="${not empty qnaList }">
					<!-- Hoverable Table rows -->
				              <div class="card">
				                <h5 class="card-header">QnA</h5>
				                
				                <div class="button-container d-flex justify-content-end">
									<!-- onclick="history.back()" 하면 답변 등록됐을 때 view 페이지는  답변 여부가 업데이트가 되는데, list 페이지는 반영 안됨 -->
									<a href="/admin/qnaList" class="btn btn-info rounded-pill shadow-sm" style="color: white; margin-right: 8%; margin-bottom: 10px;">전체 보기</a>
								</div>
				                <div class="table-responsive text-nowrap">
				                  <table class="table table-hover">
				                    <thead>
				                      <tr>
				                        <th>번호</th>
				                        <th>작성자</th>
				                        <th>제목</th>
				                        <th>답변 여부</th>
				                        <th>등록일</th>
				                        <th>삭제</th>
				                      </tr>
				                    </thead>
				                    <tbody class="table-border-bottom-0">
				                    <!-- 반복문 -->
					               		<c:forEach var="qna" items="${qnaList }">
						                 	<tr>
						            		  <td>${qna.id}</td>
						            		  <td>${qna.writerName}</td>
						            		  <td><a href="/admin/qnaView/${qna.id}">${qna.title}</a></td>
						            		  <td style="padding-left: 40px;">${qna.answerYn}</td>
						            		  <td>${qna.formatCreatedAt()}</td>
						            		  <td>
						            		  	<a data-id="${qna.id }" name="deleteButton" class="btn btn-primary" style="color: white">삭제</a>
						            		  </td>
						                   	</tr>
					                  	</c:forEach>
				               		<!-- 반복문 끝-->
				                    </tbody>
				                  </table>
				                </div>
				              </div>
					<!--/ Hoverable Table rows -->
					</c:if>
                </div>
                <!--/ Total Revenue -->
                
              </div>
              <div class="row">
                

               

              
              </div>
            </div>
            <!-- / Content -->

<script src="/js/admin/index.js"></script>
<%@ include file="/WEB-INF/view/admin/layout/footer.jsp" %>
		
		
		