<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <jsp:include page="fragments/headTags.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/audStyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/conseptionStyle.css">
    <title><spring:message code="app.create"/></title>
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

<div class="container">
    <form method="post" action="${pageContext.request.contextPath}/createAudio">
        <div class="form-group">
            <label id="titleLable" for="exampleInputEmail1"><spring:message code="task.field"/></label>
            <input name="name" type="text" class="form-control in1" id="exampleInputEmail1" aria-describedby="titleHelp"
                   placeholder="<spring:message code="task.field"/>" required>
            <%--            <small id="emailHelp" class="form-text text-muted">You need this to identify your task</small>--%>
        </div>
        <div class="form-group">
            <label for="exampleFormControlTextarea1">Text</label>
            <textarea name="text" class="form-control in2" id="exampleFormControlTextarea1" rows="13"
                      required></textarea>
        </div>

        <button type="submit"><spring:message code="creation.next"/></button>
        <button onclick="window.history.back()" type="button"><spring:message code="profile.cancel"/></button>
    </form>
</div>

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
