<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://topjava.javawebinar.ru/functions" %>
<html>


<jsp:include page="fragments/headTags.jsp"/>
<body style="background-color: darkgray">
<jsp:include page="fragments/bodyHeader.jsp"/>
<div class="container-fluid"></div>
<div class="container">
    <div class="card-group">
        <c:forEach items="${requestScope.tasks}" var="task">
            <jsp:useBean id="task" type="ru.vazh.model.Task"/>
            <div class="row mr-1 mb-4">
                <div class="col">
                    <div class="card">
                        <a href="${pageContext.request.contextPath}/img?id=${task.id()}"><img src="${pageContext.request.contextPath}/${task.img_path}" alt=""
                             class="card-img-top"></a>
                        <div class="card-body">
                            <h4 class="card-title">${task.name}</h4>
                            <a href="${pageContext.request.contextPath}/tasks/open?id=${task.id}"
                               class="btn btn-primary">Open</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
<%--<div class="card" style="width: 30em">--%>
<%--    <img src="${pageContext.request.contextPath}/resources/images/rocks.jpeg" alt="taskLogo"--%>
<%--         class="card-img-top">--%>
<%--    <div class="card-body">--%>
<%--        <h4 class="card-title text-center">${task.name}</h4>--%>
<%--        <p class="card-text">${task.text}</p>--%>
<%--        <div class="col text-center">--%>
<%--            <a href="tasks/open?id=${task.id}" class="btn btn-primary">Open</a>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>