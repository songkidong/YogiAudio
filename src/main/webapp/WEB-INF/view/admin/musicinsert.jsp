<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/view/admin/layout/header.jsp" %>

	<form action="/admin/music-insert" method="post" enctype="multipart/form-data">
	    <div class="container-insertmusic" style="margin-top: 50px;">
	        <div class="row justify-content-center"> <!-- 중앙 정렬 -->
	            <div class="col-md-4"> <!-- 중간 폭 설정 -->
	        		<h3 class="title">🔊음원등록</h3>
	                <div class="mb-3">
	                    <label for="exampleFormControlInput1" class="form-label">제목</label>
	                    <input type="text" class="form-control" name="musictitle" >
	                </div>
	                 <div class="mb-3">
	                    <label for="exampleFormControlInput1" class="form-label">가수</label>
	                    <input type="text" class="form-control" name="musicsinger" >
	                </div>
	                <div class="mb-3">
	                    <label for="exampleFormControlInput1" class="form-label">국가분류</label>
	                     <select class="form-select" name="musicmajor">
					        <option value="국내">국내</option>
					        <option value="국외">국외</option>
					    </select>
	                </div>
	                <div class="mb-3">
	                    <label for="exampleFormControlInput1" class="form-label">장르</label>
	                     <select class="form-select" name="musicminor">
					        <option value="발라드">발라드</option>
					        <option value="힙합">힙합</option>
					        <option value="클래식">클래식</option>
					        <option value="트로트">트로트</option>
					    </select>
	                </div>
	                 <div class="mb-3">
	                    <label for="exampleFormControlInput1" class="form-label">소속사</label>
	                    <input type="text" class="form-control" name="musiccompany" >
	                 </div>
	                 <div class="mb-3">
	                    <label for="exampleFormControlInput1" class="form-label">발매일</label>
	                    <input type="text" class="form-control" name="startdate">
	                </div>
	                 <div class="mb-3">
	                    <label for="exampleFormControlInput1" class="form-label">가격</label>
	                    <input type="text" class="form-control" name="musicprice">
	                </div>
	                <div class="mb-3">
	                    <label for="exampleFormControlTextarea1" class="form-label">가사</label>
	                    <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="lyrics"></textarea>
	                </div>
	                <div class="mb-3">
	                    <label for="exampleFormControlTextarea1" class="form-label">음원설명</label>
	                    <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="musiccontent"></textarea>
	                </div>
	                <div class="mb-3">
	                    <label for="exampleFormControlTextarea1" class="form-label">앨범자켓</label>
	                    <input type='file' id='btnAtt' multiple='multiple' name="files2">
	                </div>
	                 <div class="mb-3">
	                    <label for="exampleFormControlInput1" class="form-label">음원파일</label>
	                    <input type='file' id='btnAtt' multiple='multiple' name="files">
	                </div>
	                  <button type="submit" class="btn btn-success" id="updateButton">등록하기</button>
	            </div>
	        </div>
	    </div>
	</form>





















































<%@ include file="/WEB-INF/view/admin/layout/footer.jsp" %>
