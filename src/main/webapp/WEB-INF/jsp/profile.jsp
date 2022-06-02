<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="vazh" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<jsp:include page="fragments/headTags.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/audStyle.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/conseptionStyle.css">
<title><spring:message code="app.title"/></title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/logo.png">

<body onload="backbiting()">
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
    <%--@elvariable id="user" type="ru.vazh.model.User"--%>
    <h3>${user.name} <spring:message code="${register ? 'profile.registration' : 'profile.profile'}"/></h3>
    <form:form class="form-group" modelAttribute="user" method="post"
               action="${register ? 'registration' : 'profile'}"
               charset="utf-8" accept-charset="UTF-8">

        <input name="id" value="${user.id}" type="hidden">
        <vazh:inputField labelCode="user.name" name="name"/>
        <vazh:inputField labelCode="user.email" name="email"/>
        <vazh:inputField labelCode="user.password" name="password" inputType="password"/>

        <button id="signIn" type="submit"><spring:message code="profile.save"/></button>
        <button id="signIn" onclick="window.history.back()" type="button"><spring:message code="profile.cancel"/></button>

    </form:form>
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
    function backbiting() {
        document.getElementById("name").placeholder = "<spring:message code="profile.placeholder.name"/>";
        document.getElementById("email").placeholder = "<spring:message code="profile.placeholder.email"/>";
        document.getElementById("password").placeholder = "<spring:message code="profile.placeholder.pass"/>";
    }

    function toggle() {
        var nav = document.getElementById('navigation');
        nav.classList.toggle('active');
    }

    window.onload(function () {
        alert("OK");
    })
</script>
</body>
</html>