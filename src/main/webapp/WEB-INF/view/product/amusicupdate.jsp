<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>    

	<form action="/product/amusic-update" method="post" enctype="multipart/form-data">
		<div class="card mb-3" style="max-width: 700px;">
		  <div class="row g-0">
		    <div class="col-md-4">
		      <img src="/album/default.png" style="width: 100px; height: 130px; margin-left: 30px; margin-top: 60px;" class="img-fluid rounded-start" alt="...">
		    </div>
		    <div class="col-md-8">
		      <div class="card-body">
		        <h3 class="card-title" style="margin-top: 50px;">음원등록</h3>
		        
		        <div class="row" style ="margin-top: 30px;">
		        	 <div class="col-md-3">
				        <label for="name" class="form-label">번호</label>
				     </div>
				    <div class="col-md-5">
				        <div class="input-box">
				            <input type="text" class="form-control" name ="musicno" id="musicno_input" >
				        </div>
				    </div>
				  </div>
		 		
		 		
		 	  <div class="row" style ="margin-top: 10px;">
				    <div class="col-md-3">
				        <label for="name" class="form-label">음원등록</label>
				    </div>
				    <div class="col-md-5">
				        <div class="input-box">
						<input type='file' id='btnAtt' multiple='multiple' name="files">				        
				    </div>
				</div>
		      </div>
		 		
		 		
		 		
	
		      </div>
		    </div>
		  </div>
		  
		  <div class="row">
            <div class="col-md-12">
                <button type="submit" class="btn btn-success" id="updateButton" style="margin-left:450px; margin-bottom: 10px; margin-top:10px;">등록하기</button>
            </div>
          </div>
		  
		  
		   
		</div>
		
	</form>	