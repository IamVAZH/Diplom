<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Task</title>
    <style>
        dl {
            background: none repeat scroll 0 0 #FAFAFA;
            margin: 8px 0;
            padding: 0;
        }

        dt {
            display: inline-block;
            width: 170px;
        }

        dd {
            display: inline-block;
            margin-left: 8px;
            vertical-align: top;
        }
    </style>
</head>
<body>
<section>
    <h3><a href="index.html">Home</a></h3>
    <hr>
    <h2>${param.action == 'create' ? 'Create meal' : 'Edit meal'}</h2>
    <jsp:useBean id="task" type="ru.vazh.model.Task" scope="request"/>
    <form method="post" action="tasks">
        <input type="hidden" name="id" value="${task.id}">
        <dl>
            <!--<dt>DateTime:</dt> -->
            <dd><input type="hidden" value="${task.dateTime}" name="dateTime" required></dd>
        </dl>
        <dl>
            <dt>Name:</dt>
            <dd><input type="text" value="${task.name}" size=40 name="name" required></dd>
        </dl>
        <dl>
            <dt>Text:</dt>
            <dd><input type="text" value="${task.text}" name="text" required></dd>
        </dl>
        <button type="submit">Save</button>
        <button onclick="window.history.back()" type="button">Cancel</button>
    </form>
</section>
</body>
</html>
