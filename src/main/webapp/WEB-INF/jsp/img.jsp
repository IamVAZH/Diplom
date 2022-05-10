<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
</head>
<body>
<img src="${pageContext.request.contextPath}/${savedImg}" alt="logo">
<form method="post" action="${pageContext.request.contextPath}/img" enctype="multipart/form-data">
    <input name="image" type="file" accept="image/png, image/jpeg, image/jpg"><br>
    <input value="${id}" name="id" type="hidden">
    <input type="submit" value="Upload">
</form>
</body>
</html>
