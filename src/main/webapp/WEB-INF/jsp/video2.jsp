<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <jsp:include page="fragments/headTags.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/vidStyle.css">
    <script src="webjars/noty/3.1.4/lib/noty.min.js" defer></script>
    <link rel="stylesheet" href="webjars/noty/3.1.4/lib/noty.css"/>
    <title><spring:message code="title.video"/></title>
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

    <p>
        <button id="btnStart"><spring:message code="app.startRec"/></button>
        <br/>
        <button id="btnStop" hidden><spring:message code="app.stopRec"/></button>
    </p>
    <video id="vid1" controls hidden></video>

    <video id="vid2" controls src="/diplom/video/${savedVideo}"></video>
    <!-- could save to canvas and do image manipulation and saving too -->
    <input id="ajaxfile" hidden type="file"><br>
    <button id="uploadbtn" onclick="uploadFileAjax()"><spring:message code="app.upload"/></button>
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
    let blobData = null;

    let constraintObj = {
        audio: true,
        video: {
            facingMode: "user",
            width: {min: 640, ideal: 1280, max: 1920},
            height: {min: 480, ideal: 720, max: 1080}
        }
    };
    // width: 1280, height: 720  -- preference only
    // facingMode: {exact: "user"}
    // facingMode: "environment"

    //handle older browsers that might implement getUserMedia in some way
    if (navigator.mediaDevices === undefined) {
        navigator.mediaDevices = {};
        navigator.mediaDevices.getUserMedia = function (constraintObj) {
            let getUserMedia = navigator.webkitGetUserMedia || navigator.mozGetUserMedia;
            if (!getUserMedia) {
                return Promise.reject(new Error('getUserMedia is not implemented in this browser'));
            }
            return new Promise(function (resolve, reject) {
                getUserMedia.call(navigator, constraintObj, resolve, reject);
            });
        }
    } else {
        navigator.mediaDevices.enumerateDevices()
            .then(devices => {
                devices.forEach(device => {
                    console.log(device.kind.toUpperCase(), device.label);
                    //, device.deviceId
                })
            })
            .catch(err => {
                console.log(err.name, err.message);
            })
    }

    navigator.mediaDevices.getUserMedia(constraintObj)
        .then(function (mediaStreamObj) {
            //connect the media stream to the first video element
            let video = document.querySelector('video');
            if ("srcObject" in video) {
                video.srcObject = mediaStreamObj;
            } else {
                //old version
                video.src = window.URL.createObjectURL(mediaStreamObj);
            }

            video.onloadedmetadata = function (ev) {
                //show in the video element what is being captured by the webcam
                // video1.pause();
            };

            //add listeners for saving video/audio
            let start = document.getElementById('btnStart');
            let stop = document.getElementById('btnStop');
            let video1 = document.getElementById('vid1');
            let video2 = document.getElementById('vid2');

            let uploadbtn = document.getElementById('uploadbtn');
            let mediaRecorder = new MediaRecorder(mediaStreamObj);
            let chunks = [];

            video1.controls = false;
            uploadbtn.hidden = true;

            start.addEventListener('click', (ev) => {
                start.hidden = true;
                stop.hidden = false;
                video2.hidden = true;
                video1.hidden = false;
                uploadbtn.hidden = true;
                video2.pause();
                video1.play();
                // video1.play();
                mediaRecorder.start();
                console.log(mediaRecorder.state);
            })
            stop.addEventListener('click', (ev) => {
                stop.hidden = true;
                start.hidden = false;
                mediaRecorder.stop();
                video1.pause();
                video1.hidden = true;
                uploadbtn.hidden = false;
                video2.hidden = false;
                console.log(mediaRecorder.state);
            });
            mediaRecorder.ondataavailable = function (ev) {
                chunks.push(ev.data);
            }
            mediaRecorder.onstop = (ev) => {
                let blob = new Blob(chunks, {'type': 'video/mp4'});
                blobData = blob;
                chunks = [];
                let videoURL = window.URL.createObjectURL(blob);
                video2.src = videoURL;
            }
        })
        .catch(function (err) {
            console.log(err.name, err.message);
        });

    async function uploadFileAjax() {
        if (blobData != null) {
            let formData = new FormData();
            const myFile = new File(
                [blobData],
                "demo.mp4",
                {type: 'video/mp4'}
            );
            formData.append('video', myFile);
            formData.append('id', ${id});
            $.ajax({
                url: '${pageContext.request.contextPath}/video',
                type: 'POST',
                data: formData,
                cache: false,
                processData: false,
                contentType: false
            }).done(function () {
                successNoty();
                setTimeout(() => {
                    window.location.href = "${pageContext.request.contextPath}/tasks";
                }, 1500)
            }).fail(function () {
                alert("<spring:message code="tasks.error.connecting"/>");
            });
        } else {
            alertNoty();
            setTimeout(() => {
                window.location.href = "${pageContext.request.contextPath}/tasks";
            }, 1500)
        }
    }

    function successNoty() {
        new Noty({
            text: "<spring:message code="tasks.noty.videoChanged"/>",
            type: 'success',
            layout: "bottomRight",
            timeout: 1000
        }).show();
    }

    function alertNoty() {
        new Noty({
            text: "<spring:message code="tasks.noty.noChanges"/>",
            type: 'alert',
            layout: "bottomRight",
            timeout: 1000
        }).show();
    }

    function toggle() {
        var nav = document.getElementById('navigation');
        nav.classList.toggle('active');
    }
</script>
</body>
</html>
