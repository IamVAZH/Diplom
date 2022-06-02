<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title><spring:message code="task.title"/></title>
    <jsp:include page="fragments/headTags.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/formstyle.css">
    <title><spring:message code="title.form"/></title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/logo.png">

</head>
<body>
<header>
    <a href="${pageContext.request.contextPath}/" class="logo"><spring:message code="app.title"/></a>
    <div id="toggle" onclick="toggle()"></div>
</header>
<div id="navigation">
    <ul>
        <sec:authorize access="isAuthenticated()">
            <li><a href="${pageContext.request.contextPath}/"><spring:message code="app.general"/></a></li>
            <sec:authorize access="hasRole('ROLE_ADMIN')">
                <li><a href="${pageContext.request.contextPath}/admin/users"><spring:message code="app.users"/></a></li>
            </sec:authorize>
            <li><a href="${pageContext.request.contextPath}/profile"><spring:message code="app.profile"/></a></li>
        </sec:authorize>
        <sec:authorize access="isAuthenticated()">
            <li><a href="${pageContext.request.contextPath}/tasks"><spring:message code="app.tasks"/></a></li>
            <li><a id="fao" data-toggle="modal" data-target="#tutorial"><spring:message code="app.fao"/></a></li>
            <li><a href="${pageContext.request.contextPath}/logout"><spring:message code="app.logout"/></a></li>
        </sec:authorize>
        <sec:authorize access="isAnonymous()">
            <li><a href="${pageContext.request.contextPath}/login"><spring:message code="app.login"/></a></li>
            <li><a href="${pageContext.request.contextPath}/registration"><spring:message code="app.register"/></a></li>
        </sec:authorize>
        <li><a href="${requestScope['javax.servlet.forward.request_uri']}?lang=en">en</a></li>
        <li><a href="${requestScope['javax.servlet.forward.request_uri']}?lang=ru">ru</a></li>
    </ul>
</div>
<jsp:useBean id="task" type="ru.vazh.model.Task" scope="request"/>
<form method="post" action="${pageContext.request.contextPath}/tasks">
    <input type="hidden" name="id" value="${task.id}">
    <div class="container">
        <div class="img tool">
            <a href="${pageContext.request.contextPath}/img?id=${task.id}"><img
                    src="${pageContext.request.contextPath}/img/${task.img_path}"></a>
        </div>
        <div id="data-local" class="data"><input type="datetime-local" value="${task.dateTime}" name="dateTime"
                                                 min="2022-05-13T00:00"
                                                 max="2999-12-31T23:59" required></div>
        <div class="title">
            <input class="text-field__input" type="text" name="name" id="Title"
                   placeholder="<spring:message code="task.field"/>" value="${task.name}">
        </div>
        <div class="mainText">
            <textarea class="text-field__input1" name="taskText" required>${task.text}</textarea>
        </div>
        <div class="description">
            <textarea class="text-field__input1" name="shortDescription" required>${task.shortDescription}</textarea>
        </div>
        <div class="audio text-field__input1">
            <audio src="/diplom/audio/${task.audio_path}" controls></audio>&nbsp;&nbsp;&nbsp;
            <a href="${pageContext.request.contextPath}/audio?id=${task.id}"><spring:message code="task.audioBtn"/></a>
        </div>
        <div class="video field__input1">
            <video width="700" controls src="/diplom/video/${task.video_path}"></video>
            <a href="${pageContext.request.contextPath}/video?id=${task.id}"><spring:message code="task.videoBtn"/></a>
        </div>

        <div class="confirm field__input1">
            <button type="submit"><spring:message code="task.submitBtn"/></button>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <a href="${pageContext.request.contextPath}/tasks">
                <button type="button"><spring:message code="task.close"/></button>
            </a>
            <a></a>
        </div>
    </div>
</form>

<div class="modal fade" id="tutorial" tabindex="-1" role="dialog"
     aria-labelledby="tutorial" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="tutorialLable"><spring:message code="app.fao"/></h5>
                <button class="close" type="button" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <img src="${pageContext.request.contextPath}/resources/images/<spring:message code="app.faoImg"/>"/>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    function toggle() {
        var nav = document.getElementById('navigation');
        nav.classList.toggle('active');
    }
</script>
</body>
</html>
