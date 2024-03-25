<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/view/admin/layout/header.jsp" %>





	<form action="/admin/mv-insert" method="post" enctype="multipart/form-data">
	    <div class="container-insertmusic">
	        <div class="row justify-content-center"> <!-- 중앙 정렬 -->
	            <div class="col-md-4"> <!-- 중간 폭 설정 -->
	                <div class="mb-3">
	                    <label for="exampleFormControlInput1" class="form-label">음원번호</label>
	                    <input type="text" class="form-control" id="exampleFormControlInput1" name="musicno">
	                </div>
	                <div class="mb-3">
	                    <label for="exampleFormControlInput2" class="form-label">뮤비제목</label>
	                    <input type="text" class="form-control" id="exampleFormControlInput2" name="videotitle">
	                </div>
	                <div class="mb-3">
	                    <label for="exampleFormControlInput2" class="form-label">가수</label>
	                    <input type="text" class="form-control" id="exampleFormControlInput2" name="videosinger">
	                </div>
	                <div class="mb-3">
	                    <label for="exampleFormControlInput2" class="form-label">국가분류</label>
	                    <input type="text" class="form-control" id="exampleFormControlInput2" name="musicmajor">
	                </div>
	                <div class="mb-3">
	                    <label for="exampleFormControlInput2" class="form-label">장르</label>
	                    <input type="text" class="form-control" id="exampleFormControlInput2" name="musicminor">
	                </div>
	                <div class="mb-3">
	                    <label for="exampleFormControlInput2" class="form-label">뮤비경로</label>
	                    <input type="text" class="form-control" id="exampleFormControlInput2" name="mvfile">
	                </div>
	                 <div class="mb-3">
	                    <label for="exampleFormControlInput1" class="form-label">뮤비앨범자켓</label>
	                    <input type='file' id='btnAtt' multiple='multiple' name="files">
	                </div>
	                <div class="mb-3">
	                    <label for="exampleFormControlTextarea1" class="form-label">뮤비내용</label>
	                    <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="videocontent"></textarea>
	                </div>
	                  <button type="submit" class="btn btn-success" id="updateButton">등록하기</button>
	            </div>
	        </div>
	    </div>
	</form>
	
























































<%@ include file="/WEB-INF/view/admin/layout/footer.jsp" %>
