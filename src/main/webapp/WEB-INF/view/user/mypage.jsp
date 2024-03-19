<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <!-- CSS -->
    <link href="/css/user/mypage.css" rel="stylesheet">
</head>
<%@include file="/WEB-INF/view/layout/header.jsp"%>
   <div class="mypage-main-container">

        <form action="#" >
         <fieldset class="input-name">
            <h3 class="head-basic-info">내 정보</h3>
                <div class="input-key">
                    <label for="name">성명</label>  <br>
                    <input type="text" id="name" name="name" value="${principal.name}" readonly>
                </div>

                <div class="input-key">
                    <label for="nickname">별명</label>  <br>
                    <input type="text" id="nickname" name="nickname" value="${principal.nickname}" readonly>
                </div>

                <div class="input-key">
                    <label for="password">비밀번호</label>  <br>
                    <input type="password" id="password" name="password" value="${principal.password}" readonly>
                </div>

                <div class="input-key">
                    <label for="email">이메일 주소</label>  <br>
                    <input type="text" id="email" name="email" value="${principal.email}" readonly>
                </div>
          </fieldset>
                  <div class="button">
            <button class="change" id="change">수정하기</button>
        </div>
        </form>

        </div>
</body>
<%@include file="/WEB-INF/view/layout/footer.jsp"%>
</html>
