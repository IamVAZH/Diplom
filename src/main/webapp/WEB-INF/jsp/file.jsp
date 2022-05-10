<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://topjava.javawebinar.ru/functions" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<lable>Video:</lable>
<video width="700" controls src="${pageContext.request.contextPath}/${video}"></video>
</body>
</html>
