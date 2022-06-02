<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://topjava.javawebinar.ru/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <jsp:include page="fragments/headTags.jsp"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/tableStyle.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/audStyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/conseptionStyle.css">
    <title><spring:message code="app.users"/></title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/logo.png">

</head>
<header>
    <a href="${pageContext.request.contextPath}/" class="logo"><spring:message code="app.title"/></a>
    <div id="toggle" onclick="toggle()"></div>
</header>
<div class="container">
    <table class="content-table">
        <thead>
        <tr>
            <th><spring:message code="user.name"/></th>
            <th><spring:message code="user.email"/></th>
            <th><spring:message code="user.roles"/></th>
            <th><spring:message code="user.active"/></th>
            <th><spring:message code="user.registered"/></th>
            <th><spring:message code="user.edit"/></th>
            <th><spring:message code="user.delete"/></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${requestScope.users}" var="user">
            <jsp:useBean id="user" type="ru.vazh.model.User"/>
            <tr>
                <th>${user.name}</th>
                <th>${user.email}</th>
                <th>${user.roles}</th>
                <th>${user.enabled}</th>
                <%
                    String str = user.getRegistered().toString().substring(0, 10);
                %>
                <th>
                    <%=str%>
                </th>
                <th>
                    <a href="${pageContext.request.contextPath}/admin/update?id=${user.id()}"><spring:message code="user.edit"/></a>
                </th>
                <th>
                    <center><a class="btn" href="${pageContext.request.contextPath}/admin/delete?id=${user.id()}">&times;</a></center>
                </th>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
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
        var nav = document.getElementById('navigation');
        nav.classList.toggle('active');
    }
</script>
</body>
</html>