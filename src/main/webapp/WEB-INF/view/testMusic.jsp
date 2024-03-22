<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>File Upload JSP</title>
</head>
<body>
    <h1>File Upload</h1>
    <form action="/testFile" method="post" enctype="multipart/form-data">
        <input type="file" name="file" id="file">
        <input type="submit" value="Upload" name="submit">
    </form>
</body>
</html>