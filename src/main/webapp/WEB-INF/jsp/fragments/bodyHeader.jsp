<section class="banner" id="sec">
<header>
    <a href="${pageContext.request.contextPath}/" class="logo">Diplom</a>
    <div id="toggle" onclick="toggle()"></div>
</header>
</section>

<div id="navigation">
    <ul>
        <li><a href="${pageContext.request.contextPath}/">General</a></li>
        <li><a href="${pageContext.request.contextPath}/tasks">Tasks</a></li>
        <li><a id="fao" data-toggle="modal" data-target="#tutorial">How to use</a></li>
        <li><a href="${pageContext.request.contextPath}/registration">Sign in</a></li>
    </ul>
</div>
<div class="modal fade" id="tutorial" tabindex="-1" role="dialog"
     aria-labelledby="tutorial" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="tutorialLable">Modal title</h5>
                <button class="close" type="button" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <img src="${pageContext.request.contextPath}/resources/files/images/default.jpeg">
                <img src="${pageContext.request.contextPath}/resources/files/images/default.jpeg">
                <img src="${pageContext.request.contextPath}/resources/files/images/default.jpeg">
            </div>
        </div>
    </div>
</div>
<%--<script type="text/javascript">--%>
<%--    function toggle() {--%>
<%--        var sec = document.getElementById('sec');--%>
<%--        var nav = document.getElementById('navigation');--%>
<%--        sec.classList.toggle('active');--%>
<%--        nav.classList.toggle('active');--%>
<%--    }--%>
<%--</script>--%>