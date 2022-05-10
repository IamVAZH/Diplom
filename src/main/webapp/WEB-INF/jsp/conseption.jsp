<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<jsp:include page="fragments/headTags.jsp"/>
<body>
<jsp:include page="fragments/bodyHeader.jsp"/>
<form method="post" action="${pageContext.request.contextPath}/createAudio">
    <div class="form-group">
<%--        <input type="hidden" name="id" value="${task.id}">--%>
        <label for="exampleInputEmail1">Title</label>
        <input name="name" type="text" class="form-control" id="exampleInputEmail1" aria-describedby="titleHelp" placeholder="Enter title">
        <small id="emailHelp" class="form-text text-muted">You need this to identify your task</small>
    </div>
    <div class="form-group">
        <label for="exampleFormControlTextarea1">Text</label>
        <textarea name="text" class="form-control" id="exampleFormControlTextarea1" rows="20"></textarea>
    </div>

    <button type="submit" class="btn btn-primary">Переходим к краткому переписыванию</button>
    <button onclick="window.history.back()" class="btn btn-primary" type="button">cancel</button>
</form>
</body>
</html>

