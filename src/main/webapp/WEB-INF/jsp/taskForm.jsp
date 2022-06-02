<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<body>
<section>
    <jsp:useBean id="task" type="ru.vazh.model.Task" scope="request"/>
    <hr>
    <form method="post" action="${pageContext.request.contextPath}/tasks">
        <input type="hidden" name="id" value="${task.id}">
        <dl>
            <label>Created time: </label>
            <input type="datetime-local" value="${task.dateTime}" name="dateTime" required>
        </dl>
        <dl>
            <lable>Title:</lable>
            <input type="text" value="${task.name}" name="name" required>
        </dl>
        <dl>
            <textarea name="taskText" rows="50" cols="80" required>${task.text}</textarea>
        </dl>
        <dl>
            <textarea name="shortDescription" rows="4" cols="80" required>${task.shortDescription}</textarea>
        </dl>
        <dl>
            <lable>Audio:</lable>
            <audio src="/diplom/audio/${task.audio_path}" controls></audio>
            <a href="${pageContext.request.contextPath}/audio?id=${task.id}">change audio</a>
        </dl>
        <dl>
            <lable>Video:</lable>
            <video width="700" controls src="/diplom/video/${task.video_path}"></video>
            <a href="${pageContext.request.contextPath}/video?id=${task.id}">change video</a>
        </dl>
        <button type="submit">Submit changes</button>
        <button onclick="window.history.back()" type="button">Close</button>
    </form>
</section>
</body>
</html>
