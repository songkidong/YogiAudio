<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>b.jsp</title>
    <script>
    // 부모 창에서 호출되어 리스트에 데이터를 추가하는 함수
    function addToList(data) {
        // 받은 데이터를 리스트에 추가
        var listItem = document.createElement('li');
        listItem.textContent = data;
        document.getElementById('list').appendChild(listItem);
    }
    </script>
</head>
<body>
    <h1>자식 창</h1>
    <ul id="list"></ul>
</body>
</html>
