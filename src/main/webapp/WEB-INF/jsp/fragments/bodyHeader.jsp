<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
    <a href="${pageContext.request.contextPath}/" class="navbar-brand">
        <img src="${pageContext.request.contextPath}/resources/images/logo.png"
            alt="logo"
            width="30"
            height="30">
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse"
            data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent"
            aria-expanded="false"
            aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a href="${pageContext.request.contextPath}/" class="nav-link">General</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/tasks" class="nav-link">Tasks</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/tutorial" class="nav-link">How to use</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/registration" class="nav-link">Sign in</a>
            </li>
        </ul>
    </div>
</nav>
