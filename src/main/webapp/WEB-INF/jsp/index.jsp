<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <link href="webjars/bootstrap/4.6.1/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="webjars/jquery/3.6.0/jquery.min.js" defer></script>
    <script src="webjars/bootstrap/4.6.1/js/bootstrap.min.js" defer></script>
    <script src="webjars/bootstrap/4.6.1/js/bootstrap.bundle.min.js" defer></script>
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <title><spring:message code="app.general"/></title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/logo.png">
</head>
<body>
<video autoplay loop muted playsinline class="back-video">
    <source src="${pageContext.request.contextPath}/resources/background/backVideo1.mp4">
</video>
<section class="banner" id="sec">
    <header>
        <a href="${pageContext.request.contextPath}/" class="logo"><spring:message code="app.title"/></a>
        <div id="toggle" onclick="toggle()"></div>
    </header>
    <div class="content">
        <h2><spring:message code="app.h2"/> <span><spring:message code="app.author"/></span></h2>
        <p><spring:message code="app.p"/></p>
        <sec:authorize access="isAuthenticated()">
            <a href="${pageContext.request.contextPath}/conseption"><spring:message code="app.create"/></a>
        </sec:authorize>
    </div>
</section>
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
        var sec = document.getElementById('sec');
        var nav = document.getElementById('navigation');
        sec.classList.toggle('active');
        nav.classList.toggle('active');
    }
</script>
</body>
</html>
