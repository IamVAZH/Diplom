<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://topjava.javawebinar.ru/functions" %>
<%--<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>--%>
<html>
<head>
    <title>Task list</title>
</head>
<body>
<section>
    <h3><a href="index.html">Home</a></h3>
    <hr/>
    <h2>Task</h2>
    <a href="tasks?action=create">Add Task</a>
    <br><br>
    <table border="1" cellpadding="8" cellspacing="0">
        <thead>
        <tr>
            <th>Date</th>
            <th>Name</th>
            <th>Text</th>
            <th></th>
            <th></th>
        </tr>
        </thead>
        <c:forEach items="${tasks}" var="task">
            <jsp:useBean id="task" type="ru.vazh.model.Task"/>
            <tr>
                <td>
                        ${fn:formatDateTime(task.dateTime)}
                </td>
                <td>${task.name}</td>
                <td>${task.text}</td>
                <td><a href="tasks?action=update&id=${task.id}">Update</a></td>
                <td><a href="tasks?action=delete&id=${task.id}">Delete</a></td>
            </tr>
        </c:forEach>
    </table>
</section>
</body>
</html>